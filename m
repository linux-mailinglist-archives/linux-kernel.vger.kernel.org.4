Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B512974A750
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGFWwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjGFWwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:52:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19801BE1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688683935; x=1720219935;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4xApv630bDWGA3D1AqAA58hMQu4Ci3gLE1FNV1ctCI8=;
  b=Jcl2fg12RcOWk5mQ7Z7faeS5IwE9Pxo8q7IC1H/K24B6nV1j6ndJVa0m
   h3zglQBGgM5i7o5+iK/D4t2QY2M0h9duNvyeewrc1feh7aiwCFhwmbY3y
   oRwnRZaA2Ibwe4LIcR2Ab4KBR/tAcS7/CNpG7RDZDLzw7U2o+tS+UsS29
   Wwj8x92r3lQs8YFtjpJvDDy8G+B9KpNyuPOjM8J8/Zxc3HYraDLj+E1ms
   z0s1/8BCoboMXE+Lr+Bewbc3Aq4tJm1HAIfbouKSuKEfi5vPaIGmZNOVx
   nTUqKvQ9wlk83ORoCSI3d0uW1PUVS4VCit/DRphUNEDtCsp9XWUEGyhsG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="343331363"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="343331363"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 15:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="843889869"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="843889869"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2023 15:51:45 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHXp9-0001aw-2R;
        Thu, 06 Jul 2023 22:51:43 +0000
Date:   Fri, 7 Jul 2023 06:50:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Seung-Woo Kim <sw0312.kim@samsung.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: lib/crypto/chacha.c:64:1: warning: the frame size of 1600 bytes is
 larger than 1024 bytes
Message-ID: <202307070612.8DMHJyR2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Seung-Woo,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a452483508d7b70b0f6c69e249ec0b3ea2330b5c
commit: d539fee9f825b0c8eac049732c83562b28a483b5 ARM: 9253/1: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
date:   8 months ago
config: arm-randconfig-r015-20230707 (https://download.01.org/0day-ci/archive/20230707/202307070612.8DMHJyR2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230707/202307070612.8DMHJyR2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307070612.8DMHJyR2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/crypto/chacha.c: In function 'chacha_permute':
>> lib/crypto/chacha.c:64:1: warning: the frame size of 1600 bytes is larger than 1024 bytes [-Wframe-larger-than=]
      64 | }
         | ^
--
   drivers/crypto/ccree/cc_hash.c: In function 'cc_hash_setkey':
>> drivers/crypto/ccree/cc_hash.c:919:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     919 | }
         | ^


vim +64 lib/crypto/chacha.c

e192be9d9a3055 lib/chacha20.c Theodore Ts'o 2016-06-12  15  
1ca1b917940c24 lib/chacha.c   Eric Biggers  2018-11-16  16  static void chacha_permute(u32 *x, int nrounds)
e192be9d9a3055 lib/chacha20.c Theodore Ts'o 2016-06-12  17  {
e192be9d9a3055 lib/chacha20.c Theodore Ts'o 2016-06-12  18  	int i;
e192be9d9a3055 lib/chacha20.c Theodore Ts'o 2016-06-12  19  
1ca1b917940c24 lib/chacha.c   Eric Biggers  2018-11-16  20  	/* whitelist the allowed round counts */
aa7624093cb7fb lib/chacha.c   Eric Biggers  2018-11-16  21  	WARN_ON_ONCE(nrounds != 20 && nrounds != 12);
1ca1b917940c24 lib/chacha.c   Eric Biggers  2018-11-16  22  
1ca1b917940c24 lib/chacha.c   Eric Biggers  2018-11-16  23  	for (i = 0; i < nrounds; i += 2) {
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  24  		x[0]  += x[4];    x[12] = rol32(x[12] ^ x[0],  16);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  25  		x[1]  += x[5];    x[13] = rol32(x[13] ^ x[1],  16);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  26  		x[2]  += x[6];    x[14] = rol32(x[14] ^ x[2],  16);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  27  		x[3]  += x[7];    x[15] = rol32(x[15] ^ x[3],  16);
e192be9d9a3055 lib/chacha20.c Theodore Ts'o 2016-06-12  28  
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  29  		x[8]  += x[12];   x[4]  = rol32(x[4]  ^ x[8],  12);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  30  		x[9]  += x[13];   x[5]  = rol32(x[5]  ^ x[9],  12);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  31  		x[10] += x[14];   x[6]  = rol32(x[6]  ^ x[10], 12);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  32  		x[11] += x[15];   x[7]  = rol32(x[7]  ^ x[11], 12);
e192be9d9a3055 lib/chacha20.c Theodore Ts'o 2016-06-12  33  
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  34  		x[0]  += x[4];    x[12] = rol32(x[12] ^ x[0],   8);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  35  		x[1]  += x[5];    x[13] = rol32(x[13] ^ x[1],   8);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  36  		x[2]  += x[6];    x[14] = rol32(x[14] ^ x[2],   8);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  37  		x[3]  += x[7];    x[15] = rol32(x[15] ^ x[3],   8);
e192be9d9a3055 lib/chacha20.c Theodore Ts'o 2016-06-12  38  
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  39  		x[8]  += x[12];   x[4]  = rol32(x[4]  ^ x[8],   7);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  40  		x[9]  += x[13];   x[5]  = rol32(x[5]  ^ x[9],   7);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  41  		x[10] += x[14];   x[6]  = rol32(x[6]  ^ x[10],  7);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  42  		x[11] += x[15];   x[7]  = rol32(x[7]  ^ x[11],  7);
e192be9d9a3055 lib/chacha20.c Theodore Ts'o 2016-06-12  43  
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  44  		x[0]  += x[5];    x[15] = rol32(x[15] ^ x[0],  16);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  45  		x[1]  += x[6];    x[12] = rol32(x[12] ^ x[1],  16);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  46  		x[2]  += x[7];    x[13] = rol32(x[13] ^ x[2],  16);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  47  		x[3]  += x[4];    x[14] = rol32(x[14] ^ x[3],  16);
e192be9d9a3055 lib/chacha20.c Theodore Ts'o 2016-06-12  48  
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  49  		x[10] += x[15];   x[5]  = rol32(x[5]  ^ x[10], 12);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  50  		x[11] += x[12];   x[6]  = rol32(x[6]  ^ x[11], 12);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  51  		x[8]  += x[13];   x[7]  = rol32(x[7]  ^ x[8],  12);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  52  		x[9]  += x[14];   x[4]  = rol32(x[4]  ^ x[9],  12);
e192be9d9a3055 lib/chacha20.c Theodore Ts'o 2016-06-12  53  
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  54  		x[0]  += x[5];    x[15] = rol32(x[15] ^ x[0],   8);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  55  		x[1]  += x[6];    x[12] = rol32(x[12] ^ x[1],   8);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  56  		x[2]  += x[7];    x[13] = rol32(x[13] ^ x[2],   8);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  57  		x[3]  += x[4];    x[14] = rol32(x[14] ^ x[3],   8);
e192be9d9a3055 lib/chacha20.c Theodore Ts'o 2016-06-12  58  
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  59  		x[10] += x[15];   x[5]  = rol32(x[5]  ^ x[10],  7);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  60  		x[11] += x[12];   x[6]  = rol32(x[6]  ^ x[11],  7);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  61  		x[8]  += x[13];   x[7]  = rol32(x[7]  ^ x[8],   7);
7660b1fb367eb3 lib/chacha20.c Eric Biggers  2017-12-31  62  		x[9]  += x[14];   x[4]  = rol32(x[4]  ^ x[9],   7);
e192be9d9a3055 lib/chacha20.c Theodore Ts'o 2016-06-12  63  	}
dd333449d0fb66 lib/chacha20.c Eric Biggers  2018-11-16 @64  }
dd333449d0fb66 lib/chacha20.c Eric Biggers  2018-11-16  65  

:::::: The code at line 64 was first introduced by commit
:::::: dd333449d0fb667c5250c42488a7e90470e16c77 crypto: chacha20-generic - add HChaCha20 library function

:::::: TO: Eric Biggers <ebiggers@google.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
