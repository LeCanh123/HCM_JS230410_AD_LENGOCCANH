import express from 'express';
const router = express.Router();

import usersModule from './modules/user.module'
router.use('/users', usersModule)

import postsModule from './modules/post.module'
router.use('/posts', postsModule)

module.exports = router;