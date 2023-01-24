Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC9E67A6DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjAXXcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAXXcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:32:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E543BD84
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674603149; x=1706139149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j88JmOmcT/SnluuDmc8xEb8YjP08eR0HMySwO24LBbk=;
  b=hS52VEBuvCPAq/U57GmMXdeD5Cghxz5BiFIl55MRDxIHxLsFIu2MEHBA
   yMf6f3Nsi5rSBGOtncIYLqfnlCRfihTVZ47g/IJexavgy2TRcsnEInOpT
   DyG7pNeeaFTEbf69ClTPL9W5cAAGAXrViktwBPy5RNjeXl0zyeMuyg4es
   GWHhuNDOCFInHm5er2Hjxc82gXzPdtwrJzHpz208cSfi7LukYrkrnecQR
   l9BSIG2B3D97obbhI/MfCdZbCcQrp+zjUW7lJGJvtvIKWhZbl6NhE5ydx
   Q3aymi+FXEEBMNMpjCmmiDNYUY3UUwkz/IKCneZfEHVrey8s5cGpLRAsu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="306792155"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="306792155"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 15:32:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="655609112"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="655609112"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Jan 2023 15:32:26 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKSm9-0006s0-0U;
        Tue, 24 Jan 2023 23:32:25 +0000
Date:   Wed, 25 Jan 2023 07:32:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 04/11] staging: rtl8192e: Remove unused variables
 numpacket.. and received_pre..
Message-ID: <202301250710.9Mt0vvCc-lkp@intel.com>
References: <c90c54f7b0e122914d5c02d6849447897a268f16.1674596722.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c90c54f7b0e122914d5c02d6849447897a268f16.1674596722.git.philipp.g.hortmann@gmail.com>
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
patch link:    https://lore.kernel.org/r/c90c54f7b0e122914d5c02d6849447897a268f16.1674596722.git.philipp.g.hortmann%40gmail.com
patch subject: [PATCH 04/11] staging: rtl8192e: Remove unused variables numpacket.. and received_pre..
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230125/202301250710.9Mt0vvCc-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6e636a3b2ef9d90cd6fe7dba2a4acb627f13ba3e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Philipp-Hortmann/staging-rtl8192e-Remove-unused-variables-rxrdu-and-rxok/20230125-060703
        git checkout 6e636a3b2ef9d90cd6fe7dba2a4acb627f13ba3e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/staging/rtl8192e/rtl8192e/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c: In function '_rtl92e_update_received_rate_histogram_stats':
>> drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:1702:13: warning: variable 'preamble_guardinterval' set but not used [-Wunused-but-set-variable]
    1702 |         u32 preamble_guardinterval;
         |             ^~~~~~~~~~~~~~~~~~~~~~


vim +/preamble_guardinterval +1702 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c

94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1694  
77055c56a71bcc drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c Mateusz Kulikowski 2015-09-20  1695  static void _rtl92e_update_received_rate_histogram_stats(
49aab5fd9df153 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1696  					   struct net_device *dev,
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1697  					   struct rtllib_rx_stats *pstats)
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1698  {
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1699  	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1700  	u32 rcvType = 1;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1701  	u32 rateIndex;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23 @1702  	u32 preamble_guardinterval;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1703  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1704  	if (pstats->bCRC)
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1705  		rcvType = 2;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1706  	else if (pstats->bICV)
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1707  		rcvType = 3;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1708  
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1709  	if (pstats->bShortPreamble)
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1710  		preamble_guardinterval = 1;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1711  	else
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1712  		preamble_guardinterval = 0;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1713  
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1714  	switch (pstats->rate) {
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1715  	case MGN_1M:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1716  		rateIndex = 0;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1717  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1718  	case MGN_2M:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1719  		rateIndex = 1;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1720  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1721  	case MGN_5_5M:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1722  		rateIndex = 2;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1723  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1724  	case MGN_11M:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1725  		rateIndex = 3;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1726  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1727  	case MGN_6M:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1728  		rateIndex = 4;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1729  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1730  	case MGN_9M:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1731  		rateIndex = 5;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1732  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1733  	case MGN_12M:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1734  		rateIndex = 6;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1735  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1736  	case MGN_18M:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1737  		rateIndex = 7;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1738  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1739  	case MGN_24M:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1740  		rateIndex = 8;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1741  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1742  	case MGN_36M:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1743  		rateIndex = 9;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1744  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1745  	case MGN_48M:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1746  		rateIndex = 10;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1747  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1748  	case MGN_54M:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1749  		rateIndex = 11;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1750  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1751  	case MGN_MCS0:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1752  		rateIndex = 12;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1753  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1754  	case MGN_MCS1:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1755  		rateIndex = 13;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1756  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1757  	case MGN_MCS2:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1758  		rateIndex = 14;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1759  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1760  	case MGN_MCS3:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1761  		rateIndex = 15;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1762  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1763  	case MGN_MCS4:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1764  		rateIndex = 16;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1765  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1766  	case MGN_MCS5:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1767  		rateIndex = 17;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1768  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1769  	case MGN_MCS6:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1770  		rateIndex = 18;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1771  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1772  	case MGN_MCS7:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1773  		rateIndex = 19;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1774  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1775  	case MGN_MCS8:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1776  		rateIndex = 20;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1777  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1778  	case MGN_MCS9:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1779  		rateIndex = 21;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1780  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1781  	case MGN_MCS10:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1782  		rateIndex = 22;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1783  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1784  	case MGN_MCS11:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1785  		rateIndex = 23;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1786  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1787  	case MGN_MCS12:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1788  		rateIndex = 24;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1789  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1790  	case MGN_MCS13:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1791  		rateIndex = 25;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1792  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1793  	case MGN_MCS14:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1794  		rateIndex = 26;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1795  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1796  	case MGN_MCS15:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1797  		rateIndex = 27;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1798  		break;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1799  	default:
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1800  		rateIndex = 28;
526294770c72e9 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-25  1801  		break;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1802  	}
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1803  	priv->stats.received_rate_histogram[0][rateIndex]++;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1804  	priv->stats.received_rate_histogram[rcvType][rateIndex]++;
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1805  }
94a799425eee82 drivers/staging/rtl8192e/r8192E_dev.c          Larry Finger       2011-08-23  1806  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
