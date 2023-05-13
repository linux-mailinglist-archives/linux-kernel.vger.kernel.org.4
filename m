Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD0270157B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjEMJGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEMJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:06:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189934ED7;
        Sat, 13 May 2023 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683968771; x=1715504771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D70CvXStS43IjD7L5CpDH3KFVNxY0NX2aLgy/4yjULo=;
  b=M1AApBaPM6C2tSuriPjmNBxawo2ddoYUzyqKltjvN2hx3yBp3iuRf5f8
   2ygLwh3yFaHvcu4PQkyxVh0vmXB4RdCiLezPhdv/p0eYE5Z++QUJEQ/oD
   UhUwaVz5JPm4mTQiks+dJn/jgDyWlblgzwdVn+4fHoH4Z+UdLM/ASNpbf
   yBHor/U63+lzIY0+0uDoxTeIH/sM46a5I0ve54ET0/ZMzdPBbRpnlvp/h
   tlLWp0+s17EvivPGZfMlIOOukVFoP6Sogn86eTBn2v/1f5To/v9sAPvyz
   iy/riLVSv5wQ3xOjvnp93fE6TGJof3upnx9WE9nA8flZtEi97LuQ1bYAc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="335468893"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="335468893"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 02:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="844685129"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="844685129"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2023 02:06:08 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxlCZ-0005Py-26;
        Sat, 13 May 2023 09:06:07 +0000
Date:   Sat, 13 May 2023 17:05:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Yang <mmyangfl@gmail.com>, linux-crypto@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] crypto: hisilicon/advca - Add SHA support
Message-ID: <202305131617.8wrECG3g-lkp@intel.com>
References: <20230513074339.266879-3-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513074339.266879-3-mmyangfl@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230513074339.266879-3-mmyangfl%40gmail.com
patch subject: [PATCH v2 2/2] crypto: hisilicon/advca - Add SHA support
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230513/202305131617.8wrECG3g-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/57ff91a10a13d90fadb0567f9245d9040ce9659e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Yang/crypto-hisilicon-Add-HiSilicon-ADVCA-Subsystem/20230513-154545
        git checkout 57ff91a10a13d90fadb0567f9245d9040ce9659e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/crypto/hisilicon/advca/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305131617.8wrECG3g-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/crypto/hisilicon/advca/hisi-advca-sha.c: In function 'hica_sha_update':
>> drivers/crypto/hisilicon/advca/hisi-advca-sha.c:216:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     216 |         bool inplace = !((unsigned int) data & 3);
         |                          ^


vim +216 drivers/crypto/hisilicon/advca/hisi-advca-sha.c

   211	
   212	static int hica_sha_update(const struct hica_sha_priv *priv, const void *data,
   213				   unsigned int len, bool may_sleep)
   214	{
   215		struct device *dev = priv->dev;
 > 216		bool inplace = !((unsigned int) data & 3);
   217		u8 *buf = NULL;
   218		dma_addr_t addr;
   219		int ret;
   220	
   221		if (!len)
   222			return 0;
   223	
   224		if (WARN_ON(len % SHA_BLOCK_SIZE))
   225			return -EINVAL;
   226	
   227		if (inplace) {
   228			addr = dma_map_single(dev, (void *) data, len, DMA_TO_DEVICE);
   229			if (dma_mapping_error(dev, addr)) {
   230				dev_err(dev, "error mapping src\n");
   231				return -EIO;
   232			}
   233	
   234			inplace = !(addr & 3);
   235			if (!inplace)
   236				dma_unmap_single(dev, addr, len, DMA_TO_DEVICE);
   237		}
   238	
   239		if (!inplace) {
   240			buf = dma_alloc_attrs(dev, len, &addr,
   241					      may_sleep ? GFP_KERNEL : GFP_ATOMIC, 0);
   242			if (!buf)
   243				return -ENOMEM;
   244			memcpy(buf, data, len);
   245		}
   246	
   247		dma_sync_single_for_device(dev, addr, len, DMA_TO_DEVICE);
   248		ret = hica_sha_record(priv, addr, len) ?:
   249		      hica_sha_wait(priv, SHA_RECORD_READY);
   250	
   251		if (!buf)
   252			dma_unmap_single(dev, addr, len, DMA_TO_DEVICE);
   253		else {
   254			memzero_explicit(buf, len);
   255			dma_free_attrs(dev, len, buf, addr, 0);
   256		}
   257	
   258		pr_debug("%s: read %u\n", __func__, len);
   259		return ret;
   260	}
   261	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
