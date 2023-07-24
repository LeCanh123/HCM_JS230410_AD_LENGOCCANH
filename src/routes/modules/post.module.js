import express, { Router } from 'express';
const router = express.Router();
import fs from 'fs'
import multiparty from 'multiparty';
import dotenv from 'dotenv';
import bodyParser from 'body-parser';
dotenv.config();
import { dirname } from 'path';
// import d from "./../../user-post-api/users.json"



router.get('/', (req, res) => {
    res.json(require("./../../user-post-api/posts.json"))
}
)

router.get('/:id', (req, res) => {
    const postId = req.params.id;
    const posts = require("./../../user-post-api/posts.json");
    const post = posts.find(post => post.id == postId);
    if (!post) {
      // Trả về mã lỗi 404 nếu không tìm thấy người dùng
      res.status(404).json({ message: `post with id ${postId} not found` });
    } else {
      res.json(post);
    }
  });


  router.post('/', (req, res) => {
    const newpost = req.body;
    const posts = require("./../../user-post-api/posts.json");
    const maxId = Math.max(...posts.map(post => post.id));
    const post = {
        id: maxId + 1,
      ...newpost
    };
    posts.push(post);
    console.log(posts);
    fs.writeFileSync(__dirname+"./../../user-post-api/posts.json", JSON.stringify(posts));
    res.json(posts);
  });


  


  router.put('/:id', (req, res) => {
    const postId = req.params.id;
    const posts = require("./../../user-post-api/posts.json");
    const postIndex = posts.findIndex(post => post.id == postId);
    if (postIndex == -1) {
      res.status(404).json({ message: `post with id ${postId} not found` });
    } else {
      posts[postIndex] = {
        ...req.body,
        id: postId
      };
      fs.writeFileSync(__dirname+"./../../user-post-api/posts.json", JSON.stringify(posts, null, 2));
      res.json(posts);
    }
  });




  router.delete('/:id', (req, res) => {
    const postId = req.params.id;
    const posts = require("./../../user-post-api/posts.json");
    const newposts = posts.filter(post => post.id != postId);
    if (newposts.length == posts.length) {
      res.status(404).json({ message: `post with id ${postId} not found` });
    } else {
      fs.writeFileSync(__dirname+"./../../user-post-api/posts.json", JSON.stringify(newposts, null, 2));
      res.json(newposts);
    }
  });


  module.exports=router;


