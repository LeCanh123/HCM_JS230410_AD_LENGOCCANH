
--2
--Hiển thị toàn bộ nội dung của bảng Architect
SELECT * FROM Architect
--Hiển thị danh sách gồm họ tên và giới tính của kiến trúc sư
SELECT name,sex FROM `architect`
--Hiển thị những năm sinh có thể có của các kiến trúc sư
SELECT DISTINCT birthday FROM `architect`
--Hiển thị danh sách các kiến trúc sư (họ tên và năm sinh) (giá trị năm sinh tăng dần)
SELECT DISTINCT name,birthday FROM `architect` ORDER BY birthday ASC
--Hiển thị danh sách các kiến trúc sư (họ tên và năm sinh) (giá trị năm sinh giảm dần)
SELECT DISTINCT name,birthday FROM `architect` ORDER BY birthday DESC
--Hiển thị danh sách các công trình có chi phí từ thấp đến cao. Nếu 2 công trình có chi phí bằng nhau sắp xếp tên thành phố theo bảng chữ cái building
SELECT * FROM `building` ORDER BY cost ASC ,city ASC

--bai 4
--Hiển thị tất cả thông tin của kiến trúc sư "le thanh tung"
SELECT * FROM `architect` 
WHERE name LIKE 'le thanh tung'
--Hiển thị tên, năm sinh các công nhân có chuyên môn hàn hoặc điện
SELECT name,birthday FROM `worker` 
WHERE skill LIKE 'han' OR skill LIKE 'dien';
--Hiển thị tên các công nhân có chuyên môn hàn hoặc điện và năm sinh lớn hơn 1948
SELECT name FROM worker
WHERE (skill = 'han' OR skill = 'dien') AND birthday > 1948;
--Hiển thị những công nhân bắt đầu vào nghề khi dưới 20 (birthday + 20 > year)
SELECT * FROM worker
WHERE birthday+20>year
--Hiển thị những công nhân có năm sinh 1945, 1940, 1948
SELECT * FROM worker
WHERE birthday IN (1945, 1940, 1948);
--Tìm những công trình có chi phí đầu tư từ 200 đến 500 triệu đồng
SELECT * FROM `building`
WHERE cost >= 200 AND cost <= 500;
--Tìm kiếm những kiến trúc sư có họ là nguyen: % chuỗi
SELECT * FROM architect
WHERE name LIKE 'nguyen%';
--Tìm kiếm những kiến trúc sư có tên đệm là anh
SELECT * FROM architect
WHERE name LIKE '% anh %';
--Tìm kiếm những kiến trúc sư có tên bắt đầu th và có 3 ký tự
SELECT * FROM architect
WHERE name LIKE 'th_';
--Tìm kiếm những kiến trúc sư có tên bắt đầu th và có 3 ký tự
SELECT * FROM architect
WHERE name LIKE '%th_';
--Tìm chủ thầu không có phone
SELECT * FROM `contractor`
WHERE phone IS NULL;

--bai 5
--Thống kê tổng số kiến trúc sư
SELECT COUNT(*) as total FROM architect;
--Thống kê tổng số kiến trúc sư nam
SELECT COUNT(*) as total_male_architects FROM architect
WHERE sex = 1;
--Tìm ngày tham gia công trình nhiều nhất của công nhân
SELECT date ,MAX(total) as max_start_date
FROM work
GROUP BY date
ORDER BY max_start_date DESC
LIMIT 1;
--Tìm ngày tham gia công trình ít nhất của công nhân
SELECT date, MIN(total) as min_start_date
FROM work
GROUP BY date
ORDER BY min_start_date ASC
LIMIT 1;
--Tìm tổng số ngày tham gia công trình của tất cả công nhân
SELECT worker_id, SUM(total) as max_start_date
FROM work
GROUP BY worker_id
--Tìm tổng chi phí phải trả cho việc thiết kế công trình của kiến trúc sư có Mã số 1
SELECT architect_id, SUM(benefit*building.cost) AS chiPhiPhaiTra
FROM design
INNER JOIN building ON design.building_id = building.id
GROUP BY architect_id;
--Tìm trung bình số ngày tham gia công trình của công nhân
SELECT AVG(total) as avg_days
FROM work;
--Hiển thị thông tin kiến trúc sư: họ tên, tuổi
SELECT name, YEAR(CURDATE()) - birthday AS age
FROM `architect`;
--Tính thù lao của kiến trúc sư: Thù lao = benefit * 1000
SELECT architect.name, SUM(design.benefit) * 1000 AS totalbenefit
FROM `design`
INNER JOIN architect ON design.architect_id = architect.id
GROUP BY architect.name;


--cau 6
--Hiển thị thông tin công trình có chi phí cao nhất
SELECT *
FROM building
WHERE cost = (
  SELECT MAX(cost)
  FROM building
);
--Hiển thị thông tin công trình có chi phí lớn hơn tất cả các công trình được xây dựng ở Cần Thơ
SELECT *
FROM building
WHERE cost = (
  SELECT MAX(cost)
  FROM building
  WHERE city = 'can tho'
);
--Hiển thị thông tin công trình có chi phí lớn hơn một trong các công trình được xây dựng ở Cần Thơ
SELECT *
FROM building
WHERE cost > (
  SELECT cost
  FROM building
  WHERE city = 'can tho'
  ORDER BY cost ASC
  LIMIT 1
);
--Hiển thị thông tin công trình chưa có kiến trúc sư thiết kế
SELECT design.building_id ,building.contractor_id
FROM `design` 
LEFT JOIN building
ON building.id = design.building_id
WHERE design.building_id IS NULL
--Hiển thị thông tin các kiến trúc sư cùng năm sinh và cùng nơi tốt nghiệp
SELECT DISTINCT a.*
FROM architect a
INNER JOIN building b ON a.id = b.contractor_id
WHERE a.birthday IN (
    SELECT birthday
    FROM architect
    GROUP BY birthday
    HAVING COUNT(*) > 1
)
AND a.place IN (
    SELECT place
    FROM architect
    GROUP BY place
    HAVING COUNT(*) > 1
);


--bai 7
--Hiển thị thù lao trung bình của từng kiến trúc sư
SELECT architect.name, AVG(building.cost) AS avg_salary
FROM architect
JOIN building ON architect.id = building.contractor_id
GROUP BY architect.id;
--Hiển thị chi phí đầu tư cho các công trình ở mỗi thành phố


--Tìm các công trình có chi phí trả cho kiến trúc sư lớn hơn 50
SELECT city, SUM(cost) AS total_investment
FROM building
GROUP BY city
HAVING SUM(cost) > 50;


--Tìm các thành phố có ít nhất một kiến trúc sư tốt nghiệp































