Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0426D34DE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 00:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDAWet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 18:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDAWer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 18:34:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C82125552
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680388484; x=1711924484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vzBj1tGsvf0VH9YgyPZvt8l6t5nW3CSRc0vVF8Z9z3w=;
  b=OBJU4dkvSyH/2/f5X7I+2wiSPXa82UsJLr8t+TRwaFbt6gsJFUY7pico
   ZTWL818ONKQZ49g8dQlJHjhwSZgusxL/4Nd57uw6xEtc+LjIUXSVF4sfp
   4dLnPsW0j56J/0nrvs7c2tbgnOUlv3nMYiofjpytjpOqHDvVXub1MbcPQ
   DVptqitglS+uou9ovAsdodaX5Fh6JokURxPf+gRbt1PIf/6HAS/NrY7sO
   UI1KshDfETGqUmLC9hHuT5mUY5kVs39P7cFKW6+gceWWyX0qmstmDHufe
   UjzEHi3hRKrAc3tdXUYgmUNxQ0FMRTVNV9S/0CZDYm/7ZebQdDpebGaTK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="339180030"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="339180030"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 15:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="859746407"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="859746407"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Apr 2023 15:34:41 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pijo0-000N5J-1h;
        Sat, 01 Apr 2023 22:34:40 +0000
Date:   Sun, 2 Apr 2023 06:34:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/5] staging: rtl8192e: Remove enum RF_1T2R
Message-ID: <202304020640.6kQhWbyp-lkp@intel.com>
References: <97fef03c12dbc619aab749867fa20686af2b8e3b.1680297150.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97fef03c12dbc619aab749867fa20686af2b8e3b.1680297150.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Hortmann/staging-rtl8192e-Remove-enum-RF_1T2R/20230401-052904
patch link:    https://lore.kernel.org/r/97fef03c12dbc619aab749867fa20686af2b8e3b.1680297150.git.philipp.g.hortmann%40gmail.com
patch subject: [PATCH 1/5] staging: rtl8192e: Remove enum RF_1T2R
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230402/202304020640.6kQhWbyp-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/151a231e49c070db4fbf7e4a497ad98d30944109
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Philipp-Hortmann/staging-rtl8192e-Remove-enum-RF_1T2R/20230401-052904
        git checkout 151a231e49c070db4fbf7e4a497ad98d30944109
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hid/ drivers/iio/pressure/ drivers/staging/rtl8192e/rtl8192e/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304020640.6kQhWbyp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/staging/rtl8192e/rtl8192e/rtl_dm.c:613:15: warning: variable 'RF_Type' is uninitialized when used here [-Wuninitialized]
                                                                         RF_Type);
                                                                         ^~~~~~~
   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c:523:12: note: initialize the variable 'RF_Type' to silence this warning
           u8      RF_Type, tmp_report[5] = {0, 0, 0, 0, 0};
                          ^
                           = '\0'
   1 warning generated.


vim +/RF_Type +613 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c

eae10b8ea5c0811 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-04-13  515  
a19b5d7207f7baa drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-09-20  516  static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  517  {
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  518  	struct r8192_priv *priv = rtllib_priv(dev);
4a67342ea9c7c34 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c YueHaibing         2019-08-21  519  	bool	viviflag = false;
bdc632bc940f012 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-07-18  520  	struct dcmd_txcmd tx_cmd;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  521  	u8	powerlevelOFDM24G;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  522  	int	i = 0, j = 0, k = 0;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  523  	u8	RF_Type, tmp_report[5] = {0, 0, 0, 0, 0};
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  524  	u32	Value;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  525  	u8	Pwr_Flag;
48ca41d38892550 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  526  	u16	Avg_TSSI_Meas, tssi_13dBm, Avg_TSSI_Meas_from_driver = 0;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  527  	u32	delta = 0;
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  528  
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  529  	rtl92e_writeb(dev, Pw_Track_Flag, 0);
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  530  	rtl92e_writeb(dev, FW_Busy_Flag, 0);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  531  	priv->rtllib->bdynamic_txpower_enable = false;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  532  
48ca41d38892550 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  533  	powerlevelOFDM24G = priv->pwr_track >> 24;
151a231e49c070d drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-03-31  534  	Value = powerlevelOFDM24G;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  535  
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  536  	for (j = 0; j <= 30; j++) {
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  537  
9adc341cdcf63a4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Dragan Cvetic      2022-10-10  538  		tx_cmd.op	= TXCMD_SET_TX_PWR_TRACKING;
9adc341cdcf63a4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Dragan Cvetic      2022-10-10  539  		tx_cmd.length	= 4;
9adc341cdcf63a4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Dragan Cvetic      2022-10-10  540  		tx_cmd.value	= Value;
d15fe3e01989df3 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-10-19  541  		rtl92e_send_cmd_pkt(dev, DESC_PACKET_TYPE_NORMAL, (u8 *)&tx_cmd,
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  542  				    sizeof(struct dcmd_txcmd));
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  543  		mdelay(1);
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  544  		for (i = 0; i <= 30; i++) {
b59a4ca3d442186 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  545  			Pwr_Flag = rtl92e_readb(dev, Pw_Track_Flag);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  546  
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  547  			if (Pwr_Flag == 0) {
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  548  				mdelay(1);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  549  
18651492d516607 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-15  550  				if (priv->reset_in_progress) {
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  551  					rtl92e_writeb(dev, Pw_Track_Flag, 0);
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  552  					rtl92e_writeb(dev, FW_Busy_Flag, 0);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  553  					return;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  554  				}
ec07986067a7496 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2022-09-25  555  				if (priv->rtllib->rf_power_state != rf_on) {
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  556  					rtl92e_writeb(dev, Pw_Track_Flag, 0);
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  557  					rtl92e_writeb(dev, FW_Busy_Flag, 0);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  558  					return;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  559  				}
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  560  
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  561  				continue;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  562  			}
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  563  
1c0a7c0e622a94e drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  564  			Avg_TSSI_Meas = rtl92e_readw(dev, Tssi_Mea_Value);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  565  
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  566  			if (Avg_TSSI_Meas == 0) {
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  567  				rtl92e_writeb(dev, Pw_Track_Flag, 0);
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  568  				rtl92e_writeb(dev, FW_Busy_Flag, 0);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  569  				return;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  570  			}
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  571  
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  572  			for (k = 0; k < 5; k++) {
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  573  				if (k != 4)
b59a4ca3d442186 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  574  					tmp_report[k] = rtl92e_readb(dev,
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  575  							 Tssi_Report_Value1+k);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  576  				else
b59a4ca3d442186 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  577  					tmp_report[k] = rtl92e_readb(dev,
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  578  							 Tssi_Report_Value2);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  579  
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  580  				if (tmp_report[k] <= 20) {
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  581  					viviflag = true;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  582  					break;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  583  				}
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  584  			}
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  585  
4bb01423ab05af0 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Valentina Manea    2013-10-25  586  			if (viviflag) {
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  587  				rtl92e_writeb(dev, Pw_Track_Flag, 0);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  588  				viviflag = false;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  589  				for (k = 0; k < 5; k++)
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  590  					tmp_report[k] = 0;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  591  				break;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  592  			}
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  593  
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  594  			for (k = 0; k < 5; k++)
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  595  				Avg_TSSI_Meas_from_driver += tmp_report[k];
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  596  
35e33b0468ab3b3 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-05-31  597  			Avg_TSSI_Meas_from_driver *= 100 / 5;
48ca41d38892550 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  598  			tssi_13dBm = priv->tssi_13dBm;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  599  
48ca41d38892550 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  600  			if (Avg_TSSI_Meas_from_driver > tssi_13dBm)
48ca41d38892550 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  601  				delta = Avg_TSSI_Meas_from_driver - tssi_13dBm;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  602  			else
48ca41d38892550 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  603  				delta = tssi_13dBm - Avg_TSSI_Meas_from_driver;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  604  
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  605  			if (delta <= E_FOR_TX_POWER_TRACK) {
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  606  				priv->rtllib->bdynamic_txpower_enable = true;
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  607  				rtl92e_writeb(dev, Pw_Track_Flag, 0);
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  608  				rtl92e_writeb(dev, FW_Busy_Flag, 0);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  609  				return;
285b7c00e06b4fd drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-04-01  610  			}
48ca41d38892550 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  611  			if (Avg_TSSI_Meas_from_driver < tssi_13dBm - E_FOR_TX_POWER_TRACK)
ea3ab341a205097 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-09-20  612  				_rtl92e_dm_tx_update_tssi_weak_signal(dev,
ea3ab341a205097 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-09-20 @613  								      RF_Type);
eae10b8ea5c0811 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-04-13  614  			else
264045986f689af drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-09-20  615  				_rtl92e_dm_tx_update_tssi_strong_signal(dev, RF_Type);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  616  
6def63e4b4ffe09 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  617  			priv->cck_present_attn_diff
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  618  				= priv->rfa_txpowertrackingindex_real - priv->rfa_txpowertracking_default;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  619  
779c9e938d824dc drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-18  620  			if (priv->current_chnl_bw == HT_CHANNEL_WIDTH_20)
62310f889a73ea2 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2022-11-13  621  				priv->cck_present_attn =
6def63e4b4ffe09 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  622  					 priv->cck_present_attn_20m_def +
6def63e4b4ffe09 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  623  					 priv->cck_present_attn_diff;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  624  			else
62310f889a73ea2 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2022-11-13  625  				priv->cck_present_attn =
6def63e4b4ffe09 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  626  					 priv->cck_present_attn_40m_def +
6def63e4b4ffe09 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  627  					 priv->cck_present_attn_diff;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  628  
59f6f02ead58fe4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-29  629  			if (priv->cck_present_attn > (CCK_TX_BB_GAIN_TABLE_LEN - 1))
59f6f02ead58fe4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-29  630  				priv->cck_present_attn = CCK_TX_BB_GAIN_TABLE_LEN - 1;
62310f889a73ea2 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2022-11-13  631  			if (priv->cck_present_attn < 0)
62310f889a73ea2 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2022-11-13  632  				priv->cck_present_attn = 0;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  633  
62310f889a73ea2 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2022-11-13  634  			if (priv->cck_present_attn > -1 &&
59f6f02ead58fe4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-29  635  			    priv->cck_present_attn < CCK_TX_BB_GAIN_TABLE_LEN) {
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  636  				if (priv->rtllib->current_network.channel == 14 &&
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  637  				    !priv->bcck_in_ch14) {
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  638  					priv->bcck_in_ch14 = true;
59e84dc363bfaa6 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  639  					rtl92e_dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  640  				} else if (priv->rtllib->current_network.channel != 14 && priv->bcck_in_ch14) {
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  641  					priv->bcck_in_ch14 = false;
59e84dc363bfaa6 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  642  					rtl92e_dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  643  				} else
59e84dc363bfaa6 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  644  					rtl92e_dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  645  			}
b448b0cc13112c7 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-25  646  
6def63e4b4ffe09 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  647  			if (priv->cck_present_attn_diff <= -12 ||
6def63e4b4ffe09 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Philipp Hortmann   2023-01-09  648  			    priv->cck_present_attn_diff >= 24) {
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  649  				priv->rtllib->bdynamic_txpower_enable = true;
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  650  				rtl92e_writeb(dev, Pw_Track_Flag, 0);
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  651  				rtl92e_writeb(dev, FW_Busy_Flag, 0);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  652  				return;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  653  			}
285b7c00e06b4fd drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-04-01  654  
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  655  			rtl92e_writeb(dev, Pw_Track_Flag, 0);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  656  			Avg_TSSI_Meas_from_driver = 0;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  657  			for (k = 0; k < 5; k++)
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  658  				tmp_report[k] = 0;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  659  			break;
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  660  		}
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  661  		rtl92e_writeb(dev, FW_Busy_Flag, 0);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  662  	}
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  663  	priv->rtllib->bdynamic_txpower_enable = true;
d8ae1967694aca4 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c Mateusz Kulikowski 2015-07-19  664  	rtl92e_writeb(dev, Pw_Track_Flag, 0);
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  665  }
94a799425eee822 drivers/staging/rtl8192e/rtl_dm.c          Larry Finger       2011-08-23  666  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
