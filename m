Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612BE5B9BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIONdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIONdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:33:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945D36E8A8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663248793; x=1694784793;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LrYAfCURoxIJIo3WUi8qVFXPjE/uJPgluE7KuD5DkEo=;
  b=aLquWCLCh8Okk/28GQf33rw9w6GAMpWc9ZD8/QoAEXNxyAJQFmbKyO9L
   +VdZnYXNvpxnaxPt8f52OuKZiooX3koprCERMuwSa1W2exKUWKJXAcGyJ
   PJzQ+AKniJ8kGD/vFiWiJp31IwZioK+cViOb0m532HucICCrOsH2OyrAb
   SyF6o3r/ii914N/mPA0QgCEvJHYshxzgEKT82iKaFoFQSV+Rz28ZAs4uc
   W61Kv1cUYA30/AqgP9LW1geez54N5Us62KPsDvV0RmRXnVQfC3PbWWAJN
   cHBYQuc3rj3gdy/QR0NfDCwo3bfXvixN7r/zK0VNfXj/qSR9NGONoumiI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="281742998"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="281742998"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 06:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="685726491"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Sep 2022 06:33:11 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYozP-0000cI-08;
        Thu, 15 Sep 2022 13:33:11 +0000
Date:   Thu, 15 Sep 2022 21:32:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [asahilinux:bits/080-wifi 22/29]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4075:42: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202209152121.ZIrKUWNH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/080-wifi
head:   64ef0b7532df23da62964c9247f2f914c1509f3e
commit: cd60e4847890af895d0b5f3e3a941103c3a8d60d [22/29] brcmfmac: cfg80211: Add support for PMKID_V3 operations
config: openrisc-randconfig-s043-20220914 (https://download.01.org/0day-ci/archive/20220915/202209152121.ZIrKUWNH-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/cd60e4847890af895d0b5f3e3a941103c3a8d60d
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/080-wifi
        git checkout cd60e4847890af895d0b5f3e3a941103c3a8d60d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1087:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] version @@     got int @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1087:28: sparse:     expected restricted __le16 [usertype] version
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1087:28: sparse:     got int
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1149:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] scan_type @@     got int @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1149:38: sparse:     expected restricted __le32 [usertype] scan_type
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1149:38: sparse:     got int
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:790:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] scan_type @@     got restricted __le32 [usertype] scan_type @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:790:30: sparse:     expected unsigned char [usertype] scan_type
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:790:30: sparse:     got restricted __le32 [usertype] scan_type
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4075:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] time_left @@     got unsigned int @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4075:42: sparse:     expected restricted __le32 [usertype] time_left
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4075:42: sparse:     got unsigned int

vim +4075 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c

  4053	
  4054	static s32
  4055	brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg80211_pmksa *pmksa,
  4056			  bool alive)
  4057	{
  4058		struct brcmf_pmk_op_v3_le *pmk_op;
  4059		int length = offsetof(struct brcmf_pmk_op_v3_le, pmk);
  4060		int ret;
  4061	
  4062		pmk_op = kzalloc(sizeof(*pmk_op), GFP_KERNEL);
  4063		pmk_op->version = cpu_to_le16(BRCMF_PMKSA_VER_3);
  4064	
  4065		if (!pmksa) {
  4066			/* Flush operation, operate on entire list */
  4067			pmk_op->count = cpu_to_le16(0);
  4068		} else {
  4069			/* Single PMK operation */
  4070			pmk_op->count = cpu_to_le16(1);
  4071			length += sizeof(struct brcmf_pmksa_v3);
  4072			memcpy(pmk_op->pmk[0].bssid, pmksa->bssid, ETH_ALEN);
  4073			memcpy(pmk_op->pmk[0].pmkid, pmksa->pmkid, WLAN_PMKID_LEN);
  4074			pmk_op->pmk[0].pmkid_len = WLAN_PMKID_LEN;
> 4075			pmk_op->pmk[0].time_left = alive ? BRCMF_PMKSA_NO_EXPIRY : 0;
  4076		}
  4077	
  4078		pmk_op->length = cpu_to_le16(length);
  4079	
  4080		ret = brcmf_fil_iovar_data_set(ifp, "pmkid_info", pmk_op, sizeof(*pmk_op));
  4081		kfree(pmk_op);
  4082		return ret;
  4083	}
  4084	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
