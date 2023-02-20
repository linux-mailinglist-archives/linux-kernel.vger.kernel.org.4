Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A922169C38C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 01:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBTAR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 19:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBTARy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 19:17:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50A210E6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 16:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676852272; x=1708388272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k2zKdQfrDadA/GggbiTNdQvcKWaCjtc4nD14ZZhHEYs=;
  b=kK0I+YOM1nka2jfg8aJ+W07rG0EsIgkfBpHfzioW90octjYu6LODQAfb
   pdok5n0A5m2km2EXlSclFNN0rm2xRUX3VuV/D+DnIFway5X1slFH2BiWb
   iPy3CzcfFrxQQxh+Shw8ntLsr5bc9ya3McgLzueGC7/jdXSDIBMt4P6JU
   eSUA+ztg2NiZeSbCfAFp2ATS9DsezC8+OYZ2QiTCxFuxhTHak3GShmbX7
   W6/blRSTXVN2gaAhxTZJLqftBdbI7lbQue5coFabdzJ/148PDDIIQavv2
   oOe5h0M9lDPHAYxflwWA7cbg4WZsYaQWX3TLLoJArDpMXne1irQHl3plR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="312662601"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="312662601"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 16:17:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="916675977"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="916675977"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 19 Feb 2023 16:17:51 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTtsM-000DVh-25;
        Mon, 20 Feb 2023 00:17:50 +0000
Date:   Mon, 20 Feb 2023 08:17:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>
Subject: drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:1580
 rtl8xxxu_print_chipinfo() warn: always true condition '(priv->chip_cut <=
 15) => (0-15 <= 15)'
Message-ID: <202302200805.crse1DV5-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   925cf0457d7e62ce08878ffb789189ac08ca8677
commit: 7b0ac469e331d9f9fd77f4ebb7a6322f5562db67 wifi: rtl8xxxu: Recognise all possible chip cuts
date:   4 months ago
config: x86_64-randconfig-m001-20230213 (https://download.01.org/0day-ci/archive/20230220/202302200805.crse1DV5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302200805.crse1DV5-lkp@intel.com/

New smatch warnings:
drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:1580 rtl8xxxu_print_chipinfo() warn: always true condition '(priv->chip_cut <= 15) => (0-15 <= 15)'

Old smatch warnings:
drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5675 rtl8xxxu_c2hcmd_callback() warn: potential spectre issue 'rtl8xxxu_legacy_ratetable' [r] (local cap)

vim +1580 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c

  1573	
  1574	static void rtl8xxxu_print_chipinfo(struct rtl8xxxu_priv *priv)
  1575	{
  1576		struct device *dev = &priv->udev->dev;
  1577		char cut = '?';
  1578	
  1579		/* Currently always true: chip_cut is 4 bits. */
> 1580		if (priv->chip_cut <= 15)
  1581			cut = 'A' + priv->chip_cut;
  1582	
  1583		dev_info(dev,
  1584			 "RTL%s rev %c (%s) %iT%iR, TX queues %i, WiFi=%i, BT=%i, GPS=%i, HI PA=%i\n",
  1585			 priv->chip_name, cut, priv->chip_vendor, priv->tx_paths,
  1586			 priv->rx_paths, priv->ep_tx_count, priv->has_wifi,
  1587			 priv->has_bluetooth, priv->has_gps, priv->hi_pa);
  1588	
  1589		dev_info(dev, "RTL%s MAC: %pM\n", priv->chip_name, priv->mac_addr);
  1590	}
  1591	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
