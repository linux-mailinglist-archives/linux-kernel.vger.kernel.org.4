Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0975C6A0127
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjBWCXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBWCXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:23:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9921167F;
        Wed, 22 Feb 2023 18:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677119025; x=1708655025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D8RMmDz9O4xg0Z75j4obRMTa+YqIeL7+eIp5XbHH3ps=;
  b=iDYv8o5EVaM1Lnxc92Aglm0rgr2lVvIF73sksm8ekm2z4H45er0B3Lvz
   BqRSvz8+YZudA/hDhEVLaGgTut70R1Z07EPCOm7jjBI+srqhStDRKs1p7
   hJ+F3A5j+R8yYHNStc36L/fyPAvIxKcp6gmcCjaM5QkNttkzgjAVg4LS8
   cHmeMXVDZobtC3qNfn11ReSMU8a9WOCruIxT3x+Bc15M1zy6Y2XYsyR61
   Oi1w9dTcBb6y9fQnrccWA7XpmDAiR8Yhl/yV8dBqavSOZgmPYoiEIXwmd
   fgtvOXCnIpgDwHzVhZYA6EeKbfPXUJLYTE3I+B1M9yw587tY2HvzoTLXj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="397789113"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="397789113"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 18:23:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="761183053"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="761183053"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Feb 2023 18:23:42 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pV1Gn-0000vB-1F;
        Thu, 23 Feb 2023 02:23:41 +0000
Date:   Thu, 23 Feb 2023 10:23:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        beanhuo@micron.com, bvanassche@acm.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: Re: [PATCH 1/2] include: uapi: scsi: Change utp_upiu_query struct
Message-ID: <202302231040.fsntCrq0-lkp@intel.com>
References: <1677078770-30994-2-git-send-email-Arthur.Simchaev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1677078770-30994-2-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arthur,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on jejb-scsi/for-next linus/master next-20230222]
[cannot apply to v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arthur-Simchaev/include-uapi-scsi-Change-utp_upiu_query-struct/20230222-233738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/1677078770-30994-2-git-send-email-Arthur.Simchaev%40wdc.com
patch subject: [PATCH 1/2] include: uapi: scsi: Change utp_upiu_query struct
config: riscv-randconfig-r025-20230222 (https://download.01.org/0day-ci/archive/20230223/202302231040.fsntCrq0-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/b821692fde9b136903941365fae75b13d85c23c7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Arthur-Simchaev/include-uapi-scsi-Change-utp_upiu_query-struct/20230222-233738
        git checkout b821692fde9b136903941365fae75b13d85c23c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/ufs/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302231040.fsntCrq0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/ufs/core/ufshcd.c:12:
   In file included from include/linux/async.h:14:
   In file included from include/linux/device.h:15:
   In file included from include/linux/dev_printk.h:16:
   In file included from include/linux/ratelimit.h:6:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:5:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:29:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:11:
   In file included from include/linux/string.h:253:
>> include/linux/fortify-string.h:513:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
                           __write_overflow_field(p_size_field, size);
                           ^
   include/linux/fortify-string.h:522:4: warning: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
                           __read_overflow2_field(q_size_field, size);
                           ^
>> include/linux/fortify-string.h:513:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
                           __write_overflow_field(p_size_field, size);
                           ^
   include/linux/fortify-string.h:522:4: warning: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
                           __read_overflow2_field(q_size_field, size);
                           ^
   4 warnings generated.


vim +513 include/linux/fortify-string.h

a28a6e860c6cf2 Francis Laniel 2021-02-25  457  
f68f2ff91512c1 Kees Cook      2021-04-20  458  /*
f68f2ff91512c1 Kees Cook      2021-04-20  459   * To make sure the compiler can enforce protection against buffer overflows,
f68f2ff91512c1 Kees Cook      2021-04-20  460   * memcpy(), memmove(), and memset() must not be used beyond individual
f68f2ff91512c1 Kees Cook      2021-04-20  461   * struct members. If you need to copy across multiple members, please use
f68f2ff91512c1 Kees Cook      2021-04-20  462   * struct_group() to create a named mirror of an anonymous struct union.
f68f2ff91512c1 Kees Cook      2021-04-20  463   * (e.g. see struct sk_buff.) Read overflow checking is currently only
f68f2ff91512c1 Kees Cook      2021-04-20  464   * done when a write overflow is also present, or when building with W=1.
f68f2ff91512c1 Kees Cook      2021-04-20  465   *
f68f2ff91512c1 Kees Cook      2021-04-20  466   * Mitigation coverage matrix
f68f2ff91512c1 Kees Cook      2021-04-20  467   *					Bounds checking at:
f68f2ff91512c1 Kees Cook      2021-04-20  468   *					+-------+-------+-------+-------+
f68f2ff91512c1 Kees Cook      2021-04-20  469   *					| Compile time  |   Run time    |
f68f2ff91512c1 Kees Cook      2021-04-20  470   * memcpy() argument sizes:		| write | read  | write | read  |
f68f2ff91512c1 Kees Cook      2021-04-20  471   *        dest     source   length      +-------+-------+-------+-------+
f68f2ff91512c1 Kees Cook      2021-04-20  472   * memcpy(known,   known,   constant)	|   y   |   y   |  n/a  |  n/a  |
f68f2ff91512c1 Kees Cook      2021-04-20  473   * memcpy(known,   unknown, constant)	|   y   |   n   |  n/a  |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  474   * memcpy(known,   known,   dynamic)	|   n   |   n   |   B   |   B   |
f68f2ff91512c1 Kees Cook      2021-04-20  475   * memcpy(known,   unknown, dynamic)	|   n   |   n   |   B   |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  476   * memcpy(unknown, known,   constant)	|   n   |   y   |   V   |  n/a  |
f68f2ff91512c1 Kees Cook      2021-04-20  477   * memcpy(unknown, unknown, constant)	|   n   |   n   |   V   |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  478   * memcpy(unknown, known,   dynamic)	|   n   |   n   |   V   |   B   |
f68f2ff91512c1 Kees Cook      2021-04-20  479   * memcpy(unknown, unknown, dynamic)	|   n   |   n   |   V   |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  480   *					+-------+-------+-------+-------+
f68f2ff91512c1 Kees Cook      2021-04-20  481   *
f68f2ff91512c1 Kees Cook      2021-04-20  482   * y = perform deterministic compile-time bounds checking
f68f2ff91512c1 Kees Cook      2021-04-20  483   * n = cannot perform deterministic compile-time bounds checking
f68f2ff91512c1 Kees Cook      2021-04-20  484   * n/a = no run-time bounds checking needed since compile-time deterministic
f68f2ff91512c1 Kees Cook      2021-04-20  485   * B = can perform run-time bounds checking (currently unimplemented)
f68f2ff91512c1 Kees Cook      2021-04-20  486   * V = vulnerable to run-time overflow (will need refactoring to solve)
f68f2ff91512c1 Kees Cook      2021-04-20  487   *
f68f2ff91512c1 Kees Cook      2021-04-20  488   */
54d9469bc515dc Kees Cook      2021-06-24  489  __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
f68f2ff91512c1 Kees Cook      2021-04-20  490  					 const size_t p_size,
f68f2ff91512c1 Kees Cook      2021-04-20  491  					 const size_t q_size,
f68f2ff91512c1 Kees Cook      2021-04-20  492  					 const size_t p_size_field,
f68f2ff91512c1 Kees Cook      2021-04-20  493  					 const size_t q_size_field,
f68f2ff91512c1 Kees Cook      2021-04-20  494  					 const char *func)
a28a6e860c6cf2 Francis Laniel 2021-02-25  495  {
a28a6e860c6cf2 Francis Laniel 2021-02-25  496  	if (__builtin_constant_p(size)) {
f68f2ff91512c1 Kees Cook      2021-04-20  497  		/*
f68f2ff91512c1 Kees Cook      2021-04-20  498  		 * Length argument is a constant expression, so we
f68f2ff91512c1 Kees Cook      2021-04-20  499  		 * can perform compile-time bounds checking where
fa35198f39571b Kees Cook      2022-09-19  500  		 * buffer sizes are also known at compile time.
f68f2ff91512c1 Kees Cook      2021-04-20  501  		 */
f68f2ff91512c1 Kees Cook      2021-04-20  502  
f68f2ff91512c1 Kees Cook      2021-04-20  503  		/* Error when size is larger than enclosing struct. */
fa35198f39571b Kees Cook      2022-09-19  504  		if (__compiletime_lessthan(p_size_field, p_size) &&
fa35198f39571b Kees Cook      2022-09-19  505  		    __compiletime_lessthan(p_size, size))
a28a6e860c6cf2 Francis Laniel 2021-02-25  506  			__write_overflow();
fa35198f39571b Kees Cook      2022-09-19  507  		if (__compiletime_lessthan(q_size_field, q_size) &&
fa35198f39571b Kees Cook      2022-09-19  508  		    __compiletime_lessthan(q_size, size))
a28a6e860c6cf2 Francis Laniel 2021-02-25  509  			__read_overflow2();
f68f2ff91512c1 Kees Cook      2021-04-20  510  
f68f2ff91512c1 Kees Cook      2021-04-20  511  		/* Warn when write size argument larger than dest field. */
fa35198f39571b Kees Cook      2022-09-19  512  		if (__compiletime_lessthan(p_size_field, size))
f68f2ff91512c1 Kees Cook      2021-04-20 @513  			__write_overflow_field(p_size_field, size);
f68f2ff91512c1 Kees Cook      2021-04-20  514  		/*
f68f2ff91512c1 Kees Cook      2021-04-20  515  		 * Warn for source field over-read when building with W=1
f68f2ff91512c1 Kees Cook      2021-04-20  516  		 * or when an over-write happened, so both can be fixed at
f68f2ff91512c1 Kees Cook      2021-04-20  517  		 * the same time.
f68f2ff91512c1 Kees Cook      2021-04-20  518  		 */
fa35198f39571b Kees Cook      2022-09-19  519  		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) ||
fa35198f39571b Kees Cook      2022-09-19  520  		     __compiletime_lessthan(p_size_field, size)) &&
fa35198f39571b Kees Cook      2022-09-19  521  		    __compiletime_lessthan(q_size_field, size))
f68f2ff91512c1 Kees Cook      2021-04-20  522  			__read_overflow2_field(q_size_field, size);
a28a6e860c6cf2 Francis Laniel 2021-02-25  523  	}
f68f2ff91512c1 Kees Cook      2021-04-20  524  	/*
f68f2ff91512c1 Kees Cook      2021-04-20  525  	 * At this point, length argument may not be a constant expression,
f68f2ff91512c1 Kees Cook      2021-04-20  526  	 * so run-time bounds checking can be done where buffer sizes are
f68f2ff91512c1 Kees Cook      2021-04-20  527  	 * known. (This is not an "else" because the above checks may only
f68f2ff91512c1 Kees Cook      2021-04-20  528  	 * be compile-time warnings, and we want to still warn for run-time
f68f2ff91512c1 Kees Cook      2021-04-20  529  	 * overflows.)
f68f2ff91512c1 Kees Cook      2021-04-20  530  	 */
f68f2ff91512c1 Kees Cook      2021-04-20  531  
f68f2ff91512c1 Kees Cook      2021-04-20  532  	/*
f68f2ff91512c1 Kees Cook      2021-04-20  533  	 * Always stop accesses beyond the struct that contains the
f68f2ff91512c1 Kees Cook      2021-04-20  534  	 * field, when the buffer's remaining size is known.
311fb40aa0569a Kees Cook      2022-09-02  535  	 * (The SIZE_MAX test is to optimize away checks where the buffer
f68f2ff91512c1 Kees Cook      2021-04-20  536  	 * lengths are unknown.)
f68f2ff91512c1 Kees Cook      2021-04-20  537  	 */
311fb40aa0569a Kees Cook      2022-09-02  538  	if ((p_size != SIZE_MAX && p_size < size) ||
311fb40aa0569a Kees Cook      2022-09-02  539  	    (q_size != SIZE_MAX && q_size < size))
f68f2ff91512c1 Kees Cook      2021-04-20  540  		fortify_panic(func);
54d9469bc515dc Kees Cook      2021-06-24  541  
54d9469bc515dc Kees Cook      2021-06-24  542  	/*
54d9469bc515dc Kees Cook      2021-06-24  543  	 * Warn when writing beyond destination field size.
54d9469bc515dc Kees Cook      2021-06-24  544  	 *
54d9469bc515dc Kees Cook      2021-06-24  545  	 * We must ignore p_size_field == 0 for existing 0-element
54d9469bc515dc Kees Cook      2021-06-24  546  	 * fake flexible arrays, until they are all converted to
54d9469bc515dc Kees Cook      2021-06-24  547  	 * proper flexible arrays.
54d9469bc515dc Kees Cook      2021-06-24  548  	 *
9f7d69c5cd2390 Kees Cook      2022-09-19  549  	 * The implementation of __builtin_*object_size() behaves
54d9469bc515dc Kees Cook      2021-06-24  550  	 * like sizeof() when not directly referencing a flexible
54d9469bc515dc Kees Cook      2021-06-24  551  	 * array member, which means there will be many bounds checks
54d9469bc515dc Kees Cook      2021-06-24  552  	 * that will appear at run-time, without a way for them to be
54d9469bc515dc Kees Cook      2021-06-24  553  	 * detected at compile-time (as can be done when the destination
54d9469bc515dc Kees Cook      2021-06-24  554  	 * is specifically the flexible array member).
54d9469bc515dc Kees Cook      2021-06-24  555  	 * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832
54d9469bc515dc Kees Cook      2021-06-24  556  	 */
54d9469bc515dc Kees Cook      2021-06-24  557  	if (p_size_field != 0 && p_size_field != SIZE_MAX &&
54d9469bc515dc Kees Cook      2021-06-24  558  	    p_size != p_size_field && p_size_field < size)
54d9469bc515dc Kees Cook      2021-06-24  559  		return true;
54d9469bc515dc Kees Cook      2021-06-24  560  
54d9469bc515dc Kees Cook      2021-06-24  561  	return false;
a28a6e860c6cf2 Francis Laniel 2021-02-25  562  }
a28a6e860c6cf2 Francis Laniel 2021-02-25  563  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
