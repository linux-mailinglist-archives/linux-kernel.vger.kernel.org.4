Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B26EB6A8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 03:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjDVBXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 21:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDVBXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 21:23:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8AC2106;
        Fri, 21 Apr 2023 18:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682126614; x=1713662614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8qaPqLf620JT3lsFtV3qPS9X2GQ8wbZ10jPK2VZDSjE=;
  b=jsC6T6kx0IxnFkIt2UEqBVdNCrB4D77N8Jx43rijV0wa6QEgDtXiu2Qj
   SndALJNAv+gYUHZ0FfkPtbPAoU6PUX0/AisQ4yqX9YeeK1e+i7Vd4Q3WX
   DMRoYibF2lQNlLvq232w+fftW47qEraRajAwqnUI9Fj5/mIrph7ukzqa2
   38w2i5cXf7PxETK3JleGR3m+AMOlhEMnpCQonHxrYGu8VMU5EDlquMtUL
   jac0lwcFFzirg0+M63VN6KJJMCNWbOQzd1WJi2u7pUm4l244Uwf+DYwJF
   k4JjvwobThPmJXOEZGPISVdKfh+PJquz3tBIaMt9pLkFATQPOoqCE/8ED
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="326445547"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="326445547"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 18:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="722949863"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="722949863"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2023 18:23:29 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pq1yL-000gyu-0U;
        Sat, 22 Apr 2023 01:23:29 +0000
Date:   Sat, 22 Apr 2023 09:23:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v9 09/11] AppArmor: Add selfattr hooks
Message-ID: <202304220930.OFrY92as-lkp@intel.com>
References: <20230421174259.2458-10-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-10-casey@schaufler-ca.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on acme/perf/core shuah-kselftest/next shuah-kselftest/fixes linus/master v6.3-rc7]
[cannot apply to next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230422-024331
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/20230421174259.2458-10-casey%40schaufler-ca.com
patch subject: [PATCH v9 09/11] AppArmor: Add selfattr hooks
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20230422/202304220930.OFrY92as-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2628bfcd3ff1b12fbae522a5449a7344ffe6ecbd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230422-024331
        git checkout 2628bfcd3ff1b12fbae522a5449a7344ffe6ecbd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash security/apparmor/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304220930.OFrY92as-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/apparmor/lsm.c:654:7: warning: variable 'total_len' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (error > 0) {
                       ^~~~~~~~~
   security/apparmor/lsm.c:666:10: note: uninitialized use occurs here
           *size = total_len;
                   ^~~~~~~~~
   security/apparmor/lsm.c:654:3: note: remove the 'if' if its condition is always true
                   if (error > 0) {
                   ^~~~~~~~~~~~~~~
   security/apparmor/lsm.c:652:6: warning: variable 'total_len' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (label) {
               ^~~~~
   security/apparmor/lsm.c:666:10: note: uninitialized use occurs here
           *size = total_len;
                   ^~~~~~~~~
   security/apparmor/lsm.c:652:2: note: remove the 'if' if its condition is always true
           if (label) {
           ^~~~~~~~~~~
   security/apparmor/lsm.c:640:18: note: initialize the variable 'total_len' to silence this warning
           size_t total_len;
                           ^
                            = 0
   2 warnings generated.


vim +654 security/apparmor/lsm.c

   632	
   633	static int apparmor_getselfattr(unsigned int __user attr,
   634					struct lsm_ctx __user *lx, size_t *size,
   635					u32 __user flags)
   636	{
   637		int error = -ENOENT;
   638		struct aa_task_ctx *ctx = task_ctx(current);
   639		struct aa_label *label = NULL;
   640		size_t total_len;
   641		char *value;
   642	
   643		if (attr == LSM_ATTR_CURRENT)
   644			label = aa_get_newest_label(cred_label(current_cred()));
   645		else if (attr == LSM_ATTR_PREV && ctx->previous)
   646			label = aa_get_newest_label(ctx->previous);
   647		else if (attr == LSM_ATTR_EXEC && ctx->onexec)
   648			label = aa_get_newest_label(ctx->onexec);
   649		else
   650			error = -EOPNOTSUPP;
   651	
   652		if (label) {
   653			error = aa_getprocattr(label, &value, false);
 > 654			if (error > 0) {
   655				total_len = ALIGN(error + sizeof(*ctx), 8);
   656				if (total_len > *size)
   657					error = -E2BIG;
   658				else
   659					lsm_fill_user_ctx(lx, value, error,
   660							  LSM_ID_APPARMOR, 0);
   661			}
   662		}
   663	
   664		aa_put_label(label);
   665	
   666		*size = total_len;
   667		if (error > 0)
   668			return 1;
   669		return error;
   670	}
   671	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
