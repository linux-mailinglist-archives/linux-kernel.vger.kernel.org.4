Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EBC67A760
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjAYAOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYAOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:14:33 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1A7222F6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674605670; x=1706141670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nvRmqvuX/VTxCARc9m06tiDhFyW+4qZpuVWJQLvD3dg=;
  b=Dzxh31EHWdfbDBiISQf3crsIzhhbKvR5B7bSL3LDN2xjC2XdnTWVCPt5
   Yv+OZxukSejePFBKnhlg0gTQpUjQ1lT6kTSxQGdCtvvRHsoC4M+9XhfnM
   nOBmEWMy6OV4kQCS4RWjz9p+DYAp9NMNga68fq0CF/8CTySDCd5Sf825R
   GNNFOkoxmrDm/+GS5qrZJ7wzXxRCCVYoWxRTus1t9sL7EHIAn7/G4jyQc
   2VHd89GI91s/wxASy2yaoViz3mbGfhSgz1NxdbHeIFVCHyW7B4GW8diR5
   owPGYfwByVqgOmSzEerUD54P/NVW4GegOjIrLQwI8Wnxq8idpD0k//hD1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="328533358"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="328533358"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 16:14:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="836169452"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="836169452"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2023 16:14:27 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKTQo-0006tY-2m;
        Wed, 25 Jan 2023 00:14:26 +0000
Date:   Wed, 25 Jan 2023 08:13:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 06/11] staging: rtl8192e: Remove unused variables
 num_proc.., recei.. and rxov..
Message-ID: <202301250813.dBvVqX7V-lkp@intel.com>
References: <67df12497bc6f93c6ef85b4dda7490b037f2a3da.1674596722.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67df12497bc6f93c6ef85b4dda7490b037f2a3da.1674596722.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Hortmann/staging-rtl8192e-Remove-unused-variables-rxrdu-and-rxok/20230125-060703
patch link:    https://lore.kernel.org/r/67df12497bc6f93c6ef85b4dda7490b037f2a3da.1674596722.git.philipp.g.hortmann%40gmail.com
patch subject: [PATCH 06/11] staging: rtl8192e: Remove unused variables num_proc.., recei.. and rxov..
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230125/202301250813.dBvVqX7V-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3d74e0475f452fadccfa0a14940734cbfdc31f64
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Philipp-Hortmann/staging-rtl8192e-Remove-unused-variables-rxrdu-and-rxok/20230125-060703
        git checkout 3d74e0475f452fadccfa0a14940734cbfdc31f64
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/staging/rtl8192e/rtl8192e/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c: In function '_rtl92e_query_rxphystatus':
>> drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:1299:58: warning: variable 'prxsc' set but not used [-Wunused-but-set-variable]
    1299 |         struct phy_ofdm_rx_status_rxsc_sgien_exintfflag *prxsc;
         |                                                          ^~~~~
   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c: In function '_rtl92e_update_received_rate_histogram_stats':
   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:1693:13: warning: variable 'preamble_guardinterval' set but not used [-Wunused-but-set-variable]
    1693 |         u32 preamble_guardinterval;
         |             ^~~~~~~~~~~~~~~~~~~~~~


vim +/prxsc +1299 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c

94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1276  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1277  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1278  #define	 rx_hal_is_cck_rate(_pdrvinfo)\
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1279  			((_pdrvinfo->RxRate == DESC90_RATE1M ||\
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1280  			_pdrvinfo->RxRate == DESC90_RATE2M ||\
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1281  			_pdrvinfo->RxRate == DESC90_RATE5_5M ||\
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1282  			_pdrvinfo->RxRate == DESC90_RATE11M) &&\
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1283  			!_pdrvinfo->RxHT)
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1284  
410bfd1d8f1c16 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Mateusz Kulikowski 2015-09-20  1285  static void _rtl92e_query_rxphystatus(
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1286  	struct r8192_priv *priv,
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1287  	struct rtllib_rx_stats *pstats,
4f534b36afb6fe drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-07-18  1288  	struct rx_desc  *pdesc,
6f22c62010122f drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-07-18  1289  	struct rx_fwinfo   *pdrvinfo,
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1290  	struct rtllib_rx_stats *precord_stats,
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1291  	bool bpacket_match_bssid,
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1292  	bool bpacket_toself,
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1293  	bool bPacketBeacon,
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1294  	bool bToSelfBA
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1295  	)
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1296  {
2ae7ea8cf099f0 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-07-18  1297  	struct phy_sts_ofdm_819xpci *pofdm_buf;
ececd694df70a7 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-07-18  1298  	struct phy_sts_cck_819xpci *pcck_buf;
910d9e5c2deec0 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-07-18 @1299  	struct phy_ofdm_rx_status_rxsc_sgien_exintfflag *prxsc;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1300  	u8 *prxpkt;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1301  	u8 i, max_spatial_stream, tmp_rxsnr, tmp_rxevm, rxsc_sgien_exflg;
5d5fd353740ffe drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Arnd Bergmann      2016-07-20  1302  	s8 rx_pwr[4], rx_pwr_all = 0;
5d5fd353740ffe drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Arnd Bergmann      2016-07-20  1303  	s8 rx_snrX, rx_evmX;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1304  	u8 evm, pwdb_all;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1305  	u32 RSSI, total_rssi = 0;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1306  	u8 is_cck_rate = 0;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1307  	u8 rf_rx_num = 0;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1308  	static	u8 check_reg824;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1309  	static	u32 reg824_bit9;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1310  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1311  	is_cck_rate = rx_hal_is_cck_rate(pdrvinfo);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1312  	memset(precord_stats, 0, sizeof(struct rtllib_rx_stats));
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1313  	pstats->bPacketMatchBSSID = precord_stats->bPacketMatchBSSID =
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1314  				    bpacket_match_bssid;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1315  	pstats->bPacketToSelf = precord_stats->bPacketToSelf = bpacket_toself;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1316  	pstats->bIsCCK = precord_stats->bIsCCK = is_cck_rate;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1317  	pstats->bPacketBeacon = precord_stats->bPacketBeacon = bPacketBeacon;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1318  	pstats->bToSelfBA = precord_stats->bToSelfBA = bToSelfBA;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1319  	if (check_reg824 == 0) {
3c351feca929e1 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Mateusz Kulikowski 2015-07-19  1320  		reg824_bit9 = rtl92e_get_bb_reg(priv->rtllib->dev,
3c351feca929e1 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Mateusz Kulikowski 2015-07-19  1321  						rFPGA0_XA_HSSIParameter2,
3c351feca929e1 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Mateusz Kulikowski 2015-07-19  1322  						0x200);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1323  		check_reg824 = 1;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1324  	}
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1325  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1326  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1327  	prxpkt = (u8 *)pdrvinfo;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1328  
6f22c62010122f drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-07-18  1329  	prxpkt += sizeof(struct rx_fwinfo);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1330  
ececd694df70a7 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-07-18  1331  	pcck_buf = (struct phy_sts_cck_819xpci *)prxpkt;
2ae7ea8cf099f0 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-07-18  1332  	pofdm_buf = (struct phy_sts_ofdm_819xpci *)prxpkt;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1333  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1334  	pstats->RxMIMOSignalQuality[0] = -1;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1335  	pstats->RxMIMOSignalQuality[1] = -1;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1336  	precord_stats->RxMIMOSignalQuality[0] = -1;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1337  	precord_stats->RxMIMOSignalQuality[1] = -1;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1338  
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1339  	if (is_cck_rate) {
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1340  		u8 report;
b1d5ee7004c855 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-07-13  1341  
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1342  		if (!reg824_bit9) {
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1343  			report = pcck_buf->cck_agc_rpt & 0xc0;
0dbffe07b15d43 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Aya Mahfouz        2015-02-26  1344  			report >>= 6;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1345  			switch (report) {
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1346  			case 0x3:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1347  				rx_pwr_all = -35 - (pcck_buf->cck_agc_rpt &
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1348  					     0x3e);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1349  				break;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1350  			case 0x2:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1351  				rx_pwr_all = -23 - (pcck_buf->cck_agc_rpt &
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1352  					     0x3e);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1353  				break;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1354  			case 0x1:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1355  				rx_pwr_all = -11 - (pcck_buf->cck_agc_rpt &
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1356  					     0x3e);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1357  				break;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1358  			case 0x0:
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1359  				rx_pwr_all = 8 - (pcck_buf->cck_agc_rpt & 0x3e);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1360  				break;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1361  			}
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1362  		} else {
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1363  			report = pcck_buf->cck_agc_rpt & 0x60;
0dbffe07b15d43 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Aya Mahfouz        2015-02-26  1364  			report >>= 5;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1365  			switch (report) {
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1366  			case 0x3:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1367  				rx_pwr_all = -35 -
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1368  					((pcck_buf->cck_agc_rpt &
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1369  					0x1f) << 1);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1370  				break;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1371  			case 0x2:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1372  				rx_pwr_all = -23 -
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1373  					((pcck_buf->cck_agc_rpt &
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1374  					 0x1f) << 1);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1375  				break;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1376  			case 0x1:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1377  				rx_pwr_all = -11 -
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1378  					 ((pcck_buf->cck_agc_rpt &
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1379  					 0x1f) << 1);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1380  				break;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1381  			case 0x0:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1382  				rx_pwr_all = -8 -
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1383  					 ((pcck_buf->cck_agc_rpt &
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1384  					 0x1f) << 1);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1385  				break;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1386  			}
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1387  		}
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1388  
aa804031831cfc drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Mateusz Kulikowski 2015-07-19  1389  		pwdb_all = rtl92e_rx_db_to_percent(rx_pwr_all);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1390  		pstats->RxPWDBAll = precord_stats->RxPWDBAll = pwdb_all;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1391  		pstats->RecvSignalPower = rx_pwr_all;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1392  
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1393  		if (bpacket_match_bssid) {
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1394  			u8	sq;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1395  
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1396  			if (pstats->RxPWDBAll > 40) {
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1397  				sq = 100;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1398  			} else {
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1399  				sq = pcck_buf->sq_rpt;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1400  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1401  				if (pcck_buf->sq_rpt > 64)
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1402  					sq = 0;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1403  				else if (pcck_buf->sq_rpt < 20)
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1404  					sq = 100;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1405  				else
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1406  					sq = ((64-sq) * 100) / 44;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1407  			}
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1408  			pstats->SignalQuality = sq;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1409  			precord_stats->SignalQuality = sq;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1410  			pstats->RxMIMOSignalQuality[0] = sq;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1411  			precord_stats->RxMIMOSignalQuality[0] = sq;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1412  			pstats->RxMIMOSignalQuality[1] = -1;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1413  			precord_stats->RxMIMOSignalQuality[1] = -1;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1414  		}
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1415  	} else {
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1416  		for (i = RF90_PATH_A; i < RF90_PATH_MAX; i++) {
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1417  			if (priv->brfpath_rxenable[i])
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1418  				rf_rx_num++;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1419  
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1420  			rx_pwr[i] = ((pofdm_buf->trsw_gain_X[i] & 0x3F) *
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1421  				     2) - 110;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1422  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1423  			tmp_rxsnr = pofdm_buf->rxsnr_X[i];
5d5fd353740ffe drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Arnd Bergmann      2016-07-20  1424  			rx_snrX = (s8)(tmp_rxsnr);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1425  			rx_snrX /= 2;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1426  			priv->stats.rxSNRdB[i] = (long)rx_snrX;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1427  
aa804031831cfc drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Mateusz Kulikowski 2015-07-19  1428  			RSSI = rtl92e_rx_db_to_percent(rx_pwr[i]);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1429  			if (priv->brfpath_rxenable[i])
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1430  				total_rssi += RSSI;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1431  
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1432  			if (bpacket_match_bssid) {
20400df1e48eeb drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Solomon Tan        2022-04-23  1433  				pstats->RxMIMOSignalStrength[i] = RSSI;
20400df1e48eeb drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Solomon Tan        2022-04-23  1434  				precord_stats->RxMIMOSignalStrength[i] = RSSI;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1435  			}
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1436  		}
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1437  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1438  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1439  		rx_pwr_all = (((pofdm_buf->pwdb_all) >> 1) & 0x7f) - 106;
aa804031831cfc drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Mateusz Kulikowski 2015-07-19  1440  		pwdb_all = rtl92e_rx_db_to_percent(rx_pwr_all);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1441  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1442  		pstats->RxPWDBAll = precord_stats->RxPWDBAll = pwdb_all;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1443  		pstats->RxPower = precord_stats->RxPower =	rx_pwr_all;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1444  		pstats->RecvSignalPower = rx_pwr_all;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1445  		if (pdrvinfo->RxHT && pdrvinfo->RxRate >= DESC90_RATEMCS8 &&
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1446  		    pdrvinfo->RxRate <= DESC90_RATEMCS15)
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1447  			max_spatial_stream = 2;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1448  		else
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1449  			max_spatial_stream = 1;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1450  
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1451  		for (i = 0; i < max_spatial_stream; i++) {
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1452  			tmp_rxevm = pofdm_buf->rxevm_X[i];
5d5fd353740ffe drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Arnd Bergmann      2016-07-20  1453  			rx_evmX = (s8)(tmp_rxevm);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1454  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1455  			rx_evmX /= 2;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1456  
6b89d0e7ceb733 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Mateusz Kulikowski 2015-07-19  1457  			evm = rtl92e_evm_db_to_percent(rx_evmX);
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1458  			if (bpacket_match_bssid) {
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1459  				if (i == 0) {
4db665e50ccc75 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Gargi Sharma       2017-03-09  1460  					pstats->SignalQuality = evm & 0xff;
4db665e50ccc75 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Gargi Sharma       2017-03-09  1461  					precord_stats->SignalQuality = evm & 0xff;
4db665e50ccc75 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Gargi Sharma       2017-03-09  1462  				}
4db665e50ccc75 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Gargi Sharma       2017-03-09  1463  				pstats->RxMIMOSignalQuality[i] = evm & 0xff;
4db665e50ccc75 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Gargi Sharma       2017-03-09  1464  				precord_stats->RxMIMOSignalQuality[i] = evm & 0xff;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1465  			}
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1466  		}
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1467  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1468  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1469  		rxsc_sgien_exflg = pofdm_buf->rxsc_sgien_exflg;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1470  		prxsc = (struct phy_ofdm_rx_status_rxsc_sgien_exintfflag *)
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1471  			&rxsc_sgien_exflg;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1472  	}
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1473  
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1474  	if (is_cck_rate) {
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1475  		pstats->SignalStrength = precord_stats->SignalStrength =
20400df1e48eeb drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Solomon Tan        2022-04-23  1476  					 _rtl92e_signal_scale_mapping(priv,
20400df1e48eeb drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Solomon Tan        2022-04-23  1477  					 (long)pwdb_all);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1478  
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1479  	} else {
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1480  		if (rf_rx_num != 0)
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1481  			pstats->SignalStrength = precord_stats->SignalStrength =
20400df1e48eeb drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Solomon Tan        2022-04-23  1482  					 _rtl92e_signal_scale_mapping(priv,
20400df1e48eeb drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Solomon Tan        2022-04-23  1483  					 (long)(total_rssi /= rf_rx_num));
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1484  	}
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1485  }
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1486  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
