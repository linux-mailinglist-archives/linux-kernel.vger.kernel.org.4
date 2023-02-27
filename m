Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7277F6A3A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 06:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjB0FB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 00:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0FBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 00:01:25 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F335614209
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 21:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677474084; x=1709010084;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I9MweRS0RdSIl+GXYceA9uh8+KzrfaUr24cxpGTLpH0=;
  b=g02uUJtKTMeDmCZu9+QhbRZgjgEnkA0Wh3AjKMMNiIalbahysyI1lG8A
   zkPzhx2EI1TxJyTIlouymCZPdApTUcTb9SogIDS95cSfz5kPz+D/YO8UD
   HqJR9m0XekoYZO4Mh+ne07k+yneDeQ1y+/q+euJBq6RrZ2PqwnDE1exYC
   qx2/zR1qkZNarsPNmYTTapFmQjgkU1RcfZKvpLiEsAc7tmLCG1pjOzWGV
   dWy0A/P9x8OLV1Epw5HtjbJk80srr94/9gibFaxKHvxZJAN6qHTsnwdSr
   otwu5uIGwFOtu8AAPagV+hcaC+grgrYe1WBPSi8MnqAkQU/aY82zQvOf8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="322022580"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="322022580"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 21:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="762516267"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="762516267"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Feb 2023 21:01:21 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWVdZ-00046F-0o;
        Mon, 27 Feb 2023 05:01:21 +0000
Date:   Mon, 27 Feb 2023 13:00:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     KiseokJo <kiseok.jo@irondevice.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/codecs/sma1303.c:1517:28: sparse: sparse: symbol
 'sma_i2c_regmap' was not declared. Should it be static?
Message-ID: <202302271204.H1QKC6Vv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f3a2439f20d918930cc4ae8f76fe1c1afd26958f
commit: 68cd394efd0fdce25d0def8d6cb1b8898b2c13d9 ASoC: The Iron Device SMA1303 is a boosted Class-D audio amplifier.
date:   4 weeks ago
config: sparc-randconfig-s032-20230226 (https://download.01.org/0day-ci/archive/20230227/202302271204.H1QKC6Vv-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68cd394efd0fdce25d0def8d6cb1b8898b2c13d9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 68cd394efd0fdce25d0def8d6cb1b8898b2c13d9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302271204.H1QKC6Vv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/codecs/sma1303.c:1517:28: sparse: sparse: symbol 'sma_i2c_regmap' was not declared. Should it be static?

vim +/sma_i2c_regmap +1517 sound/soc/codecs/sma1303.c

  1457	
  1458	static void sma1303_check_fault_worker(struct work_struct *work)
  1459	{
  1460		struct sma1303_priv *sma1303 =
  1461			container_of(work, struct sma1303_priv, check_fault_work.work);
  1462		int ret = 0;
  1463		unsigned int over_temp, ocp_val, uvlo_val;
  1464	
  1465		if (sma1303->tsdw_cnt)
  1466			ret = sma1303_regmap_read(sma1303,
  1467				SMA1303_0A_SPK_VOL, &sma1303->cur_vol);
  1468		else
  1469			ret = sma1303_regmap_read(sma1303,
  1470				SMA1303_0A_SPK_VOL, &sma1303->init_vol);
  1471	
  1472		if (ret != 0) {
  1473			dev_err(sma1303->dev,
  1474				"failed to read SMA1303_0A_SPK_VOL : %d\n", ret);
  1475			return;
  1476		}
  1477	
  1478		ret = sma1303_regmap_read(sma1303, SMA1303_FA_STATUS1, &over_temp);
  1479		if (ret != 0) {
  1480			dev_err(sma1303->dev,
  1481				"failed to read SMA1303_FA_STATUS1 : %d\n", ret);
  1482			return;
  1483		}
  1484	
  1485		ret = sma1303_regmap_read(sma1303, SMA1303_FB_STATUS2, &ocp_val);
  1486		if (ret != 0) {
  1487			dev_err(sma1303->dev,
  1488				"failed to read SMA1303_FB_STATUS2 : %d\n", ret);
  1489			return;
  1490		}
  1491	
  1492		ret = sma1303_regmap_read(sma1303, SMA1303_FF_DEVICE_INDEX, &uvlo_val);
  1493		if (ret != 0) {
  1494			dev_err(sma1303->dev,
  1495				"failed to read SMA1303_FF_DEVICE_INDEX : %d\n", ret);
  1496			return;
  1497		}
  1498	
  1499		if (~over_temp & SMA1303_OT1_OK_STATUS) {
  1500			dev_crit(sma1303->dev,
  1501				"%s : OT1(Over Temperature Level 1)\n", __func__);
  1502	
  1503			if ((sma1303->cur_vol + 6) <= 0xFF)
  1504				sma1303_regmap_write(sma1303,
  1505					SMA1303_0A_SPK_VOL, sma1303->cur_vol + 6);
  1506	
  1507			sma1303->tsdw_cnt++;
  1508		} else if (sma1303->tsdw_cnt) {
  1509			sma1303_regmap_write(sma1303,
  1510					SMA1303_0A_SPK_VOL, sma1303->init_vol);
  1511			sma1303->tsdw_cnt = 0;
  1512			sma1303->cur_vol = sma1303->init_vol;
  1513		}
  1514	
  1515		if (~over_temp & SMA1303_OT2_OK_STATUS) {
  1516			dev_crit(sma1303->dev,
> 1517				"%s : OT2(Over Temperature Level 2)\n", __func__);
  1518		}
  1519		if (ocp_val & SMA1303_OCP_SPK_STATUS) {
  1520			dev_crit(sma1303->dev,
  1521				"%s : OCP_SPK(Over Current Protect SPK)\n", __func__);
  1522		}
  1523		if (ocp_val & SMA1303_OCP_BST_STATUS) {
  1524			dev_crit(sma1303->dev,
  1525				"%s : OCP_BST(Over Current Protect Boost)\n", __func__);
  1526		}
  1527		if ((ocp_val & SMA1303_CLK_MON_STATUS) && (sma1303->amp_power_status)) {
  1528			dev_crit(sma1303->dev,
  1529				"%s : CLK_FAULT(No clock input)\n", __func__);
  1530		}
  1531		if (uvlo_val & SMA1303_UVLO_BST_STATUS) {
  1532			dev_crit(sma1303->dev,
  1533				"%s : UVLO(Under Voltage Lock Out)\n", __func__);
  1534		}
  1535	
  1536		if ((over_temp != sma1303->last_over_temp) ||
  1537			(ocp_val != sma1303->last_ocp_val)) {
  1538	
  1539			dev_crit(sma1303->dev, "Please check AMP status");
  1540			dev_dbg(sma1303->dev, "STATUS1=0x%02X : STATUS2=0x%02X\n",
  1541					over_temp, ocp_val);
  1542			sma1303->last_over_temp = over_temp;
  1543			sma1303->last_ocp_val = ocp_val;
  1544		}
  1545	
  1546		if (sma1303->check_fault_status) {
  1547			if (sma1303->check_fault_period > 0)
  1548				queue_delayed_work(system_freezable_wq,
  1549					&sma1303->check_fault_work,
  1550						sma1303->check_fault_period * HZ);
  1551			else
  1552				queue_delayed_work(system_freezable_wq,
  1553					&sma1303->check_fault_work,
  1554						CHECK_PERIOD_TIME * HZ);
  1555		}
  1556	
  1557		if (!(~over_temp & SMA1303_OT1_OK_STATUS)
  1558				&& !(~over_temp & SMA1303_OT2_OK_STATUS)
  1559				&& !(ocp_val & SMA1303_OCP_SPK_STATUS)
  1560				&& !(ocp_val & SMA1303_OCP_BST_STATUS)
  1561				&& !(ocp_val & SMA1303_CLK_MON_STATUS)
  1562				&& !(uvlo_val & SMA1303_UVLO_BST_STATUS)) {
  1563		}
  1564	}
  1565	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
