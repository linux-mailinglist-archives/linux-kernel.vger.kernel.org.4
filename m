Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE85F82C8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 05:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJHDXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 23:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJHDX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 23:23:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE0711B2F2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 20:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665199404; x=1696735404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oWew8nMf8kxKOQmpNFgX/kBx8Hb7BrIwFDchMPfSCeE=;
  b=ei1WWHB8ju6xt1rf7THCcl4Gwph2anGPV9MXBB/b7TDYEj3/BfRWTa0O
   DlB4AIV9HDvfgVCfnZmhyaUnezpWRNJqHCaKk/1kkJQnCGuQPiYfBetAK
   sAKo7UQXllkaMZFCgcqiXWwRwsl2cFnbM1pRnchZzpT9ekEHvPmaHfJ8t
   zUkX8YDvFKww4vpcExV9m4lCxKyEnpZHwU4cDi2D2GJtxJYxxyezsgnEg
   NuF2TY/zT3XXeKoDijaWEVf+msPGFTl3xyRvVuR22fKO92Ywx0sR06wIP
   5HZ7xY5NUxa0rD4oqZXq2rbbU3LIjed7nDYBSry+2YXkprMi8BBsedb8t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="330336093"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="330336093"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 20:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="576456548"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="576456548"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2022 20:23:22 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oh0Qr-0001nL-1y;
        Sat, 08 Oct 2022 03:23:21 +0000
Date:   Sat, 8 Oct 2022 11:22:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: io_uring/rw.c:934:24: warning: Local variable 'rw' shadows outer
 variable [shadowVariable]
Message-ID: <202210081142.cjzWE8ru-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8bc52cb8df80c31c73c726ab58ea9746e9ff734
commit: 4e17aaab54359fa2cdeb0080c822a08f2980f979 io_uring: Add support for async buffered writes
date:   3 months ago
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 4e17aaab54359fa2cdeb0080c822a08f2980f979
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

cppcheck warnings: (new ones prefixed by >>)
>> io_uring/rw.c:934:24: warning: Local variable 'rw' shadows outer variable [shadowVariable]
      struct io_async_rw *rw;
                          ^
   io_uring/rw.c:842:16: note: Shadowed declaration
    struct io_rw *rw = io_kiocb_to_cmd(req);
                  ^
   io_uring/rw.c:934:24: note: Shadow variable
      struct io_async_rw *rw;
                          ^

vim +/rw +934 io_uring/rw.c

   839	
   840	int io_write(struct io_kiocb *req, unsigned int issue_flags)
   841	{
   842		struct io_rw *rw = io_kiocb_to_cmd(req);
   843		struct io_rw_state __s, *s = &__s;
   844		struct iovec *iovec;
   845		struct kiocb *kiocb = &rw->kiocb;
   846		bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
   847		ssize_t ret, ret2;
   848		loff_t *ppos;
   849	
   850		if (!req_has_async_data(req)) {
   851			ret = io_import_iovec(WRITE, req, &iovec, s, issue_flags);
   852			if (unlikely(ret < 0))
   853				return ret;
   854		} else {
   855			struct io_async_rw *io = req->async_data;
   856	
   857			s = &io->s;
   858			iov_iter_restore(&s->iter, &s->iter_state);
   859			iovec = NULL;
   860		}
   861		ret = io_rw_init_file(req, FMODE_WRITE);
   862		if (unlikely(ret)) {
   863			kfree(iovec);
   864			return ret;
   865		}
   866		req->cqe.res = iov_iter_count(&s->iter);
   867	
   868		if (force_nonblock) {
   869			/* If the file doesn't support async, just async punt */
   870			if (unlikely(!io_file_supports_nowait(req)))
   871				goto copy_iov;
   872	
   873			/* File path supports NOWAIT for non-direct_IO only for block devices. */
   874			if (!(kiocb->ki_flags & IOCB_DIRECT) &&
   875				!(kiocb->ki_filp->f_mode & FMODE_BUF_WASYNC) &&
   876				(req->flags & REQ_F_ISREG))
   877				goto copy_iov;
   878	
   879			kiocb->ki_flags |= IOCB_NOWAIT;
   880		} else {
   881			/* Ensure we clear previously set non-block flag */
   882			kiocb->ki_flags &= ~IOCB_NOWAIT;
   883		}
   884	
   885		ppos = io_kiocb_update_pos(req);
   886	
   887		ret = rw_verify_area(WRITE, req->file, ppos, req->cqe.res);
   888		if (unlikely(ret)) {
   889			kfree(iovec);
   890			return ret;
   891		}
   892	
   893		/*
   894		 * Open-code file_start_write here to grab freeze protection,
   895		 * which will be released by another thread in
   896		 * io_complete_rw().  Fool lockdep by telling it the lock got
   897		 * released so that it doesn't complain about the held lock when
   898		 * we return to userspace.
   899		 */
   900		if (req->flags & REQ_F_ISREG) {
   901			sb_start_write(file_inode(req->file)->i_sb);
   902			__sb_writers_release(file_inode(req->file)->i_sb,
   903						SB_FREEZE_WRITE);
   904		}
   905		kiocb->ki_flags |= IOCB_WRITE;
   906	
   907		if (likely(req->file->f_op->write_iter))
   908			ret2 = call_write_iter(req->file, kiocb, &s->iter);
   909		else if (req->file->f_op->write)
   910			ret2 = loop_rw_iter(WRITE, rw, &s->iter);
   911		else
   912			ret2 = -EINVAL;
   913	
   914		if (req->flags & REQ_F_REISSUE) {
   915			req->flags &= ~REQ_F_REISSUE;
   916			ret2 = -EAGAIN;
   917		}
   918	
   919		/*
   920		 * Raw bdev writes will return -EOPNOTSUPP for IOCB_NOWAIT. Just
   921		 * retry them without IOCB_NOWAIT.
   922		 */
   923		if (ret2 == -EOPNOTSUPP && (kiocb->ki_flags & IOCB_NOWAIT))
   924			ret2 = -EAGAIN;
   925		/* no retry on NONBLOCK nor RWF_NOWAIT */
   926		if (ret2 == -EAGAIN && (req->flags & REQ_F_NOWAIT))
   927			goto done;
   928		if (!force_nonblock || ret2 != -EAGAIN) {
   929			/* IOPOLL retry should happen for io-wq threads */
   930			if (ret2 == -EAGAIN && (req->ctx->flags & IORING_SETUP_IOPOLL))
   931				goto copy_iov;
   932	
   933			if (ret2 != req->cqe.res && ret2 >= 0 && need_complete_io(req)) {
 > 934				struct io_async_rw *rw;
   935	
   936				/* This is a partial write. The file pos has already been
   937				 * updated, setup the async struct to complete the request
   938				 * in the worker. Also update bytes_done to account for
   939				 * the bytes already written.
   940				 */
   941				iov_iter_save_state(&s->iter, &s->iter_state);
   942				ret = io_setup_async_rw(req, iovec, s, true);
   943	
   944				rw = req->async_data;
   945				if (rw)
   946					rw->bytes_done += ret2;
   947	
   948				return ret ? ret : -EAGAIN;
   949			}
   950	done:
   951			ret = kiocb_done(req, ret2, issue_flags);
   952		} else {
   953	copy_iov:
   954			iov_iter_restore(&s->iter, &s->iter_state);
   955			ret = io_setup_async_rw(req, iovec, s, false);
   956			return ret ?: -EAGAIN;
   957		}
   958		/* it's reportedly faster than delegating the null check to kfree() */
   959		if (iovec)
   960			kfree(iovec);
   961		return ret;
   962	}
   963	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
