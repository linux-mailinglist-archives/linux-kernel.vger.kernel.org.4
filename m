Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485426FD3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 04:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjEJCAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 22:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjEJCAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 22:00:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD93E74
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 19:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683684008; x=1715220008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B9ArjFq88tRK/W8TdAMdDGRhtdgpeucVRoEz9w5Qd0I=;
  b=D8Xk1bBJBBvZDCZx0Imr1KxAs1jZM1qRwp3Y20EuIB2kwgsnlH4Uu/X4
   OyKQszTj4/I7GzIlkHyY6+CefZWfvCbMNYfT2iX9fgR7Otzdka9avJk/2
   MFBVHx1yrzn59XcMq53nZyHI9dpekrmNnNHLL5KsvNa4jF8mjrkvRuRKO
   Vvd4CWTTM5pMVlJKSDJuSzsOrSyG7i7pkRV5zizzTCyRRebBGf6QlOXup
   UcQbu1tnl3aZZ+CzM9snFmLMkaqXc8MJX0iLVKSpnfFLHmAFCvXoIpwpM
   AOlAJfNA0RmDE4d7FSEYjtGr7W3zBYmE+ijPvThVjaZtJS8QRucuG0ktp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="378200130"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="378200130"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 19:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="873410089"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="873410089"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 May 2023 19:00:06 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwZ7d-0002mX-2X;
        Wed, 10 May 2023 02:00:05 +0000
Date:   Wed, 10 May 2023 09:59:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [paulmck-rcu:dev.2023.05.08c 15/67]
 drivers/infiniband/sw/rxe/rxe_verbs.c:1359:21: error: macro "kfree_rcu"
 requires 2 arguments, but only 1 given
Message-ID: <202305100912.lreD3oLd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.08c
head:   b7c6d563fb2aa29acb91fd8665380979bb8d131d
commit: df2d6f48c0dc148ea5dc86d3264ac27bd908b1e5 [15/67] rcu/kvfree: Eliminate k[v]free_rcu() single argument macro
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230510/202305100912.lreD3oLd-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=df2d6f48c0dc148ea5dc86d3264ac27bd908b1e5
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2023.05.08c
        git checkout df2d6f48c0dc148ea5dc86d3264ac27bd908b1e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305100912.lreD3oLd-lkp@intel.com/

Note: the paulmck-rcu/dev.2023.05.08c HEAD b7c6d563fb2aa29acb91fd8665380979bb8d131d builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/infiniband/sw/rxe/rxe_verbs.c: In function 'rxe_dereg_mr':
>> drivers/infiniband/sw/rxe/rxe_verbs.c:1359:21: error: macro "kfree_rcu" requires 2 arguments, but only 1 given
    1359 |         kfree_rcu(mr);
         |                     ^
   In file included from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/infiniband/sw/rxe/rxe_verbs.c:7:
   include/linux/rcupdate.h:961: note: macro "kfree_rcu" defined here
     961 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
         | 
>> drivers/infiniband/sw/rxe/rxe_verbs.c:1359:9: error: 'kfree_rcu' undeclared (first use in this function); did you mean 'kfree_skb'?
    1359 |         kfree_rcu(mr);
         |         ^~~~~~~~~
         |         kfree_skb
   drivers/infiniband/sw/rxe/rxe_verbs.c:1359:9: note: each undeclared identifier is reported only once for each function it appears in


vim +/kfree_rcu +1359 drivers/infiniband/sw/rxe/rxe_verbs.c

8700e3e7c4857d Moni Shoua  2016-06-16  1342  
5bf944f24129cb Bob Pearson 2023-03-03  1343  static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
5bf944f24129cb Bob Pearson 2023-03-03  1344  {
5bf944f24129cb Bob Pearson 2023-03-03  1345  	struct rxe_mr *mr = to_rmr(ibmr);
5bf944f24129cb Bob Pearson 2023-03-03  1346  	int err, cleanup_err;
5bf944f24129cb Bob Pearson 2023-03-03  1347  
5bf944f24129cb Bob Pearson 2023-03-03  1348  	/* See IBA 10.6.7.2.6 */
5bf944f24129cb Bob Pearson 2023-03-03  1349  	if (atomic_read(&mr->num_mw) > 0) {
5bf944f24129cb Bob Pearson 2023-03-03  1350  		err = -EINVAL;
5bf944f24129cb Bob Pearson 2023-03-03  1351  		rxe_dbg_mr(mr, "mr has mw's bound");
5bf944f24129cb Bob Pearson 2023-03-03  1352  		goto err_out;
5bf944f24129cb Bob Pearson 2023-03-03  1353  	}
5bf944f24129cb Bob Pearson 2023-03-03  1354  
5bf944f24129cb Bob Pearson 2023-03-03  1355  	cleanup_err = rxe_cleanup(mr);
5bf944f24129cb Bob Pearson 2023-03-03  1356  	if (cleanup_err)
5bf944f24129cb Bob Pearson 2023-03-03  1357  		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
5bf944f24129cb Bob Pearson 2023-03-03  1358  
5bf944f24129cb Bob Pearson 2023-03-03 @1359  	kfree_rcu(mr);
5bf944f24129cb Bob Pearson 2023-03-03  1360  	return 0;
5bf944f24129cb Bob Pearson 2023-03-03  1361  
5bf944f24129cb Bob Pearson 2023-03-03  1362  err_out:
5bf944f24129cb Bob Pearson 2023-03-03  1363  	rxe_err_mr(mr, "returned err = %d", err);
5bf944f24129cb Bob Pearson 2023-03-03  1364  	return err;
5bf944f24129cb Bob Pearson 2023-03-03  1365  }
5bf944f24129cb Bob Pearson 2023-03-03  1366  

:::::: The code at line 1359 was first introduced by commit
:::::: 5bf944f24129cbc4b5828348bdce2db94ca9fbd6 RDMA/rxe: Add error messages

:::::: TO: Bob Pearson <rpearsonhpe@gmail.com>
:::::: CC: Jason Gunthorpe <jgg@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
