Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE706EB943
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDVNMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 09:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjDVNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 09:12:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F53CE65;
        Sat, 22 Apr 2023 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682169170; x=1713705170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=siolPaBbzy3Sc50U7pDpe27/YvjBEvisAHA0WNyP5iw=;
  b=Wqoisyc/jSSHBrIZdyhw+76BfpbMX6B+df2vnCWI7tUFQJDwbHQ4nnZH
   qkPkjU3Vqo+bLx2ywclqL0gCuoVPJxfL2JO4O2jeEK0kD9FNnRqQIiHgz
   lW6T3nGhU4Rwr/gvjI4/nAChXvo5inxRir6RZGJjh+yQw6SY3HYswVqPY
   vkyLCqNhXfpL5/+Y99cuO1ijQnvD6Gxx7fzAVDjmE+VRHFnJAKMMwXcAd
   6RhxFKCeajENQsMRQWgciL54EFC85H2ux3dVlEPEVubjJ5/mBRWKlOKm4
   TEBcDUqWw0ty0W9i5R2JvsRs7FQHnf8uzH+XYW+kf3WrT+gshFaRr7uRp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="330362804"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="330362804"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 06:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="836441170"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="836441170"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2023 06:12:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqD2i-000hJY-1T;
        Sat, 22 Apr 2023 13:12:44 +0000
Date:   Sat, 22 Apr 2023 21:12:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 04/11] LSM: syscalls for current process attributes
Message-ID: <202304222142.YHgqLhGF-lkp@intel.com>
References: <20230421174259.2458-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-5-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230421174259.2458-5-casey%40schaufler-ca.com
patch subject: [PATCH v9 04/11] LSM: syscalls for current process attributes
config: mips-randconfig-s051-20230421 (https://download.01.org/0day-ci/archive/20230422/202304222142.YHgqLhGF-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/78ea54cc31d7bd9e5a5c7fe8cf34fba9516fde95
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230422-024331
        git checkout 78ea54cc31d7bd9e5a5c7fe8cf34fba9516fde95
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304222142.YHgqLhGF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> security/lsm_syscalls.c:34:48: sparse: sparse: dereference of noderef expression
--
   security/security.c:406:25: sparse: sparse: cast removes address space '__rcu' of expression
>> security/security.c:2196:13: sparse: sparse: dereference of noderef expression
   security/security.c:2203:14: sparse: sparse: dereference of noderef expression
   security/security.c:2208:20: sparse: sparse: dereference of noderef expression
   security/security.c:2218:43: sparse: sparse: dereference of noderef expression
   security/security.c:2218:66: sparse: sparse: dereference of noderef expression
   security/security.c:2263:13: sparse: sparse: dereference of noderef expression
   security/security.c:2265:13: sparse: sparse: dereference of noderef expression
   security/security.c:2269:13: sparse: sparse: dereference of noderef expression
   security/security.c:2269:32: sparse: sparse: dereference of noderef expression
   security/security.c:2275:53: sparse: sparse: dereference of noderef expression
   security/security.c:2275:64: sparse: sparse: dereference of noderef expression
   security/security.c:2275:70: sparse: sparse: dereference of noderef expression

vim +34 security/lsm_syscalls.c

    19	
    20	/**
    21	 * sys_lsm_set_self_attr - Set current task's security module attribute
    22	 * @attr: which attribute to set
    23	 * @ctx: the LSM contexts
    24	 * @size: size of @ctx
    25	 * @flags: reserved for future use
    26	 *
    27	 * Sets the calling task's LSM context. On success this function
    28	 * returns 0. If the attribute specified cannot be set a negative
    29	 * value indicating the reason for the error is returned.
    30	 */
    31	SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
    32			ctx, size_t __user, size, u32, flags)
    33	{
  > 34		return security_setselfattr(attr, ctx, size, flags);
    35	}
    36	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
