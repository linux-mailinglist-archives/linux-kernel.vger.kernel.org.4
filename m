Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EAA676B86
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 09:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjAVIN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 03:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 03:13:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2A7222D2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 00:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674375202; x=1705911202;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cJDZm4Q4gEltynb0011gp744YJV8WVYrUBBBJzea7S4=;
  b=czTv6/SwVHTjOkMP3ooHYS7wzDBYvt7Q4pDlgC8pMn1IibbnZiCzJyu0
   wq/NWmBiFD8nhIO7n4e7TcdxaxzrvN0MMZ51bIahUmBYFNwE/VhcIfvKm
   mkZxfX9AOGyF+YnyN3xZWmjHuOh+RKjq+5OKtbASZcWjzCw0/czn3ZV63
   kc8bur/WrCQ3Hrt2i6JJPsXr0tnXREkgRIXgFUmsi2VoYrrTB6iYOXclp
   GHBZ0DCICzy4rjPMr2I89XFEi7UaLovZfe03XED73l+t1wCxoSrOGrIfZ
   sqaxNcGTTHkAjKVCvQMCEZMhZczQS2MQ2BPqQRsf2jV92041NSjE1VTv1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="313767862"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="313767862"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 00:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="803549019"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="803549019"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jan 2023 00:13:19 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJVTa-0004rw-2v;
        Sun, 22 Jan 2023 08:13:18 +0000
Date:   Sun, 22 Jan 2023 16:12:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>
Subject: drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202301221647.9RyZMvaz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2241ab53cbb5cdb08a6b2d4688feb13971058f65
commit: c5b331d4f550fb78bf1a553b2517616a5ea913d6 wifi: wilc1000: add WPA3 SAE support
date:   8 months ago
config: parisc-randconfig-s041-20230122 (https://download.01.org/0day-ci/archive/20230122/202301221647.9RyZMvaz-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c5b331d4f550fb78bf1a553b2517616a5ea913d6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c5b331d4f550fb78bf1a553b2517616a5ea913d6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash drivers/mfd/ drivers/net/wireless/microchip/wilc1000/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int key_mgmt_suite @@     got restricted __be32 [usertype] @@
   drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:     expected unsigned int key_mgmt_suite
   drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:     got restricted __be32 [usertype]

vim +361 drivers/net/wireless/microchip/wilc1000/cfg80211.c

   300	
   301	static int connect(struct wiphy *wiphy, struct net_device *dev,
   302			   struct cfg80211_connect_params *sme)
   303	{
   304		struct wilc_vif *vif = netdev_priv(dev);
   305		struct wilc_priv *priv = &vif->priv;
   306		struct host_if_drv *wfi_drv = priv->hif_drv;
   307		int ret;
   308		u32 i;
   309		u8 security = WILC_FW_SEC_NO;
   310		enum authtype auth_type = WILC_FW_AUTH_ANY;
   311		u32 cipher_group;
   312		struct cfg80211_bss *bss;
   313		void *join_params;
   314		u8 ch;
   315	
   316		vif->connecting = true;
   317	
   318		cipher_group = sme->crypto.cipher_group;
   319		if (cipher_group != 0) {
   320			if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2) {
   321				if (cipher_group == WLAN_CIPHER_SUITE_TKIP)
   322					security = WILC_FW_SEC_WPA2_TKIP;
   323				else
   324					security = WILC_FW_SEC_WPA2_AES;
   325			} else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_1) {
   326				if (cipher_group == WLAN_CIPHER_SUITE_TKIP)
   327					security = WILC_FW_SEC_WPA_TKIP;
   328				else
   329					security = WILC_FW_SEC_WPA_AES;
   330			} else {
   331				ret = -ENOTSUPP;
   332				netdev_err(dev, "%s: Unsupported cipher\n",
   333					   __func__);
   334				goto out_error;
   335			}
   336		}
   337	
   338		if ((sme->crypto.wpa_versions & NL80211_WPA_VERSION_1) ||
   339		    (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2)) {
   340			for (i = 0; i < sme->crypto.n_ciphers_pairwise; i++) {
   341				u32 ciphers_pairwise = sme->crypto.ciphers_pairwise[i];
   342	
   343				if (ciphers_pairwise == WLAN_CIPHER_SUITE_TKIP)
   344					security |= WILC_FW_TKIP;
   345				else
   346					security |= WILC_FW_AES;
   347			}
   348		}
   349	
   350		switch (sme->auth_type) {
   351		case NL80211_AUTHTYPE_OPEN_SYSTEM:
   352			auth_type = WILC_FW_AUTH_OPEN_SYSTEM;
   353			break;
   354	
   355		case NL80211_AUTHTYPE_SAE:
   356			auth_type = WILC_FW_AUTH_SAE;
   357			if (sme->ssid_len) {
   358				memcpy(vif->auth.ssid.ssid, sme->ssid, sme->ssid_len);
   359				vif->auth.ssid.ssid_len = sme->ssid_len;
   360			}
 > 361			vif->auth.key_mgmt_suite = cpu_to_be32(sme->crypto.akm_suites[0]);
   362			ether_addr_copy(vif->auth.bssid, sme->bssid);
   363			break;
   364	
   365		default:
   366			break;
   367		}
   368	
   369		if (sme->crypto.n_akm_suites) {
   370			if (sme->crypto.akm_suites[0] == WLAN_AKM_SUITE_8021X)
   371				auth_type = WILC_FW_AUTH_IEEE8021;
   372			else if (sme->crypto.akm_suites[0] == WLAN_AKM_SUITE_PSK_SHA256)
   373				auth_type = WILC_FW_AUTH_OPEN_SYSTEM_SHA256;
   374			else if (sme->crypto.akm_suites[0] == WLAN_AKM_SUITE_8021X_SHA256)
   375				auth_type = WILC_FW_AUTH_IEE8021X_SHA256;
   376		}
   377	
   378		if (wfi_drv->usr_scan_req.scan_result) {
   379			netdev_err(vif->ndev, "%s: Scan in progress\n", __func__);
   380			ret = -EBUSY;
   381			goto out_error;
   382		}
   383	
   384		bss = cfg80211_get_bss(wiphy, sme->channel, sme->bssid, sme->ssid,
   385				       sme->ssid_len, IEEE80211_BSS_TYPE_ANY,
   386				       IEEE80211_PRIVACY(sme->privacy));
   387		if (!bss) {
   388			ret = -EINVAL;
   389			goto out_error;
   390		}
   391	
   392		if (ether_addr_equal_unaligned(vif->bssid, bss->bssid)) {
   393			ret = -EALREADY;
   394			goto out_put_bss;
   395		}
   396	
   397		join_params = wilc_parse_join_bss_param(bss, &sme->crypto);
   398		if (!join_params) {
   399			netdev_err(dev, "%s: failed to construct join param\n",
   400				   __func__);
   401			ret = -EINVAL;
   402			goto out_put_bss;
   403		}
   404	
   405		ch = ieee80211_frequency_to_channel(bss->channel->center_freq);
   406		vif->wilc->op_ch = ch;
   407		if (vif->iftype != WILC_CLIENT_MODE)
   408			vif->wilc->sta_ch = ch;
   409	
   410		wilc_wlan_set_bssid(dev, bss->bssid, WILC_STATION_MODE);
   411	
   412		wfi_drv->conn_info.security = security;
   413		wfi_drv->conn_info.auth_type = auth_type;
   414		wfi_drv->conn_info.ch = ch;
   415		wfi_drv->conn_info.conn_result = cfg_connect_result;
   416		wfi_drv->conn_info.arg = priv;
   417		wfi_drv->conn_info.param = join_params;
   418	
   419		ret = wilc_set_join_req(vif, bss->bssid, sme->ie, sme->ie_len);
   420		if (ret) {
   421			netdev_err(dev, "wilc_set_join_req(): Error\n");
   422			ret = -ENOENT;
   423			if (vif->iftype != WILC_CLIENT_MODE)
   424				vif->wilc->sta_ch = WILC_INVALID_CHANNEL;
   425			wilc_wlan_set_bssid(dev, NULL, WILC_STATION_MODE);
   426			wfi_drv->conn_info.conn_result = NULL;
   427			kfree(join_params);
   428			goto out_put_bss;
   429		}
   430		kfree(join_params);
   431		vif->bss = bss;
   432		cfg80211_put_bss(wiphy, bss);
   433		return 0;
   434	
   435	out_put_bss:
   436		cfg80211_put_bss(wiphy, bss);
   437	
   438	out_error:
   439		vif->connecting = false;
   440		return ret;
   441	}
   442	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
