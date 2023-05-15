Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999FD702F34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbjEOOFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbjEOOFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:05:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EB02688
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684159515; x=1715695515;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WaFpMMu3LNTzIiHIALPZGNFfXkASpyVUBB+K9Z1sPHY=;
  b=Pm1PTcZJ3k68GHUOg7GBA5YrqB5a1B5A+qg2BkrW7YV/dMtcJJDK7fxT
   SLmscciIsGE36zhQDSVGWi5dZsBO9Y8BaBu8J9wX/ScHkNf+V6VIJHKCl
   PxP59vDUsjx5Ozx0lhEHx0yqsXfyKGZa3EvtZdBoEmSK8hJVH7w5K17dS
   HVgRnlMnK4u/+44P7XdUV8XqAieEz/jNOUbZ06C78AjDtqTUJ/GJrZObx
   EHhL/PhyOBeoei+WMVgU/J/paS9IanVbo1PgX4o2Qcu8I+zKE0OjaKwMs
   DcoL9Gaz09okP9mKUYJMnHQlVWks8G6tRG1At82GtcccK2FPKk+8ZLw7B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="416860433"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="416860433"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 07:04:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="825197470"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="825197470"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 May 2023 07:04:17 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pyYoC-0006OA-3C;
        Mon, 15 May 2023 14:04:17 +0000
Date:   Mon, 15 May 2023 22:03:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Stitt <jstitt007@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202305152240.IBOKtkx6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7 include/uapi/linux/swab.h: move explicit cast outside ternary
date:   11 months ago
config: parisc-randconfig-s041-20230515 (https://download.01.org/0day-ci/archive/20230515/202305152240.IBOKtkx6-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash drivers/net/vmxnet3/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305152240.IBOKtkx6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] addr @@     got unsigned long long [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse:     expected restricted __le64 [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse:     got unsigned long long [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:244:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:244:22: sparse:     expected unsigned int [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:244:22: sparse:     got restricted __le32 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:1250:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got restricted __be16 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:1250:43: sparse:     expected restricted __wsum [usertype] csum
   drivers/net/vmxnet3/vmxnet3_drv.c:1250:43: sparse:     got restricted __be16 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:1392:17: sparse: sparse: restricted __le64 degrades to integer
   drivers/net/vmxnet3/vmxnet3_drv.c:1685:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le64 [usertype] addr @@
   drivers/net/vmxnet3/vmxnet3_drv.c:1685:33: sparse:     expected unsigned int [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:1685:33: sparse:     got restricted __le64 [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:1691:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le64 [usertype] addr @@
   drivers/net/vmxnet3/vmxnet3_drv.c:1691:33: sparse:     expected unsigned int [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:1691:33: sparse:     got restricted __le64 [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:2313:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2313:31: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2313:31: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2330:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2330:39: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2330:39: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2352:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2352:39: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2352:39: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2404:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2404:39: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2404:39: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2450:31: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/vmxnet3/vmxnet3_drv.c:2463:17: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le16 [usertype] mfTableLen @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2463:17: sparse:     expected unsigned int [usertype] size
   drivers/net/vmxnet3/vmxnet3_drv.c:2463:17: sparse:     got restricted __le16 [usertype] mfTableLen
   drivers/net/vmxnet3/vmxnet3_drv.c:2501:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2501:49: sparse:     expected unsigned int [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:2501:49: sparse:     got restricted __le32 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:2542:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] txDataRingDescSize @@     got restricted __le32 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2542:41: sparse:     expected restricted __le16 [usertype] txDataRingDescSize
   drivers/net/vmxnet3/vmxnet3_drv.c:2542:41: sparse:     got restricted __le32 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:2591:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] confVer @@     got int @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2591:46: sparse:     expected restricted __le32 [usertype] confVer
   drivers/net/vmxnet3/vmxnet3_drv.c:2591:46: sparse:     got int
   drivers/net/vmxnet3/vmxnet3_drv.c:2640:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] confVer @@     got int @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2640:34: sparse:     expected restricted __le32 [usertype] confVer
   drivers/net/vmxnet3/vmxnet3_drv.c:2640:34: sparse:     got int

vim +228 drivers/net/vmxnet3/vmxnet3_drv.c

d1a890fa37f27d Shreyas Bhatewara 2009-10-13  209  
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  210  #ifdef __BIG_ENDIAN_BITFIELD
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  211  /*
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  212   * The device expects the bitfields in shared structures to be written in
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  213   * little endian. When CPU is big endian, the following routines are used to
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  214   * correctly read and write into ABI.
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  215   * The general technique used here is : double word bitfields are defined in
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  216   * opposite order for big endian architecture. Then before reading them in
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  217   * driver the complete double word is translated using le32_to_cpu. Similarly
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  218   * After the driver writes into bitfields, cpu_to_le32 is used to translate the
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  219   * double words into required format.
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  220   * In order to avoid touching bits in shared structure more than once, temporary
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  221   * descriptors are used. These are passed as srcDesc to following functions.
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  222   */
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  223  static void vmxnet3_RxDescToCPU(const struct Vmxnet3_RxDesc *srcDesc,
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  224  				struct Vmxnet3_RxDesc *dstDesc)
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  225  {
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  226  	u32 *src = (u32 *)srcDesc + 2;
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  227  	u32 *dst = (u32 *)dstDesc + 2;
115924b6bdc7cc Shreyas Bhatewara 2009-11-16 @228  	dstDesc->addr = le64_to_cpu(srcDesc->addr);
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  229  	*dst = le32_to_cpu(*src);
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  230  	dstDesc->ext1 = le32_to_cpu(srcDesc->ext1);
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  231  }
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  232  

:::::: The code at line 228 was first introduced by commit
:::::: 115924b6bdc7cc6bf7da5b933b09281e1f4e17a9 net: Getting rid of the x86 dependency to built vmxnet3

:::::: TO: Shreyas Bhatewara <sbhatewara@vmware.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
