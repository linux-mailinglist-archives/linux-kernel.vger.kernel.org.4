Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D241B7043FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 05:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjEPDf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 23:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEPDfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 23:35:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0484C2E
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684208153; x=1715744153;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VUAhUSEUp3Pf4jHAs0A0/40DQUetqOHN0KefYPTGyOk=;
  b=L1MWkFzUyTvK6saaZgR6h5OEBalBeb4JXN/lwmN6SK5TcBPsPFF57nWx
   aRbLjz1Zi7FDBvmUDP8/GUDjKDtzSy9cwFHnBptTXUrNR2bo8jg0id4ac
   XPfSGc6x1hCKgl4HBKCqoVIvGHMBC2JeS9DBT9oo7TyBgsClds3xb/m7H
   Jlw4myxkTq9j/xNWj30qshXhfKojOcuYQg+mILr+P++e87Va+0Vptlt3P
   UyPtYscSrVPRnWcqq+K+Ozrfy3Ge++hGyIjqm9A1CxZ5gN+Z8GeEm+o6x
   Or5+Gzg9knMrt/qYSqDlGONlNWMiadW4Hsrnw3MCt3GcHz6id8cNHR7by
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="340736356"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="340736356"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 20:35:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="813244905"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="813244905"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 May 2023 20:35:51 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pylTb-0006w4-0K;
        Tue, 16 May 2023 03:35:51 +0000
Date:   Tue, 16 May 2023 11:34:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28:
 sparse: sparse: incorrect type in argument 1 (different base types)
Message-ID: <202305161121.f86ZFbXd-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: a050910972bb25152b42ad2e544652117c5ad915 efi/libstub: implement generic EFI zboot
date:   8 months ago
config: riscv-randconfig-s041-20230515 (https://download.01.org/0day-ci/archive/20230516/202305161121.f86ZFbXd-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a050910972bb25152b42ad2e544652117c5ad915
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a050910972bb25152b42ad2e544652117c5ad915
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305161121.f86ZFbXd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
   drivers/firmware/efi/libstub/zboot.c: note: in included file (through drivers/firmware/efi/libstub/../../../../lib/decompress_unxz.c):
>> drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     expected restricted __le32 const [usertype] *p
   drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     got unsigned int const [usertype] *
   drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     expected restricted __le32 const [usertype] *p
   drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     got unsigned int const [usertype] *
   drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     expected restricted __le32 const [usertype] *p
   drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     got unsigned int const [usertype] *
   drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     expected restricted __le32 const [usertype] *p
   drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     got unsigned int const [usertype] *
   drivers/firmware/efi/libstub/zboot.c:163:1: sparse: sparse: symbol 'efi_zboot_entry' was not declared. Should it be static?

vim +393 drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c

24fa0402a9b6a5 Lasse Collin 2011-01-12  385  
24fa0402a9b6a5 Lasse Collin 2011-01-12  386  /* Decode the Stream Header field (the first 12 bytes of the .xz Stream). */
24fa0402a9b6a5 Lasse Collin 2011-01-12  387  static enum xz_ret dec_stream_header(struct xz_dec *s)
24fa0402a9b6a5 Lasse Collin 2011-01-12  388  {
24fa0402a9b6a5 Lasse Collin 2011-01-12  389  	if (!memeq(s->temp.buf, HEADER_MAGIC, HEADER_MAGIC_SIZE))
24fa0402a9b6a5 Lasse Collin 2011-01-12  390  		return XZ_FORMAT_ERROR;
24fa0402a9b6a5 Lasse Collin 2011-01-12  391  
24fa0402a9b6a5 Lasse Collin 2011-01-12  392  	if (xz_crc32(s->temp.buf + HEADER_MAGIC_SIZE, 2, 0)
24fa0402a9b6a5 Lasse Collin 2011-01-12 @393  			!= get_le32(s->temp.buf + HEADER_MAGIC_SIZE + 2))
24fa0402a9b6a5 Lasse Collin 2011-01-12  394  		return XZ_DATA_ERROR;
24fa0402a9b6a5 Lasse Collin 2011-01-12  395  
24fa0402a9b6a5 Lasse Collin 2011-01-12  396  	if (s->temp.buf[HEADER_MAGIC_SIZE] != 0)
24fa0402a9b6a5 Lasse Collin 2011-01-12  397  		return XZ_OPTIONS_ERROR;
24fa0402a9b6a5 Lasse Collin 2011-01-12  398  
24fa0402a9b6a5 Lasse Collin 2011-01-12  399  	/*
24fa0402a9b6a5 Lasse Collin 2011-01-12  400  	 * Of integrity checks, we support only none (Check ID = 0) and
24fa0402a9b6a5 Lasse Collin 2011-01-12  401  	 * CRC32 (Check ID = 1). However, if XZ_DEC_ANY_CHECK is defined,
24fa0402a9b6a5 Lasse Collin 2011-01-12  402  	 * we will accept other check types too, but then the check won't
24fa0402a9b6a5 Lasse Collin 2011-01-12  403  	 * be verified and a warning (XZ_UNSUPPORTED_CHECK) will be given.
24fa0402a9b6a5 Lasse Collin 2011-01-12  404  	 */
4f8d7abaa413c3 Lasse Collin 2021-10-11  405  	if (s->temp.buf[HEADER_MAGIC_SIZE + 1] > XZ_CHECK_MAX)
4f8d7abaa413c3 Lasse Collin 2021-10-11  406  		return XZ_OPTIONS_ERROR;
4f8d7abaa413c3 Lasse Collin 2021-10-11  407  
24fa0402a9b6a5 Lasse Collin 2011-01-12  408  	s->check_type = s->temp.buf[HEADER_MAGIC_SIZE + 1];
24fa0402a9b6a5 Lasse Collin 2011-01-12  409  

:::::: The code at line 393 was first introduced by commit
:::::: 24fa0402a9b6a537e87e38341e78b7da86486846 decompressors: add XZ decompressor module

:::::: TO: Lasse Collin <lasse.collin@tukaani.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
