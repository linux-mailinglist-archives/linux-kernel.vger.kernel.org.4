Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B205BAF2E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiIPOXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiIPOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:23:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5B1923C9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663338180; x=1694874180;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+Uq8/Qm9rAnA0pwSxTizcf5pgMVHtsJ+n/ks5w9hDuc=;
  b=Oo6P8QE1CD/YZE3Q6MZcskIOR27he7aRHwRjUPFScFbLSEgr+XbgNtED
   t9bASl4puI7bc6BWt5qjZpjSZ/Iqg38FGq3UrJSu3CFBYhL0mJR6A/cpN
   qKBKzUjdWlceLR971JCBOa38iiQZ6NKdlDhF4o77y5KAEVjz0WGK3Vf2H
   1Q5iTNzy2D/QwYPYXaOikhYQIwJ4TELbiMERYOzXZL6/crSZCc/YfleyQ
   5/Xt2oV4cvcJmTFMTnGxk7nhVRbSa55dnQyNcELujO0u0yhQAvPouH8mB
   i7tiEETwB7LrzJlRdBJtXbks7dYuk+xqUmI9QKUandAe9j80RPU0wKyh5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="362963363"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="362963363"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="946389479"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Sep 2022 07:22:57 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZCF6-0001q6-20;
        Fri, 16 Sep 2022 14:22:56 +0000
Date:   Fri, 16 Sep 2022 22:22:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:palmer/linux/vdso-fix-v3 9/9]
 arch/riscv/kernel/vdso.c:26:27: warning: tentative definition of variable
 with internal linkage has incomplete non-array type 'struct __vdso_info'
Message-ID: <202209162203.LQxeIrqT-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/vdso-fix-v3
head:   fcbe4db4bf998e22fc7a35a2e02f6ba3d5ffb5db
commit: fcbe4db4bf998e22fc7a35a2e02f6ba3d5ffb5db [9/9] WIP: riscv: vdso: fix NULL deference in vdso_join_timens() when vfork
config: riscv-randconfig-r022-20220916 (https://download.01.org/0day-ci/archive/20220916/202209162203.LQxeIrqT-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/fcbe4db4bf998e22fc7a35a2e02f6ba3d5ffb5db
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/vdso-fix-v3
        git checkout fcbe4db4bf998e22fc7a35a2e02f6ba3d5ffb5db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ drivers/char/pcmcia/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/vdso.c:26:27: warning: tentative definition of variable with internal linkage has incomplete non-array type 'struct __vdso_info' [-Wtentative-definition-incomplete-type]
   static struct __vdso_info vdso_info;
                             ^
   arch/riscv/kernel/vdso.c:26:15: note: forward declaration of 'struct __vdso_info'
   static struct __vdso_info vdso_info;
                 ^
   arch/riscv/kernel/vdso.c:29:27: warning: tentative definition of variable with internal linkage has incomplete non-array type 'struct __vdso_info' [-Wtentative-definition-incomplete-type]
   static struct __vdso_info compat_vdso_info;
                             ^
   arch/riscv/kernel/vdso.c:26:15: note: forward declaration of 'struct __vdso_info'
   static struct __vdso_info vdso_info;
                 ^
   2 warnings generated.


vim +26 arch/riscv/kernel/vdso.c

    24	
    25	extern char vdso_start[], vdso_end[];
  > 26	static struct __vdso_info vdso_info;
    27	#ifdef CONFIG_COMPAT
    28	extern char compat_vdso_start[], compat_vdso_end[];
    29	static struct __vdso_info compat_vdso_info;
    30	#endif
    31	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
