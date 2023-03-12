Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0716B62D3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 03:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjCLCJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 21:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCLCJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 21:09:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FFC38B57;
        Sat, 11 Mar 2023 18:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678586956; x=1710122956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XmKC7vQVVfZU0bA+FbafUjgEDixlcV/5Wbr0HiZW5pQ=;
  b=UynnqJgPPJswSg08eubYk78r14Gt/iRwC2lJGJsv4GqUgjOQEjTuuzYm
   j5nufqTKk4D9kAtU6U/BU4Y0oNsjCSw41qfdkANYP+VL43ixkCoQVkHsN
   GNwuTVOBCFCvcOpry4nhVN62sX0TVVVx+A0DvSaep016cdUawRA6+5asJ
   wbeNdwHNSBOo8dcMdgrmgsDGUT+qHSz608PWpE7uMsuldMq9BUHLcrHOv
   beoh+o2KaKnvWsoudFw4+A6tEiOwJfpwmiB4SLbfGS6U4nA2CCAZBvIxH
   f1kphOmX2Do0D7msz5tVHjR0IQBE1oc6iPepO9CtKzmukAy2sB3DrLhO4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="364612609"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="364612609"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 18:09:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="678265676"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="678265676"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2023 18:09:08 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbB92-0004vR-0f;
        Sun, 12 Mar 2023 02:09:08 +0000
Date:   Sun, 12 Mar 2023 10:08:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v11 15/15] soc: amd: Add support for AMD Pensando SoC
 Controller
Message-ID: <202303120925.SxLjwOd2-lkp@intel.com>
References: <20230312004445.15913-16-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312004445.15913-16-blarson@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

I love your patch! Perhaps something to improve:

[auto build test WARNING on fe15c26ee26efa11741a7b632e9f23b01aca4cc6]

url:    https://github.com/intel-lab-lkp/linux/commits/Brad-Larson/dt-bindings-arm-add-AMD-Pensando-boards/20230312-085000
base:   fe15c26ee26efa11741a7b632e9f23b01aca4cc6
patch link:    https://lore.kernel.org/r/20230312004445.15913-16-blarson%40amd.com
patch subject: [PATCH v11 15/15] soc: amd: Add support for AMD Pensando SoC Controller
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230312/202303120925.SxLjwOd2-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2a812dc8022120f2ff9130618bd33e8c678be177
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Brad-Larson/dt-bindings-arm-add-AMD-Pensando-boards/20230312-085000
        git checkout 2a812dc8022120f2ff9130618bd33e8c678be177
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/soc/amd/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303120925.SxLjwOd2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/soc/amd/pensando-ctrl.c: In function 'penctrl_ioctl':
>> drivers/soc/amd/pensando-ctrl.c:97:44: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      97 |         if (copy_from_user((void *)tx_buf, (void __user *)msg->tx_buf, msg->len)) {
         |                                            ^
   drivers/soc/amd/pensando-ctrl.c:120:26: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     120 |         if (copy_to_user((void __user *)msg->rx_buf, (void *)rx_buf, msg->len))
         |                          ^


vim +97 drivers/soc/amd/pensando-ctrl.c

    35	
    36	static long
    37	penctrl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
    38	{
    39		struct spi_transfer t[2] = { 0 };
    40		struct penctrl_device *penctrl;
    41		struct penctrl_spi_xfer *msg;
    42		struct spi_device *spi_dev;
    43		unsigned int num_msgs;
    44		struct spi_message m;
    45		u8 tx_buf[PENCTRL_MAX_MSG_LEN];
    46		u8 rx_buf[PENCTRL_MAX_MSG_LEN];
    47		u32 size;
    48		int ret;
    49	
    50		/* Check for a valid command */
    51		if (_IOC_TYPE(cmd) != PENCTRL_IOC_MAGIC)
    52			return -ENOTTY;
    53	
    54		if (_IOC_NR(cmd) > PENCTRL_IOC_MAXNR)
    55			return -ENOTTY;
    56	
    57		if (_IOC_DIR(cmd) & _IOC_READ)
    58			ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
    59		else if (_IOC_DIR(cmd) & _IOC_WRITE)
    60			ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
    61	
    62		if (ret)
    63			return -EFAULT;
    64	
    65		/* Get a reference to the SPI device */
    66		penctrl = filp->private_data;
    67		if (!penctrl)
    68			return -ESHUTDOWN;
    69	
    70		spi_dev = spi_dev_get(penctrl->spi_dev);
    71		if (!spi_dev)
    72			return -ESHUTDOWN;
    73	
    74		/* Verify and prepare spi message */
    75		size = _IOC_SIZE(cmd);
    76		if ((size % sizeof(struct penctrl_spi_xfer)) != 0) {
    77			ret = -EINVAL;
    78			goto done;
    79		}
    80		num_msgs = size / sizeof(struct penctrl_spi_xfer);
    81		if (num_msgs == 0) {
    82			ret = -EINVAL;
    83			goto done;
    84		}
    85		msg = memdup_user((struct penctrl_spi_xfer __user *)arg, size);
    86		if (!msg) {
    87			ret = PTR_ERR(msg);
    88			goto done;
    89		}
    90		if (msg->len > PENCTRL_MAX_MSG_LEN) {
    91			ret = -EINVAL;
    92			goto done;
    93		}
    94	
    95		t[0].tx_buf = tx_buf;
    96		t[0].len = msg->len;
  > 97		if (copy_from_user((void *)tx_buf, (void __user *)msg->tx_buf, msg->len)) {
    98			ret = -EFAULT;
    99			goto done;
   100		}
   101		if (num_msgs > 1) {
   102			msg++;
   103			if (msg->len > PENCTRL_MAX_MSG_LEN) {
   104				ret = -EINVAL;
   105				goto done;
   106			}
   107			t[1].rx_buf = rx_buf;
   108			t[1].len = msg->len;
   109		}
   110		spi_message_init_with_transfers(&m, t, num_msgs);
   111	
   112		/* Perform the transfer */
   113		mutex_lock(&spi_lock);
   114		ret = spi_sync(spi_dev, &m);
   115		mutex_unlock(&spi_lock);
   116	
   117		if (ret || (num_msgs == 1))
   118			goto done;
   119	
   120		if (copy_to_user((void __user *)msg->rx_buf, (void *)rx_buf, msg->len))
   121			ret = -EFAULT;
   122	
   123	done:
   124		spi_dev_put(spi_dev);
   125		return ret;
   126	}
   127	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
