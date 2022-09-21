Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E515C0409
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiIUQZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiIUQY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:24:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CDFB2491
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663776467; x=1695312467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vQZ1w2NXnyYMmr9xISuEs4lcP/u037I0ATDUQDpwZ7k=;
  b=WizuYCkddRl5c64X6ZANUDXE93bi0wrd88dCZwPa9nHcY2Sk1Q5Hluo9
   8rQD5e7mUK36R/hYnQpWl6X+Bp6tELBeRc2bf7XRJqyg5Ir/lvZMXG3Kv
   op9RtT6gQC0hQaeSOROCc7ngYWfhE/ZGDuHq473fSh5coAJglZlmr8dzn
   QfZ7TmfmhNceZCUmXe6nFD9FsasCviWRTVvKLffXXG1vT5t03Pu0OOAYK
   a1QndAWeIOOP9j4U4FaD/QaXUdQ6ah0oMf2zojDqiwSNLSKXkV01qatEX
   SdHxfFnp9YH5q04Q2m2dbkdhmQeuWJkgYP5jgiSi3W8aspMsJLAzxMtQ5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="364024073"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="364024073"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 09:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="948214985"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2022 09:07:26 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob2Fy-0003kC-0y;
        Wed, 21 Sep 2022 16:07:26 +0000
Date:   Thu, 22 Sep 2022 00:06:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     SeongJae Park <sj@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [sj:damon/next 26/29] mm/damon/core.c:807:3: warning: variable 'err'
 is used uninitialized whenever 'if' condition is false
Message-ID: <202209220049.dcCdIisb-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
head:   a5f85a5de8b74931ccd564bdb63194aedc99f2a9
commit: 71af589c839d9564a9daa6bb0af2f7f4931ea19c [26/29] mm/damon/core: separate damos application logic
config: hexagon-randconfig-r033-20220921 (https://download.01.org/0day-ci/archive/20220922/202209220049.dcCdIisb-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?id=71af589c839d9564a9daa6bb0af2f7f4931ea19c
        git remote add sj https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git
        git fetch --no-tags sj damon/next
        git checkout 71af589c839d9564a9daa6bb0af2f7f4931ea19c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash mm/damon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/damon/core.c:807:3: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (c->callback.before_scheme_apply)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/damon/core.c:809:8: note: uninitialized use occurs here
                   if (!err)
                        ^~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   mm/damon/core.c:807:3: note: remove the 'if' if its condition is always true
                   if (c->callback.before_scheme_apply)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   mm/damon/core.c:787:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
   1 warning generated.


vim +807 mm/damon/core.c

b47f2bf827d3e3 SeongJae Park 2022-09-20  779  
71af589c839d95 SeongJae Park 2022-09-20  780  static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
71af589c839d95 SeongJae Park 2022-09-20  781  		struct damon_region *r, struct damos *s)
b47f2bf827d3e3 SeongJae Park 2022-09-20  782  {
b47f2bf827d3e3 SeongJae Park 2022-09-20  783  	struct damos_quota *quota = &s->quota;
71af589c839d95 SeongJae Park 2022-09-20  784  	unsigned long sz = r->ar.end - r->ar.start;
b47f2bf827d3e3 SeongJae Park 2022-09-20  785  	struct timespec64 begin, end;
b47f2bf827d3e3 SeongJae Park 2022-09-20  786  	unsigned long sz_applied = 0;
71af589c839d95 SeongJae Park 2022-09-20  787  	int err;
b47f2bf827d3e3 SeongJae Park 2022-09-20  788  
f7d911c39cbbb8 SeongJae Park 2022-03-22  789  	if (c->ops.apply_scheme) {
71af589c839d95 SeongJae Park 2022-09-20  790  		if (quota->esz && quota->charged_sz + sz > quota->esz) {
1cd2430300594a SeongJae Park 2021-11-05  791  			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
2b8a248d587334 SeongJae Park 2021-11-05  792  					DAMON_MIN_REGION);
2b8a248d587334 SeongJae Park 2021-11-05  793  			if (!sz)
2b8a248d587334 SeongJae Park 2021-11-05  794  				goto update_stat;
2886230666fa8b SeongJae Park 2022-08-14  795  			if (sz >= r->ar.end - r->ar.start) {
2886230666fa8b SeongJae Park 2022-08-14  796  				pr_err("sz: %lu, region: %lu-%lu (%lu), quota: %lu, charged: %lu\n",
2886230666fa8b SeongJae Park 2022-08-14  797  						sz, r->ar.start,
2886230666fa8b SeongJae Park 2022-08-14  798  						r->ar.end, r->ar.end -
2886230666fa8b SeongJae Park 2022-08-14  799  						r->ar.start,
2886230666fa8b SeongJae Park 2022-08-14  800  						quota->esz,
2886230666fa8b SeongJae Park 2022-08-14  801  						quota->charged_sz);
2886230666fa8b SeongJae Park 2022-08-14  802  				BUG();
2886230666fa8b SeongJae Park 2022-08-14  803  			}
4ed9824346c071 Kaixu Xia     2022-08-13  804  			damon_split_region_at(t, r, sz);
2b8a248d587334 SeongJae Park 2021-11-05  805  		}
1cd2430300594a SeongJae Park 2021-11-05  806  		ktime_get_coarse_ts64(&begin);
5cb21aeba065d6 SeongJae Park 2022-09-20 @807  		if (c->callback.before_scheme_apply)
71af589c839d95 SeongJae Park 2022-09-20  808  			err = c->callback.before_scheme_apply(c, t, r, s);
5cb21aeba065d6 SeongJae Park 2022-09-20  809  		if (!err)
f7d911c39cbbb8 SeongJae Park 2022-03-22  810  			sz_applied = c->ops.apply_scheme(c, t, r, s);
1cd2430300594a SeongJae Park 2021-11-05  811  		ktime_get_coarse_ts64(&end);
1cd2430300594a SeongJae Park 2021-11-05  812  		quota->total_charged_ns += timespec64_to_ns(&end) -
1cd2430300594a SeongJae Park 2021-11-05  813  			timespec64_to_ns(&begin);
2b8a248d587334 SeongJae Park 2021-11-05  814  		quota->charged_sz += sz;
1cd2430300594a SeongJae Park 2021-11-05  815  		if (quota->esz && quota->charged_sz >= quota->esz) {
50585192bc2ef9 SeongJae Park 2021-11-05  816  			quota->charge_target_from = t;
50585192bc2ef9 SeongJae Park 2021-11-05  817  			quota->charge_addr_from = r->ar.end + 1;
50585192bc2ef9 SeongJae Park 2021-11-05  818  		}
2b8a248d587334 SeongJae Park 2021-11-05  819  	}
2f0b548c9f03a7 SeongJae Park 2021-11-05  820  	if (s->action != DAMOS_STAT)
1f366e421c8f69 SeongJae Park 2021-11-05  821  		r->age = 0;
2b8a248d587334 SeongJae Park 2021-11-05  822  
2b8a248d587334 SeongJae Park 2021-11-05  823  update_stat:
0e92c2ee9f4595 SeongJae Park 2022-01-14  824  	s->stat.nr_tried++;
0e92c2ee9f4595 SeongJae Park 2022-01-14  825  	s->stat.sz_tried += sz;
0e92c2ee9f4595 SeongJae Park 2022-01-14  826  	if (sz_applied)
0e92c2ee9f4595 SeongJae Park 2022-01-14  827  		s->stat.nr_applied++;
0e92c2ee9f4595 SeongJae Park 2022-01-14  828  	s->stat.sz_applied += sz_applied;
1f366e421c8f69 SeongJae Park 2021-11-05  829  }
71af589c839d95 SeongJae Park 2022-09-20  830  

:::::: The code at line 807 was first introduced by commit
:::::: 5cb21aeba065d632fa56295d75151d6b70a2bd1b mm/damon/core: add a DAMON callback for scheme target regions check

:::::: TO: SeongJae Park <sj@kernel.org>
:::::: CC: SeongJae Park <sj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
