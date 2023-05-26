Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C681713039
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjEZXF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjEZXFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:05:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E8CAD;
        Fri, 26 May 2023 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685142352; x=1716678352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pvJQz74MnTdZRRPfhTypRddqinT3EDy3g2yrcXnBbtk=;
  b=ZsL3nzskDBFyIoaHBcU3K/yYfdbEhqP/svf7iIQeDMJoDwzdiOG11ryG
   0+qZTjfHAOvfqjYFXrcTsxQWRrx7PQshxb9Qq6qmKAtmNS+ZAhFP+vfr3
   ftCoNjGHMDP2Sc7dEyGe/EHr9SQu4nLe/C137zoXA+LkHIJB0fzXKT2su
   CES2bmwg++Ji3YHCenE60jIFVktsl+IPvzVja4/DQyQ8xxks6tGkYQFpt
   /d4o852ZP/m0Z+P2RxwiitXA7Z5oav877KYh+nFpSF/pUHZ/HLac2vP8H
   SBH8gyFdaIyttQqrMINmeu7a1plpYBCFaknPhhR46mjWkpPpNhR/D2bvv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="356709014"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="356709014"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 16:05:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="879689885"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="879689885"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2023 16:05:47 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2gVG-000JeU-0A;
        Fri, 26 May 2023 23:05:46 +0000
Date:   Sat, 27 May 2023 07:04:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Yang <mmyangfl@gmail.com>, linux-crypto@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] crypto: hisilicon/advca - Add SHA support
Message-ID: <202305270619.CZWqR9rV-lkp@intel.com>
References: <20230525160446.43800-3-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525160446.43800-3-mmyangfl@gmail.com>
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
patch link:    https://lore.kernel.org/r/20230525160446.43800-3-mmyangfl%40gmail.com
patch subject: [PATCH v3 2/2] crypto: hisilicon/advca - Add SHA support
config: alpha-randconfig-s033-20230526 (https://download.01.org/0day-ci/archive/20230527/202305270619.CZWqR9rV-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/e564a62a5be87775c20a4de84d42b8be79be9d11
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Yang/crypto-hisilicon-Add-HiSilicon-ADVCA-Subsystem/20230526-002048
        git checkout e564a62a5be87775c20a4de84d42b8be79be9d11
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/crypto/hisilicon/advca/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305270619.CZWqR9rV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/crypto/hisilicon/advca/hisi-advca-sha.c:163:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
   drivers/crypto/hisilicon/advca/hisi-advca-sha.c:163:32: sparse:     expected unsigned int [usertype] b
   drivers/crypto/hisilicon/advca/hisi-advca-sha.c:163:32: sparse:     got restricted __be32 [usertype]
>> drivers/crypto/hisilicon/advca/hisi-advca-sha.c:269:25: sparse: sparse: cast to restricted __be32
>> drivers/crypto/hisilicon/advca/hisi-advca-sha.c:269:25: sparse: sparse: cast to restricted __be32
>> drivers/crypto/hisilicon/advca/hisi-advca-sha.c:269:25: sparse: sparse: cast to restricted __be32
>> drivers/crypto/hisilicon/advca/hisi-advca-sha.c:269:25: sparse: sparse: cast to restricted __be32
>> drivers/crypto/hisilicon/advca/hisi-advca-sha.c:269:25: sparse: sparse: cast to restricted __be32
>> drivers/crypto/hisilicon/advca/hisi-advca-sha.c:269:25: sparse: sparse: cast to restricted __be32

vim +163 drivers/crypto/hisilicon/advca/hisi-advca-sha.c

   152	
   153	/*
   154	 * must be called before setting SHA_START
   155	 * does nothing if import is not supported (SHA_TYPE_HASH)
   156	 */
   157	static void hica_sha_import(const struct hica_sha_priv *priv, const void *state)
   158	{
   159		if (priv->type != SHA_TYPE_MHASH)
   160			return;
   161	
   162		for (unsigned int i = 0; i < SHA_DIGEST_SIZE; i += sizeof(u32))
 > 163			writel_relaxed(cpu_to_be32(*(const u32 *) (state + i)),
   164				       priv->base + SHA_INIT0 + i);
   165	}
   166	
   167	static int hica_sha_init(const struct hica_sha_priv *priv,
   168				 const struct hica_sha_ctrl *ctrl, bool state)
   169	{
   170		u32 val;
   171		int ret;
   172	
   173		/* re-enable SHA_START */
   174		ret = reset_control_assert(priv->rst) ?:
   175		      reset_control_deassert(priv->rst);
   176		if (ret)
   177			return ret;
   178	
   179		/* config SHA_CTRL */
   180		val = readl_relaxed(priv->base + SHA_CTRL);
   181	
   182		val &= ~SHA_SINGLE_READ;
   183		val &= ~SHA_ALG;
   184		val |= (ctrl->alg << 1) & SHA_ALG;
   185		val &= ~SHA_HMAC;
   186		val |= SHA_ENDIAN;
   187	
   188		if (priv->type == SHA_TYPE_HASH)
   189			val |= SHA_USED_BY_ARM;
   190		else if (state)
   191			val |= SHA_SET_INIT;
   192	
   193		writel(val, priv->base + SHA_CTRL);
   194	
   195		/* test SHA_CTRL */
   196		val = readl_relaxed(priv->base + SHA_CTRL);
   197		if (val & SHA_USED_BY_C51)
   198			return -EBUSY;
   199	
   200		/* wait ready */
   201		if (hica_sha_wait(priv, SHA_HASH_READY))
   202			return -ETIMEDOUT;
   203	
   204		/* ask device to set state */
   205		writel(SHA_START_BIT, priv->base + SHA_START);
   206	
   207		pr_debug("%s: alg %u\n", __func__, ctrl->alg);
   208		return 0;
   209	}
   210	
   211	static int hica_sha_update(const struct hica_sha_priv *priv, const void *data,
   212				   unsigned int len, bool may_sleep)
   213	{
   214		struct device *dev = priv->dev;
   215		bool inplace = !((uintptr_t) data & 3);
   216		u8 *buf = NULL;
   217		dma_addr_t addr;
   218		int ret;
   219	
   220		if (!len)
   221			return 0;
   222	
   223		if (WARN_ON(len % SHA_BLOCK_SIZE))
   224			return -EINVAL;
   225	
   226		if (inplace) {
   227			addr = dma_map_single(dev, (void *) data, len, DMA_TO_DEVICE);
   228			if (dma_mapping_error(dev, addr)) {
   229				dev_err(dev, "error mapping src\n");
   230				return -EIO;
   231			}
   232	
   233			inplace = !(addr & 3);
   234			if (!inplace)
   235				dma_unmap_single(dev, addr, len, DMA_TO_DEVICE);
   236		}
   237	
   238		if (!inplace) {
   239			buf = dma_alloc_attrs(dev, len, &addr,
   240					      may_sleep ? GFP_KERNEL : GFP_ATOMIC, 0);
   241			if (!buf)
   242				return -ENOMEM;
   243			memcpy(buf, data, len);
   244		}
   245	
   246		dma_sync_single_for_device(dev, addr, len, DMA_TO_DEVICE);
   247		ret = hica_sha_record(priv, addr, len) ?:
   248		      hica_sha_wait(priv, SHA_RECORD_READY);
   249	
   250		if (!buf)
   251			dma_unmap_single(dev, addr, len, DMA_TO_DEVICE);
   252		else {
   253			memzero_explicit(buf, len);
   254			dma_free_attrs(dev, len, buf, addr, 0);
   255		}
   256	
   257		pr_debug("%s: read %u\n", __func__, len);
   258		return ret;
   259	}
   260	
   261	static int hica_sha_export(const struct hica_sha_priv *priv, void *out,
   262				   unsigned int digestsize)
   263	{
   264		if (hica_sha_wait(priv, SHA_RECORD_READY))
   265			return -ETIMEDOUT;
   266	
   267		for (unsigned int i = 0; i < digestsize; i += sizeof(u32))
   268			*(u32 *) (out + i) =
 > 269				be32_to_cpu(readl_relaxed(priv->base + SHA_OUT0 + i));
   270	
   271		return 0;
   272	}
   273	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
