Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73D969EE61
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjBVFfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjBVFfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:35:00 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF3034F58
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 21:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677044098; x=1708580098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c+NPOUZdVR+EOq3CpFB0IxbMJMQPa7X3cq5jJue4q7g=;
  b=MCMQieu7BFahihlTSIaCsmIttIM0qOIXzqoV//hZI+3sD2dk0rykfT83
   mmqFwPxO+vrT0NEtMPt6uB4x3Qrllf8X0Go1uVOG1Nqn1kNX6SH58W6GV
   V26VcIMKdhKk8NDsXn0D51ezP5yZ+neZLUuIxUw91OBQQt2gDcxhEr9N2
   BdWYr5jESQFes+/s6ezUmdM9zkX8w7l08bf0Nmkyq2VkLR6MhZqh1yWl8
   62q2+4hAWhyf7icOefyl616EcmpflVdNq2paTSXd6/eabKvsNT29kAThN
   sQUymqmLGASaUDBC1mbgzjb8A/1XNi0iKf3Etb+xdTEGM6mcOJMVcnXk8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="330565370"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="330565370"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 21:34:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="814792614"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="814792614"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2023 21:34:56 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUhmJ-00001b-2p;
        Wed, 22 Feb 2023 05:34:55 +0000
Date:   Wed, 22 Feb 2023 13:34:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shibo Li <zzutcyha@163.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Shibo Li <zzutcyha@163.com>
Subject: Re: [PATCH] staging: rtl8712: Fix Sparse warnings in
 rtl871x_ioctl_linux.c
Message-ID: <202302221320.dttJ7Puv-lkp@intel.com>
References: <20230220143758.4396-1-zzutcyha@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220143758.4396-1-zzutcyha@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shibo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Shibo-Li/staging-rtl8712-Fix-Sparse-warnings-in-rtl871x_ioctl_linux-c/20230220-224057
patch link:    https://lore.kernel.org/r/20230220143758.4396-1-zzutcyha%40163.com
patch subject: [PATCH] staging: rtl8712: Fix Sparse warnings in rtl871x_ioctl_linux.c
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20230222/202302221320.dttJ7Puv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7117082894534ef14c409d6a9070fa051a84f619
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shibo-Li/staging-rtl8712-Fix-Sparse-warnings-in-rtl871x_ioctl_linux-c/20230220-224057
        git checkout 7117082894534ef14c409d6a9070fa051a84f619
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/rtl8712/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302221320.dttJ7Puv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/rtl8712/rtl871x_ioctl_linux.c: In function 'r8711_wx_set_essid':
>> drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1272:62: error: 'struct wlan_bssid_ex' has no member named 'configurationInfrastructureMode'
    1272 |                                         if (pnetwork->network.configurationInfrastructureMode
         |                                                              ^
>> drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1274:81: error: request for member 'cur_network' in something not a structure or union
    1274 |                                                 padapter->mlmepriv.assoc_by_rssi.
         |                                                                                 ^


vim +1272 drivers/staging/rtl8712/rtl871x_ioctl_linux.c

  1218	
  1219	/* set ssid flow
  1220	 * s1. set_802_11_infrastructure_mode()
  1221	 * s2. set_802_11_authenticaion_mode()
  1222	 * s3. set_802_11_encryption_mode()
  1223	 * s4. set_802_11_ssid()
  1224	 *
  1225	 * This function intends to handle the Set ESSID command.
  1226	 * Currently, the request comes via the Wireless Extensions' SIOCSIWESSID ioctl.
  1227	 *
  1228	 * For this operation to succeed, there is no need for the interface to be Up.
  1229	 *
  1230	 */
  1231	static int r8711_wx_set_essid(struct net_device *dev,
  1232					struct iw_request_info *a,
  1233					union iwreq_data *wrqu, char *extra)
  1234	{
  1235		struct _adapter *padapter = netdev_priv(dev);
  1236		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
  1237		struct  __queue *queue = &pmlmepriv->scanned_queue;
  1238		struct wlan_network *pnetwork = NULL;
  1239		enum NDIS_802_11_AUTHENTICATION_MODE	authmode;
  1240		struct ndis_802_11_ssid ndis_ssid;
  1241		u8 *dst_ssid, *src_ssid;
  1242		struct list_head *phead;
  1243		u32 len;
  1244	
  1245		if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
  1246			return -EBUSY;
  1247		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
  1248			return 0;
  1249		if (wrqu->essid.length > IW_ESSID_MAX_SIZE)
  1250			return -E2BIG;
  1251		authmode = padapter->securitypriv.ndisauthtype;
  1252		if (wrqu->essid.flags && wrqu->essid.length) {
  1253			len = (wrqu->essid.length < IW_ESSID_MAX_SIZE) ?
  1254			       wrqu->essid.length : IW_ESSID_MAX_SIZE;
  1255			memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
  1256			ndis_ssid.SsidLength = len;
  1257			memcpy(ndis_ssid.Ssid, extra, len);
  1258			src_ssid = ndis_ssid.Ssid;
  1259			phead = &queue->queue;
  1260			pmlmepriv->pscanned = phead->next;
  1261			while (1) {
  1262				if (end_of_queue_search(phead, pmlmepriv->pscanned))
  1263					break;
  1264				pnetwork = container_of(pmlmepriv->pscanned,
  1265							struct wlan_network, list);
  1266				pmlmepriv->pscanned = pmlmepriv->pscanned->next;
  1267				dst_ssid = pnetwork->network.Ssid.Ssid;
  1268				if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength))
  1269				    && (pnetwork->network.Ssid.SsidLength ==
  1270				     ndis_ssid.SsidLength)) {
  1271					if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
> 1272						if (pnetwork->network.configurationInfrastructureMode
  1273							!=
> 1274							padapter->mlmepriv.assoc_by_rssi.
  1275							cur_network.network.InfrastructureMode)
  1276							continue;
  1277					}
  1278	
  1279					r8712_set_802_11_infrastructure_mode(
  1280					     padapter,
  1281					     pnetwork->network.InfrastructureMode);
  1282					break;
  1283				}
  1284			}
  1285			r8712_set_802_11_authentication_mode(padapter, authmode);
  1286			r8712_set_802_11_ssid(padapter, &ndis_ssid);
  1287		}
  1288		return -EINPROGRESS;
  1289	}
  1290	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
