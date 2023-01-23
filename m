Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A1677641
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjAWI0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjAWI0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:26:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76165196A0;
        Mon, 23 Jan 2023 00:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674462365; x=1705998365;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=09s0OxVD4yELiygvPoXhquCBPkkmgctRJPXVCJBDnIg=;
  b=a9S0FVlHK55JPB5BFNUmDocW0p46IS19CBw3tQJn9SeFcvbehtPr3rM7
   zVGlCdHytqb3mYCJrZXxr6J+bCtMB3raziXdaaTbm7urJDvGRDRr8z8Ny
   2CzAYKRBY4aeWt3sGdc7okNp6s6EiSPjypubUm27iCxAnzInMICqRDucl
   sGVW1gOy7AKCuU/RXxgfklaR7nvVCxAAy2HQhw238WezU7t4bF4+htgQT
   VGTOZYq/ceaPKqquvdmNoJO/vTQwOGrz4/VVjqW0SwKiFM3k0L68CzvpV
   yqSSw79UDxWGA5JzYY/2i8+F6/AQjpiMftJrm4jzvq+govX1Bbs3NjKub
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="412223323"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="412223323"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 00:26:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="692050160"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="692050160"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Jan 2023 00:26:02 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJs9R-0005WO-19;
        Mon, 23 Jan 2023 08:26:01 +0000
Date:   Mon, 23 Jan 2023 16:25:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: ld.lld: error: undefined symbol: vb2_vmalloc_memops
Message-ID: <202301231611.IEV8PsyF-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2475bf0250dee99b477e0c56d7dc9d7ac3f04117
commit: cb48ae89be3b6e916fe1640a9ee23fe4c87a1ca6 media: atomisp: Convert to videobuf2
date:   8 weeks ago
config: i386-randconfig-r014-20230123 (https://download.01.org/0day-ci/archive/20230123/202301231611.IEV8PsyF-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cb48ae89be3b6e916fe1640a9ee23fe4c87a1ca6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cb48ae89be3b6e916fe1640a9ee23fe4c87a1ca6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: vb2_vmalloc_memops
   >>> referenced by atomisp_fops.c:629 (drivers/staging/media/atomisp/pci/atomisp_fops.c:629)
   >>>               drivers/staging/media/atomisp/pci/atomisp_fops.o:(atomisp_open) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
