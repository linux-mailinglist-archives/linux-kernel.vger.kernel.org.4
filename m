Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB5737732
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjFTWFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjFTWFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:05:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1591713
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687298742; x=1718834742;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WCAxJ2yKOcSnS6zOTMV3gR2/FLkdoSakLnUYnkQKTx8=;
  b=AsRVfildIvIW8j2qCtZPgFIPvS3FOJYEFd+fSwDnbShvMMH74Vf3OrXo
   wmMs3Lc80KZ594GeWHXtuS+U1xp4ZcgqkHoDJv2DpMXRJNX/26WkV5pH7
   Y7NQVvgKSGdG8nrViOV++HkjFyGqbkXXjMpX81qcLCIfiG7gBl3w9LRXA
   yGC5Wynnp6x2VbtI+bfJZ2iKb/7O5hX38mJ5Eq7H7yBpybdy9vY6sATUd
   nv1WhcTxj1+1H2FGCJ3vcmOSmntUmnUt4XZv2LbOYsQ7tZaaIDW2sPBc+
   WrdLZlygwZSzlpKjGz+pE27oqQNx+Hb3qbOeLV7pmVijK1zq4QM+HNHeB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="425951831"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="425951831"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 15:05:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664407696"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="664407696"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Jun 2023 15:05:41 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBjTo-0006Hj-1U;
        Tue, 20 Jun 2023 22:05:40 +0000
Date:   Wed, 21 Jun 2023 06:05:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: io_uring/net.c:206:25: sparse: sparse: incorrect type in assignment
 (different address spaces)
Message-ID: <202306210654.mDMcyMuB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   692b7dc87ca6d55ab254f8259e6f970171dc9d01
commit: cac9e4418f4cbd548ccb065b3adcafe073f7f7d2 io_uring/net: save msghdr->msg_control for retries
date:   7 days ago
config: i386-randconfig-s001-20230620 (https://download.01.org/0day-ci/archive/20230621/202306210654.mDMcyMuB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306210654.mDMcyMuB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306210654.mDMcyMuB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   io_uring/net.c: note: in included file (through io_uring/io_uring.h):
   include/linux/io_uring_types.h:179:37: sparse: sparse: array of flexible structures
>> io_uring/net.c:206:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *msg_control @@     got void *msg_control @@
   io_uring/net.c:206:25: sparse:     expected void [noderef] __user *msg_control
   io_uring/net.c:206:25: sparse:     got void *msg_control
>> io_uring/net.c:305:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *msg_control @@     got void [noderef] __user *msg_control @@
   io_uring/net.c:305:39: sparse:     expected void *msg_control
   io_uring/net.c:305:39: sparse:     got void [noderef] __user *msg_control

vim +206 io_uring/net.c

   194	
   195	static int io_sendmsg_copy_hdr(struct io_kiocb *req,
   196				       struct io_async_msghdr *iomsg)
   197	{
   198		struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
   199		int ret;
   200	
   201		iomsg->msg.msg_name = &iomsg->addr;
   202		iomsg->free_iov = iomsg->fast_iov;
   203		ret = sendmsg_copy_msghdr(&iomsg->msg, sr->umsg, sr->msg_flags,
   204						&iomsg->free_iov);
   205		/* save msg_control as sys_sendmsg() overwrites it */
 > 206		sr->msg_control = iomsg->msg.msg_control;
   207		return ret;
   208	}
   209	
   210	int io_send_prep_async(struct io_kiocb *req)
   211	{
   212		struct io_sr_msg *zc = io_kiocb_to_cmd(req, struct io_sr_msg);
   213		struct io_async_msghdr *io;
   214		int ret;
   215	
   216		if (!zc->addr || req_has_async_data(req))
   217			return 0;
   218		io = io_msg_alloc_async_prep(req);
   219		if (!io)
   220			return -ENOMEM;
   221		ret = move_addr_to_kernel(zc->addr, zc->addr_len, &io->addr);
   222		return ret;
   223	}
   224	
   225	static int io_setup_async_addr(struct io_kiocb *req,
   226				      struct sockaddr_storage *addr_storage,
   227				      unsigned int issue_flags)
   228	{
   229		struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
   230		struct io_async_msghdr *io;
   231	
   232		if (!sr->addr || req_has_async_data(req))
   233			return -EAGAIN;
   234		io = io_msg_alloc_async(req, issue_flags);
   235		if (!io)
   236			return -ENOMEM;
   237		memcpy(&io->addr, addr_storage, sizeof(io->addr));
   238		return -EAGAIN;
   239	}
   240	
   241	int io_sendmsg_prep_async(struct io_kiocb *req)
   242	{
   243		int ret;
   244	
   245		if (!io_msg_alloc_async_prep(req))
   246			return -ENOMEM;
   247		ret = io_sendmsg_copy_hdr(req, req->async_data);
   248		if (!ret)
   249			req->flags |= REQ_F_NEED_CLEANUP;
   250		return ret;
   251	}
   252	
   253	void io_sendmsg_recvmsg_cleanup(struct io_kiocb *req)
   254	{
   255		struct io_async_msghdr *io = req->async_data;
   256	
   257		kfree(io->free_iov);
   258	}
   259	
   260	int io_sendmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
   261	{
   262		struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
   263	
   264		if (req->opcode == IORING_OP_SEND) {
   265			if (READ_ONCE(sqe->__pad3[0]))
   266				return -EINVAL;
   267			sr->addr = u64_to_user_ptr(READ_ONCE(sqe->addr2));
   268			sr->addr_len = READ_ONCE(sqe->addr_len);
   269		} else if (sqe->addr2 || sqe->file_index) {
   270			return -EINVAL;
   271		}
   272	
   273		sr->umsg = u64_to_user_ptr(READ_ONCE(sqe->addr));
   274		sr->len = READ_ONCE(sqe->len);
   275		sr->flags = READ_ONCE(sqe->ioprio);
   276		if (sr->flags & ~IORING_RECVSEND_POLL_FIRST)
   277			return -EINVAL;
   278		sr->msg_flags = READ_ONCE(sqe->msg_flags) | MSG_NOSIGNAL;
   279		if (sr->msg_flags & MSG_DONTWAIT)
   280			req->flags |= REQ_F_NOWAIT;
   281	
   282	#ifdef CONFIG_COMPAT
   283		if (req->ctx->compat)
   284			sr->msg_flags |= MSG_CMSG_COMPAT;
   285	#endif
   286		sr->done_io = 0;
   287		return 0;
   288	}
   289	
   290	int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
   291	{
   292		struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
   293		struct io_async_msghdr iomsg, *kmsg;
   294		struct socket *sock;
   295		unsigned flags;
   296		int min_ret = 0;
   297		int ret;
   298	
   299		sock = sock_from_file(req->file);
   300		if (unlikely(!sock))
   301			return -ENOTSOCK;
   302	
   303		if (req_has_async_data(req)) {
   304			kmsg = req->async_data;
 > 305			kmsg->msg.msg_control = sr->msg_control;
   306		} else {
   307			ret = io_sendmsg_copy_hdr(req, &iomsg);
   308			if (ret)
   309				return ret;
   310			kmsg = &iomsg;
   311		}
   312	
   313		if (!(req->flags & REQ_F_POLLED) &&
   314		    (sr->flags & IORING_RECVSEND_POLL_FIRST))
   315			return io_setup_async_msg(req, kmsg, issue_flags);
   316	
   317		flags = sr->msg_flags;
   318		if (issue_flags & IO_URING_F_NONBLOCK)
   319			flags |= MSG_DONTWAIT;
   320		if (flags & MSG_WAITALL)
   321			min_ret = iov_iter_count(&kmsg->msg.msg_iter);
   322	
   323		ret = __sys_sendmsg_sock(sock, &kmsg->msg, flags);
   324	
   325		if (ret < min_ret) {
   326			if (ret == -EAGAIN && (issue_flags & IO_URING_F_NONBLOCK))
   327				return io_setup_async_msg(req, kmsg, issue_flags);
   328			if (ret > 0 && io_net_retry(sock, flags)) {
   329				sr->done_io += ret;
   330				req->flags |= REQ_F_PARTIAL_IO;
   331				return io_setup_async_msg(req, kmsg, issue_flags);
   332			}
   333			if (ret == -ERESTARTSYS)
   334				ret = -EINTR;
   335			req_set_fail(req);
   336		}
   337		/* fast path, check for non-NULL to avoid function call */
   338		if (kmsg->free_iov)
   339			kfree(kmsg->free_iov);
   340		req->flags &= ~REQ_F_NEED_CLEANUP;
   341		io_netmsg_recycle(req, issue_flags);
   342		if (ret >= 0)
   343			ret += sr->done_io;
   344		else if (sr->done_io)
   345			ret = sr->done_io;
   346		io_req_set_res(req, ret, 0);
   347		return IOU_OK;
   348	}
   349	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
