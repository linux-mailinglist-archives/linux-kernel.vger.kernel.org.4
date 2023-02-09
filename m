Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B068FCC3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjBICC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBICC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:02:26 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9636F25973
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675908141; x=1707444141;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SnHTC2RRJuF6tW5+3HgimDqpCY+HonnMuoOMxEQ3Z8o=;
  b=MUP4bCjMojSA4ydLmcZ6PKQGvUueUAWENxK1D6Me7V2owHoiwGi5UYyO
   Q4pZWJjy1sX8NLJozc2IOi4EbJr/UEQNWB+152dZIoVb8GY9QECBt/cHV
   3mjvnojizAYDCpwHCfCHPtwkfaJ01UwQldJEvryNOfqXqSpGDK0VacZPQ
   kwOffvKGrj5bHqkPTArvxtC/oJcPCjMdeuVTR1zwEoFIjeFATfJKn4d1A
   VTmL9+eMgd3+IkxXElgnAVcKlCWBKbIR++zttX1c3pdQ1kfsWG1sn7HuZ
   05XMBaNVieApilXJVkSpmtQ+jLq/r1Wx0C4dNjCQGlHH3uTVd+24AiMZY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331273332"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331273332"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 18:01:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="667469833"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="667469833"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Feb 2023 18:01:20 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPwFU-0004kY-01;
        Thu, 09 Feb 2023 02:01:20 +0000
Date:   Thu, 9 Feb 2023 10:01:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dillon Varone <Dillon.Varone@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3727:1:
 warning: the frame size of 2064 bytes is larger than 2048 bytes
Message-ID: <202302090946.N4i3Pm6J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0983f6bf2bfc0789b51ddf7315f644ff4da50acb
commit: 6d4727c80947de0e6fad58b196a9d215e3b32608 drm/amd/display: Add check for DET fetch latency hiding for dcn32
date:   3 months ago
config: arm64-buildonly-randconfig-r002-20230209 (https://download.01.org/0day-ci/archive/20230209/202302090946.N4i3Pm6J-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d4727c80947de0e6fad58b196a9d215e3b32608
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6d4727c80947de0e6fad58b196a9d215e3b32608
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302090946.N4i3Pm6J-lkp@intel.com

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3727:1: warning: the frame size of 2064 bytes is larger than 2048 bytes [-Wframe-larger-than=]
    3727 | } // ModeSupportAndSystemConfigurationFull
         | ^


vim +3727 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c

dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1720  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1721  	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1722  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1723  	/*Scale Ratio, taps Support Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1724  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1725  	mode_lib->vba.ScaleRatioAndTapsSupport = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1726  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1727  		if (mode_lib->vba.ScalerEnabled[k] == false
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1728  				&& ((mode_lib->vba.SourcePixelFormat[k] != dm_444_64
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1729  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_32
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1730  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1731  						&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1732  						&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_8
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1733  						&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1734  						&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe_alpha)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1735  						|| mode_lib->vba.HRatio[k] != 1.0 || mode_lib->vba.htaps[k] != 1.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1736  						|| mode_lib->vba.VRatio[k] != 1.0 || mode_lib->vba.vtaps[k] != 1.0)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1737  			mode_lib->vba.ScaleRatioAndTapsSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1738  		} else if (mode_lib->vba.vtaps[k] < 1.0 || mode_lib->vba.vtaps[k] > 8.0 || mode_lib->vba.htaps[k] < 1.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1739  				|| mode_lib->vba.htaps[k] > 8.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1740  				|| (mode_lib->vba.htaps[k] > 1.0 && (mode_lib->vba.htaps[k] % 2) == 1)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1741  				|| mode_lib->vba.HRatio[k] > mode_lib->vba.MaxHSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1742  				|| mode_lib->vba.VRatio[k] > mode_lib->vba.MaxVSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1743  				|| mode_lib->vba.HRatio[k] > mode_lib->vba.htaps[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1744  				|| mode_lib->vba.VRatio[k] > mode_lib->vba.vtaps[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1745  				|| (mode_lib->vba.SourcePixelFormat[k] != dm_444_64
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1746  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_32
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1747  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1748  						&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1749  						&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_8
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1750  						&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1751  						&& (mode_lib->vba.VTAPsChroma[k] < 1
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1752  								|| mode_lib->vba.VTAPsChroma[k] > 8
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1753  								|| mode_lib->vba.HTAPsChroma[k] < 1
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1754  								|| mode_lib->vba.HTAPsChroma[k] > 8
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1755  								|| (mode_lib->vba.HTAPsChroma[k] > 1
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1756  										&& mode_lib->vba.HTAPsChroma[k] % 2
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1757  												== 1)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1758  								|| mode_lib->vba.HRatioChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1759  										> mode_lib->vba.MaxHSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1760  								|| mode_lib->vba.VRatioChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1761  										> mode_lib->vba.MaxVSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1762  								|| mode_lib->vba.HRatioChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1763  										> mode_lib->vba.HTAPsChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1764  								|| mode_lib->vba.VRatioChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1765  										> mode_lib->vba.VTAPsChroma[k]))) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1766  			mode_lib->vba.ScaleRatioAndTapsSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1767  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1768  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1769  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1770  	/*Source Format, Pixel Format and Scan Support Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1771  	mode_lib->vba.SourceFormatPixelAndScanSupport = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1772  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1773  		if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
ce19bbe46fcfb8 Chandan Vurdigere Nataraj 2022-06-07  1774  			&& (!(!IsVertical((enum dm_rotation_angle) mode_lib->vba.SourceScan[k]))
ce19bbe46fcfb8 Chandan Vurdigere Nataraj 2022-06-07  1775  				|| mode_lib->vba.DCCEnable[k] == true)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1776  			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1777  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1778  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1779  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1780  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1781  		dml32_CalculateBytePerPixelAndBlockSizes(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1782  				mode_lib->vba.SourcePixelFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1783  				mode_lib->vba.SurfaceTiling[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1784  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1785  				/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1786  				&mode_lib->vba.BytePerPixelY[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1787  				&mode_lib->vba.BytePerPixelC[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1788  				&mode_lib->vba.BytePerPixelInDETY[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1789  				&mode_lib->vba.BytePerPixelInDETC[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1790  				&mode_lib->vba.Read256BlockHeightY[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1791  				&mode_lib->vba.Read256BlockHeightC[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1792  				&mode_lib->vba.Read256BlockWidthY[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1793  				&mode_lib->vba.Read256BlockWidthC[k],
827e3c9caa77d3 Aric Cyr                  2022-08-24  1794  				&mode_lib->vba.MacroTileHeightY[k],
827e3c9caa77d3 Aric Cyr                  2022-08-24  1795  				&mode_lib->vba.MacroTileHeightC[k],
827e3c9caa77d3 Aric Cyr                  2022-08-24  1796  				&mode_lib->vba.MacroTileWidthY[k],
827e3c9caa77d3 Aric Cyr                  2022-08-24  1797  				&mode_lib->vba.MacroTileWidthC[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1798  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1799  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1800  	/*Bandwidth Support Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1801  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1802  		if (!IsVertical(mode_lib->vba.SourceRotation[k])) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1803  			v->SwathWidthYSingleDPP[k] = mode_lib->vba.ViewportWidth[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1804  			v->SwathWidthCSingleDPP[k] = mode_lib->vba.ViewportWidthChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1805  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1806  			v->SwathWidthYSingleDPP[k] = mode_lib->vba.ViewportHeight[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1807  			v->SwathWidthCSingleDPP[k] = mode_lib->vba.ViewportHeightChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1808  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1809  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1810  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1811  		v->ReadBandwidthLuma[k] = v->SwathWidthYSingleDPP[k] * dml_ceil(v->BytePerPixelInDETY[k], 1.0)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1812  				/ (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * mode_lib->vba.VRatio[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1813  		v->ReadBandwidthChroma[k] = v->SwathWidthYSingleDPP[k] / 2 * dml_ceil(v->BytePerPixelInDETC[k], 2.0)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1814  				/ (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * mode_lib->vba.VRatio[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1815  				/ 2.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1816  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1817  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1818  		if (mode_lib->vba.WritebackEnable[k] == true && mode_lib->vba.WritebackPixelFormat[k] == dm_444_64) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1819  			v->WriteBandwidth[k] = mode_lib->vba.WritebackDestinationWidth[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1820  					* mode_lib->vba.WritebackDestinationHeight[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1821  					/ (mode_lib->vba.WritebackSourceHeight[k] * mode_lib->vba.HTotal[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1822  							/ mode_lib->vba.PixelClock[k]) * 8.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1823  		} else if (mode_lib->vba.WritebackEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1824  			v->WriteBandwidth[k] = mode_lib->vba.WritebackDestinationWidth[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1825  					* mode_lib->vba.WritebackDestinationHeight[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1826  					/ (mode_lib->vba.WritebackSourceHeight[k] * mode_lib->vba.HTotal[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1827  							/ mode_lib->vba.PixelClock[k]) * 4.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1828  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1829  			v->WriteBandwidth[k] = 0.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1830  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1831  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1832  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1833  	/*Writeback Latency support check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1834  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1835  	mode_lib->vba.WritebackLatencySupport = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1836  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1837  		if (mode_lib->vba.WritebackEnable[k] == true
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1838  				&& (v->WriteBandwidth[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1839  						> mode_lib->vba.WritebackInterfaceBufferSize * 1024
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1840  								/ mode_lib->vba.WritebackLatency)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1841  			mode_lib->vba.WritebackLatencySupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1842  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1843  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1844  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1845  	/*Writeback Mode Support Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1846  	mode_lib->vba.EnoughWritebackUnits = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1847  	mode_lib->vba.TotalNumberOfActiveWriteback = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1848  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1849  		if (mode_lib->vba.WritebackEnable[k] == true)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1850  			mode_lib->vba.TotalNumberOfActiveWriteback = mode_lib->vba.TotalNumberOfActiveWriteback + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1851  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1852  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1853  	if (mode_lib->vba.TotalNumberOfActiveWriteback > mode_lib->vba.MaxNumWriteback)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1854  		mode_lib->vba.EnoughWritebackUnits = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1855  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1856  	/*Writeback Scale Ratio and Taps Support Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1857  	mode_lib->vba.WritebackScaleRatioAndTapsSupport = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1858  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1859  		if (mode_lib->vba.WritebackEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1860  			if (mode_lib->vba.WritebackHRatio[k] > mode_lib->vba.WritebackMaxHSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1861  					|| mode_lib->vba.WritebackVRatio[k] > mode_lib->vba.WritebackMaxVSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1862  					|| mode_lib->vba.WritebackHRatio[k] < mode_lib->vba.WritebackMinHSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1863  					|| mode_lib->vba.WritebackVRatio[k] < mode_lib->vba.WritebackMinVSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1864  					|| mode_lib->vba.WritebackHTaps[k] > mode_lib->vba.WritebackMaxHSCLTaps
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1865  					|| mode_lib->vba.WritebackVTaps[k] > mode_lib->vba.WritebackMaxVSCLTaps
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1866  					|| mode_lib->vba.WritebackHRatio[k] > mode_lib->vba.WritebackHTaps[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1867  					|| mode_lib->vba.WritebackVRatio[k] > mode_lib->vba.WritebackVTaps[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1868  					|| (mode_lib->vba.WritebackHTaps[k] > 2.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1869  							&& ((mode_lib->vba.WritebackHTaps[k] % 2) == 1))) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1870  				mode_lib->vba.WritebackScaleRatioAndTapsSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1871  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1872  			if (2.0 * mode_lib->vba.WritebackDestinationWidth[k] * (mode_lib->vba.WritebackVTaps[k] - 1)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1873  					* 57 > mode_lib->vba.WritebackLineBufferSize) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1874  				mode_lib->vba.WritebackScaleRatioAndTapsSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1875  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1876  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1877  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1878  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1879  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1880  		dml32_CalculateSinglePipeDPPCLKAndSCLThroughput(mode_lib->vba.HRatio[k], mode_lib->vba.HRatioChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1881  				mode_lib->vba.VRatio[k], mode_lib->vba.VRatioChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1882  				mode_lib->vba.MaxDCHUBToPSCLThroughput, mode_lib->vba.MaxPSCLToLBThroughput,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1883  				mode_lib->vba.PixelClock[k], mode_lib->vba.SourcePixelFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1884  				mode_lib->vba.htaps[k], mode_lib->vba.HTAPsChroma[k], mode_lib->vba.vtaps[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1885  				mode_lib->vba.VTAPsChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1886  				/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1887  				&mode_lib->vba.PSCL_FACTOR[k], &mode_lib->vba.PSCL_FACTOR_CHROMA[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1888  				&mode_lib->vba.MinDPPCLKUsingSingleDPP[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1889  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1890  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1891  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1892  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1893  		if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1894  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 8192;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1895  		} else if (!IsVertical(mode_lib->vba.SourceRotation[k]) && v->BytePerPixelC[k] > 0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1896  				&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe_alpha) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1897  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 7680;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1898  		} else if (IsVertical(mode_lib->vba.SourceRotation[k]) && v->BytePerPixelC[k] > 0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1899  				&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe_alpha) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1900  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 4320;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1901  		} else if (mode_lib->vba.SourcePixelFormat[k] == dm_rgbe_alpha) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1902  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 3840;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1903  		} else if (IsVertical(mode_lib->vba.SourceRotation[k]) && v->BytePerPixelY[k] == 8 &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1904  				mode_lib->vba.DCCEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1905  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 3072;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1906  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1907  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 6144;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1908  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1909  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1910  		if (mode_lib->vba.SourcePixelFormat[k] == dm_420_8 || mode_lib->vba.SourcePixelFormat[k] == dm_420_10
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1911  				|| mode_lib->vba.SourcePixelFormat[k] == dm_420_12) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1912  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportChroma = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma / 2.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1913  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1914  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportChroma = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1915  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1916  		v->MaximumSwathWidthInLineBufferLuma = mode_lib->vba.LineBufferSizeFinal
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1917  				* dml_max(mode_lib->vba.HRatio[k], 1.0) / mode_lib->vba.LBBitPerPixel[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1918  				/ (mode_lib->vba.vtaps[k] + dml_max(dml_ceil(mode_lib->vba.VRatio[k], 1.0) - 2, 0.0));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1919  		if (v->BytePerPixelC[k] == 0.0) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1920  			v->MaximumSwathWidthInLineBufferChroma = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1921  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1922  			v->MaximumSwathWidthInLineBufferChroma = mode_lib->vba.LineBufferSizeFinal
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1923  					* dml_max(mode_lib->vba.HRatioChroma[k], 1.0) / mode_lib->vba.LBBitPerPixel[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1924  					/ (mode_lib->vba.VTAPsChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1925  							+ dml_max(dml_ceil(mode_lib->vba.VRatioChroma[k], 1.0) - 2,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1926  									0.0));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1927  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1928  		v->MaximumSwathWidthLuma[k] = dml_min(v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1929  				v->MaximumSwathWidthInLineBufferLuma);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1930  		v->MaximumSwathWidthChroma[k] = dml_min(v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1931  				v->MaximumSwathWidthInLineBufferChroma);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1932  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1933  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1934  	dml32_CalculateSwathAndDETConfiguration(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1935  			mode_lib->vba.DETSizeOverride,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1936  			mode_lib->vba.UsesMALLForPStateChange,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1937  			mode_lib->vba.ConfigReturnBufferSizeInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1938  			mode_lib->vba.MaxTotalDETInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1939  			mode_lib->vba.MinCompressedBufferSizeInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1940  			1, /* ForceSingleDPP */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1941  			mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1942  			mode_lib->vba.nomDETInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1943  			mode_lib->vba.UseUnboundedRequesting,
f4b4e41a2e0527 Jun Lei                   2022-06-24  1944  			mode_lib->vba.DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment,
f4b4e41a2e0527 Jun Lei                   2022-06-24  1945  			mode_lib->vba.ip.pixel_chunk_size_kbytes,
f4b4e41a2e0527 Jun Lei                   2022-06-24  1946  			mode_lib->vba.ip.rob_buffer_size_kbytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1947  			mode_lib->vba.CompressedBufferSegmentSizeInkByteFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1948  			mode_lib->vba.Output,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1949  			mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1950  			mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1951  			mode_lib->vba.MaximumSwathWidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1952  			mode_lib->vba.MaximumSwathWidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1953  			mode_lib->vba.SourceRotation,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1954  			mode_lib->vba.ViewportStationary,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1955  			mode_lib->vba.SourcePixelFormat,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1956  			mode_lib->vba.SurfaceTiling,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1957  			mode_lib->vba.ViewportWidth,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1958  			mode_lib->vba.ViewportHeight,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1959  			mode_lib->vba.ViewportXStartY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1960  			mode_lib->vba.ViewportYStartY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1961  			mode_lib->vba.ViewportXStartC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1962  			mode_lib->vba.ViewportYStartC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1963  			mode_lib->vba.SurfaceWidthY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1964  			mode_lib->vba.SurfaceWidthC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1965  			mode_lib->vba.SurfaceHeightY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1966  			mode_lib->vba.SurfaceHeightC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1967  			mode_lib->vba.Read256BlockHeightY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1968  			mode_lib->vba.Read256BlockHeightC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1969  			mode_lib->vba.Read256BlockWidthY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1970  			mode_lib->vba.Read256BlockWidthC,
7acc487ab57e07 Alex Deucher              2022-07-20  1971  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_odm_mode,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1972  			mode_lib->vba.BlendingAndTiming,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1973  			mode_lib->vba.BytePerPixelY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1974  			mode_lib->vba.BytePerPixelC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1975  			mode_lib->vba.BytePerPixelInDETY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1976  			mode_lib->vba.BytePerPixelInDETC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1977  			mode_lib->vba.HActive,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1978  			mode_lib->vba.HRatio,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1979  			mode_lib->vba.HRatioChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1980  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0], /*  Integer DPPPerSurface[] */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1981  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1982  			/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1983  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[1], /* Long            swath_width_luma_ub[] */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1984  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[2], /* Long            swath_width_chroma_ub[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1985  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_double_array[0], /* Long            SwathWidth[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1986  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_double_array[1], /* Long            SwathWidthChroma[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1987  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[3], /* Integer         SwathHeightY[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1988  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[4], /* Integer         SwathHeightC[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1989  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[5], /* Long            DETBufferSizeInKByte[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1990  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[6], /* Long            DETBufferSizeY[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1991  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[7], /* Long            DETBufferSizeC[]  */
01cf387b1c7f60 Alex Deucher              2022-06-22  1992  			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0][0], /* bool           *UnboundedRequestEnabled  */
01cf387b1c7f60 Alex Deucher              2022-06-22  1993  			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0][0], /* Long           *CompressedBufferSizeInkByte  */
f4b4e41a2e0527 Jun Lei                   2022-06-24  1994  			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[1][0], /* Long           *CompBufReservedSpaceKBytes */
f4b4e41a2e0527 Jun Lei                   2022-06-24  1995  			&CompBufReservedSpaceNeedAdjustmentSingleDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1996  			mode_lib->vba.SingleDPPViewportSizeSupportPerSurface,/* bool ViewportSizeSupportPerSurface[] */
01cf387b1c7f60 Alex Deucher              2022-06-22  1997  			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[1][0]); /* bool           *ViewportSizeSupport */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1998  
7acc487ab57e07 Alex Deucher              2022-07-20  1999  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsNeededForPStateChangeAndVoltage = false;
7acc487ab57e07 Alex Deucher              2022-07-20  2000  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsPossible = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2001  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2002  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2003  		if (mode_lib->vba.MPCCombineUse[k] == dm_mpc_reduce_voltage_and_clocks)
7acc487ab57e07 Alex Deucher              2022-07-20  2004  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsNeededForPStateChangeAndVoltage = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2005  		if (mode_lib->vba.MPCCombineUse[k] == dm_mpc_always_when_possible)
7acc487ab57e07 Alex Deucher              2022-07-20  2006  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsPossible = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2007  	}
7acc487ab57e07 Alex Deucher              2022-07-20  2008  	mode_lib->vba.MPCCombineMethodIncompatible = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsNeededForPStateChangeAndVoltage
7acc487ab57e07 Alex Deucher              2022-07-20  2009  			&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsPossible;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2010  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2011  	for (i = 0; i < v->soc.num_states; i++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2012  		for (j = 0; j < 2; j++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2013  			mode_lib->vba.TotalNumberOfActiveDPP[i][j] = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2014  			mode_lib->vba.TotalAvailablePipesSupport[i][j] = true;
7acc487ab57e07 Alex Deucher              2022-07-20  2015  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeNoDSC = dm_odm_combine_mode_disabled;
7acc487ab57e07 Alex Deucher              2022-07-20  2016  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeDSC = dm_odm_combine_mode_disabled;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2017  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2018  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2019  				dml32_CalculateODMMode(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2020  						mode_lib->vba.MaximumPixelsPerLinePerDSCUnit,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2021  						mode_lib->vba.HActive[k],
16e5859d9faee7 Chris Park                2022-09-12  2022  						mode_lib->vba.OutputFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2023  						mode_lib->vba.Output[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2024  						mode_lib->vba.ODMUse[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2025  						mode_lib->vba.MaxDispclk[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2026  						mode_lib->vba.MaxDispclk[v->soc.num_states - 1],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2027  						false,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2028  						mode_lib->vba.TotalNumberOfActiveDPP[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2029  						mode_lib->vba.MaxNumDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2030  						mode_lib->vba.PixelClock[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2031  						mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2032  						mode_lib->vba.DISPCLKRampingMargin,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2033  						mode_lib->vba.DISPCLKDPPCLKVCOSpeed,
572200db77ecbd Taimur Hassan             2022-08-12  2034  						mode_lib->vba.NumberOfDSCSlices[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2035  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2036  						/* Output */
7acc487ab57e07 Alex Deucher              2022-07-20  2037  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportNoDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2038  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NumberOfDPPNoDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2039  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeNoDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2040  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.RequiredDISPCLKPerSurfaceNoDSC);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2041  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2042  				dml32_CalculateODMMode(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2043  						mode_lib->vba.MaximumPixelsPerLinePerDSCUnit,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2044  						mode_lib->vba.HActive[k],
16e5859d9faee7 Chris Park                2022-09-12  2045  						mode_lib->vba.OutputFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2046  						mode_lib->vba.Output[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2047  						mode_lib->vba.ODMUse[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2048  						mode_lib->vba.MaxDispclk[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2049  						mode_lib->vba.MaxDispclk[v->soc.num_states - 1],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2050  						true,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2051  						mode_lib->vba.TotalNumberOfActiveDPP[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2052  						mode_lib->vba.MaxNumDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2053  						mode_lib->vba.PixelClock[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2054  						mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2055  						mode_lib->vba.DISPCLKRampingMargin,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2056  						mode_lib->vba.DISPCLKDPPCLKVCOSpeed,
572200db77ecbd Taimur Hassan             2022-08-12  2057  						mode_lib->vba.NumberOfDSCSlices[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2058  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2059  						/* Output */
7acc487ab57e07 Alex Deucher              2022-07-20  2060  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2061  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NumberOfDPPDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2062  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2063  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.RequiredDISPCLKPerSurfaceDSC);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2064  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2065  				dml32_CalculateOutputLink(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2066  						mode_lib->vba.PHYCLKPerState[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2067  						mode_lib->vba.PHYCLKD18PerState[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2068  						mode_lib->vba.PHYCLKD32PerState[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2069  						mode_lib->vba.Downspreading,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2070  						(mode_lib->vba.BlendingAndTiming[k] == k),
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2071  						mode_lib->vba.Output[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2072  						mode_lib->vba.OutputFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2073  						mode_lib->vba.HTotal[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2074  						mode_lib->vba.HActive[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2075  						mode_lib->vba.PixelClockBackEnd[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2076  						mode_lib->vba.ForcedOutputLinkBPP[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2077  						mode_lib->vba.DSCInputBitPerComponent[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2078  						mode_lib->vba.NumberOfDSCSlices[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2079  						mode_lib->vba.AudioSampleRate[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2080  						mode_lib->vba.AudioSampleLayout[k],
7acc487ab57e07 Alex Deucher              2022-07-20  2081  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeNoDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2082  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeDSC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2083  						mode_lib->vba.DSCEnable[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2084  						mode_lib->vba.OutputLinkDPLanes[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2085  						mode_lib->vba.OutputLinkDPRate[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2086  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2087  						/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2088  						&mode_lib->vba.RequiresDSC[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2089  						&mode_lib->vba.RequiresFEC[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2090  						&mode_lib->vba.OutputBppPerState[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2091  						&mode_lib->vba.OutputTypePerState[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2092  						&mode_lib->vba.OutputRatePerState[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2093  						&mode_lib->vba.RequiredSlots[i][k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2094  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2095  				if (mode_lib->vba.RequiresDSC[i][k] == false) {
7acc487ab57e07 Alex Deucher              2022-07-20  2096  					mode_lib->vba.ODMCombineEnablePerState[i][k] = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeNoDSC;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2097  					mode_lib->vba.RequiredDISPCLKPerSurface[i][j][k] =
7acc487ab57e07 Alex Deucher              2022-07-20  2098  							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.RequiredDISPCLKPerSurfaceNoDSC;
7acc487ab57e07 Alex Deucher              2022-07-20  2099  					if (!v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportNoDSC)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2100  						mode_lib->vba.TotalAvailablePipesSupport[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2101  					mode_lib->vba.TotalNumberOfActiveDPP[i][j] =
7acc487ab57e07 Alex Deucher              2022-07-20  2102  							mode_lib->vba.TotalNumberOfActiveDPP[i][j] + v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NumberOfDPPNoDSC;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2103  				} else {
7acc487ab57e07 Alex Deucher              2022-07-20  2104  					mode_lib->vba.ODMCombineEnablePerState[i][k] = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeDSC;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2105  					mode_lib->vba.RequiredDISPCLKPerSurface[i][j][k] =
7acc487ab57e07 Alex Deucher              2022-07-20  2106  							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.RequiredDISPCLKPerSurfaceDSC;
7acc487ab57e07 Alex Deucher              2022-07-20  2107  					if (!v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportDSC)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2108  						mode_lib->vba.TotalAvailablePipesSupport[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2109  					mode_lib->vba.TotalNumberOfActiveDPP[i][j] =
7acc487ab57e07 Alex Deucher              2022-07-20  2110  							mode_lib->vba.TotalNumberOfActiveDPP[i][j] + v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NumberOfDPPDSC;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2111  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2112  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2113  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2114  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2115  				if (mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2116  					mode_lib->vba.MPCCombine[i][j][k] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2117  					mode_lib->vba.NoOfDPP[i][j][k] = 4;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2118  				} else if (mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2119  					mode_lib->vba.MPCCombine[i][j][k] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2120  					mode_lib->vba.NoOfDPP[i][j][k] = 2;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2121  				} else if (mode_lib->vba.MPCCombineUse[k] == dm_mpc_never) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2122  					mode_lib->vba.MPCCombine[i][j][k] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2123  					mode_lib->vba.NoOfDPP[i][j][k] = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2124  				} else if (dml32_RoundToDFSGranularity(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2125  						mode_lib->vba.MinDPPCLKUsingSingleDPP[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2126  								* (1 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2127  												/ 100), 1,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2128  						mode_lib->vba.DISPCLKDPPCLKVCOSpeed) <= mode_lib->vba.MaxDppclk[i] &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2129  				mode_lib->vba.SingleDPPViewportSizeSupportPerSurface[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2130  					mode_lib->vba.MPCCombine[i][j][k] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2131  					mode_lib->vba.NoOfDPP[i][j][k] = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2132  				} else if (mode_lib->vba.TotalNumberOfActiveDPP[i][j] < mode_lib->vba.MaxNumDPP) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2133  					mode_lib->vba.MPCCombine[i][j][k] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2134  					mode_lib->vba.NoOfDPP[i][j][k] = 2;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2135  					mode_lib->vba.TotalNumberOfActiveDPP[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2136  							mode_lib->vba.TotalNumberOfActiveDPP[i][j] + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2137  				} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2138  					mode_lib->vba.MPCCombine[i][j][k] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2139  					mode_lib->vba.NoOfDPP[i][j][k] = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2140  					mode_lib->vba.TotalAvailablePipesSupport[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2141  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2142  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2143  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2144  			mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] = 0;
7acc487ab57e07 Alex Deucher              2022-07-20  2145  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NoChroma = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2146  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2147  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2148  				if (mode_lib->vba.NoOfDPP[i][j][k] == 1)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2149  					mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2150  							mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2151  				if (mode_lib->vba.SourcePixelFormat[k] == dm_420_8
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2152  						|| mode_lib->vba.SourcePixelFormat[k] == dm_420_10
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2153  						|| mode_lib->vba.SourcePixelFormat[k] == dm_420_12
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2154  						|| mode_lib->vba.SourcePixelFormat[k] == dm_rgbe_alpha) {
7acc487ab57e07 Alex Deucher              2022-07-20  2155  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NoChroma = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2156  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2157  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2158  
f4b4e41a2e0527 Jun Lei                   2022-06-24  2159  			// if TotalNumberOfActiveDPP is > 1, then there should be no unbounded req mode (hw limitation), the comp buf reserved adjustment is not needed regardless
f4b4e41a2e0527 Jun Lei                   2022-06-24  2160  			// if TotalNumberOfActiveDPP is == 1, then will use the SingleDPP version of unbounded_req for the decision
f4b4e41a2e0527 Jun Lei                   2022-06-24  2161  			CompBufReservedSpaceNeedAdjustment = (mode_lib->vba.TotalNumberOfActiveDPP[i][j] > 1) ? 0 : CompBufReservedSpaceNeedAdjustmentSingleDPP;
f4b4e41a2e0527 Jun Lei                   2022-06-24  2162  
f4b4e41a2e0527 Jun Lei                   2022-06-24  2163  
f4b4e41a2e0527 Jun Lei                   2022-06-24  2164  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2165  			if (j == 1 && !dml32_UnboundedRequest(mode_lib->vba.UseUnboundedRequesting,
7acc487ab57e07 Alex Deucher              2022-07-20  2166  					mode_lib->vba.TotalNumberOfActiveDPP[i][j], v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NoChroma,
f4b4e41a2e0527 Jun Lei                   2022-06-24  2167  					mode_lib->vba.Output[0],
f4b4e41a2e0527 Jun Lei                   2022-06-24  2168  					mode_lib->vba.SurfaceTiling[0],
f4b4e41a2e0527 Jun Lei                   2022-06-24  2169  					CompBufReservedSpaceNeedAdjustment,
f4b4e41a2e0527 Jun Lei                   2022-06-24  2170  					mode_lib->vba.DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2171  				while (!(mode_lib->vba.TotalNumberOfActiveDPP[i][j] >= mode_lib->vba.MaxNumDPP
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2172  						|| mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] == 0)) {
7acc487ab57e07 Alex Deucher              2022-07-20  2173  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.BWOfNonCombinedSurfaceOfMaximumBandwidth = 0;
7acc487ab57e07 Alex Deucher              2022-07-20  2174  					NumberOfNonCombinedSurfaceOfMaximumBandwidth = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2175  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2176  					for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2177  						if (mode_lib->vba.MPCCombineUse[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2178  							!= dm_mpc_never &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2179  							mode_lib->vba.MPCCombineUse[k] != dm_mpc_reduce_voltage &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2180  							mode_lib->vba.ReadBandwidthLuma[k] +
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2181  							mode_lib->vba.ReadBandwidthChroma[k] >
7acc487ab57e07 Alex Deucher              2022-07-20  2182  							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.BWOfNonCombinedSurfaceOfMaximumBandwidth &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2183  							(mode_lib->vba.ODMCombineEnablePerState[i][k] !=
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2184  							dm_odm_combine_mode_2to1 &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2185  							mode_lib->vba.ODMCombineEnablePerState[i][k] !=
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2186  							dm_odm_combine_mode_4to1) &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2187  								mode_lib->vba.MPCCombine[i][j][k] == false) {
7acc487ab57e07 Alex Deucher              2022-07-20  2188  							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.BWOfNonCombinedSurfaceOfMaximumBandwidth =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2189  								mode_lib->vba.ReadBandwidthLuma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2190  								+ mode_lib->vba.ReadBandwidthChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2191  							NumberOfNonCombinedSurfaceOfMaximumBandwidth = k;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2192  						}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2193  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2194  					mode_lib->vba.MPCCombine[i][j][NumberOfNonCombinedSurfaceOfMaximumBandwidth] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2195  							true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2196  					mode_lib->vba.NoOfDPP[i][j][NumberOfNonCombinedSurfaceOfMaximumBandwidth] = 2;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2197  					mode_lib->vba.TotalNumberOfActiveDPP[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2198  							mode_lib->vba.TotalNumberOfActiveDPP[i][j] + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2199  					mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2200  							mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] - 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2201  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2202  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2203  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2204  			//DISPCLK/DPPCLK
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2205  			mode_lib->vba.WritebackRequiredDISPCLK = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2206  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2207  				if (mode_lib->vba.WritebackEnable[k]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2208  					mode_lib->vba.WritebackRequiredDISPCLK = dml_max(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2209  							mode_lib->vba.WritebackRequiredDISPCLK,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2210  							dml32_CalculateWriteBackDISPCLK(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2211  									mode_lib->vba.WritebackPixelFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2212  									mode_lib->vba.PixelClock[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2213  									mode_lib->vba.WritebackHRatio[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2214  									mode_lib->vba.WritebackVRatio[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2215  									mode_lib->vba.WritebackHTaps[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2216  									mode_lib->vba.WritebackVTaps[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2217  									mode_lib->vba.WritebackSourceWidth[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2218  									mode_lib->vba.WritebackDestinationWidth[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2219  									mode_lib->vba.HTotal[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2220  									mode_lib->vba.WritebackLineBufferSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2221  									mode_lib->vba.DISPCLKDPPCLKVCOSpeed));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2222  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2223  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2224  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2225  			mode_lib->vba.RequiredDISPCLK[i][j] = mode_lib->vba.WritebackRequiredDISPCLK;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2226  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2227  				mode_lib->vba.RequiredDISPCLK[i][j] = dml_max(mode_lib->vba.RequiredDISPCLK[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2228  						mode_lib->vba.RequiredDISPCLKPerSurface[i][j][k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2229  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2230  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2231  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2232  				mode_lib->vba.NoOfDPPThisState[k] = mode_lib->vba.NoOfDPP[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2233  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2234  			dml32_CalculateDPPCLK(mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2235  					mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2236  					mode_lib->vba.DISPCLKDPPCLKVCOSpeed, mode_lib->vba.MinDPPCLKUsingSingleDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2237  					mode_lib->vba.NoOfDPPThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2238  					/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2239  					&mode_lib->vba.GlobalDPPCLK, mode_lib->vba.RequiredDPPCLKThisState);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2240  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2241  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2242  				mode_lib->vba.RequiredDPPCLK[i][j][k] = mode_lib->vba.RequiredDPPCLKThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2243  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2244  			mode_lib->vba.DISPCLK_DPPCLK_Support[i][j] = !((mode_lib->vba.RequiredDISPCLK[i][j]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2245  					> mode_lib->vba.MaxDispclk[i])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2246  					|| (mode_lib->vba.GlobalDPPCLK > mode_lib->vba.MaxDppclk[i]));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2247  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2248  			if (mode_lib->vba.TotalNumberOfActiveDPP[i][j] > mode_lib->vba.MaxNumDPP)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2249  				mode_lib->vba.TotalAvailablePipesSupport[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2250  		} // j
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2251  	} // i (VOLTAGE_STATE)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2252  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2253  	/* Total Available OTG, HDMIFRL, DP Support Check */
7acc487ab57e07 Alex Deucher              2022-07-20  2254  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG = 0;
7acc487ab57e07 Alex Deucher              2022-07-20  2255  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveHDMIFRL = 0;
7acc487ab57e07 Alex Deucher              2022-07-20  2256  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 = 0;
7acc487ab57e07 Alex Deucher              2022-07-20  2257  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2258  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2259  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2260  		if (mode_lib->vba.BlendingAndTiming[k] == k) {
7acc487ab57e07 Alex Deucher              2022-07-20  2261  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2262  			if (mode_lib->vba.Output[k] == dm_dp2p0) {
7acc487ab57e07 Alex Deucher              2022-07-20  2263  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2264  				if (mode_lib->vba.OutputMultistreamId[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2265  						== k || mode_lib->vba.OutputMultistreamEn[k] == false) {
7acc487ab57e07 Alex Deucher              2022-07-20  2266  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2267  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2268  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2269  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2270  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2271  
7acc487ab57e07 Alex Deucher              2022-07-20  2272  	mode_lib->vba.NumberOfOTGSupport = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG <= mode_lib->vba.MaxNumOTG);
7acc487ab57e07 Alex Deucher              2022-07-20  2273  	mode_lib->vba.NumberOfHDMIFRLSupport = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveHDMIFRL <= mode_lib->vba.MaxNumHDMIFRLOutputs);
7acc487ab57e07 Alex Deucher              2022-07-20  2274  	mode_lib->vba.NumberOfDP2p0Support = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 <= mode_lib->vba.MaxNumDP2p0Streams
7acc487ab57e07 Alex Deucher              2022-07-20  2275  			&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs <= mode_lib->vba.MaxNumDP2p0Outputs);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2276  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2277  	/* Display IO and DSC Support Check */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2278  	mode_lib->vba.NonsupportedDSCInputBPC = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2279  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2280  		if (!(mode_lib->vba.DSCInputBitPerComponent[k] == 12.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2281  				|| mode_lib->vba.DSCInputBitPerComponent[k] == 10.0
a3daede4757603 Rodrigo Siqueira          2022-09-22  2282  				|| mode_lib->vba.DSCInputBitPerComponent[k] == 8.0)
a3daede4757603 Rodrigo Siqueira          2022-09-22  2283  				|| mode_lib->vba.DSCInputBitPerComponent[k] > mode_lib->vba.MaximumDSCBitsPerComponent) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2284  			mode_lib->vba.NonsupportedDSCInputBPC = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2285  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2286  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2287  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2288  	for (i = 0; i < v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2289  		mode_lib->vba.ExceededMultistreamSlots[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2290  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2291  			if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2292  				TotalSlots = mode_lib->vba.RequiredSlots[i][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2293  				for (j = 0; j < mode_lib->vba.NumberOfActiveSurfaces; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2294  					if (mode_lib->vba.OutputMultistreamId[j] == k)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2295  						TotalSlots = TotalSlots + mode_lib->vba.RequiredSlots[i][j];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2296  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2297  				if (mode_lib->vba.Output[k] == dm_dp && TotalSlots > 63)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2298  					mode_lib->vba.ExceededMultistreamSlots[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2299  				if (mode_lib->vba.Output[k] == dm_dp2p0 && TotalSlots > 64)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2300  					mode_lib->vba.ExceededMultistreamSlots[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2301  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2302  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2303  		mode_lib->vba.LinkCapacitySupport[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2304  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2305  			if (mode_lib->vba.BlendingAndTiming[k] == k
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2306  					&& (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2307  							|| mode_lib->vba.Output[k] == dm_edp
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2308  							|| mode_lib->vba.Output[k] == dm_hdmi)
d73aec401fd884 Alvin Lee                 2022-11-01  2309  					&& mode_lib->vba.OutputBppPerState[i][k] == 0 && (mode_lib->vba.UsesMALLForPStateChange[k] != dm_use_mall_pstate_change_phantom_pipe)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2310  				mode_lib->vba.LinkCapacitySupport[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2311  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2312  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2313  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2314  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2315  	mode_lib->vba.P2IWith420 = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2316  	mode_lib->vba.DSCOnlyIfNecessaryWithBPP = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2317  	mode_lib->vba.DSC422NativeNotSupported = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2318  	mode_lib->vba.LinkRateDoesNotMatchDPVersion = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2319  	mode_lib->vba.LinkRateForMultistreamNotIndicated = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2320  	mode_lib->vba.BPPForMultistreamNotIndicated = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2321  	mode_lib->vba.MultistreamWithHDMIOreDP = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2322  	mode_lib->vba.MSOOrODMSplitWithNonDPLink = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2323  	mode_lib->vba.NotEnoughLanesForMSO = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2324  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2325  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2326  		if (mode_lib->vba.BlendingAndTiming[k] == k
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2327  				&& (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2328  						|| mode_lib->vba.Output[k] == dm_edp
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2329  						|| mode_lib->vba.Output[k] == dm_hdmi)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2330  			if (mode_lib->vba.OutputFormat[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2331  					== dm_420 && mode_lib->vba.Interlace[k] == 1 &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2332  					mode_lib->vba.ProgressiveToInterlaceUnitInOPP == true)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2333  				mode_lib->vba.P2IWith420 = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2334  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2335  			if (mode_lib->vba.DSCEnable[k] && mode_lib->vba.ForcedOutputLinkBPP[k] != 0)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2336  				mode_lib->vba.DSCOnlyIfNecessaryWithBPP = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2337  			if ((mode_lib->vba.DSCEnable[k] || mode_lib->vba.DSCEnable[k])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2338  					&& mode_lib->vba.OutputFormat[k] == dm_n422
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2339  					&& !mode_lib->vba.DSC422NativeSupport)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2340  				mode_lib->vba.DSC422NativeNotSupported = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2341  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2342  			if (((mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_hbr
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2343  					|| mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_hbr2
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2344  					|| mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_hbr3)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2345  					&& mode_lib->vba.Output[k] != dm_dp && mode_lib->vba.Output[k] != dm_edp)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2346  					|| ((mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_uhbr10
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2347  							|| mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_uhbr13p5
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2348  							|| mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_uhbr20)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2349  							&& mode_lib->vba.Output[k] != dm_dp2p0))
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2350  				mode_lib->vba.LinkRateDoesNotMatchDPVersion = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2351  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2352  			if (mode_lib->vba.OutputMultistreamEn[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2353  				if (mode_lib->vba.OutputMultistreamId[k] == k
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2354  					&& mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_na)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2355  					mode_lib->vba.LinkRateForMultistreamNotIndicated = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2356  				if (mode_lib->vba.OutputMultistreamId[k] == k && mode_lib->vba.ForcedOutputLinkBPP[k] == 0)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2357  					mode_lib->vba.BPPForMultistreamNotIndicated = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2358  				for (j = 0; j < mode_lib->vba.NumberOfActiveSurfaces; ++j) {
a3daede4757603 Rodrigo Siqueira          2022-09-22  2359  					if (mode_lib->vba.OutputMultistreamId[k] == j
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2360  						&& mode_lib->vba.ForcedOutputLinkBPP[k] == 0)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2361  						mode_lib->vba.BPPForMultistreamNotIndicated = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2362  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2363  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2364  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2365  			if ((mode_lib->vba.Output[k] == dm_edp || mode_lib->vba.Output[k] == dm_hdmi)) {
a3daede4757603 Rodrigo Siqueira          2022-09-22  2366  				if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == k)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2367  					mode_lib->vba.MultistreamWithHDMIOreDP = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2368  				for (j = 0; j < mode_lib->vba.NumberOfActiveSurfaces; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2369  					if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == j)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2370  						mode_lib->vba.MultistreamWithHDMIOreDP = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2371  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2372  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2373  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2374  			if (mode_lib->vba.Output[k] != dm_dp
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2375  					&& (mode_lib->vba.ODMUse[k] == dm_odm_split_policy_1to2
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2376  							|| mode_lib->vba.ODMUse[k] == dm_odm_mso_policy_1to2
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2377  							|| mode_lib->vba.ODMUse[k] == dm_odm_mso_policy_1to4))
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2378  				mode_lib->vba.MSOOrODMSplitWithNonDPLink = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2379  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2380  			if ((mode_lib->vba.ODMUse[k] == dm_odm_mso_policy_1to2
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2381  					&& mode_lib->vba.OutputLinkDPLanes[k] < 2)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2382  					|| (mode_lib->vba.ODMUse[k] == dm_odm_mso_policy_1to4
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2383  							&& mode_lib->vba.OutputLinkDPLanes[k] < 4))
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2384  				mode_lib->vba.NotEnoughLanesForMSO = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2385  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2386  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2387  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2388  	for (i = 0; i < v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2389  		mode_lib->vba.DTBCLKRequiredMoreThanSupported[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2390  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2391  			if (mode_lib->vba.BlendingAndTiming[k] == k
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2392  					&& dml32_RequiredDTBCLK(mode_lib->vba.RequiresDSC[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2393  							mode_lib->vba.PixelClockBackEnd[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2394  							mode_lib->vba.OutputFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2395  							mode_lib->vba.OutputBppPerState[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2396  							mode_lib->vba.NumberOfDSCSlices[k], mode_lib->vba.HTotal[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2397  							mode_lib->vba.HActive[k], mode_lib->vba.AudioSampleRate[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2398  							mode_lib->vba.AudioSampleLayout[k])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2399  							> mode_lib->vba.DTBCLKPerState[i]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2400  				mode_lib->vba.DTBCLKRequiredMoreThanSupported[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2401  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2402  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2403  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2404  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2405  	for (i = 0; i < v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2406  		mode_lib->vba.ODMCombine2To1SupportCheckOK[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2407  		mode_lib->vba.ODMCombine4To1SupportCheckOK[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2408  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2409  			if (mode_lib->vba.BlendingAndTiming[k] == k
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2410  					&& mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2411  					&& mode_lib->vba.Output[k] == dm_hdmi) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2412  				mode_lib->vba.ODMCombine2To1SupportCheckOK[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2413  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2414  			if (mode_lib->vba.BlendingAndTiming[k] == k
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2415  					&& mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2416  					&& (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_edp
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2417  							|| mode_lib->vba.Output[k] == dm_hdmi)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2418  				mode_lib->vba.ODMCombine4To1SupportCheckOK[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2419  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2420  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2421  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2422  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2423  	for (i = 0; i < v->soc.num_states; i++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2424  		mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2425  		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2426  			if (mode_lib->vba.BlendingAndTiming[k] == k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2427  				if (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2428  						|| mode_lib->vba.Output[k] == dm_edp) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2429  					if (mode_lib->vba.OutputFormat[k] == dm_420) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2430  						mode_lib->vba.DSCFormatFactor = 2;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2431  					} else if (mode_lib->vba.OutputFormat[k] == dm_444) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2432  						mode_lib->vba.DSCFormatFactor = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2433  					} else if (mode_lib->vba.OutputFormat[k] == dm_n422) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2434  						mode_lib->vba.DSCFormatFactor = 2;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2435  					} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2436  						mode_lib->vba.DSCFormatFactor = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2437  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2438  					if (mode_lib->vba.RequiresDSC[i][k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2439  						if (mode_lib->vba.ODMCombineEnablePerState[i][k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2440  								== dm_odm_combine_mode_4to1) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2441  							if (mode_lib->vba.PixelClockBackEnd[k] / 12.0 / mode_lib->vba.DSCFormatFactor > (1.0 - mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) * mode_lib->vba.MaxDSCCLK[i])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2442  								mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2443  						} else if (mode_lib->vba.ODMCombineEnablePerState[i][k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2444  								== dm_odm_combine_mode_2to1) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2445  							if (mode_lib->vba.PixelClockBackEnd[k] / 6.0 / mode_lib->vba.DSCFormatFactor > (1.0 - mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) * mode_lib->vba.MaxDSCCLK[i])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2446  								mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2447  						} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2448  							if (mode_lib->vba.PixelClockBackEnd[k] / 3.0 / mode_lib->vba.DSCFormatFactor > (1.0 - mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) * mode_lib->vba.MaxDSCCLK[i])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2449  								mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2450  						}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2451  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2452  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2453  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2454  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2455  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2456  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2457  	/* Check DSC Unit and Slices Support */
7acc487ab57e07 Alex Deucher              2022-07-20  2458  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2459  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2460  	for (i = 0; i < v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2461  		mode_lib->vba.NotEnoughDSCUnits[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2462  		mode_lib->vba.NotEnoughDSCSlices[i] = false;
7acc487ab57e07 Alex Deucher              2022-07-20  2463  		v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2464  		mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2465  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2466  			if (mode_lib->vba.RequiresDSC[i][k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2467  				if (mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2468  					if (mode_lib->vba.HActive[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2469  							> 4 * mode_lib->vba.MaximumPixelsPerLinePerDSCUnit)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2470  						mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i] = false;
7acc487ab57e07 Alex Deucher              2022-07-20  2471  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired + 4;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2472  					if (mode_lib->vba.NumberOfDSCSlices[k] > 16)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2473  						mode_lib->vba.NotEnoughDSCSlices[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2474  				} else if (mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2475  					if (mode_lib->vba.HActive[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2476  							> 2 * mode_lib->vba.MaximumPixelsPerLinePerDSCUnit)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2477  						mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i] = false;
7acc487ab57e07 Alex Deucher              2022-07-20  2478  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired + 2;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2479  					if (mode_lib->vba.NumberOfDSCSlices[k] > 8)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2480  						mode_lib->vba.NotEnoughDSCSlices[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2481  				} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2482  					if (mode_lib->vba.HActive[k] > mode_lib->vba.MaximumPixelsPerLinePerDSCUnit)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2483  						mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i] = false;
7acc487ab57e07 Alex Deucher              2022-07-20  2484  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2485  					if (mode_lib->vba.NumberOfDSCSlices[k] > 4)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2486  						mode_lib->vba.NotEnoughDSCSlices[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2487  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2488  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2489  		}
7acc487ab57e07 Alex Deucher              2022-07-20  2490  		if (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired > mode_lib->vba.NumberOfDSC)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2491  			mode_lib->vba.NotEnoughDSCUnits[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2492  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2493  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2494  	/*DSC Delay per state*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2495  	for (i = 0; i < v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2496  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2497  			mode_lib->vba.DSCDelayPerState[i][k] = dml32_DSCDelayRequirement(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2498  					mode_lib->vba.RequiresDSC[i][k], mode_lib->vba.ODMCombineEnablePerState[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2499  					mode_lib->vba.DSCInputBitPerComponent[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2500  					mode_lib->vba.OutputBppPerState[i][k], mode_lib->vba.HActive[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2501  					mode_lib->vba.HTotal[k], mode_lib->vba.NumberOfDSCSlices[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2502  					mode_lib->vba.OutputFormat[k], mode_lib->vba.Output[k],
f30508e918b401 George Shen               2022-10-14  2503  					mode_lib->vba.PixelClock[k], mode_lib->vba.PixelClockBackEnd[k],
f30508e918b401 George Shen               2022-10-14  2504  					mode_lib->vba.ip.dsc_delay_factor_wa);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2505  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2506  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2507  		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2508  			for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces - 1; m++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2509  				for (j = 0; j <= mode_lib->vba.NumberOfActiveSurfaces - 1; j++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2510  					if (mode_lib->vba.BlendingAndTiming[k] == m &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2511  							mode_lib->vba.RequiresDSC[i][m] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2512  						mode_lib->vba.DSCDelayPerState[i][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2513  							mode_lib->vba.DSCDelayPerState[i][m];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2514  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2515  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2516  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2517  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2518  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2519  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2520  	//Calculate Swath, DET Configuration, DCFCLKDeepSleep
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2521  	//
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2522  	for (i = 0; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2523  		for (j = 0; j <= 1; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2524  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2525  				mode_lib->vba.RequiredDPPCLKThisState[k] = mode_lib->vba.RequiredDPPCLK[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2526  				mode_lib->vba.NoOfDPPThisState[k] = mode_lib->vba.NoOfDPP[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2527  				mode_lib->vba.ODMCombineEnableThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2528  						mode_lib->vba.ODMCombineEnablePerState[i][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2529  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2530  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2531  			dml32_CalculateSwathAndDETConfiguration(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2532  					mode_lib->vba.DETSizeOverride,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2533  					mode_lib->vba.UsesMALLForPStateChange,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2534  					mode_lib->vba.ConfigReturnBufferSizeInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2535  					mode_lib->vba.MaxTotalDETInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2536  					mode_lib->vba.MinCompressedBufferSizeInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2537  					false, /* ForceSingleDPP */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2538  					mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2539  					mode_lib->vba.nomDETInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2540  					mode_lib->vba.UseUnboundedRequesting,
f4b4e41a2e0527 Jun Lei                   2022-06-24  2541  					mode_lib->vba.DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment,
f4b4e41a2e0527 Jun Lei                   2022-06-24  2542  					mode_lib->vba.ip.pixel_chunk_size_kbytes,
f4b4e41a2e0527 Jun Lei                   2022-06-24  2543  					mode_lib->vba.ip.rob_buffer_size_kbytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2544  					mode_lib->vba.CompressedBufferSegmentSizeInkByteFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2545  					mode_lib->vba.Output,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2546  					mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2547  					mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2548  					mode_lib->vba.MaximumSwathWidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2549  					mode_lib->vba.MaximumSwathWidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2550  					mode_lib->vba.SourceRotation,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2551  					mode_lib->vba.ViewportStationary,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2552  					mode_lib->vba.SourcePixelFormat,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2553  					mode_lib->vba.SurfaceTiling,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2554  					mode_lib->vba.ViewportWidth,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2555  					mode_lib->vba.ViewportHeight,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2556  					mode_lib->vba.ViewportXStartY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2557  					mode_lib->vba.ViewportYStartY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2558  					mode_lib->vba.ViewportXStartC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2559  					mode_lib->vba.ViewportYStartC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2560  					mode_lib->vba.SurfaceWidthY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2561  					mode_lib->vba.SurfaceWidthC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2562  					mode_lib->vba.SurfaceHeightY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2563  					mode_lib->vba.SurfaceHeightC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2564  					mode_lib->vba.Read256BlockHeightY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2565  					mode_lib->vba.Read256BlockHeightC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2566  					mode_lib->vba.Read256BlockWidthY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2567  					mode_lib->vba.Read256BlockWidthC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2568  					mode_lib->vba.ODMCombineEnableThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2569  					mode_lib->vba.BlendingAndTiming,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2570  					mode_lib->vba.BytePerPixelY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2571  					mode_lib->vba.BytePerPixelC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2572  					mode_lib->vba.BytePerPixelInDETY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2573  					mode_lib->vba.BytePerPixelInDETC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2574  					mode_lib->vba.HActive,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2575  					mode_lib->vba.HRatio,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2576  					mode_lib->vba.HRatioChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2577  					mode_lib->vba.NoOfDPPThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2578  					/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2579  					mode_lib->vba.swath_width_luma_ub_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2580  					mode_lib->vba.swath_width_chroma_ub_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2581  					mode_lib->vba.SwathWidthYThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2582  					mode_lib->vba.SwathWidthCThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2583  					mode_lib->vba.SwathHeightYThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2584  					mode_lib->vba.SwathHeightCThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2585  					mode_lib->vba.DETBufferSizeInKByteThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2586  					mode_lib->vba.DETBufferSizeYThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2587  					mode_lib->vba.DETBufferSizeCThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2588  					&mode_lib->vba.UnboundedRequestEnabledThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2589  					&mode_lib->vba.CompressedBufferSizeInkByteThisState,
7acc487ab57e07 Alex Deucher              2022-07-20  2590  					&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer[0], /* Long CompBufReservedSpaceKBytes */
7acc487ab57e07 Alex Deucher              2022-07-20  2591  					&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean[0], /* bool CompBufReservedSpaceNeedAdjustment */
01cf387b1c7f60 Alex Deucher              2022-06-22  2592  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2593  					&mode_lib->vba.ViewportSizeSupport[i][j]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2594  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2595  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2596  				mode_lib->vba.swath_width_luma_ub_all_states[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2597  						mode_lib->vba.swath_width_luma_ub_this_state[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2598  				mode_lib->vba.swath_width_chroma_ub_all_states[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2599  						mode_lib->vba.swath_width_chroma_ub_this_state[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2600  				mode_lib->vba.SwathWidthYAllStates[i][j][k] = mode_lib->vba.SwathWidthYThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2601  				mode_lib->vba.SwathWidthCAllStates[i][j][k] = mode_lib->vba.SwathWidthCThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2602  				mode_lib->vba.SwathHeightYAllStates[i][j][k] = mode_lib->vba.SwathHeightYThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2603  				mode_lib->vba.SwathHeightCAllStates[i][j][k] = mode_lib->vba.SwathHeightCThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2604  				mode_lib->vba.UnboundedRequestEnabledAllStates[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2605  						mode_lib->vba.UnboundedRequestEnabledThisState;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2606  				mode_lib->vba.CompressedBufferSizeInkByteAllStates[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2607  						mode_lib->vba.CompressedBufferSizeInkByteThisState;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2608  				mode_lib->vba.DETBufferSizeInKByteAllStates[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2609  						mode_lib->vba.DETBufferSizeInKByteThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2610  				mode_lib->vba.DETBufferSizeYAllStates[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2611  						mode_lib->vba.DETBufferSizeYThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2612  				mode_lib->vba.DETBufferSizeCAllStates[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2613  						mode_lib->vba.DETBufferSizeCThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2614  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2615  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2616  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2617  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2618  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2619  		mode_lib->vba.cursor_bw[k] = mode_lib->vba.NumberOfCursors[k] * mode_lib->vba.CursorWidth[k][0]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2620  				* mode_lib->vba.CursorBPP[k][0] / 8.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2621  				/ (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * mode_lib->vba.VRatio[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2622  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2623  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2624  	dml32_CalculateSurfaceSizeInMall(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2625  			mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2626  			mode_lib->vba.MALLAllocatedForDCNFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2627  			mode_lib->vba.UseMALLForStaticScreen,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2628  			mode_lib->vba.DCCEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2629  			mode_lib->vba.ViewportStationary,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2630  			mode_lib->vba.ViewportXStartY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2631  			mode_lib->vba.ViewportYStartY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2632  			mode_lib->vba.ViewportXStartC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2633  			mode_lib->vba.ViewportYStartC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2634  			mode_lib->vba.ViewportWidth,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2635  			mode_lib->vba.ViewportHeight,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2636  			mode_lib->vba.BytePerPixelY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2637  			mode_lib->vba.ViewportWidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2638  			mode_lib->vba.ViewportHeightChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2639  			mode_lib->vba.BytePerPixelC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2640  			mode_lib->vba.SurfaceWidthY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2641  			mode_lib->vba.SurfaceWidthC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2642  			mode_lib->vba.SurfaceHeightY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2643  			mode_lib->vba.SurfaceHeightC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2644  			mode_lib->vba.Read256BlockWidthY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2645  			mode_lib->vba.Read256BlockWidthC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2646  			mode_lib->vba.Read256BlockHeightY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2647  			mode_lib->vba.Read256BlockHeightC,
827e3c9caa77d3 Aric Cyr                  2022-08-24  2648  			mode_lib->vba.MacroTileWidthY,
827e3c9caa77d3 Aric Cyr                  2022-08-24  2649  			mode_lib->vba.MacroTileWidthC,
827e3c9caa77d3 Aric Cyr                  2022-08-24  2650  			mode_lib->vba.MacroTileHeightY,
827e3c9caa77d3 Aric Cyr                  2022-08-24  2651  			mode_lib->vba.MacroTileHeightC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2652  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2653  			/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2654  			mode_lib->vba.SurfaceSizeInMALL,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2655  			&mode_lib->vba.ExceededMALLSize);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2656  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2657  	for (i = 0; i < v->soc.num_states; i++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2658  		for (j = 0; j < 2; j++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2659  			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2660  				mode_lib->vba.swath_width_luma_ub_this_state[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2661  						mode_lib->vba.swath_width_luma_ub_all_states[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2662  				mode_lib->vba.swath_width_chroma_ub_this_state[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2663  						mode_lib->vba.swath_width_chroma_ub_all_states[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2664  				mode_lib->vba.SwathWidthYThisState[k] = mode_lib->vba.SwathWidthYAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2665  				mode_lib->vba.SwathWidthCThisState[k] = mode_lib->vba.SwathWidthCAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2666  				mode_lib->vba.SwathHeightYThisState[k] = mode_lib->vba.SwathHeightYAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2667  				mode_lib->vba.SwathHeightCThisState[k] = mode_lib->vba.SwathHeightCAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2668  				mode_lib->vba.DETBufferSizeInKByteThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2669  						mode_lib->vba.DETBufferSizeInKByteAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2670  				mode_lib->vba.DETBufferSizeYThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2671  						mode_lib->vba.DETBufferSizeYAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2672  				mode_lib->vba.DETBufferSizeCThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2673  						mode_lib->vba.DETBufferSizeCAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2674  				mode_lib->vba.RequiredDPPCLKThisState[k] = mode_lib->vba.RequiredDPPCLK[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2675  				mode_lib->vba.NoOfDPPThisState[k] = mode_lib->vba.NoOfDPP[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2676  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2677  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2678  			mode_lib->vba.TotalNumberOfDCCActiveDPP[i][j] = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2679  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2680  				if (mode_lib->vba.DCCEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2681  					mode_lib->vba.TotalNumberOfDCCActiveDPP[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2682  							mode_lib->vba.TotalNumberOfDCCActiveDPP[i][j]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2683  									+ mode_lib->vba.NoOfDPP[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2684  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2685  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2686  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2687  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2688  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2689  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].PixelClock = mode_lib->vba.PixelClock[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2690  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].DPPPerSurface = mode_lib->vba.NoOfDPP[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2691  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].SourceRotation = mode_lib->vba.SourceRotation[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2692  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportHeight = mode_lib->vba.ViewportHeight[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2693  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportHeightChroma = mode_lib->vba.ViewportHeightChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2694  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidth256BytesY = mode_lib->vba.Read256BlockWidthY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2695  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeight256BytesY = mode_lib->vba.Read256BlockHeightY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2696  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidth256BytesC = mode_lib->vba.Read256BlockWidthC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2697  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeight256BytesC = mode_lib->vba.Read256BlockHeightC[k];
827e3c9caa77d3 Aric Cyr                  2022-08-24  2698  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidthY = mode_lib->vba.MacroTileWidthY[k];
827e3c9caa77d3 Aric Cyr                  2022-08-24  2699  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeightY = mode_lib->vba.MacroTileHeightY[k];
827e3c9caa77d3 Aric Cyr                  2022-08-24  2700  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidthC = mode_lib->vba.MacroTileWidthC[k];
827e3c9caa77d3 Aric Cyr                  2022-08-24  2701  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeightC = mode_lib->vba.MacroTileHeightC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2702  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].InterlaceEnable = mode_lib->vba.Interlace[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2703  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].HTotal = mode_lib->vba.HTotal[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2704  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].DCCEnable = mode_lib->vba.DCCEnable[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2705  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2706  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].SurfaceTiling = mode_lib->vba.SurfaceTiling[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2707  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BytePerPixelY = mode_lib->vba.BytePerPixelY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2708  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BytePerPixelC = mode_lib->vba.BytePerPixelC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2709  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ProgressiveToInterlaceUnitInOPP =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2710  				mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2711  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].VRatio = mode_lib->vba.VRatio[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2712  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].VRatioChroma = mode_lib->vba.VRatioChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2713  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].VTaps = mode_lib->vba.vtaps[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2714  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].VTapsChroma = mode_lib->vba.VTAPsChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2715  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].PitchY = mode_lib->vba.PitchY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2716  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].DCCMetaPitchY = mode_lib->vba.DCCMetaPitchY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2717  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].PitchC = mode_lib->vba.PitchC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2718  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].DCCMetaPitchC = mode_lib->vba.DCCMetaPitchC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2719  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportStationary = mode_lib->vba.ViewportStationary[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2720  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportXStart = mode_lib->vba.ViewportXStartY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2721  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportYStart = mode_lib->vba.ViewportYStartY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2722  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportXStartC = mode_lib->vba.ViewportXStartC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2723  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportYStartC = mode_lib->vba.ViewportYStartC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2724  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].FORCE_ONE_ROW_FOR_FRAME = mode_lib->vba.ForceOneRowForFrame[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2725  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].SwathHeightY = mode_lib->vba.SwathHeightYThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2726  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].SwathHeightC = mode_lib->vba.SwathHeightCThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2727  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2728  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2729  			{
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2730  				dml32_CalculateVMRowAndSwath(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2731  						mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2732  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2733  						mode_lib->vba.SurfaceSizeInMALL,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2734  						mode_lib->vba.PTEBufferSizeInRequestsLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2735  						mode_lib->vba.PTEBufferSizeInRequestsChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2736  						mode_lib->vba.DCCMetaBufferSizeBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2737  						mode_lib->vba.UseMALLForStaticScreen,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2738  						mode_lib->vba.UsesMALLForPStateChange,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2739  						mode_lib->vba.MALLAllocatedForDCNFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2740  						mode_lib->vba.SwathWidthYThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2741  						mode_lib->vba.SwathWidthCThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2742  						mode_lib->vba.GPUVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2743  						mode_lib->vba.HostVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2744  						mode_lib->vba.HostVMMaxNonCachedPageTableLevels,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2745  						mode_lib->vba.GPUVMMaxPageTableLevels,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2746  						mode_lib->vba.GPUVMMinPageSizeKBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2747  						mode_lib->vba.HostVMMinPageSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2748  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2749  						/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2750  						mode_lib->vba.PTEBufferSizeNotExceededPerState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2751  						mode_lib->vba.DCCMetaBufferSizeNotExceededPerState,
01cf387b1c7f60 Alex Deucher              2022-06-22  2752  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0],
01cf387b1c7f60 Alex Deucher              2022-06-22  2753  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[1],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2754  						mode_lib->vba.dpte_row_height,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2755  						mode_lib->vba.dpte_row_height_chroma,
01cf387b1c7f60 Alex Deucher              2022-06-22  2756  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[2],
01cf387b1c7f60 Alex Deucher              2022-06-22  2757  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[3],
01cf387b1c7f60 Alex Deucher              2022-06-22  2758  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[4],
01cf387b1c7f60 Alex Deucher              2022-06-22  2759  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[5],
01cf387b1c7f60 Alex Deucher              2022-06-22  2760  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[6],
01cf387b1c7f60 Alex Deucher              2022-06-22  2761  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[7],
01cf387b1c7f60 Alex Deucher              2022-06-22  2762  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[8],
01cf387b1c7f60 Alex Deucher              2022-06-22  2763  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[9],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2764  						mode_lib->vba.meta_row_height,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2765  						mode_lib->vba.meta_row_height_chroma,
01cf387b1c7f60 Alex Deucher              2022-06-22  2766  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[10],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2767  						mode_lib->vba.dpte_group_bytes,
01cf387b1c7f60 Alex Deucher              2022-06-22  2768  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[11],
01cf387b1c7f60 Alex Deucher              2022-06-22  2769  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[12],
01cf387b1c7f60 Alex Deucher              2022-06-22  2770  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[13],
01cf387b1c7f60 Alex Deucher              2022-06-22  2771  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[14],
01cf387b1c7f60 Alex Deucher              2022-06-22  2772  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[15],
01cf387b1c7f60 Alex Deucher              2022-06-22  2773  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[16],
01cf387b1c7f60 Alex Deucher              2022-06-22  2774  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[17],
01cf387b1c7f60 Alex Deucher              2022-06-22  2775  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[18],
01cf387b1c7f60 Alex Deucher              2022-06-22  2776  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[19],
01cf387b1c7f60 Alex Deucher              2022-06-22  2777  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[20],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2778  						mode_lib->vba.PrefetchLinesYThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2779  						mode_lib->vba.PrefetchLinesCThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2780  						mode_lib->vba.PrefillY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2781  						mode_lib->vba.PrefillC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2782  						mode_lib->vba.MaxNumSwY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2783  						mode_lib->vba.MaxNumSwC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2784  						mode_lib->vba.meta_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2785  						mode_lib->vba.dpte_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2786  						mode_lib->vba.DPTEBytesPerRowThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2787  						mode_lib->vba.PDEAndMetaPTEBytesPerFrameThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2788  						mode_lib->vba.MetaRowBytesThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2789  						mode_lib->vba.use_one_row_for_frame_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2790  						mode_lib->vba.use_one_row_for_frame_flip_this_state,
01cf387b1c7f60 Alex Deucher              2022-06-22  2791  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0], // Boolean UsesMALLForStaticScreen[]
01cf387b1c7f60 Alex Deucher              2022-06-22  2792  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[1], // Boolean PTE_BUFFER_MODE[]
01cf387b1c7f60 Alex Deucher              2022-06-22  2793  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[21]); // Long BIGK_FRAGMENT_SIZE[]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2794  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2795  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2796  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2797  				mode_lib->vba.PrefetchLinesY[i][j][k] = mode_lib->vba.PrefetchLinesYThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2798  				mode_lib->vba.PrefetchLinesC[i][j][k] = mode_lib->vba.PrefetchLinesCThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2799  				mode_lib->vba.meta_row_bandwidth[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2800  						mode_lib->vba.meta_row_bandwidth_this_state[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2801  				mode_lib->vba.dpte_row_bandwidth[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2802  						mode_lib->vba.dpte_row_bandwidth_this_state[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2803  				mode_lib->vba.DPTEBytesPerRow[i][j][k] = mode_lib->vba.DPTEBytesPerRowThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2804  				mode_lib->vba.PDEAndMetaPTEBytesPerFrame[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2805  						mode_lib->vba.PDEAndMetaPTEBytesPerFrameThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2806  				mode_lib->vba.MetaRowBytes[i][j][k] = mode_lib->vba.MetaRowBytesThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2807  				mode_lib->vba.use_one_row_for_frame[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2808  						mode_lib->vba.use_one_row_for_frame_this_state[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2809  				mode_lib->vba.use_one_row_for_frame_flip[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2810  						mode_lib->vba.use_one_row_for_frame_flip_this_state[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2811  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2812  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2813  			mode_lib->vba.PTEBufferSizeNotExceeded[i][j] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2814  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2815  				if (mode_lib->vba.PTEBufferSizeNotExceededPerState[k] == false)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2816  					mode_lib->vba.PTEBufferSizeNotExceeded[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2817  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2818  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2819  			mode_lib->vba.DCCMetaBufferSizeNotExceeded[i][j] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2820  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2821  				if (mode_lib->vba.DCCMetaBufferSizeNotExceededPerState[k] == false)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2822  					mode_lib->vba.DCCMetaBufferSizeNotExceeded[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2823  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2824  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2825  			mode_lib->vba.UrgLatency[i] = dml32_CalculateUrgentLatency(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2826  					mode_lib->vba.UrgentLatencyPixelDataOnly,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2827  					mode_lib->vba.UrgentLatencyPixelMixedWithVMData,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2828  					mode_lib->vba.UrgentLatencyVMDataOnly, mode_lib->vba.DoUrgentLatencyAdjustment,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2829  					mode_lib->vba.UrgentLatencyAdjustmentFabricClockComponent,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2830  					mode_lib->vba.UrgentLatencyAdjustmentFabricClockReference,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2831  					mode_lib->vba.FabricClockPerState[i]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2832  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2833  			//bool   NotUrgentLatencyHiding[DC__NUM_DPP__MAX];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2834  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2835  				dml32_CalculateUrgentBurstFactor(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2836  						mode_lib->vba.UsesMALLForPStateChange[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2837  						mode_lib->vba.swath_width_luma_ub_this_state[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2838  						mode_lib->vba.swath_width_chroma_ub_this_state[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2839  						mode_lib->vba.SwathHeightYThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2840  						mode_lib->vba.SwathHeightCThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2841  						(double) mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2842  						mode_lib->vba.UrgLatency[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2843  						mode_lib->vba.CursorBufferSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2844  						mode_lib->vba.CursorWidth[k][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2845  						mode_lib->vba.CursorBPP[k][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2846  						mode_lib->vba.VRatio[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2847  						mode_lib->vba.VRatioChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2848  						mode_lib->vba.BytePerPixelInDETY[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2849  						mode_lib->vba.BytePerPixelInDETC[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2850  						mode_lib->vba.DETBufferSizeYThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2851  						mode_lib->vba.DETBufferSizeCThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2852  						/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2853  						&mode_lib->vba.UrgentBurstFactorCursor[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2854  						&mode_lib->vba.UrgentBurstFactorLuma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2855  						&mode_lib->vba.UrgentBurstFactorChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2856  						&mode_lib->vba.NoUrgentLatencyHiding[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2857  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2858  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2859  			dml32_CalculateDCFCLKDeepSleep(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2860  					mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2861  					mode_lib->vba.BytePerPixelY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2862  					mode_lib->vba.BytePerPixelC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2863  					mode_lib->vba.VRatio,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2864  					mode_lib->vba.VRatioChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2865  					mode_lib->vba.SwathWidthYThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2866  					mode_lib->vba.SwathWidthCThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2867  					mode_lib->vba.NoOfDPPThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2868  					mode_lib->vba.HRatio,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2869  					mode_lib->vba.HRatioChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2870  					mode_lib->vba.PixelClock,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2871  					mode_lib->vba.PSCL_FACTOR,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2872  					mode_lib->vba.PSCL_FACTOR_CHROMA,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2873  					mode_lib->vba.RequiredDPPCLKThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2874  					mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2875  					mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2876  					mode_lib->vba.ReturnBusWidth,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2877  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2878  					/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2879  					&mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2880  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2881  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2882  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2883  	//Calculate Return BW
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2884  	for (i = 0; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2885  		for (j = 0; j <= 1; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2886  			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2887  				if (mode_lib->vba.BlendingAndTiming[k] == k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2888  					if (mode_lib->vba.WritebackEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2889  						mode_lib->vba.WritebackDelayTime[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2890  							mode_lib->vba.WritebackLatency
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2891  						+ dml32_CalculateWriteBackDelay(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2892  							mode_lib->vba.WritebackPixelFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2893  							mode_lib->vba.WritebackHRatio[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2894  							mode_lib->vba.WritebackVRatio[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2895  							mode_lib->vba.WritebackVTaps[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2896  							mode_lib->vba.WritebackDestinationWidth[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2897  							mode_lib->vba.WritebackDestinationHeight[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2898  							mode_lib->vba.WritebackSourceHeight[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2899  							mode_lib->vba.HTotal[k])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2900  							/ mode_lib->vba.RequiredDISPCLK[i][j];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2901  					} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2902  						mode_lib->vba.WritebackDelayTime[k] = 0.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2903  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2904  					for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces - 1; m++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2905  						if (mode_lib->vba.BlendingAndTiming[m]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2906  								== k && mode_lib->vba.WritebackEnable[m] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2907  							mode_lib->vba.WritebackDelayTime[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2908  								dml_max(mode_lib->vba.WritebackDelayTime[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2909  									mode_lib->vba.WritebackLatency
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2910  								+ dml32_CalculateWriteBackDelay(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2911  									mode_lib->vba.WritebackPixelFormat[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2912  									mode_lib->vba.WritebackHRatio[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2913  									mode_lib->vba.WritebackVRatio[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2914  									mode_lib->vba.WritebackVTaps[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2915  									mode_lib->vba.WritebackDestinationWidth[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2916  									mode_lib->vba.WritebackDestinationHeight[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2917  									mode_lib->vba.WritebackSourceHeight[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2918  									mode_lib->vba.HTotal[m]) /
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2919  									mode_lib->vba.RequiredDISPCLK[i][j]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2920  						}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2921  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2922  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2923  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2924  			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2925  				for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces - 1; m++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2926  					if (mode_lib->vba.BlendingAndTiming[k] == m) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2927  						mode_lib->vba.WritebackDelayTime[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2928  								mode_lib->vba.WritebackDelayTime[m];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2929  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2930  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2931  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2932  			mode_lib->vba.MaxMaxVStartup[i][j] = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2933  			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2934  				mode_lib->vba.MaximumVStartup[i][j][k] = ((mode_lib->vba.Interlace[k] &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2935  								!mode_lib->vba.ProgressiveToInterlaceUnitInOPP) ?
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2936  								dml_floor((mode_lib->vba.VTotal[k] -
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2937  									mode_lib->vba.VActive[k]) / 2.0, 1.0) :
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2938  								mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2939  								- dml_max(1.0, dml_ceil(1.0 *
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2940  									mode_lib->vba.WritebackDelayTime[k] /
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2941  									(mode_lib->vba.HTotal[k] /
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2942  									mode_lib->vba.PixelClock[k]), 1.0));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2943  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2944  				// Clamp to max OTG vstartup register limit
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2945  				if (mode_lib->vba.MaximumVStartup[i][j][k] > 1023)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2946  					mode_lib->vba.MaximumVStartup[i][j][k] = 1023;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2947  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2948  				mode_lib->vba.MaxMaxVStartup[i][j] = dml_max(mode_lib->vba.MaxMaxVStartup[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2949  						mode_lib->vba.MaximumVStartup[i][j][k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2950  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2951  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2952  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2953  
7acc487ab57e07 Alex Deucher              2022-07-20  2954  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ReorderingBytes = mode_lib->vba.NumberOfChannels
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2955  			* dml_max3(mode_lib->vba.UrgentOutOfOrderReturnPerChannelPixelDataOnly,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2956  					mode_lib->vba.UrgentOutOfOrderReturnPerChannelPixelMixedWithVMData,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2957  					mode_lib->vba.UrgentOutOfOrderReturnPerChannelVMDataOnly);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2958  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2959  	dml32_CalculateMinAndMaxPrefetchMode(mode_lib->vba.AllowForPStateChangeOrStutterInVBlankFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2960  			&mode_lib->vba.MinPrefetchMode,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2961  			&mode_lib->vba.MaxPrefetchMode);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2962  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2963  	for (i = 0; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2964  		for (j = 0; j <= 1; ++j)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2965  			mode_lib->vba.DCFCLKState[i][j] = mode_lib->vba.DCFCLKPerState[i];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2966  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2967  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2968  	/* Immediate Flip and MALL parameters */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2969  	mode_lib->vba.ImmediateFlipRequiredFinal = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2970  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2971  		mode_lib->vba.ImmediateFlipRequiredFinal = mode_lib->vba.ImmediateFlipRequiredFinal
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2972  				|| (mode_lib->vba.ImmediateFlipRequirement[k] == dm_immediate_flip_required);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2973  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2974  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2975  	mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2976  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2977  		mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2978  				mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2979  						|| ((mode_lib->vba.ImmediateFlipRequirement[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2980  								!= dm_immediate_flip_required)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2981  								&& (mode_lib->vba.ImmediateFlipRequirement[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2982  										!= dm_immediate_flip_not_required));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2983  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2984  	mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2985  			mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2986  					&& mode_lib->vba.ImmediateFlipRequiredFinal;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2987  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2988  	mode_lib->vba.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2989  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2990  		mode_lib->vba.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2991  			mode_lib->vba.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe ||
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2992  			((mode_lib->vba.HostVMEnable == true || mode_lib->vba.ImmediateFlipRequirement[k] !=
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2993  					dm_immediate_flip_not_required) &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2994  			(mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_full_frame ||
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2995  			mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_phantom_pipe));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2996  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2997  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2998  	mode_lib->vba.InvalidCombinationOfMALLUseForPStateAndStaticScreen = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2999  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3000  		mode_lib->vba.InvalidCombinationOfMALLUseForPStateAndStaticScreen =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3001  			mode_lib->vba.InvalidCombinationOfMALLUseForPStateAndStaticScreen
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3002  			|| ((mode_lib->vba.UseMALLForStaticScreen[k] == dm_use_mall_static_screen_enable
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3003  			|| mode_lib->vba.UseMALLForStaticScreen[k] == dm_use_mall_static_screen_optimize)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3004  			&& (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_phantom_pipe))
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3005  			|| ((mode_lib->vba.UseMALLForStaticScreen[k] == dm_use_mall_static_screen_disable
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3006  			|| mode_lib->vba.UseMALLForStaticScreen[k] == dm_use_mall_static_screen_optimize)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3007  			&& (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_full_frame));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3008  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3009  
7acc487ab57e07 Alex Deucher              2022-07-20  3010  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.FullFrameMALLPStateMethod = false;
7acc487ab57e07 Alex Deucher              2022-07-20  3011  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SubViewportMALLPStateMethod = false;
7acc487ab57e07 Alex Deucher              2022-07-20  3012  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.PhantomPipeMALLPStateMethod = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3013  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3014  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3015  		if (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_full_frame)
7acc487ab57e07 Alex Deucher              2022-07-20  3016  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.FullFrameMALLPStateMethod = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3017  		if (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_sub_viewport)
7acc487ab57e07 Alex Deucher              2022-07-20  3018  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SubViewportMALLPStateMethod = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3019  		if (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_phantom_pipe)
7acc487ab57e07 Alex Deucher              2022-07-20  3020  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.PhantomPipeMALLPStateMethod = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3021  	}
7acc487ab57e07 Alex Deucher              2022-07-20  3022  	mode_lib->vba.InvalidCombinationOfMALLUseForPState = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SubViewportMALLPStateMethod
7acc487ab57e07 Alex Deucher              2022-07-20  3023  			!= v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.PhantomPipeMALLPStateMethod) || (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SubViewportMALLPStateMethod && v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.FullFrameMALLPStateMethod);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3024  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3025  	if (mode_lib->vba.UseMinimumRequiredDCFCLK == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3026  		dml32_UseMinimumDCFCLK(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3027  				mode_lib->vba.UsesMALLForPStateChange,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3028  				mode_lib->vba.DRRDisplay,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3029  				mode_lib->vba.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3030  				mode_lib->vba.MaxInterDCNTileRepeaters,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3031  				mode_lib->vba.MaxPrefetchMode,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3032  				mode_lib->vba.DRAMClockChangeLatency,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3033  				mode_lib->vba.FCLKChangeLatency,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3034  				mode_lib->vba.SREnterPlusExitTime,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3035  				mode_lib->vba.ReturnBusWidth,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3036  				mode_lib->vba.RoundTripPingLatencyCycles,
7acc487ab57e07 Alex Deucher              2022-07-20  3037  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ReorderingBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3038  				mode_lib->vba.PixelChunkSizeInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3039  				mode_lib->vba.MetaChunkSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3040  				mode_lib->vba.GPUVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3041  				mode_lib->vba.GPUVMMaxPageTableLevels,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3042  				mode_lib->vba.HostVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3043  				mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3044  				mode_lib->vba.HostVMMinPageSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3045  				mode_lib->vba.HostVMMaxNonCachedPageTableLevels,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3046  				mode_lib->vba.DynamicMetadataVMEnabled,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3047  				mode_lib->vba.ImmediateFlipRequiredFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3048  				mode_lib->vba.ProgressiveToInterlaceUnitInOPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3049  				mode_lib->vba.MaxAveragePercentOfIdealSDPPortBWDisplayCanUseInNormalSystemOperation,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3050  				mode_lib->vba.PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3051  				mode_lib->vba.VTotal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3052  				mode_lib->vba.VActive,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3053  				mode_lib->vba.DynamicMetadataTransmittedBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3054  				mode_lib->vba.DynamicMetadataLinesBeforeActiveRequired,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3055  				mode_lib->vba.Interlace,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3056  				mode_lib->vba.RequiredDPPCLK,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3057  				mode_lib->vba.RequiredDISPCLK,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3058  				mode_lib->vba.UrgLatency,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3059  				mode_lib->vba.NoOfDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3060  				mode_lib->vba.ProjectedDCFCLKDeepSleep,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3061  				mode_lib->vba.MaximumVStartup,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3062  				mode_lib->vba.TotalNumberOfActiveDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3063  				mode_lib->vba.TotalNumberOfDCCActiveDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3064  				mode_lib->vba.dpte_group_bytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3065  				mode_lib->vba.PrefetchLinesY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3066  				mode_lib->vba.PrefetchLinesC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3067  				mode_lib->vba.swath_width_luma_ub_all_states,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3068  				mode_lib->vba.swath_width_chroma_ub_all_states,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3069  				mode_lib->vba.BytePerPixelY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3070  				mode_lib->vba.BytePerPixelC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3071  				mode_lib->vba.HTotal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3072  				mode_lib->vba.PixelClock,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3073  				mode_lib->vba.PDEAndMetaPTEBytesPerFrame,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3074  				mode_lib->vba.DPTEBytesPerRow,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3075  				mode_lib->vba.MetaRowBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3076  				mode_lib->vba.DynamicMetadataEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3077  				mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3078  				mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3079  				mode_lib->vba.DCFCLKPerState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3080  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3081  				/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3082  				mode_lib->vba.DCFCLKState);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3083  	} // UseMinimumRequiredDCFCLK == true
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3084  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3085  	for (i = 0; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3086  		for (j = 0; j <= 1; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3087  			mode_lib->vba.ReturnBWPerState[i][j] = dml32_get_return_bw_mbps(&mode_lib->vba.soc, i,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3088  					mode_lib->vba.HostVMEnable, mode_lib->vba.DCFCLKState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3089  					mode_lib->vba.FabricClockPerState[i], mode_lib->vba.DRAMSpeedPerState[i]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3090  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3091  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3092  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3093  	//Re-ordering Buffer Support Check
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3094  	for (i = 0; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3095  		for (j = 0; j <= 1; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3096  			if ((mode_lib->vba.ROBBufferSizeInKByte - mode_lib->vba.PixelChunkSizeInKByte) * 1024
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3097  					/ mode_lib->vba.ReturnBWPerState[i][j]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3098  					> (mode_lib->vba.RoundTripPingLatencyCycles + 32)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3099  							/ mode_lib->vba.DCFCLKState[i][j]
7acc487ab57e07 Alex Deucher              2022-07-20  3100  							+ v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ReorderingBytes / mode_lib->vba.ReturnBWPerState[i][j]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3101  				mode_lib->vba.ROBSupport[i][j] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3102  			} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3103  				mode_lib->vba.ROBSupport[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3104  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3105  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3106  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3107  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3108  	//Vertical Active BW support check
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3109  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaxTotalVActiveRDBandwidth = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3110  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3111  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3112  		v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaxTotalVActiveRDBandwidth += mode_lib->vba.ReadBandwidthLuma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3113  				+ mode_lib->vba.ReadBandwidthChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3114  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3115  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3116  	for (i = 0; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3117  		for (j = 0; j <= 1; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3118  			mode_lib->vba.MaxTotalVerticalActiveAvailableBandwidth[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3119  				dml_min3(mode_lib->vba.ReturnBusWidth * mode_lib->vba.DCFCLKState[i][j]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3120  					* mode_lib->vba.MaxAveragePercentOfIdealSDPPortBWDisplayCanUseInNormalSystemOperation / 100,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3121  					mode_lib->vba.FabricClockPerState[i]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3122  					* mode_lib->vba.FabricDatapathToDCNDataReturn
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3123  					* mode_lib->vba.MaxAveragePercentOfIdealFabricBWDisplayCanUseInNormalSystemOperation / 100,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3124  					mode_lib->vba.DRAMSpeedPerState[i]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3125  					* mode_lib->vba.NumberOfChannels
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3126  					* mode_lib->vba.DRAMChannelWidth
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3127  					* (i < 2 ? mode_lib->vba.MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperationSTROBE : mode_lib->vba.MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperation) / 100);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3128  
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3129  			if (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaxTotalVActiveRDBandwidth
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3130  					<= mode_lib->vba.MaxTotalVerticalActiveAvailableBandwidth[i][j]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3131  				mode_lib->vba.TotalVerticalActiveBandwidthSupport[i][j] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3132  			} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3133  				mode_lib->vba.TotalVerticalActiveBandwidthSupport[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3134  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3135  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3136  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3137  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3138  	/* Prefetch Check */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3139  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3140  	for (i = 0; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3141  		for (j = 0; j <= 1; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3142  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3143  			mode_lib->vba.TimeCalc = 24 / mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3144  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3145  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3146  				mode_lib->vba.NoOfDPPThisState[k] = mode_lib->vba.NoOfDPP[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3147  				mode_lib->vba.swath_width_luma_ub_this_state[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3148  						mode_lib->vba.swath_width_luma_ub_all_states[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3149  				mode_lib->vba.swath_width_chroma_ub_this_state[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3150  						mode_lib->vba.swath_width_chroma_ub_all_states[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3151  				mode_lib->vba.SwathWidthYThisState[k] = mode_lib->vba.SwathWidthYAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3152  				mode_lib->vba.SwathWidthCThisState[k] = mode_lib->vba.SwathWidthCAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3153  				mode_lib->vba.SwathHeightYThisState[k] = mode_lib->vba.SwathHeightYAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3154  				mode_lib->vba.SwathHeightCThisState[k] = mode_lib->vba.SwathHeightCAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3155  				mode_lib->vba.UnboundedRequestEnabledThisState =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3156  						mode_lib->vba.UnboundedRequestEnabledAllStates[i][j];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3157  				mode_lib->vba.CompressedBufferSizeInkByteThisState =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3158  						mode_lib->vba.CompressedBufferSizeInkByteAllStates[i][j];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3159  				mode_lib->vba.DETBufferSizeInKByteThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3160  						mode_lib->vba.DETBufferSizeInKByteAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3161  				mode_lib->vba.DETBufferSizeYThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3162  						mode_lib->vba.DETBufferSizeYAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3163  				mode_lib->vba.DETBufferSizeCThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3164  						mode_lib->vba.DETBufferSizeCAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3165  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3166  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3167  			mode_lib->vba.VActiveBandwithSupport[i][j] = dml32_CalculateVActiveBandwithSupport(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3168  					mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3169  					mode_lib->vba.ReturnBWPerState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3170  					mode_lib->vba.NoUrgentLatencyHiding,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3171  					mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3172  					mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3173  					mode_lib->vba.cursor_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3174  					mode_lib->vba.meta_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3175  					mode_lib->vba.dpte_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3176  					mode_lib->vba.NoOfDPPThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3177  					mode_lib->vba.UrgentBurstFactorLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3178  					mode_lib->vba.UrgentBurstFactorChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3179  					mode_lib->vba.UrgentBurstFactorCursor);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3180  
6d4727c80947de Dillon Varone             2022-11-08  3181  			mode_lib->vba.NotEnoughDETSwathFillLatencyHidingPerState[i][j] = dml32_CalculateDETSwathFillLatencyHiding(
6d4727c80947de Dillon Varone             2022-11-08  3182  					mode_lib->vba.NumberOfActiveSurfaces,
6d4727c80947de Dillon Varone             2022-11-08  3183  					mode_lib->vba.ReturnBWPerState[i][j],
6d4727c80947de Dillon Varone             2022-11-08  3184  					mode_lib->vba.UrgLatency[i],
6d4727c80947de Dillon Varone             2022-11-08  3185  					mode_lib->vba.SwathHeightYThisState,
6d4727c80947de Dillon Varone             2022-11-08  3186  					mode_lib->vba.SwathHeightCThisState,
6d4727c80947de Dillon Varone             2022-11-08  3187  					mode_lib->vba.swath_width_luma_ub_this_state,
6d4727c80947de Dillon Varone             2022-11-08  3188  					mode_lib->vba.swath_width_chroma_ub_this_state,
6d4727c80947de Dillon Varone             2022-11-08  3189  					mode_lib->vba.BytePerPixelInDETY,
6d4727c80947de Dillon Varone             2022-11-08  3190  					mode_lib->vba.BytePerPixelInDETC,
6d4727c80947de Dillon Varone             2022-11-08  3191  					mode_lib->vba.DETBufferSizeYThisState,
6d4727c80947de Dillon Varone             2022-11-08  3192  					mode_lib->vba.DETBufferSizeCThisState,
6d4727c80947de Dillon Varone             2022-11-08  3193  					mode_lib->vba.NoOfDPPThisState,
6d4727c80947de Dillon Varone             2022-11-08  3194  					mode_lib->vba.HTotal,
6d4727c80947de Dillon Varone             2022-11-08  3195  					mode_lib->vba.PixelClock,
6d4727c80947de Dillon Varone             2022-11-08  3196  					mode_lib->vba.VRatio,
6d4727c80947de Dillon Varone             2022-11-08  3197  					mode_lib->vba.VRatioChroma,
6d4727c80947de Dillon Varone             2022-11-08  3198  					mode_lib->vba.UsesMALLForPStateChange);
6d4727c80947de Dillon Varone             2022-11-08  3199  
7acc487ab57e07 Alex Deucher              2022-07-20  3200  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.VMDataOnlyReturnBWPerState = dml32_get_return_bw_mbps_vm_only(&mode_lib->vba.soc, i,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3201  					mode_lib->vba.DCFCLKState[i][j], mode_lib->vba.FabricClockPerState[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3202  					mode_lib->vba.DRAMSpeedPerState[i]);
7acc487ab57e07 Alex Deucher              2022-07-20  3203  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3204  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3205  			if (mode_lib->vba.GPUVMEnable && mode_lib->vba.HostVMEnable)
7acc487ab57e07 Alex Deucher              2022-07-20  3206  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor = mode_lib->vba.ReturnBWPerState[i][j]
7acc487ab57e07 Alex Deucher              2022-07-20  3207  						/ v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.VMDataOnlyReturnBWPerState;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3208  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3209  			mode_lib->vba.ExtraLatency = dml32_CalculateExtraLatency(
7acc487ab57e07 Alex Deucher              2022-07-20  3210  					mode_lib->vba.RoundTripPingLatencyCycles, v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ReorderingBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3211  					mode_lib->vba.DCFCLKState[i][j], mode_lib->vba.TotalNumberOfActiveDPP[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3212  					mode_lib->vba.PixelChunkSizeInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3213  					mode_lib->vba.TotalNumberOfDCCActiveDPP[i][j], mode_lib->vba.MetaChunkSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3214  					mode_lib->vba.ReturnBWPerState[i][j], mode_lib->vba.GPUVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3215  					mode_lib->vba.HostVMEnable, mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3216  					mode_lib->vba.NoOfDPPThisState, mode_lib->vba.dpte_group_bytes,
7acc487ab57e07 Alex Deucher              2022-07-20  3217  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor, mode_lib->vba.HostVMMinPageSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3218  					mode_lib->vba.HostVMMaxNonCachedPageTableLevels);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3219  
7acc487ab57e07 Alex Deucher              2022-07-20  3220  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState = mode_lib->vba.MinPrefetchMode;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3221  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3222  			mode_lib->vba.NextMaxVStartup = mode_lib->vba.MaxMaxVStartup[i][j];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3223  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3224  			do {
7acc487ab57e07 Alex Deucher              2022-07-20  3225  				mode_lib->vba.PrefetchModePerState[i][j] = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3226  				mode_lib->vba.MaxVStartup = mode_lib->vba.NextMaxVStartup;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3227  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3228  				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3229  					mode_lib->vba.TWait = dml32_CalculateTWait(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3230  							mode_lib->vba.PrefetchModePerState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3231  							mode_lib->vba.UsesMALLForPStateChange[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3232  							mode_lib->vba.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3233  							mode_lib->vba.DRRDisplay[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3234  							mode_lib->vba.DRAMClockChangeLatency,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3235  							mode_lib->vba.FCLKChangeLatency, mode_lib->vba.UrgLatency[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3236  							mode_lib->vba.SREnterPlusExitTime);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3237  
a1b6667ef90b38 Aurabindo Pillai          2022-10-20  3238  					memset(&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull, 0, sizeof(DmlPipe));
7acc487ab57e07 Alex Deucher              2022-07-20  3239  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.Dppclk = mode_lib->vba.RequiredDPPCLK[i][j][k];
7acc487ab57e07 Alex Deucher              2022-07-20  3240  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.Dispclk = mode_lib->vba.RequiredDISPCLK[i][j];
7acc487ab57e07 Alex Deucher              2022-07-20  3241  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.PixelClock = mode_lib->vba.PixelClock[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3242  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DCFClkDeepSleep = mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
7acc487ab57e07 Alex Deucher              2022-07-20  3243  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DPPPerSurface = mode_lib->vba.NoOfDPP[i][j][k];
7acc487ab57e07 Alex Deucher              2022-07-20  3244  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3245  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3246  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockWidth256BytesY = mode_lib->vba.Read256BlockWidthY[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3247  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockHeight256BytesY = mode_lib->vba.Read256BlockHeightY[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3248  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockWidth256BytesC = mode_lib->vba.Read256BlockWidthC[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3249  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockHeight256BytesC = mode_lib->vba.Read256BlockHeightC[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3250  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3251  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3252  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3253  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.HTotal = mode_lib->vba.HTotal[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3254  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.HActive = mode_lib->vba.HActive[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3255  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3256  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ODMMode = mode_lib->vba.ODMCombineEnablePerState[i][k];
7acc487ab57e07 Alex Deucher              2022-07-20  3257  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3258  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BytePerPixelY = mode_lib->vba.BytePerPixelY[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3259  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BytePerPixelC = mode_lib->vba.BytePerPixelC[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3260  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ProgressiveToInterlaceUnitInOPP =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3261  							mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3262  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3263  					mode_lib->vba.NoTimeForPrefetch[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3264  						dml32_CalculatePrefetchSchedule(
3b4e83a232244e Nathan Chancellor         2022-08-30  3265  							v,
3b4e83a232244e Nathan Chancellor         2022-08-30  3266  							k,
7acc487ab57e07 Alex Deucher              2022-07-20  3267  							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor,
7acc487ab57e07 Alex Deucher              2022-07-20  3268  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe,
3b4e83a232244e Nathan Chancellor         2022-08-30  3269  							v->DSCDelayPerState[i][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3270  							v->SwathWidthYThisState[k] / v->HRatio[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3271  							dml_min(v->MaxVStartup, v->MaximumVStartup[i][j][k]),
3b4e83a232244e Nathan Chancellor         2022-08-30  3272  							v->MaximumVStartup[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3273  							v->UrgLatency[i],
3b4e83a232244e Nathan Chancellor         2022-08-30  3274  							v->ExtraLatency,
3b4e83a232244e Nathan Chancellor         2022-08-30  3275  							v->TimeCalc,
3b4e83a232244e Nathan Chancellor         2022-08-30  3276  							v->PDEAndMetaPTEBytesPerFrame[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3277  							v->MetaRowBytes[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3278  							v->DPTEBytesPerRow[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3279  							v->PrefetchLinesY[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3280  							v->SwathWidthYThisState[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3281  							v->PrefillY[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3282  							v->MaxNumSwY[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3283  							v->PrefetchLinesC[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3284  							v->SwathWidthCThisState[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3285  							v->PrefillC[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3286  							v->MaxNumSwC[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3287  							v->swath_width_luma_ub_this_state[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3288  							v->swath_width_chroma_ub_this_state[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3289  							v->SwathHeightYThisState[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3290  							v->SwathHeightCThisState[k], v->TWait,
01c0c124b9ecaa Dillon Varone             2022-10-27  3291  							v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ ?
01c0c124b9ecaa Dillon Varone             2022-10-27  3292  									mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3293  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3294  							/* Output */
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3295  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTXAfterScaler[k],
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3296  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTYAfterScaler[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3297  							&v->LineTimesForPrefetch[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3298  							&v->PrefetchBW[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3299  							&v->LinesForMetaPTE[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3300  							&v->LinesForMetaAndDPTERow[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3301  							&v->VRatioPreY[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3302  							&v->VRatioPreC[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3303  							&v->RequiredPrefetchPixelDataBWLuma[0][0][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3304  							&v->RequiredPrefetchPixelDataBWChroma[0][0][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3305  							&v->NoTimeForDynamicMetadata[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3306  							&v->Tno_bw[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3307  							&v->prefetch_vmrow_bw[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3308  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0],         // double *Tdmdl_vm
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3309  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1],         // double *Tdmdl
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3310  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[2],         // double *TSetup
7acc487ab57e07 Alex Deucher              2022-07-20  3311  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer[0],         							    // unsigned int   *VUpdateOffsetPix
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3312  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[3],         // unsigned int   *VUpdateWidthPix
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3313  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[4]);        // unsigned int   *VReadyOffsetPix
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3314  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3315  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3316  				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3317  					dml32_CalculateUrgentBurstFactor(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3318  							mode_lib->vba.UsesMALLForPStateChange[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3319  							mode_lib->vba.swath_width_luma_ub_this_state[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3320  							mode_lib->vba.swath_width_chroma_ub_this_state[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3321  							mode_lib->vba.SwathHeightYThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3322  							mode_lib->vba.SwathHeightCThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3323  							mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3324  							mode_lib->vba.UrgLatency[i], mode_lib->vba.CursorBufferSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3325  							mode_lib->vba.CursorWidth[k][0], mode_lib->vba.CursorBPP[k][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3326  							mode_lib->vba.VRatioPreY[i][j][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3327  							mode_lib->vba.VRatioPreC[i][j][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3328  							mode_lib->vba.BytePerPixelInDETY[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3329  							mode_lib->vba.BytePerPixelInDETC[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3330  							mode_lib->vba.DETBufferSizeYThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3331  							mode_lib->vba.DETBufferSizeCThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3332  							/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3333  							&mode_lib->vba.UrgentBurstFactorCursorPre[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3334  							&mode_lib->vba.UrgentBurstFactorLumaPre[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3335  							&mode_lib->vba.UrgentBurstFactorChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3336  							&mode_lib->vba.NotUrgentLatencyHidingPre[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3337  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3338  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3339  				{
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3340  					dml32_CalculatePrefetchBandwithSupport(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3341  							mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3342  							mode_lib->vba.ReturnBWPerState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3343  							mode_lib->vba.NotUrgentLatencyHidingPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3344  							mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3345  							mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3346  							mode_lib->vba.RequiredPrefetchPixelDataBWLuma[0][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3347  							mode_lib->vba.RequiredPrefetchPixelDataBWChroma[0][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3348  							mode_lib->vba.cursor_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3349  							mode_lib->vba.meta_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3350  							mode_lib->vba.dpte_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3351  							mode_lib->vba.cursor_bw_pre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3352  							mode_lib->vba.prefetch_vmrow_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3353  							mode_lib->vba.NoOfDPPThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3354  							mode_lib->vba.UrgentBurstFactorLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3355  							mode_lib->vba.UrgentBurstFactorChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3356  							mode_lib->vba.UrgentBurstFactorCursor,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3357  							mode_lib->vba.UrgentBurstFactorLumaPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3358  							mode_lib->vba.UrgentBurstFactorChromaPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3359  							mode_lib->vba.UrgentBurstFactorCursorPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3360  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3361  							/* output */
01cf387b1c7f60 Alex Deucher              2022-06-22  3362  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0],   // Single  *PrefetchBandwidth
01cf387b1c7f60 Alex Deucher              2022-06-22  3363  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1],   // Single  *FractionOfUrgentBandwidth
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3364  							&mode_lib->vba.PrefetchSupported[i][j]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3365  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3366  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3367  				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3368  					if (mode_lib->vba.LineTimesForPrefetch[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3369  							< 2.0 || mode_lib->vba.LinesForMetaPTE[k] >= 32.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3370  							|| mode_lib->vba.LinesForMetaAndDPTERow[k] >= 16.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3371  							|| mode_lib->vba.NoTimeForPrefetch[i][j][k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3372  						mode_lib->vba.PrefetchSupported[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3373  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3374  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3375  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3376  				mode_lib->vba.DynamicMetadataSupported[i][j] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3377  				for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3378  					if (mode_lib->vba.NoTimeForDynamicMetadata[i][j][k] == true)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3379  						mode_lib->vba.DynamicMetadataSupported[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3380  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3381  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3382  				mode_lib->vba.VRatioInPrefetchSupported[i][j] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3383  				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3384  					if (mode_lib->vba.VRatioPreY[i][j][k] > __DML_MAX_VRATIO_PRE__
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3385  							|| mode_lib->vba.VRatioPreC[i][j][k] > __DML_MAX_VRATIO_PRE__
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3386  							|| mode_lib->vba.NoTimeForPrefetch[i][j][k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3387  						mode_lib->vba.VRatioInPrefetchSupported[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3388  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3389  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3390  				mode_lib->vba.AnyLinesForVMOrRowTooLarge = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3391  				for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3392  					if (mode_lib->vba.LinesForMetaAndDPTERow[k] >= 16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3393  							|| mode_lib->vba.LinesForMetaPTE[k] >= 32) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3394  						mode_lib->vba.AnyLinesForVMOrRowTooLarge = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3395  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3396  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3397  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3398  				if (mode_lib->vba.PrefetchSupported[i][j] == true
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3399  						&& mode_lib->vba.VRatioInPrefetchSupported[i][j] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3400  					mode_lib->vba.BandwidthAvailableForImmediateFlip =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3401  							dml32_CalculateBandwidthAvailableForImmediateFlip(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3402  							mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3403  							mode_lib->vba.ReturnBWPerState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3404  							mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3405  							mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3406  							mode_lib->vba.RequiredPrefetchPixelDataBWLuma[0][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3407  							mode_lib->vba.RequiredPrefetchPixelDataBWChroma[0][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3408  							mode_lib->vba.cursor_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3409  							mode_lib->vba.cursor_bw_pre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3410  							mode_lib->vba.NoOfDPPThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3411  							mode_lib->vba.UrgentBurstFactorLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3412  							mode_lib->vba.UrgentBurstFactorChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3413  							mode_lib->vba.UrgentBurstFactorCursor,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3414  							mode_lib->vba.UrgentBurstFactorLumaPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3415  							mode_lib->vba.UrgentBurstFactorChromaPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3416  							mode_lib->vba.UrgentBurstFactorCursorPre);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3417  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3418  					mode_lib->vba.TotImmediateFlipBytes = 0.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3419  					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3420  						if (!(mode_lib->vba.ImmediateFlipRequirement[k] ==
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3421  								dm_immediate_flip_not_required)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3422  							mode_lib->vba.TotImmediateFlipBytes =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3423  									mode_lib->vba.TotImmediateFlipBytes
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3424  								+ mode_lib->vba.NoOfDPP[i][j][k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3425  								* mode_lib->vba.PDEAndMetaPTEBytesPerFrame[i][j][k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3426  								+ mode_lib->vba.MetaRowBytes[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3427  							if (mode_lib->vba.use_one_row_for_frame_flip[i][j][k]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3428  								mode_lib->vba.TotImmediateFlipBytes =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3429  									mode_lib->vba.TotImmediateFlipBytes + 2
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3430  								* mode_lib->vba.DPTEBytesPerRow[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3431  							} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3432  								mode_lib->vba.TotImmediateFlipBytes =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3433  									mode_lib->vba.TotImmediateFlipBytes
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3434  								+ mode_lib->vba.DPTEBytesPerRow[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3435  							}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3436  						}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3437  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3438  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3439  					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
7acc487ab57e07 Alex Deucher              2022-07-20  3440  						dml32_CalculateFlipSchedule(v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3441  							mode_lib->vba.ExtraLatency,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3442  							mode_lib->vba.UrgLatency[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3443  							mode_lib->vba.GPUVMMaxPageTableLevels,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3444  							mode_lib->vba.HostVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3445  							mode_lib->vba.HostVMMaxNonCachedPageTableLevels,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3446  							mode_lib->vba.GPUVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3447  							mode_lib->vba.HostVMMinPageSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3448  							mode_lib->vba.PDEAndMetaPTEBytesPerFrame[i][j][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3449  							mode_lib->vba.MetaRowBytes[i][j][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3450  							mode_lib->vba.DPTEBytesPerRow[i][j][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3451  							mode_lib->vba.BandwidthAvailableForImmediateFlip,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3452  							mode_lib->vba.TotImmediateFlipBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3453  							mode_lib->vba.SourcePixelFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3454  							(mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]),
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3455  							mode_lib->vba.VRatio[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3456  							mode_lib->vba.VRatioChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3457  							mode_lib->vba.Tno_bw[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3458  								mode_lib->vba.DCCEnable[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3459  							mode_lib->vba.dpte_row_height[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3460  							mode_lib->vba.meta_row_height[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3461  							mode_lib->vba.dpte_row_height_chroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3462  							mode_lib->vba.meta_row_height_chroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3463  							mode_lib->vba.use_one_row_for_frame_flip[i][j][k], // 24
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3464  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3465  							/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3466  							&mode_lib->vba.DestinationLinesToRequestVMInImmediateFlip[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3467  							&mode_lib->vba.DestinationLinesToRequestRowInImmediateFlip[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3468  							&mode_lib->vba.final_flip_bw[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3469  							&mode_lib->vba.ImmediateFlipSupportedForPipe[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3470  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3471  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3472  					{
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3473  						dml32_CalculateImmediateFlipBandwithSupport(mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3474  								mode_lib->vba.ReturnBWPerState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3475  								mode_lib->vba.ImmediateFlipRequirement,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3476  								mode_lib->vba.final_flip_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3477  								mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3478  								mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3479  								mode_lib->vba.RequiredPrefetchPixelDataBWLuma[0][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3480  								mode_lib->vba.RequiredPrefetchPixelDataBWChroma[0][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3481  								mode_lib->vba.cursor_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3482  								mode_lib->vba.meta_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3483  								mode_lib->vba.dpte_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3484  								mode_lib->vba.cursor_bw_pre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3485  								mode_lib->vba.prefetch_vmrow_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3486  								mode_lib->vba.DPPPerPlane,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3487  								mode_lib->vba.UrgentBurstFactorLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3488  								mode_lib->vba.UrgentBurstFactorChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3489  								mode_lib->vba.UrgentBurstFactorCursor,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3490  								mode_lib->vba.UrgentBurstFactorLumaPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3491  								mode_lib->vba.UrgentBurstFactorChromaPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3492  								mode_lib->vba.UrgentBurstFactorCursorPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3493  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3494  								/* output */
01cf387b1c7f60 Alex Deucher              2022-06-22  3495  								&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0], //  Single  *TotalBandwidth
01cf387b1c7f60 Alex Deucher              2022-06-22  3496  								&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1], //  Single  *FractionOfUrgentBandwidth
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3497  								&mode_lib->vba.ImmediateFlipSupportedForState[i][j]); // Boolean *ImmediateFlipBandwidthSupport
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3498  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3499  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3500  					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3501  						if (!(mode_lib->vba.ImmediateFlipRequirement[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3502  								== dm_immediate_flip_not_required)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3503  								&& (mode_lib->vba.ImmediateFlipSupportedForPipe[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3504  										== false))
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3505  							mode_lib->vba.ImmediateFlipSupportedForState[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3506  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3507  				} else { // if prefetch not support, assume iflip not supported
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3508  					mode_lib->vba.ImmediateFlipSupportedForState[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3509  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3510  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3511  				if (mode_lib->vba.MaxVStartup <= __DML_VBA_MIN_VSTARTUP__
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3512  						|| mode_lib->vba.AnyLinesForVMOrRowTooLarge == false) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3513  					mode_lib->vba.NextMaxVStartup = mode_lib->vba.MaxMaxVStartup[i][j];
7acc487ab57e07 Alex Deucher              2022-07-20  3514  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3515  				} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3516  					mode_lib->vba.NextMaxVStartup = mode_lib->vba.NextMaxVStartup - 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3517  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3518  			} while (!((mode_lib->vba.PrefetchSupported[i][j] == true
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3519  					&& mode_lib->vba.DynamicMetadataSupported[i][j] == true
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3520  					&& mode_lib->vba.VRatioInPrefetchSupported[i][j] == true &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3521  					// consider flip support is okay if when there is no hostvm and the
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3522  					// user does't require a iflip OR the flip bw is ok
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3523  					// If there is hostvm, DCN needs to support iflip for invalidation
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3524  					((mode_lib->vba.HostVMEnable == false
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3525  							&& !mode_lib->vba.ImmediateFlipRequiredFinal)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3526  							|| mode_lib->vba.ImmediateFlipSupportedForState[i][j] == true))
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3527  					|| (mode_lib->vba.NextMaxVStartup == mode_lib->vba.MaxMaxVStartup[i][j]
7acc487ab57e07 Alex Deucher              2022-07-20  3528  							&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState > mode_lib->vba.MaxPrefetchMode)));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3529  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3530  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3531  				mode_lib->vba.use_one_row_for_frame_this_state[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3532  						mode_lib->vba.use_one_row_for_frame[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3533  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3534  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3535  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3536  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.UrgentLatency = mode_lib->vba.UrgLatency[i];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3537  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.ExtraLatency = mode_lib->vba.ExtraLatency;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3538  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.WritebackLatency = mode_lib->vba.WritebackLatency;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3539  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.DRAMClockChangeLatency = mode_lib->vba.DRAMClockChangeLatency;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3540  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.FCLKChangeLatency = mode_lib->vba.FCLKChangeLatency;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3541  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SRExitTime = mode_lib->vba.SRExitTime;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3542  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SREnterPlusExitTime = mode_lib->vba.SREnterPlusExitTime;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3543  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SRExitZ8Time = mode_lib->vba.SRExitZ8Time;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3544  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SREnterPlusExitZ8Time = mode_lib->vba.SREnterPlusExitZ8Time;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3545  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.USRRetrainingLatency = mode_lib->vba.USRRetrainingLatency;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3546  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3547  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3548  			{
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3549  				dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
1df7e569522486 Nathan Chancellor         2022-08-30  3550  						v,
1df7e569522486 Nathan Chancellor         2022-08-30  3551  						v->PrefetchModePerState[i][j],
1df7e569522486 Nathan Chancellor         2022-08-30  3552  						v->DCFCLKState[i][j],
1df7e569522486 Nathan Chancellor         2022-08-30  3553  						v->ReturnBWPerState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3554  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters,
1df7e569522486 Nathan Chancellor         2022-08-30  3555  						v->SOCCLKPerState[i],
1df7e569522486 Nathan Chancellor         2022-08-30  3556  						v->ProjectedDCFCLKDeepSleep[i][j],
1df7e569522486 Nathan Chancellor         2022-08-30  3557  						v->DETBufferSizeYThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3558  						v->DETBufferSizeCThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3559  						v->SwathHeightYThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3560  						v->SwathHeightCThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3561  						v->SwathWidthYThisState, // 24
1df7e569522486 Nathan Chancellor         2022-08-30  3562  						v->SwathWidthCThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3563  						v->NoOfDPPThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3564  						v->BytePerPixelInDETY,
1df7e569522486 Nathan Chancellor         2022-08-30  3565  						v->BytePerPixelInDETC,
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3566  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTXAfterScaler,
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3567  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTYAfterScaler,
1df7e569522486 Nathan Chancellor         2022-08-30  3568  						v->UnboundedRequestEnabledThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3569  						v->CompressedBufferSizeInkByteThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3570  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3571  						/* Output */
1df7e569522486 Nathan Chancellor         2022-08-30  3572  						&v->DRAMClockChangeSupport[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3573  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single2[0], // double *MaxActiveDRAMClockChangeLatencySupported
7acc487ab57e07 Alex Deucher              2022-07-20  3574  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer[0], // Long SubViewportLinesNeededInMALL[]
1df7e569522486 Nathan Chancellor         2022-08-30  3575  						&v->FCLKChangeSupport[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3576  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single2[1], // double *MinActiveFCLKChangeLatencySupported
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3577  						&mode_lib->vba.USRRetrainingSupport[i][j],
a3c9b4c7a75a66 Alvin Lee                 2022-08-15  3578  						mode_lib->vba.ActiveDRAMClockChangeLatencyMarginPerState[i][j]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3579  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3580  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3581  	} // End of Prefetch Check
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3582  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3583  	/*Cursor Support Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3584  	mode_lib->vba.CursorSupport = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3585  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3586  		if (mode_lib->vba.CursorWidth[k][0] > 0.0) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3587  			if (mode_lib->vba.CursorBPP[k][0] == 64 && mode_lib->vba.Cursor64BppSupport == false)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3588  				mode_lib->vba.CursorSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3589  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3590  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3591  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3592  	/*Valid Pitch Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3593  	mode_lib->vba.PitchSupport = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3594  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3595  		mode_lib->vba.AlignedYPitch[k] = dml_ceil(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3596  				dml_max(mode_lib->vba.PitchY[k], mode_lib->vba.SurfaceWidthY[k]),
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3597  				mode_lib->vba.MacroTileWidthY[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3598  		if (mode_lib->vba.DCCEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3599  			mode_lib->vba.AlignedDCCMetaPitchY[k] = dml_ceil(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3600  					dml_max(mode_lib->vba.DCCMetaPitchY[k], mode_lib->vba.SurfaceWidthY[k]),
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3601  					64.0 * mode_lib->vba.Read256BlockWidthY[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3602  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3603  			mode_lib->vba.AlignedDCCMetaPitchY[k] = mode_lib->vba.DCCMetaPitchY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3604  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3605  		if (mode_lib->vba.SourcePixelFormat[k] != dm_444_64 && mode_lib->vba.SourcePixelFormat[k] != dm_444_32
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3606  				&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3607  				&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3608  				&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3609  				&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_8) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3610  			mode_lib->vba.AlignedCPitch[k] = dml_ceil(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3611  					dml_max(mode_lib->vba.PitchC[k], mode_lib->vba.SurfaceWidthC[k]),
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3612  					mode_lib->vba.MacroTileWidthC[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3613  			if (mode_lib->vba.DCCEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3614  				mode_lib->vba.AlignedDCCMetaPitchC[k] = dml_ceil(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3615  						dml_max(mode_lib->vba.DCCMetaPitchC[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3616  								mode_lib->vba.SurfaceWidthC[k]),
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3617  						64.0 * mode_lib->vba.Read256BlockWidthC[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3618  			} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3619  				mode_lib->vba.AlignedDCCMetaPitchC[k] = mode_lib->vba.DCCMetaPitchC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3620  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3621  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3622  			mode_lib->vba.AlignedCPitch[k] = mode_lib->vba.PitchC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3623  			mode_lib->vba.AlignedDCCMetaPitchC[k] = mode_lib->vba.DCCMetaPitchC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3624  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3625  		if (mode_lib->vba.AlignedYPitch[k] > mode_lib->vba.PitchY[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3626  				|| mode_lib->vba.AlignedCPitch[k] > mode_lib->vba.PitchC[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3627  				|| mode_lib->vba.AlignedDCCMetaPitchY[k] > mode_lib->vba.DCCMetaPitchY[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3628  				|| mode_lib->vba.AlignedDCCMetaPitchC[k] > mode_lib->vba.DCCMetaPitchC[k]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3629  			mode_lib->vba.PitchSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3630  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3631  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3632  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3633  	mode_lib->vba.ViewportExceedsSurface = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3634  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3635  		if (mode_lib->vba.ViewportWidth[k] > mode_lib->vba.SurfaceWidthY[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3636  				|| mode_lib->vba.ViewportHeight[k] > mode_lib->vba.SurfaceHeightY[k]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3637  			mode_lib->vba.ViewportExceedsSurface = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3638  			if (mode_lib->vba.SourcePixelFormat[k] != dm_444_64
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3639  					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_32
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3640  					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3641  					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3642  					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_8
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3643  					&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3644  				if (mode_lib->vba.ViewportWidthChroma[k] > mode_lib->vba.SurfaceWidthC[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3645  						|| mode_lib->vba.ViewportHeightChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3646  								> mode_lib->vba.SurfaceHeightC[k]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3647  					mode_lib->vba.ViewportExceedsSurface = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3648  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3649  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3650  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3651  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3652  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3653  	/*Mode Support, Voltage State and SOC Configuration*/
1b54a0121dba12 Rodrigo Siqueira          2022-07-22  3654  	mode_support_configuration(v, mode_lib);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3655  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3656  	MaximumMPCCombine = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3657  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3658  	for (i = v->soc.num_states; i >= 0; i--) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3659  		if (i == v->soc.num_states || mode_lib->vba.ModeSupport[i][0] == true ||
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3660  				mode_lib->vba.ModeSupport[i][1] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3661  			mode_lib->vba.VoltageLevel = i;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3662  			mode_lib->vba.ModeIsSupported = mode_lib->vba.ModeSupport[i][0] == true
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3663  					|| mode_lib->vba.ModeSupport[i][1] == true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3664  
7e6d5cf8e3e3f8 Rodrigo Siqueira          2022-09-22  3665  			if (mode_lib->vba.ModeSupport[i][0] == true)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3666  				MaximumMPCCombine = 0;
7e6d5cf8e3e3f8 Rodrigo Siqueira          2022-09-22  3667  			else
80fb575678b488 Samson Tam                2022-04-11  3668  				MaximumMPCCombine = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3669  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3670  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3671  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3672  	mode_lib->vba.ImmediateFlipSupport =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3673  			mode_lib->vba.ImmediateFlipSupportedForState[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3674  	mode_lib->vba.UnboundedRequestEnabled =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3675  			mode_lib->vba.UnboundedRequestEnabledAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3676  	mode_lib->vba.CompressedBufferSizeInkByte =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3677  			mode_lib->vba.CompressedBufferSizeInkByteAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine]; // Not used, informational
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3678  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3679  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3680  		mode_lib->vba.MPCCombineEnable[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3681  				mode_lib->vba.MPCCombine[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3682  		mode_lib->vba.DPPPerPlane[k] = mode_lib->vba.NoOfDPP[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3683  		mode_lib->vba.SwathHeightY[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3684  				mode_lib->vba.SwathHeightYAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3685  		mode_lib->vba.SwathHeightC[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3686  				mode_lib->vba.SwathHeightCAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3687  		mode_lib->vba.DETBufferSizeInKByte[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3688  			mode_lib->vba.DETBufferSizeInKByteAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3689  		mode_lib->vba.DETBufferSizeY[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3690  				mode_lib->vba.DETBufferSizeYAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3691  		mode_lib->vba.DETBufferSizeC[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3692  				mode_lib->vba.DETBufferSizeCAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3693  		mode_lib->vba.OutputType[k] = mode_lib->vba.OutputTypePerState[mode_lib->vba.VoltageLevel][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3694  		mode_lib->vba.OutputRate[k] = mode_lib->vba.OutputRatePerState[mode_lib->vba.VoltageLevel][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3695  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3696  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3697  	mode_lib->vba.DCFCLK = mode_lib->vba.DCFCLKState[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3698  	mode_lib->vba.DRAMSpeed = mode_lib->vba.DRAMSpeedPerState[mode_lib->vba.VoltageLevel];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3699  	mode_lib->vba.FabricClock = mode_lib->vba.FabricClockPerState[mode_lib->vba.VoltageLevel];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3700  	mode_lib->vba.SOCCLK = mode_lib->vba.SOCCLKPerState[mode_lib->vba.VoltageLevel];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3701  	mode_lib->vba.ReturnBW = mode_lib->vba.ReturnBWPerState[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3702  	mode_lib->vba.DISPCLK = mode_lib->vba.RequiredDISPCLK[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3703  	mode_lib->vba.maxMpcComb = MaximumMPCCombine;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3704  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3705  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3706  		if (mode_lib->vba.BlendingAndTiming[k] == k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3707  			mode_lib->vba.ODMCombineEnabled[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3708  					mode_lib->vba.ODMCombineEnablePerState[mode_lib->vba.VoltageLevel][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3709  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3710  			mode_lib->vba.ODMCombineEnabled[k] = dm_odm_combine_mode_disabled;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3711  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3712  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3713  		mode_lib->vba.DSCEnabled[k] = mode_lib->vba.RequiresDSC[mode_lib->vba.VoltageLevel][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3714  		mode_lib->vba.FECEnable[k] = mode_lib->vba.RequiresFEC[mode_lib->vba.VoltageLevel][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3715  		mode_lib->vba.OutputBpp[k] = mode_lib->vba.OutputBppPerState[mode_lib->vba.VoltageLevel][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3716  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3717  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3718  	mode_lib->vba.UrgentWatermark = mode_lib->vba.Watermark.UrgentWatermark;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3719  	mode_lib->vba.StutterEnterPlusExitWatermark = mode_lib->vba.Watermark.StutterEnterPlusExitWatermark;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3720  	mode_lib->vba.StutterExitWatermark = mode_lib->vba.Watermark.StutterExitWatermark;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3721  	mode_lib->vba.WritebackDRAMClockChangeWatermark = mode_lib->vba.Watermark.WritebackDRAMClockChangeWatermark;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3722  	mode_lib->vba.DRAMClockChangeWatermark = mode_lib->vba.Watermark.DRAMClockChangeWatermark;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3723  	mode_lib->vba.UrgentLatency = mode_lib->vba.UrgLatency[mode_lib->vba.VoltageLevel];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3724  	mode_lib->vba.DCFCLKDeepSleep = mode_lib->vba.ProjectedDCFCLKDeepSleep[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3725  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3726  	/* VBA has Error type to Error Msg output here, but not necessary for DML-C */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21 @3727  } // ModeSupportAndSystemConfigurationFull

:::::: The code at line 3727 was first introduced by commit
:::::: dda4fb85e433f761eedaed0005a2bc20d705d504 drm/amd/display: DML changes for DCN32/321

:::::: TO: Aurabindo Pillai <aurabindo.pillai@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
