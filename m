Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72805BB838
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 14:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIQMfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 08:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIQMfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 08:35:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E401D32F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 05:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663418099; x=1694954099;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cd2DWP6EM8nIAtfKD8/ylswZlvanF6mof28MN+yPTEY=;
  b=I2E1nwy8NwVRS9dKoSUG13PVK/uJxPw/z8W8hKBaHyLsp/xsgLMQgJjF
   xnVUwNMrNCa14+J0s2TxlBmeOeljxN6PU1BbWdW6VaugGnk7b9jayDDQe
   gxQ/RZ8XeF/ZL/puvTgAYoN9t+Zu/31YbhJy71ZfldEF+QETg6gwhiI25
   Tc+lMl3+7qjDxJUTPhPSVv4QQW6li5xKwYxt08PXNFRiQeZLjgV1LQheq
   QvZGtsP33uEjMv9nzREuYhAC1JbD8dKn/veOwFKbb+srNfhF2LloP3xgU
   S0yCl54GxDjsCsE9yqRYb5cfG8QfoFD6/c0+jSUOT/DDWTedpMQtkZbut
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="279533430"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="279533430"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 05:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="743617768"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Sep 2022 05:34:57 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZX28-0000KD-23;
        Sat, 17 Sep 2022 12:34:56 +0000
Date:   Sat, 17 Sep 2022 20:34:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [asahilinux:bits/080-wifi 5/29]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1849:42: warning:
 format specifies type 'long' but the argument has type 'size_t' (aka
 'unsigned int')
Message-ID: <202209172001.GNvJL0aK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/080-wifi
head:   64ef0b7532df23da62964c9247f2f914c1509f3e
commit: e225a0ff03bd18a1e65c82b5773ccc7a56bd99ac [5/29] brcmfmac: pcie: Read Apple OTP information
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220917/202209172001.GNvJL0aK-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/e225a0ff03bd18a1e65c82b5773ccc7a56bd99ac
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/080-wifi
        git checkout e225a0ff03bd18a1e65c82b5773ccc7a56bd99ac
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/media/i2c/ drivers/net/wireless/broadcom/brcm80211/brcmfmac/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1849:42: warning: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
           brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
                                           ~~~     ^~~~
                                           %zu
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h:77:14: note: expanded from macro 'brcmf_dbg'
                       fmt, ##__VA_ARGS__);                        \
                       ~~~    ^~~~~~~~~~~
   1 warning generated.


vim +1849 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c

  1842	
  1843	static int
  1844	brcmf_pcie_parse_otp(struct brcmf_pciedev_info *devinfo, u8 *otp, size_t size)
  1845	{
  1846		int p = 0;
  1847		int ret = -EINVAL;
  1848	
> 1849		brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
  1850	
  1851		while (p < (size - 1)) {
  1852			u8 type = otp[p];
  1853			u8 length = otp[p + 1];
  1854	
  1855			if (type == 0)
  1856				break;
  1857	
  1858			if ((p + 2 + length) > size)
  1859				break;
  1860	
  1861			switch (type) {
  1862			case BRCMF_OTP_SYS_VENDOR:
  1863				brcmf_dbg(PCIE, "OTP @ 0x%x (%d): SYS_VENDOR\n",
  1864					  p, length);
  1865				ret = brcmf_pcie_parse_otp_sys_vendor(devinfo,
  1866								      &otp[p + 2],
  1867								      length);
  1868				break;
  1869			case BRCMF_OTP_BRCM_CIS:
  1870				brcmf_dbg(PCIE, "OTP @ 0x%x (%d): BRCM_CIS\n",
  1871					  p, length);
  1872				break;
  1873			default:
  1874				brcmf_dbg(PCIE, "OTP @ 0x%x (%d): Unknown type 0x%x\n",
  1875					  p, length, type);
  1876				break;
  1877			}
  1878	
  1879			p += 2 + length;
  1880		}
  1881	
  1882		return ret;
  1883	}
  1884	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
