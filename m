Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79EF696349
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjBNMQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjBNMQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:16:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45966211D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676376969; x=1707912969;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xUofCmzcrew67KOIwL4w5cHjueDItJEzbBSY2HQSdDU=;
  b=WdCWWfYIzJa/UufK3rUgUYtnt/PulGmUKuqb8gBYKOi17eR1qPBE2KlG
   U04oR5L8sR7678vWWj2waHP2Yi9ik/g0PY8/tKDInojWg8p7kRMuMHQNf
   FaU88KmOFNkzU1nhe8FFZ0N1kZYBnW0nrphsuigYquF9UHu3faqO66bbW
   8f90SomIa4XU/ZGcdvO81CbQTCqa6jrOyktdshI56bDMoT6MjpzhW2VxD
   f55Q0BXwIw84X8p4iHmqQWHjAuEvnuRA5v54BUhNM0KP1MWnPmr6RHOoi
   136vmPE6unbzblKR4umX1Irppw2FFGPrK2WEb7Pjk/QfgaEpTLAnBKlX8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="328857497"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="328857497"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 04:16:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="998056949"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="998056949"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2023 04:16:07 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRuEB-0008Tx-0i;
        Tue, 14 Feb 2023 12:16:07 +0000
Date:   Tue, 14 Feb 2023 20:15:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: io_uring/io_uring.c:2932:40: error: variable 'prev' set but not used
Message-ID: <202302142034.cidUt6CO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f6feea56f66d34259c4222fa02e8171c4f2673d1
commit: ed29b0b4fd835b058ddd151c49d021e28d631ee6 io_uring: move to separate directory
date:   7 months ago
config: x86_64-sof-customedconfig-edison-defconfig (https://download.01.org/0day-ci/archive/20230214/202302142034.cidUt6CO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed29b0b4fd835b058ddd151c49d021e28d631ee6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ed29b0b4fd835b058ddd151c49d021e28d631ee6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302142034.cidUt6CO-lkp@intel.com/

All errors (new ones prefixed by >>):

   io_uring/io_uring.c: In function '__io_submit_flush_completions':
>> io_uring/io_uring.c:2932:40: error: variable 'prev' set but not used [-Werror=unused-but-set-variable]
    2932 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
   cc1: all warnings being treated as errors


vim +/prev +2932 io_uring/io_uring.c

7a743e225b2a9d fs/io_uring.c Pavel Begunkov 2020-03-03  2928  
c450178d9be9dc fs/io_uring.c Pavel Begunkov 2021-09-08  2929  static void __io_submit_flush_completions(struct io_ring_ctx *ctx)
a141dd896f544d fs/io_uring.c Jens Axboe     2021-08-12  2930  	__must_hold(&ctx->uring_lock)
905c172f32c56f fs/io_uring.c Pavel Begunkov 2021-02-10  2931  {
6f33b0bc4ea43f fs/io_uring.c Pavel Begunkov 2021-09-24 @2932  	struct io_wq_work_node *node, *prev;
cd0ca2e048dc0d fs/io_uring.c Pavel Begunkov 2021-08-09  2933  	struct io_submit_state *state = &ctx->submit_state;
905c172f32c56f fs/io_uring.c Pavel Begunkov 2021-02-10  2934  
3d4aeb9f98058c fs/io_uring.c Pavel Begunkov 2021-11-10  2935  	if (state->flush_cqes) {
79ebeaee8a21a0 fs/io_uring.c Jens Axboe     2021-08-10  2936  		spin_lock(&ctx->completion_lock);
6f33b0bc4ea43f fs/io_uring.c Pavel Begunkov 2021-09-24  2937  		wq_list_for_each(node, prev, &state->compl_reqs) {
6f33b0bc4ea43f fs/io_uring.c Pavel Begunkov 2021-09-24  2938  			struct io_kiocb *req = container_of(node, struct io_kiocb,
6f33b0bc4ea43f fs/io_uring.c Pavel Begunkov 2021-09-24  2939  						    comp_list);
5182ed2e332e8e fs/io_uring.c Pavel Begunkov 2021-06-26  2940  
f43de1f88841d5 fs/io_uring.c Pavel Begunkov 2022-06-15  2941  			if (!(req->flags & REQ_F_CQE_SKIP))
91ef75a7db0d08 fs/io_uring.c Pavel Begunkov 2022-06-15  2942  				__io_fill_cqe_req(ctx, req);
905c172f32c56f fs/io_uring.c Pavel Begunkov 2021-02-10  2943  		}
3d4aeb9f98058c fs/io_uring.c Pavel Begunkov 2021-11-10  2944  
905c172f32c56f fs/io_uring.c Pavel Begunkov 2021-02-10  2945  		io_commit_cqring(ctx);
79ebeaee8a21a0 fs/io_uring.c Jens Axboe     2021-08-10  2946  		spin_unlock(&ctx->completion_lock);
905c172f32c56f fs/io_uring.c Pavel Begunkov 2021-02-10  2947  		io_cqring_ev_posted(ctx);
3d4aeb9f98058c fs/io_uring.c Pavel Begunkov 2021-11-10  2948  		state->flush_cqes = false;
3d4aeb9f98058c fs/io_uring.c Pavel Begunkov 2021-11-10  2949  	}
5182ed2e332e8e fs/io_uring.c Pavel Begunkov 2021-06-26  2950  
1cce17aca621c3 fs/io_uring.c Pavel Begunkov 2021-09-24  2951  	io_free_batch_list(ctx, state->compl_reqs.first);
6f33b0bc4ea43f fs/io_uring.c Pavel Begunkov 2021-09-24  2952  	INIT_WQ_LIST(&state->compl_reqs);
7a743e225b2a9d fs/io_uring.c Pavel Begunkov 2020-03-03  2953  }
7a743e225b2a9d fs/io_uring.c Pavel Begunkov 2020-03-03  2954  

:::::: The code at line 2932 was first introduced by commit
:::::: 6f33b0bc4ea43f5c5ce7b7c9ab66051f80837862 io_uring: use slist for completion batching

:::::: TO: Pavel Begunkov <asml.silence@gmail.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
