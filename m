Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C176DBA1F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDHKkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDHKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:40:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA755BDCA
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680950406; x=1712486406;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eKHqVAL32smantM3k8Lt5d+MUOKLe+OaL0Irr/VIGVA=;
  b=JTJxOwV0093aAysSys+oNz7GMKviTFB0ipP6op25LjwFRrK8m6LDlcaj
   nttJhfvwRlPI6G9Kk/BH2xrcTYGK8hF7uHKjxxglCclWWv+uTVUU1Aue4
   noUqjf0Palshd6yUMeAVFqaQD4OdEO78TDUtPxSEEzF1UKWd25tkQrP8e
   7INK3ZidoDcQhIRm69/kMX/6nIIjSDYuufRvJVme0Dcv0kWUD55OA5vOJ
   k8EwcOH+N4Cwn3K3JHA+jzN8fv0GuWaBbzoMmGOwOYFDp+6GLSZzSWfsT
   O+hcK8gmK7DHHa7jbmPk4hNIPjCKCxG/mN12CnJDSeijDw79KrFPboLWY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="344911147"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="344911147"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 03:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="665149570"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="665149570"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Apr 2023 03:38:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pl5y0-000Tdd-0X;
        Sat, 08 Apr 2023 10:38:44 +0000
Date:   Sat, 8 Apr 2023 18:38:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robert Elliott <elliott@hpe.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: arch/arm/crypto/sha1_neon_glue.c:43:8: warning: cast from 'void
 (*)(void *, const char *, unsigned int)' to 'sha1_block_fn *' (aka 'void
 (*)(struct sha1_state *, const unsigned char *, int)') converts to
 incompatible function type
Message-ID: <202304081828.zjGcFUyE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aa318c48808c0aa73216bd94c54c4553d3663add
commit: 4a329fecc9aaebb27a53fa7abfa53bbc2ee42f3f crypto: Kconfig - submenus for arm and arm64
date:   8 months ago
config: arm-milbeaut_m10v_defconfig (https://download.01.org/0day-ci/archive/20230408/202304081828.zjGcFUyE-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4a329fecc9aaebb27a53fa7abfa53bbc2ee42f3f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4a329fecc9aaebb27a53fa7abfa53bbc2ee42f3f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/boot/compressed/ arch/arm/crypto/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304081828.zjGcFUyE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/crypto/sha1_neon_glue.c:43:8: warning: cast from 'void (*)(void *, const char *, unsigned int)' to 'sha1_block_fn *' (aka 'void (*)(struct sha1_state *, const unsigned char *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                               (sha1_block_fn *)sha1_transform_neon);
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/crypto/sha1_neon_glue.c:58:9: warning: cast from 'void (*)(void *, const char *, unsigned int)' to 'sha1_block_fn *' (aka 'void (*)(struct sha1_state *, const unsigned char *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                                       (sha1_block_fn *)sha1_transform_neon);
                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/crypto/sha1_neon_glue.c:59:30: warning: cast from 'void (*)(void *, const char *, unsigned int)' to 'sha1_block_fn *' (aka 'void (*)(struct sha1_state *, const unsigned char *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_transform_neon);
                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings generated.
--
>> arch/arm/crypto/sha256_neon_glue.c:38:4: warning: cast from 'void (*)(u32 *, const void *, unsigned int)' (aka 'void (*)(unsigned int *, const void *, unsigned int)') to 'sha256_block_fn *' (aka 'void (*)(struct sha256_state *, const unsigned char *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                           (sha256_block_fn *)sha256_block_data_order_neon);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/crypto/sha256_neon_glue.c:53:4: warning: cast from 'void (*)(u32 *, const void *, unsigned int)' (aka 'void (*)(unsigned int *, const void *, unsigned int)') to 'sha256_block_fn *' (aka 'void (*)(struct sha256_state *, const unsigned char *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                           (sha256_block_fn *)sha256_block_data_order_neon);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/crypto/sha256_neon_glue.c:55:4: warning: cast from 'void (*)(u32 *, const void *, unsigned int)' (aka 'void (*)(unsigned int *, const void *, unsigned int)') to 'sha256_block_fn *' (aka 'void (*)(struct sha256_state *, const unsigned char *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                           (sha256_block_fn *)sha256_block_data_order_neon);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings generated.
--
>> arch/arm/crypto/sha512-neon-glue.c:37:3: warning: cast from 'void (*)(u64 *, const u8 *, int)' (aka 'void (*)(unsigned long long *, const unsigned char *, int)') to 'sha512_block_fn *' (aka 'void (*)(struct sha512_state *, const unsigned char *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   (sha512_block_fn *)sha512_block_data_order_neon);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/crypto/sha512-neon-glue.c:52:4: warning: cast from 'void (*)(u64 *, const u8 *, int)' (aka 'void (*)(unsigned long long *, const unsigned char *, int)') to 'sha512_block_fn *' (aka 'void (*)(struct sha512_state *, const unsigned char *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                           (sha512_block_fn *)sha512_block_data_order_neon);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/crypto/sha512-neon-glue.c:54:3: warning: cast from 'void (*)(u64 *, const u8 *, int)' (aka 'void (*)(unsigned long long *, const unsigned char *, int)') to 'sha512_block_fn *' (aka 'void (*)(struct sha512_state *, const unsigned char *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   (sha512_block_fn *)sha512_block_data_order_neon);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings generated.


vim +43 arch/arm/crypto/sha1_neon_glue.c

604682551aa511e Jussi Kivilinna 2014-07-29  28  
604682551aa511e Jussi Kivilinna 2014-07-29  29  asmlinkage void sha1_transform_neon(void *state_h, const char *data,
604682551aa511e Jussi Kivilinna 2014-07-29  30  				    unsigned int rounds);
604682551aa511e Jussi Kivilinna 2014-07-29  31  
604682551aa511e Jussi Kivilinna 2014-07-29  32  static int sha1_neon_update(struct shash_desc *desc, const u8 *data,
604682551aa511e Jussi Kivilinna 2014-07-29  33  			  unsigned int len)
604682551aa511e Jussi Kivilinna 2014-07-29  34  {
604682551aa511e Jussi Kivilinna 2014-07-29  35  	struct sha1_state *sctx = shash_desc_ctx(desc);
604682551aa511e Jussi Kivilinna 2014-07-29  36  
99680c5e9182945 Eric Biggers    2019-03-12  37  	if (!crypto_simd_usable() ||
51e515faa887e40 Ard Biesheuvel  2015-04-09  38  	    (sctx->count % SHA1_BLOCK_SIZE) + len < SHA1_BLOCK_SIZE)
51e515faa887e40 Ard Biesheuvel  2015-04-09  39  		return sha1_update_arm(desc, data, len);
604682551aa511e Jussi Kivilinna 2014-07-29  40  
604682551aa511e Jussi Kivilinna 2014-07-29  41  	kernel_neon_begin();
51e515faa887e40 Ard Biesheuvel  2015-04-09  42  	sha1_base_do_update(desc, data, len,
51e515faa887e40 Ard Biesheuvel  2015-04-09 @43  			    (sha1_block_fn *)sha1_transform_neon);
604682551aa511e Jussi Kivilinna 2014-07-29  44  	kernel_neon_end();
604682551aa511e Jussi Kivilinna 2014-07-29  45  
604682551aa511e Jussi Kivilinna 2014-07-29  46  	return 0;
604682551aa511e Jussi Kivilinna 2014-07-29  47  }
604682551aa511e Jussi Kivilinna 2014-07-29  48  

:::::: The code at line 43 was first introduced by commit
:::::: 51e515faa887e40e7e30a3e13607ea6be418e4c4 crypto: arm/sha1_neon - move SHA-1 NEON implementation to base layer

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
