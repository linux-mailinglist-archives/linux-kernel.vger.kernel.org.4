Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104606DF280
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDLLEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLLEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:04:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E1A65B0;
        Wed, 12 Apr 2023 04:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681297451; x=1712833451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wASHHa1jhQxtW4fY4VimABiJjIV6Yy6QxwIyZkdzWYc=;
  b=SP8LDdt/XfSlqOOeLVrHmavi5iCor6rOjZIlAH46ar1C/05Jl7MKlxfB
   AULwLXHdpkXd4mVb8q2Rf4s7ftJ8N7L1kHVzEKM6v0BdBWX9HJqBjA3uK
   VE87yxhlaXl70uAta5WWjwbR5DUqC2ixo4m/yL0AU6Wd0BCSS9ksHefBV
   hEWgWMwsWCr4XKRyerlE4a1i6fwKo1u3LXfkhWWTh8qmXmDHRqjQQjnzy
   eTw+8o0UrR8qO88zEQjWLgik2OU9B6kjXWoAsxhuRW4uuxgS4lZ39u7Xe
   Ah+r++x0wbAyCLF3jEIKZYVpory/uTzNkPBfkYlzfffWn4K+UXp17BrwB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="324226419"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="324226419"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 04:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="753488981"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="753488981"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2023 04:04:07 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmYGk-000XeF-1Z;
        Wed, 12 Apr 2023 11:04:06 +0000
Date:   Wed, 12 Apr 2023 19:03:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v8 04/11] LSM: syscalls for current process attributes
Message-ID: <202304121843.QWCxhPE9-lkp@intel.com>
References: <20230411155921.14716-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411155921.14716-5-casey@schaufler-ca.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on acme/perf/core shuah-kselftest/next shuah-kselftest/fixes linus/master v6.3-rc6]
[cannot apply to next-20230412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230412-005929
patch link:    https://lore.kernel.org/r/20230411155921.14716-5-casey%40schaufler-ca.com
patch subject: [PATCH v8 04/11] LSM: syscalls for current process attributes
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230412/202304121843.QWCxhPE9-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0308dbcd345400b5ded1e1721045c6941979c7a6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230412-005929
        git checkout 0308dbcd345400b5ded1e1721045c6941979c7a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304121843.QWCxhPE9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from security/lsm_syscalls.c:15:
>> include/linux/syscalls.h:243:25: error: conflicting types for 'sys_lsm_set_self_attr'; have 'long int(unsigned int,  struct lsm_ctx *, size_t,  u32)' {aka 'long int(unsigned int,  struct lsm_ctx *, unsigned int,  unsigned int)'}
     243 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   security/lsm_syscalls.c:31:1: note: in expansion of macro 'SYSCALL_DEFINE4'
      31 | SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:1064:17: note: previous declaration of 'sys_lsm_set_self_attr' with type 'long int(unsigned int,  struct lsm_ctx *, __u32)' {aka 'long int(unsigned int,  struct lsm_ctx *, unsigned int)'}
    1064 | asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
         |                 ^~~~~~~~~~~~~~~~~~~~~


vim +243 include/linux/syscalls.h

1bd21c6c21e848 Dominik Brodowski   2018-04-05  232  
e145242ea0df6b Dominik Brodowski   2018-04-09  233  /*
e145242ea0df6b Dominik Brodowski   2018-04-09  234   * The asmlinkage stub is aliased to a function named __se_sys_*() which
e145242ea0df6b Dominik Brodowski   2018-04-09  235   * sign-extends 32-bit ints to longs whenever needed. The actual work is
e145242ea0df6b Dominik Brodowski   2018-04-09  236   * done within __do_sys_*().
e145242ea0df6b Dominik Brodowski   2018-04-09  237   */
1bd21c6c21e848 Dominik Brodowski   2018-04-05  238  #ifndef __SYSCALL_DEFINEx
bed1ffca022cc8 Frederic Weisbecker 2009-03-13  239  #define __SYSCALL_DEFINEx(x, name, ...)					\
bee20031772af3 Arnd Bergmann       2018-06-19  240  	__diag_push();							\
bee20031772af3 Arnd Bergmann       2018-06-19  241  	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
bee20031772af3 Arnd Bergmann       2018-06-19  242  		      "Type aliasing is used to sanitize syscall arguments");\
83460ec8dcac14 Andi Kleen          2013-11-12 @243  	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
e145242ea0df6b Dominik Brodowski   2018-04-09  244  		__attribute__((alias(__stringify(__se_sys##name))));	\
c9a211951c7c79 Howard McLauchlan   2018-03-21  245  	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
e145242ea0df6b Dominik Brodowski   2018-04-09  246  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
e145242ea0df6b Dominik Brodowski   2018-04-09  247  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
e145242ea0df6b Dominik Brodowski   2018-04-09  248  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
1a94bc34768e46 Heiko Carstens      2009-01-14  249  	{								\
e145242ea0df6b Dominik Brodowski   2018-04-09  250  		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
07fe6e00f6cca6 Al Viro             2013-01-21  251  		__MAP(x,__SC_TEST,__VA_ARGS__);				\
2cf0966683430b Al Viro             2013-01-21  252  		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
2cf0966683430b Al Viro             2013-01-21  253  		return ret;						\
1a94bc34768e46 Heiko Carstens      2009-01-14  254  	}								\
bee20031772af3 Arnd Bergmann       2018-06-19  255  	__diag_pop();							\
e145242ea0df6b Dominik Brodowski   2018-04-09  256  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
1bd21c6c21e848 Dominik Brodowski   2018-04-05  257  #endif /* __SYSCALL_DEFINEx */
1a94bc34768e46 Heiko Carstens      2009-01-14  258  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
