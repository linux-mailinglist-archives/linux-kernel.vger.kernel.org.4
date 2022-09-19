Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09035BD68D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiISVkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiISVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:40:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880A93FA05;
        Mon, 19 Sep 2022 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663623616; x=1695159616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9XHp03OKElTnJ7QmSS3tbUp2mmxjZ3uF1z6KwOYFKoc=;
  b=CkeB+qkM/u2n+bPcbPjsnwkTApfqJ3NZB3QnzvIe6mJMETQ7A+QI8NmN
   7JcqNYSUd6Tda4Y3KkSvti+jjSZcYlljnpsL/XiQQZyBajjI/Qx32h1+v
   ib3oTjZM5GoHpjtnyAEB74EV1AifMEFkVVuie5e5UzqhHA86oYWeuCxsH
   j07kEtaWD9lwUpsMtD7GpPHXBty1jtJGWig3x40VdA7qaXphTG+m37YDN
   Hjm2oQAuTdOoDx5zg1uxLW1XoE1b882O+5OWgAmjVEw7H1f4dlG2AZ00b
   fOul7TkdgMvvx80pwe6Q3CMOlTd3YIWcTh0K7gJLsXBwEjxB33SIY3SAn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="385817372"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="385817372"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 14:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="947398864"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2022 14:40:14 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaOUv-0002F1-2i;
        Mon, 19 Sep 2022 21:40:13 +0000
Date:   Tue, 20 Sep 2022 05:39:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>, Nick Terrell <terrelln@fb.com>
Cc:     kbuild-all@lists.01.org, Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] lib: zstd: build common files separately for compress
 and decompress
Message-ID: <202209200555.i687Ffik-lkp@intel.com>
References: <20220919120408.3956424-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919120408.3956424-1-npiggin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc6 next-20220919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicholas-Piggin/lib-zstd-build-common-files-separately-for-compress-and-decompress/20220919-200605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 521a547ced6477c54b4b0cc206000406c221b4d6
config: microblaze-randconfig-c043-20220918 (https://download.01.org/0day-ci/archive/20220920/202209200555.i687Ffik-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5c841e581c21f9aeb22e008899f84ac275b462a9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nicholas-Piggin/lib-zstd-build-common-files-separately-for-compress-and-decompress/20220919-200605
        git checkout 5c841e581c21f9aeb22e008899f84ac275b462a9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: lib/zstd/decompress/common/debug.o:lib/zstd/decompress/common/debug.c:24: multiple definition of `g_debuglevel'; lib/zstd/compress/common/debug.o:lib/zstd/compress/common/debug.c:24: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/entropy_common.o: in function `FSE_versionNumber':
   lib/zstd/decompress/common/entropy_common.c:27: multiple definition of `FSE_versionNumber'; lib/zstd/compress/common/entropy_common.o:lib/zstd/compress/common/entropy_common.c:27: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/entropy_common.o: in function `ERR_isError':
>> lib/zstd/decompress/common/error_private.h:45: multiple definition of `FSE_isError'; lib/zstd/compress/common/entropy_common.o:lib/zstd/compress/common/error_private.h:45: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/entropy_common.o: in function `FSE_getErrorName':
   lib/zstd/decompress/common/entropy_common.c:32: multiple definition of `FSE_getErrorName'; lib/zstd/compress/common/entropy_common.o:lib/zstd/compress/common/entropy_common.c:32: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/entropy_common.o: in function `ERR_isError':
>> lib/zstd/decompress/common/error_private.h:45: multiple definition of `HUF_isError'; lib/zstd/compress/common/entropy_common.o:lib/zstd/compress/common/error_private.h:45: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/entropy_common.o: in function `HUF_getErrorName':
   lib/zstd/decompress/common/entropy_common.c:35: multiple definition of `HUF_getErrorName'; lib/zstd/compress/common/entropy_common.o:lib/zstd/compress/common/entropy_common.c:35: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/entropy_common.o: in function `FSE_readNCount_bmi2':
   lib/zstd/decompress/common/entropy_common.c:226: multiple definition of `FSE_readNCount_bmi2'; lib/zstd/compress/common/entropy_common.o:lib/zstd/compress/common/entropy_common.c:226: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/entropy_common.o: in function `FSE_readNCount':
   lib/zstd/decompress/common/entropy_common.c:239: multiple definition of `FSE_readNCount'; lib/zstd/compress/common/entropy_common.o:lib/zstd/compress/common/entropy_common.c:239: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/entropy_common.o: in function `HUF_readStats':
   lib/zstd/decompress/common/entropy_common.c:254: multiple definition of `HUF_readStats'; lib/zstd/compress/common/entropy_common.o:lib/zstd/compress/common/entropy_common.c:254: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/entropy_common.o: in function `HUF_readStats_wksp':
   lib/zstd/decompress/common/entropy_common.c:349: multiple definition of `HUF_readStats_wksp'; lib/zstd/compress/common/entropy_common.o:lib/zstd/compress/common/entropy_common.c:349: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/error_private.o: in function `ERR_getErrorString':
   lib/zstd/decompress/common/error_private.c:22: multiple definition of `ERR_getErrorString'; lib/zstd/compress/common/error_private.o:lib/zstd/compress/common/error_private.c:22: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/fse_decompress.o: in function `FSE_createDTable':
   lib/zstd/decompress/common/fse_decompress.c:64: multiple definition of `FSE_createDTable'; lib/zstd/compress/common/fse_decompress.o:lib/zstd/compress/common/fse_decompress.c:64: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/fse_decompress.o: in function `FSE_freeDTable':
   lib/zstd/decompress/common/fse_decompress.c:69: multiple definition of `FSE_freeDTable'; lib/zstd/compress/common/fse_decompress.o:lib/zstd/compress/common/fse_decompress.c:69: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/fse_decompress.o: in function `FSE_buildDTable_wksp':
   lib/zstd/decompress/common/fse_decompress.c:177: multiple definition of `FSE_buildDTable_wksp'; lib/zstd/compress/common/fse_decompress.o:lib/zstd/compress/common/fse_decompress.c:177: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/fse_decompress.o: in function `FSE_buildDTable_rle':
   lib/zstd/decompress/common/fse_decompress.c:202: multiple definition of `FSE_buildDTable_rle'; lib/zstd/compress/common/fse_decompress.o:lib/zstd/compress/common/fse_decompress.c:202: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/fse_decompress.o: in function `FSE_buildDTable_raw':
   lib/zstd/decompress/common/fse_decompress.c:211: multiple definition of `FSE_buildDTable_raw'; lib/zstd/compress/common/fse_decompress.o:lib/zstd/compress/common/fse_decompress.c:211: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/fse_decompress.o: in function `FSE_decompress_usingDTable':
   lib/zstd/decompress/common/fse_decompress.c:297: multiple definition of `FSE_decompress_usingDTable'; lib/zstd/compress/common/fse_decompress.o:lib/zstd/compress/common/fse_decompress.c:297: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/fse_decompress.o: in function `FSE_decompress_wksp':
   lib/zstd/decompress/common/fse_decompress.c:309: multiple definition of `FSE_decompress_wksp'; lib/zstd/compress/common/fse_decompress.o:lib/zstd/compress/common/fse_decompress.c:309: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/fse_decompress.o: in function `FSE_decompress_wksp_bmi2':
   lib/zstd/decompress/common/fse_decompress.c:375: multiple definition of `FSE_decompress_wksp_bmi2'; lib/zstd/compress/common/fse_decompress.o:lib/zstd/compress/common/fse_decompress.c:375: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/zstd_common.o: in function `ZSTD_versionNumber':
   lib/zstd/decompress/common/zstd_common.c:25: multiple definition of `ZSTD_versionNumber'; lib/zstd/compress/common/zstd_common.o:lib/zstd/compress/common/zstd_common.c:25: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/zstd_common.o: in function `ZSTD_versionString':
   lib/zstd/decompress/common/zstd_common.c:27: multiple definition of `ZSTD_versionString'; lib/zstd/compress/common/zstd_common.o:lib/zstd/compress/common/zstd_common.c:27: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/zstd_common.o: in function `ERR_isError':
>> lib/zstd/decompress/common/error_private.h:45: multiple definition of `ZSTD_isError'; lib/zstd/compress/common/zstd_common.o:lib/zstd/compress/common/error_private.h:45: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/zstd_common.o: in function `ZSTD_getErrorName':
   lib/zstd/decompress/common/zstd_common.c:41: multiple definition of `ZSTD_getErrorName'; lib/zstd/compress/common/zstd_common.o:lib/zstd/compress/common/zstd_common.c:41: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/zstd_common.o: in function `ERR_getErrorCode':
>> lib/zstd/decompress/common/error_private.h:47: multiple definition of `ZSTD_getErrorCode'; lib/zstd/compress/common/zstd_common.o:lib/zstd/compress/common/error_private.h:47: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/zstd_common.o: in function `ZSTD_getErrorString':
   lib/zstd/decompress/common/zstd_common.c:49: multiple definition of `ZSTD_getErrorString'; lib/zstd/compress/common/zstd_common.o:lib/zstd/compress/common/zstd_common.c:49: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/zstd_common.o: in function `ZSTD_customMalloc':
   lib/zstd/decompress/common/zstd_common.c:57: multiple definition of `ZSTD_customMalloc'; lib/zstd/compress/common/zstd_common.o:lib/zstd/compress/common/zstd_common.c:57: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/zstd_common.o: in function `ZSTD_customCalloc':
   lib/zstd/decompress/common/zstd_common.c:64: multiple definition of `ZSTD_customCalloc'; lib/zstd/compress/common/zstd_common.o:lib/zstd/compress/common/zstd_common.c:64: first defined here
   microblaze-linux-ld: lib/zstd/decompress/common/zstd_common.o: in function `ZSTD_customFree':
   lib/zstd/decompress/common/zstd_common.c:76: multiple definition of `ZSTD_customFree'; lib/zstd/compress/common/zstd_common.o:lib/zstd/compress/common/zstd_common.c:76: first defined here


vim +45 lib/zstd/decompress/common/error_private.h

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
