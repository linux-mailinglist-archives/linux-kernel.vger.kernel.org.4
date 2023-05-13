Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF7770154A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 10:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjEMInP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 04:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMInN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 04:43:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9AC4C10;
        Sat, 13 May 2023 01:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683967391; x=1715503391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+QgOiRaS6uSr1eVJzQcLvEfSxNZaNOBXvZTLLm9zO+E=;
  b=MryeNSW/TpIAQLasOR5vkHTYbaFfuS/iKhCHDdn0n/At+UZAZ4Pd3lrg
   1MYq/rxh3ulqhee3OIL7ihhJJSxNrPiblQ2LVXEqDbsvDf7gcxdBfvMiK
   nVoU3HBo5TQ9cjCE0nCu1kHZG4wxmDkuEDvkWA6B4mk4YGI5KvQ/oRqKr
   1K9vvZD1b8s4YZbajD8nXEmBgsr3ayxpStwo79Pbne3YNWQNCL8/eJVzY
   Sspz4Hoc4oei3CmDyMrnNLj2upYEIgm6LSny5gQTKQucFl96z3xUWlQVb
   uv3wUcPmZ7nOCaHSOU1L5GlVNLPYb0p73sSudjqKswwDENHZdcNFkte1M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="414322385"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="414322385"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 01:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="790071567"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="790071567"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 May 2023 01:43:07 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxkqJ-0005PI-0x;
        Sat, 13 May 2023 08:43:07 +0000
Date:   Sat, 13 May 2023 16:42:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Yang <mmyangfl@gmail.com>, linux-crypto@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] crypto: hisilicon - Add HiSilicon ADVCA Subsystem
Message-ID: <202305131630.Wt74Rpda-lkp@intel.com>
References: <20230513074339.266879-2-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513074339.266879-2-mmyangfl@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9a48d604672220545d209e9996c2a1edbb5637f6]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/crypto-hisilicon-Add-HiSilicon-ADVCA-Subsystem/20230513-154545
base:   9a48d604672220545d209e9996c2a1edbb5637f6
patch link:    https://lore.kernel.org/r/20230513074339.266879-2-mmyangfl%40gmail.com
patch subject: [PATCH v2 1/2] crypto: hisilicon - Add HiSilicon ADVCA Subsystem
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230513/202305131630.Wt74Rpda-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6f6cb7dd5da91063c560d2d252104268ffac785b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Yang/crypto-hisilicon-Add-HiSilicon-ADVCA-Subsystem/20230513-154545
        git checkout 6f6cb7dd5da91063c560d2d252104268ffac785b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/crypto/hisilicon/advca/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305131630.Wt74Rpda-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/crypto/hisilicon/advca/hisi-advca-muc.c:77:41: warning: unsigned conversion from 'int' to 'unsigned char:2' changes value from '4' to '0' [-Woverflow]
      77 | #define  MUC_MODE_CTR                   4  /* not for DES */
         |                                         ^
   drivers/crypto/hisilicon/advca/hisi-advca-muc.c:1283:25: note: in expansion of macro 'MUC_MODE_CTR'
    1283 |                 .mode = MUC_MODE_##_MODE, \
         |                         ^~~~~~~~~
   drivers/crypto/hisilicon/advca/hisi-advca-muc.c:1298:9: note: in expansion of macro 'hica_muc_tmpl_define'
    1298 |         hica_muc_tmpl_define(AES, _MODE, aes, _mode, AES_MIN_KEY_SIZE, \
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/crypto/hisilicon/advca/hisi-advca-muc.c:1311:9: note: in expansion of macro 'hica_muc_tmpl_define_aes'
    1311 |         hica_muc_tmpl_define_aes(CTR, ctr),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~


vim +77 drivers/crypto/hisilicon/advca/hisi-advca-muc.c

    69	
    70	/* for CTRL reg */
    71	#define MUC_DECRYPT		BIT(0)
    72	#define MUC_MODE		GENMASK(3, 1)  /* other: as 0 */
    73	#define  MUC_MODE_ECB			0
    74	#define  MUC_MODE_CBC			1
    75	#define  MUC_MODE_CFB			2
    76	#define  MUC_MODE_OFB			3
  > 77	#define  MUC_MODE_CTR			4  /* not for DES */
    78	#define MUC_ALG			GENMASK(5, 4)  /* other: as 0 */
    79	#define  MUC_ALG_DES			0
    80	#define  MUC_ALG_DES3_EDE		1
    81	#define  MUC_ALG_AES			2
    82	#define MUC_WIDTH		GENMASK(7, 6)  /* other: as 0 */
    83	#define  MUC_WIDTH_BLOCK		0
    84	#define  MUC_WIDTH_8B			1
    85	#define  MUC_WIDTH_1B			2
    86	#define MUC_CHAN0_IV_CHANGE	BIT(8)
    87	#define MUC_KEY			GENMASK(10, 9)  /* other: as 0 */
    88	#define  MUC_KEY_AES_128B		0
    89	#define  MUC_KEY_AES_192B		1
    90	#define  MUC_KEY_AES_256B		2
    91	#define  MUC_KEY_DES			0
    92	#define  MUC_KEY_DES3_EDE_3KEY		0
    93	#define  MUC_KEY_DES3_EDE_2KEY		3
    94	#define MUC_KEY_FROM_MKL	BIT(13)
    95	#define MUC_KEY_ID		GENMASK(16, 14)
    96	#define MUC_WEIGHT		GENMASK(31, 22)
    97	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
