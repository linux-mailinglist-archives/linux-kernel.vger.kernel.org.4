Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3779C6FDE6E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbjEJNYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjEJNYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:24:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083017696
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98D9D6359F
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04938C433EF;
        Wed, 10 May 2023 13:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683725057;
        bh=UAsPSxXbARXElooA/L3e+9/xl0EghbnAYlj2VBVox2U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Cuzvccdxd3unHeoeokUJ7PgswNsvxYgvG6GEum9LZ87KhFMO+MYiK/M/sQvpsL+Rq
         tXPwNDV1z9pv0juTN7O9quhvF8XM5tMtlfogOWtfIKhUV4MD0irO+NruODovmglK8k
         zATI5eZgvuxp/5ZoHzAJaXYHG8lG85UPsR+YhWDZyPMkVdBSF0Cj8VA9OUhfWS0gIw
         UF3yVwwAYDG/iot07QjLfKiBnVNlkVipilHoXNvhfnjaQv0qIjMUuloIww6Ik1rCkL
         AVCgpkoAhLw4fPjT4nmU73aaF3NeSip//qXdugaWQO/iCadFFduXlO5SJ8cfQy2OTa
         w4OmVsccNBPxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8C11CCE126E; Wed, 10 May 2023 06:24:16 -0700 (PDT)
Date:   Wed, 10 May 2023 06:24:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [paulmck-rcu:dev.2023.05.08c 15/67]
 drivers/infiniband/sw/rxe/rxe_verbs.c:1359:21: error: macro "kfree_rcu"
 requires 2 arguments, but only 1 given
Message-ID: <63e250db-d029-4b32-988e-d9d4e3ec6974@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202305100912.lreD3oLd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305100912.lreD3oLd-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 09:59:31AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.08c
> head:   b7c6d563fb2aa29acb91fd8665380979bb8d131d
> commit: df2d6f48c0dc148ea5dc86d3264ac27bd908b1e5 [15/67] rcu/kvfree: Eliminate k[v]free_rcu() single argument macro
> config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230510/202305100912.lreD3oLd-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=df2d6f48c0dc148ea5dc86d3264ac27bd908b1e5
>         git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags paulmck-rcu dev.2023.05.08c
>         git checkout df2d6f48c0dc148ea5dc86d3264ac27bd908b1e5
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305100912.lreD3oLd-lkp@intel.com/
> 
> Note: the paulmck-rcu/dev.2023.05.08c HEAD b7c6d563fb2aa29acb91fd8665380979bb8d131d builds fine.
>       It only hurts bisectability.

The final fixes eliminating the need for single-argument kfree_rcu()
are not yet in mainline, so I revert this commit further up the stack
for my own testing.  Once all the fixes make it into -next, I will leave
that revert out of -next testing in order to help prevent additional
uses from sneaking in.  ;-)

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    drivers/infiniband/sw/rxe/rxe_verbs.c: In function 'rxe_dereg_mr':
> >> drivers/infiniband/sw/rxe/rxe_verbs.c:1359:21: error: macro "kfree_rcu" requires 2 arguments, but only 1 given
>     1359 |         kfree_rcu(mr);
>          |                     ^
>    In file included from include/linux/rculist.h:11,
>                     from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from include/linux/ratelimit.h:6,
>                     from include/linux/dev_printk.h:16,
>                     from include/linux/device.h:15,
>                     from include/linux/dma-mapping.h:7,
>                     from drivers/infiniband/sw/rxe/rxe_verbs.c:7:
>    include/linux/rcupdate.h:961: note: macro "kfree_rcu" defined here
>      961 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
>          | 
> >> drivers/infiniband/sw/rxe/rxe_verbs.c:1359:9: error: 'kfree_rcu' undeclared (first use in this function); did you mean 'kfree_skb'?
>     1359 |         kfree_rcu(mr);
>          |         ^~~~~~~~~
>          |         kfree_skb
>    drivers/infiniband/sw/rxe/rxe_verbs.c:1359:9: note: each undeclared identifier is reported only once for each function it appears in
> 
> 
> vim +/kfree_rcu +1359 drivers/infiniband/sw/rxe/rxe_verbs.c
> 
> 8700e3e7c4857d Moni Shoua  2016-06-16  1342  
> 5bf944f24129cb Bob Pearson 2023-03-03  1343  static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
> 5bf944f24129cb Bob Pearson 2023-03-03  1344  {
> 5bf944f24129cb Bob Pearson 2023-03-03  1345  	struct rxe_mr *mr = to_rmr(ibmr);
> 5bf944f24129cb Bob Pearson 2023-03-03  1346  	int err, cleanup_err;
> 5bf944f24129cb Bob Pearson 2023-03-03  1347  
> 5bf944f24129cb Bob Pearson 2023-03-03  1348  	/* See IBA 10.6.7.2.6 */
> 5bf944f24129cb Bob Pearson 2023-03-03  1349  	if (atomic_read(&mr->num_mw) > 0) {
> 5bf944f24129cb Bob Pearson 2023-03-03  1350  		err = -EINVAL;
> 5bf944f24129cb Bob Pearson 2023-03-03  1351  		rxe_dbg_mr(mr, "mr has mw's bound");
> 5bf944f24129cb Bob Pearson 2023-03-03  1352  		goto err_out;
> 5bf944f24129cb Bob Pearson 2023-03-03  1353  	}
> 5bf944f24129cb Bob Pearson 2023-03-03  1354  
> 5bf944f24129cb Bob Pearson 2023-03-03  1355  	cleanup_err = rxe_cleanup(mr);
> 5bf944f24129cb Bob Pearson 2023-03-03  1356  	if (cleanup_err)
> 5bf944f24129cb Bob Pearson 2023-03-03  1357  		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
> 5bf944f24129cb Bob Pearson 2023-03-03  1358  
> 5bf944f24129cb Bob Pearson 2023-03-03 @1359  	kfree_rcu(mr);
> 5bf944f24129cb Bob Pearson 2023-03-03  1360  	return 0;
> 5bf944f24129cb Bob Pearson 2023-03-03  1361  
> 5bf944f24129cb Bob Pearson 2023-03-03  1362  err_out:
> 5bf944f24129cb Bob Pearson 2023-03-03  1363  	rxe_err_mr(mr, "returned err = %d", err);
> 5bf944f24129cb Bob Pearson 2023-03-03  1364  	return err;
> 5bf944f24129cb Bob Pearson 2023-03-03  1365  }
> 5bf944f24129cb Bob Pearson 2023-03-03  1366  
> 
> :::::: The code at line 1359 was first introduced by commit
> :::::: 5bf944f24129cbc4b5828348bdce2db94ca9fbd6 RDMA/rxe: Add error messages
> 
> :::::: TO: Bob Pearson <rpearsonhpe@gmail.com>
> :::::: CC: Jason Gunthorpe <jgg@nvidia.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
