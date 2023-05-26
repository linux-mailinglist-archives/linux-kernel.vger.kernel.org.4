Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2B8712EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbjEZVUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEZVUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:20:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF19599;
        Fri, 26 May 2023 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685136047; x=1716672047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7KsCT3WZ1HGpyHVyBAkJkfv5z2dS/oXPfy61ucCGhNo=;
  b=AV1iAvnVn3L9a52thwfbALwL0hOHU6RmVaV8gL/Lp7jYnKeWad/64hZu
   jPblRXaQDEMmZT/AwhiN6VqwKvlcCQT87AiOAU5xGbc8wDKLLiKBPadSY
   fRT8HwLFe8osTDM1g1wK85rJw9WCZY3T2UuZH8t9byuu4gfPnX8N9kc09
   QYToI5W7GFGw81NxJT0C/qZYVODOuQKCi/i1O52zJSVnUvNwHzaZNYF3J
   AJGADLx2ieouwl7QmLD8FL+7cesRXdsxw5Pq1k296O/qls6dxbGgZUU0b
   BBHxmH/DGMzNsADJWRlPzxYgk0QGYeaJ3iQKkpmn/ILscvESWXEhhwbzy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="343804529"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="343804529"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 14:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="849683617"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="849683617"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2023 14:20:45 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2erc-000Jba-0x;
        Fri, 26 May 2023 21:20:44 +0000
Date:   Sat, 27 May 2023 05:19:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Yang <mmyangfl@gmail.com>, linux-crypto@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] crypto: hisilicon - Add HiSilicon ADVCA Subsystem
Message-ID: <202305270501.pOwEtEy0-lkp@intel.com>
References: <20230525160446.43800-2-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525160446.43800-2-mmyangfl@gmail.com>
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

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 44c026a73be8038f03dbdeef028b642880cf1511]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/crypto-hisilicon-Add-HiSilicon-ADVCA-Subsystem/20230526-002048
base:   44c026a73be8038f03dbdeef028b642880cf1511
patch link:    https://lore.kernel.org/r/20230525160446.43800-2-mmyangfl%40gmail.com
patch subject: [PATCH v3 1/2] crypto: hisilicon - Add HiSilicon ADVCA Subsystem
config: alpha-randconfig-s033-20230526 (https://download.01.org/0day-ci/archive/20230527/202305270501.pOwEtEy0-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/ae9280d4724511425d7fc2ad1119eba4e52f70b5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Yang/crypto-hisilicon-Add-HiSilicon-ADVCA-Subsystem/20230526-002048
        git checkout ae9280d4724511425d7fc2ad1119eba4e52f70b5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/crypto/hisilicon/advca/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305270501.pOwEtEy0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/crypto/hisilicon/advca/hisi-advca-muc.c:149:3: sparse: sparse: symbol 'hica_muc_key_maps' was not declared. Should it be static?

vim +/hica_muc_key_maps +149 drivers/crypto/hisilicon/advca/hisi-advca-muc.c

   144	
   145	struct hica_muc_key_map {
   146		unsigned int alg;
   147		unsigned int key;
   148		unsigned int len;
 > 149	} hica_muc_key_maps[] = {
   150		{      MUC_ALG_AES,      MUC_KEY_AES_256B,   AES_KEYSIZE_256 },
   151		{      MUC_ALG_AES,      MUC_KEY_AES_192B,   AES_KEYSIZE_192 },
   152		{      MUC_ALG_AES,      MUC_KEY_AES_128B,   AES_KEYSIZE_128 },
   153		{      MUC_ALG_DES,           MUC_KEY_DES,      DES_KEY_SIZE },
   154		{ MUC_ALG_DES3_EDE, MUC_KEY_DES3_EDE_3KEY, DES3_EDE_KEY_SIZE },
   155		{ MUC_ALG_DES3_EDE, MUC_KEY_DES3_EDE_2KEY,  2 * DES_KEY_SIZE },
   156		{ }
   157	};
   158	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
