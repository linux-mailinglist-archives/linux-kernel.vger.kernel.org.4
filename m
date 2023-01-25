Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEE667AB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjAYH4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjAYH4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:56:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F8C457C2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674633412; x=1706169412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vzWdDF0dNodN2Xse6XuZgwHDAfYRfn2RPrMdYCSQG+A=;
  b=FLRJdewh2dIWBfUtxxzX+ra9upd6KsV8lVQEQKOdMjKMX2Da7yoiMElo
   cV/t2UmKi6qcicDUyycrih/2PwOR6Uoi00mDT+26kBJZv8Ffk8zq15t3o
   wdHm3FQOxVPI08XvneDroOz4gPeDDW9L19sfn5tgFronz35sdlQw3xMcx
   oj/1TejvXRNFPxN9U0XSHBx0tIZ4Ei8U2rJGW51TSCLU6z2PjQueV5vtf
   Ju9ecW99Y6ItFQwpIn2RaJ+a46oVKFScmrLVn58SDuD1yy1f3jo6NQ0Z2
   Y497R1ryiIG+E++VFWXbgu73hmtwLONeHYpqlcMANaCO7DpbuGHnS2tA5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="325176991"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="325176991"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 23:56:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="692870377"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="692870377"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2023 23:56:49 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKaeH-00079c-05;
        Wed, 25 Jan 2023 07:56:49 +0000
Date:   Wed, 25 Jan 2023 15:56:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 04/11] staging: rtl8192e: Remove unused variables
 numpacket.. and received_pre..
Message-ID: <202301251527.mB6KfScg-lkp@intel.com>
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
config: i386-randconfig-a011-20230123 (https://download.01.org/0day-ci/archive/20230125/202301251527.mB6KfScg-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6e636a3b2ef9d90cd6fe7dba2a4acb627f13ba3e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Philipp-Hortmann/staging-rtl8192e-Remove-unused-variables-rxrdu-and-rxok/20230125-060703
        git checkout 6e636a3b2ef9d90cd6fe7dba2a4acb627f13ba3e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/rtl8192e/rtl8192e/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:1702:6: warning: variable 'preamble_guardinterval' set but not used [-Wunused-but-set-variable]
           u32 preamble_guardinterval;
               ^
   1 warning generated.


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
