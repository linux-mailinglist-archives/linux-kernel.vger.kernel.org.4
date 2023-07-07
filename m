Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283AC74A979
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 05:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGGDwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 23:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGGDv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 23:51:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12B1FC9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 20:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688701914; x=1720237914;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pKVfa9ZqBKHj9k/ZNhtHGi309gBSA9KU/qEGoQ28Vz8=;
  b=FPar1zn3UMu1eQXYU0fghpnpZhCc5lkBxN42utiRryv9v/7Ga3i5Oj/o
   P4XAygDr2A8kdI/RaoUHElmQAtdNIHejJjkX6StFx583oGGWpylDNPxPJ
   r3EtpoaqJRWythzqTXnIk2R6g5hM7pWuEUYOpA6AtTp62MtfXl9Pt7Bo+
   jZ5NsZUUFmtg0VxXZTepIN0T8bI8MLNZxT923Lc6iHhGLAlbMWFuQ0AwN
   ZTINzKxcOdk2XfrV3im+peYhnDKCkKuAupL/zgQ6Joq4Xsaaap+f1iNN+
   ouSWFsAQekelXrOE8BpMQO2H4FseTe1DIXBrRaLyeiUtILrV30e8xTXwz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="427475707"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="427475707"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 20:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="789803752"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="789803752"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2023 20:51:50 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHcVZ-0001ji-28;
        Fri, 07 Jul 2023 03:51:49 +0000
Date:   Fri, 7 Jul 2023 11:50:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alvin Lee <alvin.lee2@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nevenko Stupar <nevenko.stupar@amd.com>,
        Jun Lei <jun.lei@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3756:1:
 warning: the frame size of 2064 bytes is larger than 2048 bytes
Message-ID: <202307071115.BOMZDRvt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1793eac148d0136f9afe877766b9d8f4458fbf21
commit: 7e60ab4eb3e4ba2adac46d737fdbbc5732bebd58 drm/amd/display: Apply 60us prefetch for DCFCLK <= 300Mhz
date:   4 weeks ago
config: arm64-randconfig-r034-20230707 (https://download.01.org/0day-ci/archive/20230707/202307071115.BOMZDRvt-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230707/202307071115.BOMZDRvt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307071115.BOMZDRvt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3756:1: warning: the frame size of 2064 bytes is larger than 2048 bytes [-Wframe-larger-than=]
    3756 | } // ModeSupportAndSystemConfigurationFull
         | ^


vim +3756 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c

dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1736  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1737  	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  1738  	if (mode_lib->validate_max_state)
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  1739  		start_state = v->soc.num_states - 1;
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  1740  	else
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  1741  		start_state = 0;
59b4c07892d8cc Martin Leung              2022-12-12  1742  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1743  	/*Scale Ratio, taps Support Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1744  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1745  	mode_lib->vba.ScaleRatioAndTapsSupport = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1746  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1747  		if (mode_lib->vba.ScalerEnabled[k] == false
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1748  				&& ((mode_lib->vba.SourcePixelFormat[k] != dm_444_64
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1749  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_32
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1750  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1751  						&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1752  						&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_8
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1753  						&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1754  						&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe_alpha)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1755  						|| mode_lib->vba.HRatio[k] != 1.0 || mode_lib->vba.htaps[k] != 1.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1756  						|| mode_lib->vba.VRatio[k] != 1.0 || mode_lib->vba.vtaps[k] != 1.0)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1757  			mode_lib->vba.ScaleRatioAndTapsSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1758  		} else if (mode_lib->vba.vtaps[k] < 1.0 || mode_lib->vba.vtaps[k] > 8.0 || mode_lib->vba.htaps[k] < 1.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1759  				|| mode_lib->vba.htaps[k] > 8.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1760  				|| (mode_lib->vba.htaps[k] > 1.0 && (mode_lib->vba.htaps[k] % 2) == 1)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1761  				|| mode_lib->vba.HRatio[k] > mode_lib->vba.MaxHSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1762  				|| mode_lib->vba.VRatio[k] > mode_lib->vba.MaxVSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1763  				|| mode_lib->vba.HRatio[k] > mode_lib->vba.htaps[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1764  				|| mode_lib->vba.VRatio[k] > mode_lib->vba.vtaps[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1765  				|| (mode_lib->vba.SourcePixelFormat[k] != dm_444_64
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1766  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_32
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1767  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1768  						&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1769  						&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_8
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1770  						&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1771  						&& (mode_lib->vba.VTAPsChroma[k] < 1
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1772  								|| mode_lib->vba.VTAPsChroma[k] > 8
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1773  								|| mode_lib->vba.HTAPsChroma[k] < 1
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1774  								|| mode_lib->vba.HTAPsChroma[k] > 8
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1775  								|| (mode_lib->vba.HTAPsChroma[k] > 1
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1776  										&& mode_lib->vba.HTAPsChroma[k] % 2
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1777  												== 1)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1778  								|| mode_lib->vba.HRatioChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1779  										> mode_lib->vba.MaxHSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1780  								|| mode_lib->vba.VRatioChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1781  										> mode_lib->vba.MaxVSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1782  								|| mode_lib->vba.HRatioChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1783  										> mode_lib->vba.HTAPsChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1784  								|| mode_lib->vba.VRatioChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1785  										> mode_lib->vba.VTAPsChroma[k]))) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1786  			mode_lib->vba.ScaleRatioAndTapsSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1787  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1788  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1789  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1790  	/*Source Format, Pixel Format and Scan Support Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1791  	mode_lib->vba.SourceFormatPixelAndScanSupport = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1792  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1793  		if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
ce19bbe46fcfb8 Chandan Vurdigere Nataraj 2022-06-07  1794  			&& (!(!IsVertical((enum dm_rotation_angle) mode_lib->vba.SourceScan[k]))
ce19bbe46fcfb8 Chandan Vurdigere Nataraj 2022-06-07  1795  				|| mode_lib->vba.DCCEnable[k] == true)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1796  			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1797  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1798  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1799  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1800  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1801  		dml32_CalculateBytePerPixelAndBlockSizes(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1802  				mode_lib->vba.SourcePixelFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1803  				mode_lib->vba.SurfaceTiling[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1804  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1805  				/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1806  				&mode_lib->vba.BytePerPixelY[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1807  				&mode_lib->vba.BytePerPixelC[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1808  				&mode_lib->vba.BytePerPixelInDETY[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1809  				&mode_lib->vba.BytePerPixelInDETC[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1810  				&mode_lib->vba.Read256BlockHeightY[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1811  				&mode_lib->vba.Read256BlockHeightC[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1812  				&mode_lib->vba.Read256BlockWidthY[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1813  				&mode_lib->vba.Read256BlockWidthC[k],
827e3c9caa77d3 Aric Cyr                  2022-08-24  1814  				&mode_lib->vba.MacroTileHeightY[k],
827e3c9caa77d3 Aric Cyr                  2022-08-24  1815  				&mode_lib->vba.MacroTileHeightC[k],
827e3c9caa77d3 Aric Cyr                  2022-08-24  1816  				&mode_lib->vba.MacroTileWidthY[k],
827e3c9caa77d3 Aric Cyr                  2022-08-24  1817  				&mode_lib->vba.MacroTileWidthC[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1818  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1819  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1820  	/*Bandwidth Support Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1821  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1822  		if (!IsVertical(mode_lib->vba.SourceRotation[k])) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1823  			v->SwathWidthYSingleDPP[k] = mode_lib->vba.ViewportWidth[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1824  			v->SwathWidthCSingleDPP[k] = mode_lib->vba.ViewportWidthChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1825  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1826  			v->SwathWidthYSingleDPP[k] = mode_lib->vba.ViewportHeight[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1827  			v->SwathWidthCSingleDPP[k] = mode_lib->vba.ViewportHeightChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1828  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1829  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1830  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1831  		v->ReadBandwidthLuma[k] = v->SwathWidthYSingleDPP[k] * dml_ceil(v->BytePerPixelInDETY[k], 1.0)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1832  				/ (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * mode_lib->vba.VRatio[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1833  		v->ReadBandwidthChroma[k] = v->SwathWidthYSingleDPP[k] / 2 * dml_ceil(v->BytePerPixelInDETC[k], 2.0)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1834  				/ (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * mode_lib->vba.VRatio[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1835  				/ 2.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1836  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1837  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1838  		if (mode_lib->vba.WritebackEnable[k] == true && mode_lib->vba.WritebackPixelFormat[k] == dm_444_64) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1839  			v->WriteBandwidth[k] = mode_lib->vba.WritebackDestinationWidth[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1840  					* mode_lib->vba.WritebackDestinationHeight[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1841  					/ (mode_lib->vba.WritebackSourceHeight[k] * mode_lib->vba.HTotal[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1842  							/ mode_lib->vba.PixelClock[k]) * 8.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1843  		} else if (mode_lib->vba.WritebackEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1844  			v->WriteBandwidth[k] = mode_lib->vba.WritebackDestinationWidth[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1845  					* mode_lib->vba.WritebackDestinationHeight[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1846  					/ (mode_lib->vba.WritebackSourceHeight[k] * mode_lib->vba.HTotal[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1847  							/ mode_lib->vba.PixelClock[k]) * 4.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1848  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1849  			v->WriteBandwidth[k] = 0.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1850  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1851  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1852  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1853  	/*Writeback Latency support check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1854  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1855  	mode_lib->vba.WritebackLatencySupport = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1856  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1857  		if (mode_lib->vba.WritebackEnable[k] == true
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1858  				&& (v->WriteBandwidth[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1859  						> mode_lib->vba.WritebackInterfaceBufferSize * 1024
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1860  								/ mode_lib->vba.WritebackLatency)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1861  			mode_lib->vba.WritebackLatencySupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1862  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1863  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1864  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1865  	/*Writeback Mode Support Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1866  	mode_lib->vba.EnoughWritebackUnits = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1867  	mode_lib->vba.TotalNumberOfActiveWriteback = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1868  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1869  		if (mode_lib->vba.WritebackEnable[k] == true)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1870  			mode_lib->vba.TotalNumberOfActiveWriteback = mode_lib->vba.TotalNumberOfActiveWriteback + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1871  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1872  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1873  	if (mode_lib->vba.TotalNumberOfActiveWriteback > mode_lib->vba.MaxNumWriteback)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1874  		mode_lib->vba.EnoughWritebackUnits = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1875  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1876  	/*Writeback Scale Ratio and Taps Support Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1877  	mode_lib->vba.WritebackScaleRatioAndTapsSupport = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1878  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1879  		if (mode_lib->vba.WritebackEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1880  			if (mode_lib->vba.WritebackHRatio[k] > mode_lib->vba.WritebackMaxHSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1881  					|| mode_lib->vba.WritebackVRatio[k] > mode_lib->vba.WritebackMaxVSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1882  					|| mode_lib->vba.WritebackHRatio[k] < mode_lib->vba.WritebackMinHSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1883  					|| mode_lib->vba.WritebackVRatio[k] < mode_lib->vba.WritebackMinVSCLRatio
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1884  					|| mode_lib->vba.WritebackHTaps[k] > mode_lib->vba.WritebackMaxHSCLTaps
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1885  					|| mode_lib->vba.WritebackVTaps[k] > mode_lib->vba.WritebackMaxVSCLTaps
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1886  					|| mode_lib->vba.WritebackHRatio[k] > mode_lib->vba.WritebackHTaps[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1887  					|| mode_lib->vba.WritebackVRatio[k] > mode_lib->vba.WritebackVTaps[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1888  					|| (mode_lib->vba.WritebackHTaps[k] > 2.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1889  							&& ((mode_lib->vba.WritebackHTaps[k] % 2) == 1))) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1890  				mode_lib->vba.WritebackScaleRatioAndTapsSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1891  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1892  			if (2.0 * mode_lib->vba.WritebackDestinationWidth[k] * (mode_lib->vba.WritebackVTaps[k] - 1)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1893  					* 57 > mode_lib->vba.WritebackLineBufferSize) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1894  				mode_lib->vba.WritebackScaleRatioAndTapsSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1895  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1896  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1897  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1898  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1899  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1900  		dml32_CalculateSinglePipeDPPCLKAndSCLThroughput(mode_lib->vba.HRatio[k], mode_lib->vba.HRatioChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1901  				mode_lib->vba.VRatio[k], mode_lib->vba.VRatioChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1902  				mode_lib->vba.MaxDCHUBToPSCLThroughput, mode_lib->vba.MaxPSCLToLBThroughput,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1903  				mode_lib->vba.PixelClock[k], mode_lib->vba.SourcePixelFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1904  				mode_lib->vba.htaps[k], mode_lib->vba.HTAPsChroma[k], mode_lib->vba.vtaps[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1905  				mode_lib->vba.VTAPsChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1906  				/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1907  				&mode_lib->vba.PSCL_FACTOR[k], &mode_lib->vba.PSCL_FACTOR_CHROMA[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1908  				&mode_lib->vba.MinDPPCLKUsingSingleDPP[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1909  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1910  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1911  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1912  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1913  		if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1914  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 8192;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1915  		} else if (!IsVertical(mode_lib->vba.SourceRotation[k]) && v->BytePerPixelC[k] > 0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1916  				&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe_alpha) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1917  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 7680;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1918  		} else if (IsVertical(mode_lib->vba.SourceRotation[k]) && v->BytePerPixelC[k] > 0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1919  				&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe_alpha) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1920  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 4320;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1921  		} else if (mode_lib->vba.SourcePixelFormat[k] == dm_rgbe_alpha) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1922  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 3840;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1923  		} else if (IsVertical(mode_lib->vba.SourceRotation[k]) && v->BytePerPixelY[k] == 8 &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1924  				mode_lib->vba.DCCEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1925  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 3072;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1926  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1927  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 6144;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1928  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1929  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1930  		if (mode_lib->vba.SourcePixelFormat[k] == dm_420_8 || mode_lib->vba.SourcePixelFormat[k] == dm_420_10
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1931  				|| mode_lib->vba.SourcePixelFormat[k] == dm_420_12) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1932  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportChroma = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma / 2.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1933  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1934  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportChroma = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1935  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1936  		v->MaximumSwathWidthInLineBufferLuma = mode_lib->vba.LineBufferSizeFinal
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1937  				* dml_max(mode_lib->vba.HRatio[k], 1.0) / mode_lib->vba.LBBitPerPixel[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1938  				/ (mode_lib->vba.vtaps[k] + dml_max(dml_ceil(mode_lib->vba.VRatio[k], 1.0) - 2, 0.0));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1939  		if (v->BytePerPixelC[k] == 0.0) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1940  			v->MaximumSwathWidthInLineBufferChroma = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1941  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1942  			v->MaximumSwathWidthInLineBufferChroma = mode_lib->vba.LineBufferSizeFinal
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1943  					* dml_max(mode_lib->vba.HRatioChroma[k], 1.0) / mode_lib->vba.LBBitPerPixel[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1944  					/ (mode_lib->vba.VTAPsChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1945  							+ dml_max(dml_ceil(mode_lib->vba.VRatioChroma[k], 1.0) - 2,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1946  									0.0));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1947  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1948  		v->MaximumSwathWidthLuma[k] = dml_min(v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1949  				v->MaximumSwathWidthInLineBufferLuma);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1950  		v->MaximumSwathWidthChroma[k] = dml_min(v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1951  				v->MaximumSwathWidthInLineBufferChroma);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1952  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1953  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1954  	dml32_CalculateSwathAndDETConfiguration(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1955  			mode_lib->vba.DETSizeOverride,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1956  			mode_lib->vba.UsesMALLForPStateChange,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1957  			mode_lib->vba.ConfigReturnBufferSizeInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1958  			mode_lib->vba.MaxTotalDETInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1959  			mode_lib->vba.MinCompressedBufferSizeInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1960  			1, /* ForceSingleDPP */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1961  			mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1962  			mode_lib->vba.nomDETInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1963  			mode_lib->vba.UseUnboundedRequesting,
f4b4e41a2e0527 Jun Lei                   2022-06-24  1964  			mode_lib->vba.DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment,
f4b4e41a2e0527 Jun Lei                   2022-06-24  1965  			mode_lib->vba.ip.pixel_chunk_size_kbytes,
f4b4e41a2e0527 Jun Lei                   2022-06-24  1966  			mode_lib->vba.ip.rob_buffer_size_kbytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1967  			mode_lib->vba.CompressedBufferSegmentSizeInkByteFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1968  			mode_lib->vba.Output,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1969  			mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1970  			mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1971  			mode_lib->vba.MaximumSwathWidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1972  			mode_lib->vba.MaximumSwathWidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1973  			mode_lib->vba.SourceRotation,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1974  			mode_lib->vba.ViewportStationary,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1975  			mode_lib->vba.SourcePixelFormat,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1976  			mode_lib->vba.SurfaceTiling,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1977  			mode_lib->vba.ViewportWidth,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1978  			mode_lib->vba.ViewportHeight,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1979  			mode_lib->vba.ViewportXStartY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1980  			mode_lib->vba.ViewportYStartY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1981  			mode_lib->vba.ViewportXStartC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1982  			mode_lib->vba.ViewportYStartC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1983  			mode_lib->vba.SurfaceWidthY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1984  			mode_lib->vba.SurfaceWidthC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1985  			mode_lib->vba.SurfaceHeightY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1986  			mode_lib->vba.SurfaceHeightC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1987  			mode_lib->vba.Read256BlockHeightY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1988  			mode_lib->vba.Read256BlockHeightC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1989  			mode_lib->vba.Read256BlockWidthY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1990  			mode_lib->vba.Read256BlockWidthC,
7acc487ab57e07 Alex Deucher              2022-07-20  1991  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_odm_mode,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1992  			mode_lib->vba.BlendingAndTiming,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1993  			mode_lib->vba.BytePerPixelY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1994  			mode_lib->vba.BytePerPixelC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1995  			mode_lib->vba.BytePerPixelInDETY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1996  			mode_lib->vba.BytePerPixelInDETC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1997  			mode_lib->vba.HActive,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1998  			mode_lib->vba.HRatio,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  1999  			mode_lib->vba.HRatioChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2000  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0], /*  Integer DPPPerSurface[] */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2001  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2002  			/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2003  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[1], /* Long            swath_width_luma_ub[] */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2004  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[2], /* Long            swath_width_chroma_ub[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2005  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_double_array[0], /* Long            SwathWidth[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2006  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_double_array[1], /* Long            SwathWidthChroma[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2007  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[3], /* Integer         SwathHeightY[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2008  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[4], /* Integer         SwathHeightC[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2009  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[5], /* Long            DETBufferSizeInKByte[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2010  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[6], /* Long            DETBufferSizeY[]  */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2011  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[7], /* Long            DETBufferSizeC[]  */
01cf387b1c7f60 Alex Deucher              2022-06-22  2012  			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0][0], /* bool           *UnboundedRequestEnabled  */
01cf387b1c7f60 Alex Deucher              2022-06-22  2013  			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0][0], /* Long           *CompressedBufferSizeInkByte  */
f4b4e41a2e0527 Jun Lei                   2022-06-24  2014  			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[1][0], /* Long           *CompBufReservedSpaceKBytes */
f4b4e41a2e0527 Jun Lei                   2022-06-24  2015  			&CompBufReservedSpaceNeedAdjustmentSingleDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2016  			mode_lib->vba.SingleDPPViewportSizeSupportPerSurface,/* bool ViewportSizeSupportPerSurface[] */
01cf387b1c7f60 Alex Deucher              2022-06-22  2017  			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[1][0]); /* bool           *ViewportSizeSupport */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2018  
7acc487ab57e07 Alex Deucher              2022-07-20  2019  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsNeededForPStateChangeAndVoltage = false;
7acc487ab57e07 Alex Deucher              2022-07-20  2020  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsPossible = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2021  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2022  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2023  		if (mode_lib->vba.MPCCombineUse[k] == dm_mpc_reduce_voltage_and_clocks)
7acc487ab57e07 Alex Deucher              2022-07-20  2024  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsNeededForPStateChangeAndVoltage = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2025  		if (mode_lib->vba.MPCCombineUse[k] == dm_mpc_always_when_possible)
7acc487ab57e07 Alex Deucher              2022-07-20  2026  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsPossible = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2027  	}
7acc487ab57e07 Alex Deucher              2022-07-20  2028  	mode_lib->vba.MPCCombineMethodIncompatible = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsNeededForPStateChangeAndVoltage
7acc487ab57e07 Alex Deucher              2022-07-20  2029  			&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsPossible;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2030  
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  2031  	for (i = start_state; i < v->soc.num_states; i++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2032  		for (j = 0; j < 2; j++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2033  			mode_lib->vba.TotalNumberOfActiveDPP[i][j] = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2034  			mode_lib->vba.TotalAvailablePipesSupport[i][j] = true;
7acc487ab57e07 Alex Deucher              2022-07-20  2035  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeNoDSC = dm_odm_combine_mode_disabled;
7acc487ab57e07 Alex Deucher              2022-07-20  2036  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeDSC = dm_odm_combine_mode_disabled;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2037  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2038  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2039  				dml32_CalculateODMMode(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2040  						mode_lib->vba.MaximumPixelsPerLinePerDSCUnit,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2041  						mode_lib->vba.HActive[k],
16e5859d9faee7 Chris Park                2022-09-12  2042  						mode_lib->vba.OutputFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2043  						mode_lib->vba.Output[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2044  						mode_lib->vba.ODMUse[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2045  						mode_lib->vba.MaxDispclk[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2046  						mode_lib->vba.MaxDispclk[v->soc.num_states - 1],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2047  						false,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2048  						mode_lib->vba.TotalNumberOfActiveDPP[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2049  						mode_lib->vba.MaxNumDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2050  						mode_lib->vba.PixelClock[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2051  						mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2052  						mode_lib->vba.DISPCLKRampingMargin,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2053  						mode_lib->vba.DISPCLKDPPCLKVCOSpeed,
572200db77ecbd Taimur Hassan             2022-08-12  2054  						mode_lib->vba.NumberOfDSCSlices[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2055  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2056  						/* Output */
7acc487ab57e07 Alex Deucher              2022-07-20  2057  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportNoDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2058  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NumberOfDPPNoDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2059  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeNoDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2060  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.RequiredDISPCLKPerSurfaceNoDSC);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2061  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2062  				dml32_CalculateODMMode(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2063  						mode_lib->vba.MaximumPixelsPerLinePerDSCUnit,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2064  						mode_lib->vba.HActive[k],
16e5859d9faee7 Chris Park                2022-09-12  2065  						mode_lib->vba.OutputFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2066  						mode_lib->vba.Output[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2067  						mode_lib->vba.ODMUse[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2068  						mode_lib->vba.MaxDispclk[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2069  						mode_lib->vba.MaxDispclk[v->soc.num_states - 1],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2070  						true,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2071  						mode_lib->vba.TotalNumberOfActiveDPP[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2072  						mode_lib->vba.MaxNumDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2073  						mode_lib->vba.PixelClock[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2074  						mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2075  						mode_lib->vba.DISPCLKRampingMargin,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2076  						mode_lib->vba.DISPCLKDPPCLKVCOSpeed,
572200db77ecbd Taimur Hassan             2022-08-12  2077  						mode_lib->vba.NumberOfDSCSlices[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2078  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2079  						/* Output */
7acc487ab57e07 Alex Deucher              2022-07-20  2080  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2081  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NumberOfDPPDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2082  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2083  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.RequiredDISPCLKPerSurfaceDSC);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2084  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2085  				dml32_CalculateOutputLink(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2086  						mode_lib->vba.PHYCLKPerState[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2087  						mode_lib->vba.PHYCLKD18PerState[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2088  						mode_lib->vba.PHYCLKD32PerState[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2089  						mode_lib->vba.Downspreading,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2090  						(mode_lib->vba.BlendingAndTiming[k] == k),
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2091  						mode_lib->vba.Output[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2092  						mode_lib->vba.OutputFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2093  						mode_lib->vba.HTotal[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2094  						mode_lib->vba.HActive[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2095  						mode_lib->vba.PixelClockBackEnd[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2096  						mode_lib->vba.ForcedOutputLinkBPP[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2097  						mode_lib->vba.DSCInputBitPerComponent[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2098  						mode_lib->vba.NumberOfDSCSlices[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2099  						mode_lib->vba.AudioSampleRate[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2100  						mode_lib->vba.AudioSampleLayout[k],
7acc487ab57e07 Alex Deucher              2022-07-20  2101  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeNoDSC,
7acc487ab57e07 Alex Deucher              2022-07-20  2102  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeDSC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2103  						mode_lib->vba.DSCEnable[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2104  						mode_lib->vba.OutputLinkDPLanes[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2105  						mode_lib->vba.OutputLinkDPRate[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2106  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2107  						/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2108  						&mode_lib->vba.RequiresDSC[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2109  						&mode_lib->vba.RequiresFEC[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2110  						&mode_lib->vba.OutputBppPerState[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2111  						&mode_lib->vba.OutputTypePerState[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2112  						&mode_lib->vba.OutputRatePerState[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2113  						&mode_lib->vba.RequiredSlots[i][k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2114  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2115  				if (mode_lib->vba.RequiresDSC[i][k] == false) {
7acc487ab57e07 Alex Deucher              2022-07-20  2116  					mode_lib->vba.ODMCombineEnablePerState[i][k] = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeNoDSC;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2117  					mode_lib->vba.RequiredDISPCLKPerSurface[i][j][k] =
7acc487ab57e07 Alex Deucher              2022-07-20  2118  							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.RequiredDISPCLKPerSurfaceNoDSC;
7acc487ab57e07 Alex Deucher              2022-07-20  2119  					if (!v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportNoDSC)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2120  						mode_lib->vba.TotalAvailablePipesSupport[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2121  					mode_lib->vba.TotalNumberOfActiveDPP[i][j] =
7acc487ab57e07 Alex Deucher              2022-07-20  2122  							mode_lib->vba.TotalNumberOfActiveDPP[i][j] + v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NumberOfDPPNoDSC;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2123  				} else {
7acc487ab57e07 Alex Deucher              2022-07-20  2124  					mode_lib->vba.ODMCombineEnablePerState[i][k] = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeDSC;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2125  					mode_lib->vba.RequiredDISPCLKPerSurface[i][j][k] =
7acc487ab57e07 Alex Deucher              2022-07-20  2126  							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.RequiredDISPCLKPerSurfaceDSC;
7acc487ab57e07 Alex Deucher              2022-07-20  2127  					if (!v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportDSC)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2128  						mode_lib->vba.TotalAvailablePipesSupport[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2129  					mode_lib->vba.TotalNumberOfActiveDPP[i][j] =
7acc487ab57e07 Alex Deucher              2022-07-20  2130  							mode_lib->vba.TotalNumberOfActiveDPP[i][j] + v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NumberOfDPPDSC;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2131  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2132  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2133  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2134  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2135  				if (mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2136  					mode_lib->vba.MPCCombine[i][j][k] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2137  					mode_lib->vba.NoOfDPP[i][j][k] = 4;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2138  				} else if (mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2139  					mode_lib->vba.MPCCombine[i][j][k] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2140  					mode_lib->vba.NoOfDPP[i][j][k] = 2;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2141  				} else if (mode_lib->vba.MPCCombineUse[k] == dm_mpc_never) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2142  					mode_lib->vba.MPCCombine[i][j][k] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2143  					mode_lib->vba.NoOfDPP[i][j][k] = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2144  				} else if (dml32_RoundToDFSGranularity(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2145  						mode_lib->vba.MinDPPCLKUsingSingleDPP[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2146  								* (1 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2147  												/ 100), 1,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2148  						mode_lib->vba.DISPCLKDPPCLKVCOSpeed) <= mode_lib->vba.MaxDppclk[i] &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2149  				mode_lib->vba.SingleDPPViewportSizeSupportPerSurface[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2150  					mode_lib->vba.MPCCombine[i][j][k] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2151  					mode_lib->vba.NoOfDPP[i][j][k] = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2152  				} else if (mode_lib->vba.TotalNumberOfActiveDPP[i][j] < mode_lib->vba.MaxNumDPP) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2153  					mode_lib->vba.MPCCombine[i][j][k] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2154  					mode_lib->vba.NoOfDPP[i][j][k] = 2;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2155  					mode_lib->vba.TotalNumberOfActiveDPP[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2156  							mode_lib->vba.TotalNumberOfActiveDPP[i][j] + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2157  				} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2158  					mode_lib->vba.MPCCombine[i][j][k] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2159  					mode_lib->vba.NoOfDPP[i][j][k] = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2160  					mode_lib->vba.TotalAvailablePipesSupport[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2161  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2162  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2163  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2164  			mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] = 0;
7acc487ab57e07 Alex Deucher              2022-07-20  2165  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NoChroma = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2166  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2167  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2168  				if (mode_lib->vba.NoOfDPP[i][j][k] == 1)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2169  					mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2170  							mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2171  				if (mode_lib->vba.SourcePixelFormat[k] == dm_420_8
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2172  						|| mode_lib->vba.SourcePixelFormat[k] == dm_420_10
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2173  						|| mode_lib->vba.SourcePixelFormat[k] == dm_420_12
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2174  						|| mode_lib->vba.SourcePixelFormat[k] == dm_rgbe_alpha) {
7acc487ab57e07 Alex Deucher              2022-07-20  2175  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NoChroma = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2176  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2177  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2178  
f4b4e41a2e0527 Jun Lei                   2022-06-24  2179  			// if TotalNumberOfActiveDPP is > 1, then there should be no unbounded req mode (hw limitation), the comp buf reserved adjustment is not needed regardless
f4b4e41a2e0527 Jun Lei                   2022-06-24  2180  			// if TotalNumberOfActiveDPP is == 1, then will use the SingleDPP version of unbounded_req for the decision
f4b4e41a2e0527 Jun Lei                   2022-06-24  2181  			CompBufReservedSpaceNeedAdjustment = (mode_lib->vba.TotalNumberOfActiveDPP[i][j] > 1) ? 0 : CompBufReservedSpaceNeedAdjustmentSingleDPP;
f4b4e41a2e0527 Jun Lei                   2022-06-24  2182  
f4b4e41a2e0527 Jun Lei                   2022-06-24  2183  
f4b4e41a2e0527 Jun Lei                   2022-06-24  2184  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2185  			if (j == 1 && !dml32_UnboundedRequest(mode_lib->vba.UseUnboundedRequesting,
7acc487ab57e07 Alex Deucher              2022-07-20  2186  					mode_lib->vba.TotalNumberOfActiveDPP[i][j], v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NoChroma,
f4b4e41a2e0527 Jun Lei                   2022-06-24  2187  					mode_lib->vba.Output[0],
f4b4e41a2e0527 Jun Lei                   2022-06-24  2188  					mode_lib->vba.SurfaceTiling[0],
f4b4e41a2e0527 Jun Lei                   2022-06-24  2189  					CompBufReservedSpaceNeedAdjustment,
f4b4e41a2e0527 Jun Lei                   2022-06-24  2190  					mode_lib->vba.DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2191  				while (!(mode_lib->vba.TotalNumberOfActiveDPP[i][j] >= mode_lib->vba.MaxNumDPP
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2192  						|| mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] == 0)) {
7acc487ab57e07 Alex Deucher              2022-07-20  2193  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.BWOfNonCombinedSurfaceOfMaximumBandwidth = 0;
7acc487ab57e07 Alex Deucher              2022-07-20  2194  					NumberOfNonCombinedSurfaceOfMaximumBandwidth = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2195  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2196  					for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2197  						if (mode_lib->vba.MPCCombineUse[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2198  							!= dm_mpc_never &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2199  							mode_lib->vba.MPCCombineUse[k] != dm_mpc_reduce_voltage &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2200  							mode_lib->vba.ReadBandwidthLuma[k] +
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2201  							mode_lib->vba.ReadBandwidthChroma[k] >
7acc487ab57e07 Alex Deucher              2022-07-20  2202  							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.BWOfNonCombinedSurfaceOfMaximumBandwidth &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2203  							(mode_lib->vba.ODMCombineEnablePerState[i][k] !=
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2204  							dm_odm_combine_mode_2to1 &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2205  							mode_lib->vba.ODMCombineEnablePerState[i][k] !=
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2206  							dm_odm_combine_mode_4to1) &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2207  								mode_lib->vba.MPCCombine[i][j][k] == false) {
7acc487ab57e07 Alex Deucher              2022-07-20  2208  							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.BWOfNonCombinedSurfaceOfMaximumBandwidth =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2209  								mode_lib->vba.ReadBandwidthLuma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2210  								+ mode_lib->vba.ReadBandwidthChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2211  							NumberOfNonCombinedSurfaceOfMaximumBandwidth = k;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2212  						}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2213  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2214  					mode_lib->vba.MPCCombine[i][j][NumberOfNonCombinedSurfaceOfMaximumBandwidth] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2215  							true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2216  					mode_lib->vba.NoOfDPP[i][j][NumberOfNonCombinedSurfaceOfMaximumBandwidth] = 2;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2217  					mode_lib->vba.TotalNumberOfActiveDPP[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2218  							mode_lib->vba.TotalNumberOfActiveDPP[i][j] + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2219  					mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2220  							mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] - 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2221  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2222  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2223  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2224  			//DISPCLK/DPPCLK
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2225  			mode_lib->vba.WritebackRequiredDISPCLK = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2226  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2227  				if (mode_lib->vba.WritebackEnable[k]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2228  					mode_lib->vba.WritebackRequiredDISPCLK = dml_max(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2229  							mode_lib->vba.WritebackRequiredDISPCLK,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2230  							dml32_CalculateWriteBackDISPCLK(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2231  									mode_lib->vba.WritebackPixelFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2232  									mode_lib->vba.PixelClock[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2233  									mode_lib->vba.WritebackHRatio[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2234  									mode_lib->vba.WritebackVRatio[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2235  									mode_lib->vba.WritebackHTaps[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2236  									mode_lib->vba.WritebackVTaps[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2237  									mode_lib->vba.WritebackSourceWidth[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2238  									mode_lib->vba.WritebackDestinationWidth[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2239  									mode_lib->vba.HTotal[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2240  									mode_lib->vba.WritebackLineBufferSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2241  									mode_lib->vba.DISPCLKDPPCLKVCOSpeed));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2242  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2243  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2244  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2245  			mode_lib->vba.RequiredDISPCLK[i][j] = mode_lib->vba.WritebackRequiredDISPCLK;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2246  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2247  				mode_lib->vba.RequiredDISPCLK[i][j] = dml_max(mode_lib->vba.RequiredDISPCLK[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2248  						mode_lib->vba.RequiredDISPCLKPerSurface[i][j][k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2249  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2250  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2251  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2252  				mode_lib->vba.NoOfDPPThisState[k] = mode_lib->vba.NoOfDPP[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2253  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2254  			dml32_CalculateDPPCLK(mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2255  					mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2256  					mode_lib->vba.DISPCLKDPPCLKVCOSpeed, mode_lib->vba.MinDPPCLKUsingSingleDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2257  					mode_lib->vba.NoOfDPPThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2258  					/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2259  					&mode_lib->vba.GlobalDPPCLK, mode_lib->vba.RequiredDPPCLKThisState);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2260  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2261  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2262  				mode_lib->vba.RequiredDPPCLK[i][j][k] = mode_lib->vba.RequiredDPPCLKThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2263  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2264  			mode_lib->vba.DISPCLK_DPPCLK_Support[i][j] = !((mode_lib->vba.RequiredDISPCLK[i][j]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2265  					> mode_lib->vba.MaxDispclk[i])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2266  					|| (mode_lib->vba.GlobalDPPCLK > mode_lib->vba.MaxDppclk[i]));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2267  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2268  			if (mode_lib->vba.TotalNumberOfActiveDPP[i][j] > mode_lib->vba.MaxNumDPP)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2269  				mode_lib->vba.TotalAvailablePipesSupport[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2270  		} // j
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2271  	} // i (VOLTAGE_STATE)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2272  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2273  	/* Total Available OTG, HDMIFRL, DP Support Check */
7acc487ab57e07 Alex Deucher              2022-07-20  2274  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG = 0;
7acc487ab57e07 Alex Deucher              2022-07-20  2275  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveHDMIFRL = 0;
7acc487ab57e07 Alex Deucher              2022-07-20  2276  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 = 0;
7acc487ab57e07 Alex Deucher              2022-07-20  2277  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2278  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2279  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2280  		if (mode_lib->vba.BlendingAndTiming[k] == k) {
7acc487ab57e07 Alex Deucher              2022-07-20  2281  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2282  			if (mode_lib->vba.Output[k] == dm_dp2p0) {
7acc487ab57e07 Alex Deucher              2022-07-20  2283  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2284  				if (mode_lib->vba.OutputMultistreamId[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2285  						== k || mode_lib->vba.OutputMultistreamEn[k] == false) {
7acc487ab57e07 Alex Deucher              2022-07-20  2286  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2287  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2288  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2289  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2290  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2291  
7acc487ab57e07 Alex Deucher              2022-07-20  2292  	mode_lib->vba.NumberOfOTGSupport = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG <= mode_lib->vba.MaxNumOTG);
7acc487ab57e07 Alex Deucher              2022-07-20  2293  	mode_lib->vba.NumberOfHDMIFRLSupport = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveHDMIFRL <= mode_lib->vba.MaxNumHDMIFRLOutputs);
7acc487ab57e07 Alex Deucher              2022-07-20  2294  	mode_lib->vba.NumberOfDP2p0Support = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 <= mode_lib->vba.MaxNumDP2p0Streams
7acc487ab57e07 Alex Deucher              2022-07-20  2295  			&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs <= mode_lib->vba.MaxNumDP2p0Outputs);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2296  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2297  	/* Display IO and DSC Support Check */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2298  	mode_lib->vba.NonsupportedDSCInputBPC = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2299  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2300  		if (!(mode_lib->vba.DSCInputBitPerComponent[k] == 12.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2301  				|| mode_lib->vba.DSCInputBitPerComponent[k] == 10.0
a3daede4757603 Rodrigo Siqueira          2022-09-22  2302  				|| mode_lib->vba.DSCInputBitPerComponent[k] == 8.0)
a3daede4757603 Rodrigo Siqueira          2022-09-22  2303  				|| mode_lib->vba.DSCInputBitPerComponent[k] > mode_lib->vba.MaximumDSCBitsPerComponent) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2304  			mode_lib->vba.NonsupportedDSCInputBPC = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2305  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2306  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2307  
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  2308  	for (i = start_state; i < v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2309  		mode_lib->vba.ExceededMultistreamSlots[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2310  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2311  			if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2312  				TotalSlots = mode_lib->vba.RequiredSlots[i][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2313  				for (j = 0; j < mode_lib->vba.NumberOfActiveSurfaces; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2314  					if (mode_lib->vba.OutputMultistreamId[j] == k)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2315  						TotalSlots = TotalSlots + mode_lib->vba.RequiredSlots[i][j];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2316  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2317  				if (mode_lib->vba.Output[k] == dm_dp && TotalSlots > 63)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2318  					mode_lib->vba.ExceededMultistreamSlots[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2319  				if (mode_lib->vba.Output[k] == dm_dp2p0 && TotalSlots > 64)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2320  					mode_lib->vba.ExceededMultistreamSlots[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2321  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2322  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2323  		mode_lib->vba.LinkCapacitySupport[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2324  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2325  			if (mode_lib->vba.BlendingAndTiming[k] == k
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2326  				&& (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2327  					|| mode_lib->vba.Output[k] == dm_edp
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2328  					|| mode_lib->vba.Output[k] == dm_hdmi)
87f0c16e0eeb67 Alvin Lee                 2023-04-17  2329  				&& mode_lib->vba.OutputBppPerState[i][k] == 0 &&
87f0c16e0eeb67 Alvin Lee                 2023-04-17  2330  				(mode_lib->vba.UsesMALLForPStateChange[k] != dm_use_mall_pstate_change_phantom_pipe)) {
87f0c16e0eeb67 Alvin Lee                 2023-04-17  2331  				/* Phantom pipes don't consider DSC in DML, so it could fail link check.
87f0c16e0eeb67 Alvin Lee                 2023-04-17  2332  				 * However, we don't care about the link for phantom pipes.
87f0c16e0eeb67 Alvin Lee                 2023-04-17  2333  				 */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2334  				mode_lib->vba.LinkCapacitySupport[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2335  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2336  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2337  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2338  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2339  	mode_lib->vba.P2IWith420 = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2340  	mode_lib->vba.DSCOnlyIfNecessaryWithBPP = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2341  	mode_lib->vba.DSC422NativeNotSupported = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2342  	mode_lib->vba.LinkRateDoesNotMatchDPVersion = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2343  	mode_lib->vba.LinkRateForMultistreamNotIndicated = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2344  	mode_lib->vba.BPPForMultistreamNotIndicated = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2345  	mode_lib->vba.MultistreamWithHDMIOreDP = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2346  	mode_lib->vba.MSOOrODMSplitWithNonDPLink = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2347  	mode_lib->vba.NotEnoughLanesForMSO = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2348  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2349  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2350  		if (mode_lib->vba.BlendingAndTiming[k] == k
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2351  				&& (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2352  						|| mode_lib->vba.Output[k] == dm_edp
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2353  						|| mode_lib->vba.Output[k] == dm_hdmi)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2354  			if (mode_lib->vba.OutputFormat[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2355  					== dm_420 && mode_lib->vba.Interlace[k] == 1 &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2356  					mode_lib->vba.ProgressiveToInterlaceUnitInOPP == true)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2357  				mode_lib->vba.P2IWith420 = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2358  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2359  			if (mode_lib->vba.DSCEnable[k] && mode_lib->vba.ForcedOutputLinkBPP[k] != 0)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2360  				mode_lib->vba.DSCOnlyIfNecessaryWithBPP = true;
e26b51c79bac2b Deepak R Varma            2023-02-10  2361  			if (mode_lib->vba.DSCEnable[k] && mode_lib->vba.OutputFormat[k] == dm_n422
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2362  					&& !mode_lib->vba.DSC422NativeSupport)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2363  				mode_lib->vba.DSC422NativeNotSupported = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2364  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2365  			if (((mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_hbr
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2366  					|| mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_hbr2
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2367  					|| mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_hbr3)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2368  					&& mode_lib->vba.Output[k] != dm_dp && mode_lib->vba.Output[k] != dm_edp)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2369  					|| ((mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_uhbr10
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2370  							|| mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_uhbr13p5
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2371  							|| mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_uhbr20)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2372  							&& mode_lib->vba.Output[k] != dm_dp2p0))
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2373  				mode_lib->vba.LinkRateDoesNotMatchDPVersion = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2374  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2375  			if (mode_lib->vba.OutputMultistreamEn[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2376  				if (mode_lib->vba.OutputMultistreamId[k] == k
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2377  					&& mode_lib->vba.OutputLinkDPRate[k] == dm_dp_rate_na)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2378  					mode_lib->vba.LinkRateForMultistreamNotIndicated = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2379  				if (mode_lib->vba.OutputMultistreamId[k] == k && mode_lib->vba.ForcedOutputLinkBPP[k] == 0)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2380  					mode_lib->vba.BPPForMultistreamNotIndicated = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2381  				for (j = 0; j < mode_lib->vba.NumberOfActiveSurfaces; ++j) {
a3daede4757603 Rodrigo Siqueira          2022-09-22  2382  					if (mode_lib->vba.OutputMultistreamId[k] == j
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2383  						&& mode_lib->vba.ForcedOutputLinkBPP[k] == 0)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2384  						mode_lib->vba.BPPForMultistreamNotIndicated = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2385  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2386  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2387  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2388  			if ((mode_lib->vba.Output[k] == dm_edp || mode_lib->vba.Output[k] == dm_hdmi)) {
a3daede4757603 Rodrigo Siqueira          2022-09-22  2389  				if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == k)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2390  					mode_lib->vba.MultistreamWithHDMIOreDP = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2391  				for (j = 0; j < mode_lib->vba.NumberOfActiveSurfaces; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2392  					if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == j)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2393  						mode_lib->vba.MultistreamWithHDMIOreDP = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2394  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2395  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2396  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2397  			if (mode_lib->vba.Output[k] != dm_dp
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2398  					&& (mode_lib->vba.ODMUse[k] == dm_odm_split_policy_1to2
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2399  							|| mode_lib->vba.ODMUse[k] == dm_odm_mso_policy_1to2
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2400  							|| mode_lib->vba.ODMUse[k] == dm_odm_mso_policy_1to4))
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2401  				mode_lib->vba.MSOOrODMSplitWithNonDPLink = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2402  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2403  			if ((mode_lib->vba.ODMUse[k] == dm_odm_mso_policy_1to2
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2404  					&& mode_lib->vba.OutputLinkDPLanes[k] < 2)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2405  					|| (mode_lib->vba.ODMUse[k] == dm_odm_mso_policy_1to4
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2406  							&& mode_lib->vba.OutputLinkDPLanes[k] < 4))
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2407  				mode_lib->vba.NotEnoughLanesForMSO = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2408  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2409  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2410  
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  2411  	for (i = start_state; i < v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2412  		mode_lib->vba.DTBCLKRequiredMoreThanSupported[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2413  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2414  			if (mode_lib->vba.BlendingAndTiming[k] == k
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2415  					&& dml32_RequiredDTBCLK(mode_lib->vba.RequiresDSC[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2416  							mode_lib->vba.PixelClockBackEnd[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2417  							mode_lib->vba.OutputFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2418  							mode_lib->vba.OutputBppPerState[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2419  							mode_lib->vba.NumberOfDSCSlices[k], mode_lib->vba.HTotal[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2420  							mode_lib->vba.HActive[k], mode_lib->vba.AudioSampleRate[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2421  							mode_lib->vba.AudioSampleLayout[k])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2422  							> mode_lib->vba.DTBCLKPerState[i]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2423  				mode_lib->vba.DTBCLKRequiredMoreThanSupported[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2424  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2425  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2426  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2427  
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  2428  	for (i = start_state; i < v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2429  		mode_lib->vba.ODMCombine2To1SupportCheckOK[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2430  		mode_lib->vba.ODMCombine4To1SupportCheckOK[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2431  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2432  			if (mode_lib->vba.BlendingAndTiming[k] == k
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2433  					&& mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2434  					&& mode_lib->vba.Output[k] == dm_hdmi) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2435  				mode_lib->vba.ODMCombine2To1SupportCheckOK[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2436  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2437  			if (mode_lib->vba.BlendingAndTiming[k] == k
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2438  					&& mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2439  					&& (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_edp
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2440  							|| mode_lib->vba.Output[k] == dm_hdmi)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2441  				mode_lib->vba.ODMCombine4To1SupportCheckOK[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2442  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2443  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2444  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2445  
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  2446  	for (i = start_state; i < v->soc.num_states; i++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2447  		mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2448  		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2449  			if (mode_lib->vba.BlendingAndTiming[k] == k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2450  				if (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2451  						|| mode_lib->vba.Output[k] == dm_edp) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2452  					if (mode_lib->vba.OutputFormat[k] == dm_420) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2453  						mode_lib->vba.DSCFormatFactor = 2;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2454  					} else if (mode_lib->vba.OutputFormat[k] == dm_444) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2455  						mode_lib->vba.DSCFormatFactor = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2456  					} else if (mode_lib->vba.OutputFormat[k] == dm_n422) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2457  						mode_lib->vba.DSCFormatFactor = 2;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2458  					} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2459  						mode_lib->vba.DSCFormatFactor = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2460  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2461  					if (mode_lib->vba.RequiresDSC[i][k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2462  						if (mode_lib->vba.ODMCombineEnablePerState[i][k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2463  								== dm_odm_combine_mode_4to1) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2464  							if (mode_lib->vba.PixelClockBackEnd[k] / 12.0 / mode_lib->vba.DSCFormatFactor > (1.0 - mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) * mode_lib->vba.MaxDSCCLK[i])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2465  								mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2466  						} else if (mode_lib->vba.ODMCombineEnablePerState[i][k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2467  								== dm_odm_combine_mode_2to1) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2468  							if (mode_lib->vba.PixelClockBackEnd[k] / 6.0 / mode_lib->vba.DSCFormatFactor > (1.0 - mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) * mode_lib->vba.MaxDSCCLK[i])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2469  								mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2470  						} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2471  							if (mode_lib->vba.PixelClockBackEnd[k] / 3.0 / mode_lib->vba.DSCFormatFactor > (1.0 - mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) * mode_lib->vba.MaxDSCCLK[i])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2472  								mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2473  						}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2474  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2475  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2476  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2477  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2478  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2479  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2480  	/* Check DSC Unit and Slices Support */
7acc487ab57e07 Alex Deucher              2022-07-20  2481  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2482  
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  2483  	for (i = start_state; i < v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2484  		mode_lib->vba.NotEnoughDSCUnits[i] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2485  		mode_lib->vba.NotEnoughDSCSlices[i] = false;
7acc487ab57e07 Alex Deucher              2022-07-20  2486  		v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2487  		mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2488  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2489  			if (mode_lib->vba.RequiresDSC[i][k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2490  				if (mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2491  					if (mode_lib->vba.HActive[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2492  							> 4 * mode_lib->vba.MaximumPixelsPerLinePerDSCUnit)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2493  						mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i] = false;
7acc487ab57e07 Alex Deucher              2022-07-20  2494  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired + 4;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2495  					if (mode_lib->vba.NumberOfDSCSlices[k] > 16)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2496  						mode_lib->vba.NotEnoughDSCSlices[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2497  				} else if (mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2498  					if (mode_lib->vba.HActive[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2499  							> 2 * mode_lib->vba.MaximumPixelsPerLinePerDSCUnit)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2500  						mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i] = false;
7acc487ab57e07 Alex Deucher              2022-07-20  2501  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired + 2;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2502  					if (mode_lib->vba.NumberOfDSCSlices[k] > 8)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2503  						mode_lib->vba.NotEnoughDSCSlices[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2504  				} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2505  					if (mode_lib->vba.HActive[k] > mode_lib->vba.MaximumPixelsPerLinePerDSCUnit)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2506  						mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i] = false;
7acc487ab57e07 Alex Deucher              2022-07-20  2507  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2508  					if (mode_lib->vba.NumberOfDSCSlices[k] > 4)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2509  						mode_lib->vba.NotEnoughDSCSlices[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2510  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2511  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2512  		}
7acc487ab57e07 Alex Deucher              2022-07-20  2513  		if (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired > mode_lib->vba.NumberOfDSC)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2514  			mode_lib->vba.NotEnoughDSCUnits[i] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2515  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2516  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2517  	/*DSC Delay per state*/
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  2518  	for (i = start_state; i < v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2519  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2520  			mode_lib->vba.DSCDelayPerState[i][k] = dml32_DSCDelayRequirement(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2521  					mode_lib->vba.RequiresDSC[i][k], mode_lib->vba.ODMCombineEnablePerState[i][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2522  					mode_lib->vba.DSCInputBitPerComponent[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2523  					mode_lib->vba.OutputBppPerState[i][k], mode_lib->vba.HActive[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2524  					mode_lib->vba.HTotal[k], mode_lib->vba.NumberOfDSCSlices[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2525  					mode_lib->vba.OutputFormat[k], mode_lib->vba.Output[k],
f30508e918b401 George Shen               2022-10-14  2526  					mode_lib->vba.PixelClock[k], mode_lib->vba.PixelClockBackEnd[k],
f30508e918b401 George Shen               2022-10-14  2527  					mode_lib->vba.ip.dsc_delay_factor_wa);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2528  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2529  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2530  		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2531  			for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces - 1; m++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2532  				for (j = 0; j <= mode_lib->vba.NumberOfActiveSurfaces - 1; j++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2533  					if (mode_lib->vba.BlendingAndTiming[k] == m &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2534  							mode_lib->vba.RequiresDSC[i][m] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2535  						mode_lib->vba.DSCDelayPerState[i][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2536  							mode_lib->vba.DSCDelayPerState[i][m];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2537  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2538  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2539  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2540  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2541  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2542  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2543  	//Calculate Swath, DET Configuration, DCFCLKDeepSleep
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2544  	//
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  2545  	for (i = start_state; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2546  		for (j = 0; j <= 1; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2547  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2548  				mode_lib->vba.RequiredDPPCLKThisState[k] = mode_lib->vba.RequiredDPPCLK[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2549  				mode_lib->vba.NoOfDPPThisState[k] = mode_lib->vba.NoOfDPP[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2550  				mode_lib->vba.ODMCombineEnableThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2551  						mode_lib->vba.ODMCombineEnablePerState[i][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2552  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2553  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2554  			dml32_CalculateSwathAndDETConfiguration(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2555  					mode_lib->vba.DETSizeOverride,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2556  					mode_lib->vba.UsesMALLForPStateChange,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2557  					mode_lib->vba.ConfigReturnBufferSizeInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2558  					mode_lib->vba.MaxTotalDETInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2559  					mode_lib->vba.MinCompressedBufferSizeInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2560  					false, /* ForceSingleDPP */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2561  					mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2562  					mode_lib->vba.nomDETInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2563  					mode_lib->vba.UseUnboundedRequesting,
f4b4e41a2e0527 Jun Lei                   2022-06-24  2564  					mode_lib->vba.DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment,
f4b4e41a2e0527 Jun Lei                   2022-06-24  2565  					mode_lib->vba.ip.pixel_chunk_size_kbytes,
f4b4e41a2e0527 Jun Lei                   2022-06-24  2566  					mode_lib->vba.ip.rob_buffer_size_kbytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2567  					mode_lib->vba.CompressedBufferSegmentSizeInkByteFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2568  					mode_lib->vba.Output,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2569  					mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2570  					mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2571  					mode_lib->vba.MaximumSwathWidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2572  					mode_lib->vba.MaximumSwathWidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2573  					mode_lib->vba.SourceRotation,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2574  					mode_lib->vba.ViewportStationary,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2575  					mode_lib->vba.SourcePixelFormat,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2576  					mode_lib->vba.SurfaceTiling,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2577  					mode_lib->vba.ViewportWidth,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2578  					mode_lib->vba.ViewportHeight,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2579  					mode_lib->vba.ViewportXStartY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2580  					mode_lib->vba.ViewportYStartY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2581  					mode_lib->vba.ViewportXStartC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2582  					mode_lib->vba.ViewportYStartC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2583  					mode_lib->vba.SurfaceWidthY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2584  					mode_lib->vba.SurfaceWidthC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2585  					mode_lib->vba.SurfaceHeightY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2586  					mode_lib->vba.SurfaceHeightC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2587  					mode_lib->vba.Read256BlockHeightY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2588  					mode_lib->vba.Read256BlockHeightC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2589  					mode_lib->vba.Read256BlockWidthY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2590  					mode_lib->vba.Read256BlockWidthC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2591  					mode_lib->vba.ODMCombineEnableThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2592  					mode_lib->vba.BlendingAndTiming,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2593  					mode_lib->vba.BytePerPixelY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2594  					mode_lib->vba.BytePerPixelC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2595  					mode_lib->vba.BytePerPixelInDETY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2596  					mode_lib->vba.BytePerPixelInDETC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2597  					mode_lib->vba.HActive,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2598  					mode_lib->vba.HRatio,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2599  					mode_lib->vba.HRatioChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2600  					mode_lib->vba.NoOfDPPThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2601  					/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2602  					mode_lib->vba.swath_width_luma_ub_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2603  					mode_lib->vba.swath_width_chroma_ub_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2604  					mode_lib->vba.SwathWidthYThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2605  					mode_lib->vba.SwathWidthCThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2606  					mode_lib->vba.SwathHeightYThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2607  					mode_lib->vba.SwathHeightCThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2608  					mode_lib->vba.DETBufferSizeInKByteThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2609  					mode_lib->vba.DETBufferSizeYThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2610  					mode_lib->vba.DETBufferSizeCThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2611  					&mode_lib->vba.UnboundedRequestEnabledThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2612  					&mode_lib->vba.CompressedBufferSizeInkByteThisState,
7acc487ab57e07 Alex Deucher              2022-07-20  2613  					&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer[0], /* Long CompBufReservedSpaceKBytes */
7acc487ab57e07 Alex Deucher              2022-07-20  2614  					&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean[0], /* bool CompBufReservedSpaceNeedAdjustment */
01cf387b1c7f60 Alex Deucher              2022-06-22  2615  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2616  					&mode_lib->vba.ViewportSizeSupport[i][j]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2617  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2618  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2619  				mode_lib->vba.swath_width_luma_ub_all_states[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2620  						mode_lib->vba.swath_width_luma_ub_this_state[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2621  				mode_lib->vba.swath_width_chroma_ub_all_states[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2622  						mode_lib->vba.swath_width_chroma_ub_this_state[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2623  				mode_lib->vba.SwathWidthYAllStates[i][j][k] = mode_lib->vba.SwathWidthYThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2624  				mode_lib->vba.SwathWidthCAllStates[i][j][k] = mode_lib->vba.SwathWidthCThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2625  				mode_lib->vba.SwathHeightYAllStates[i][j][k] = mode_lib->vba.SwathHeightYThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2626  				mode_lib->vba.SwathHeightCAllStates[i][j][k] = mode_lib->vba.SwathHeightCThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2627  				mode_lib->vba.UnboundedRequestEnabledAllStates[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2628  						mode_lib->vba.UnboundedRequestEnabledThisState;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2629  				mode_lib->vba.CompressedBufferSizeInkByteAllStates[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2630  						mode_lib->vba.CompressedBufferSizeInkByteThisState;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2631  				mode_lib->vba.DETBufferSizeInKByteAllStates[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2632  						mode_lib->vba.DETBufferSizeInKByteThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2633  				mode_lib->vba.DETBufferSizeYAllStates[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2634  						mode_lib->vba.DETBufferSizeYThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2635  				mode_lib->vba.DETBufferSizeCAllStates[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2636  						mode_lib->vba.DETBufferSizeCThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2637  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2638  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2639  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2640  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2641  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2642  		mode_lib->vba.cursor_bw[k] = mode_lib->vba.NumberOfCursors[k] * mode_lib->vba.CursorWidth[k][0]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2643  				* mode_lib->vba.CursorBPP[k][0] / 8.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2644  				/ (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * mode_lib->vba.VRatio[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2645  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2646  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2647  	dml32_CalculateSurfaceSizeInMall(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2648  			mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2649  			mode_lib->vba.MALLAllocatedForDCNFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2650  			mode_lib->vba.UseMALLForStaticScreen,
a21005e4d2026e Dillon Varone             2022-12-08  2651  			mode_lib->vba.UsesMALLForPStateChange,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2652  			mode_lib->vba.DCCEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2653  			mode_lib->vba.ViewportStationary,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2654  			mode_lib->vba.ViewportXStartY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2655  			mode_lib->vba.ViewportYStartY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2656  			mode_lib->vba.ViewportXStartC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2657  			mode_lib->vba.ViewportYStartC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2658  			mode_lib->vba.ViewportWidth,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2659  			mode_lib->vba.ViewportHeight,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2660  			mode_lib->vba.BytePerPixelY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2661  			mode_lib->vba.ViewportWidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2662  			mode_lib->vba.ViewportHeightChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2663  			mode_lib->vba.BytePerPixelC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2664  			mode_lib->vba.SurfaceWidthY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2665  			mode_lib->vba.SurfaceWidthC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2666  			mode_lib->vba.SurfaceHeightY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2667  			mode_lib->vba.SurfaceHeightC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2668  			mode_lib->vba.Read256BlockWidthY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2669  			mode_lib->vba.Read256BlockWidthC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2670  			mode_lib->vba.Read256BlockHeightY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2671  			mode_lib->vba.Read256BlockHeightC,
827e3c9caa77d3 Aric Cyr                  2022-08-24  2672  			mode_lib->vba.MacroTileWidthY,
827e3c9caa77d3 Aric Cyr                  2022-08-24  2673  			mode_lib->vba.MacroTileWidthC,
827e3c9caa77d3 Aric Cyr                  2022-08-24  2674  			mode_lib->vba.MacroTileHeightY,
827e3c9caa77d3 Aric Cyr                  2022-08-24  2675  			mode_lib->vba.MacroTileHeightC,
95c454ca923bf6 Dillon Varone             2022-12-08  2676  			mode_lib->vba.DCCMetaPitchY,
95c454ca923bf6 Dillon Varone             2022-12-08  2677  			mode_lib->vba.DCCMetaPitchC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2678  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2679  			/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2680  			mode_lib->vba.SurfaceSizeInMALL,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2681  			&mode_lib->vba.ExceededMALLSize);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2682  
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  2683  	for (i = start_state; i < v->soc.num_states; i++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2684  		for (j = 0; j < 2; j++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2685  			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2686  				mode_lib->vba.swath_width_luma_ub_this_state[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2687  						mode_lib->vba.swath_width_luma_ub_all_states[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2688  				mode_lib->vba.swath_width_chroma_ub_this_state[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2689  						mode_lib->vba.swath_width_chroma_ub_all_states[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2690  				mode_lib->vba.SwathWidthYThisState[k] = mode_lib->vba.SwathWidthYAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2691  				mode_lib->vba.SwathWidthCThisState[k] = mode_lib->vba.SwathWidthCAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2692  				mode_lib->vba.SwathHeightYThisState[k] = mode_lib->vba.SwathHeightYAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2693  				mode_lib->vba.SwathHeightCThisState[k] = mode_lib->vba.SwathHeightCAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2694  				mode_lib->vba.DETBufferSizeInKByteThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2695  						mode_lib->vba.DETBufferSizeInKByteAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2696  				mode_lib->vba.DETBufferSizeYThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2697  						mode_lib->vba.DETBufferSizeYAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2698  				mode_lib->vba.DETBufferSizeCThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2699  						mode_lib->vba.DETBufferSizeCAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2700  				mode_lib->vba.RequiredDPPCLKThisState[k] = mode_lib->vba.RequiredDPPCLK[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2701  				mode_lib->vba.NoOfDPPThisState[k] = mode_lib->vba.NoOfDPP[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2702  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2703  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2704  			mode_lib->vba.TotalNumberOfDCCActiveDPP[i][j] = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2705  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2706  				if (mode_lib->vba.DCCEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2707  					mode_lib->vba.TotalNumberOfDCCActiveDPP[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2708  							mode_lib->vba.TotalNumberOfDCCActiveDPP[i][j]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2709  									+ mode_lib->vba.NoOfDPP[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2710  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2711  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2712  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2713  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2714  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2715  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].PixelClock = mode_lib->vba.PixelClock[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2716  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].DPPPerSurface = mode_lib->vba.NoOfDPP[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2717  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].SourceRotation = mode_lib->vba.SourceRotation[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2718  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportHeight = mode_lib->vba.ViewportHeight[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2719  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportHeightChroma = mode_lib->vba.ViewportHeightChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2720  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidth256BytesY = mode_lib->vba.Read256BlockWidthY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2721  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeight256BytesY = mode_lib->vba.Read256BlockHeightY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2722  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidth256BytesC = mode_lib->vba.Read256BlockWidthC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2723  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeight256BytesC = mode_lib->vba.Read256BlockHeightC[k];
827e3c9caa77d3 Aric Cyr                  2022-08-24  2724  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidthY = mode_lib->vba.MacroTileWidthY[k];
827e3c9caa77d3 Aric Cyr                  2022-08-24  2725  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeightY = mode_lib->vba.MacroTileHeightY[k];
827e3c9caa77d3 Aric Cyr                  2022-08-24  2726  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidthC = mode_lib->vba.MacroTileWidthC[k];
827e3c9caa77d3 Aric Cyr                  2022-08-24  2727  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeightC = mode_lib->vba.MacroTileHeightC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2728  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].InterlaceEnable = mode_lib->vba.Interlace[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2729  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].HTotal = mode_lib->vba.HTotal[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2730  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].DCCEnable = mode_lib->vba.DCCEnable[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2731  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2732  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].SurfaceTiling = mode_lib->vba.SurfaceTiling[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2733  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BytePerPixelY = mode_lib->vba.BytePerPixelY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2734  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BytePerPixelC = mode_lib->vba.BytePerPixelC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2735  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ProgressiveToInterlaceUnitInOPP =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2736  				mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2737  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].VRatio = mode_lib->vba.VRatio[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2738  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].VRatioChroma = mode_lib->vba.VRatioChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2739  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].VTaps = mode_lib->vba.vtaps[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2740  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].VTapsChroma = mode_lib->vba.VTAPsChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2741  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].PitchY = mode_lib->vba.PitchY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2742  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].DCCMetaPitchY = mode_lib->vba.DCCMetaPitchY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2743  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].PitchC = mode_lib->vba.PitchC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2744  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].DCCMetaPitchC = mode_lib->vba.DCCMetaPitchC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2745  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportStationary = mode_lib->vba.ViewportStationary[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2746  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportXStart = mode_lib->vba.ViewportXStartY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2747  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportYStart = mode_lib->vba.ViewportYStartY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2748  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportXStartC = mode_lib->vba.ViewportXStartC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2749  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].ViewportYStartC = mode_lib->vba.ViewportYStartC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2750  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].FORCE_ONE_ROW_FOR_FRAME = mode_lib->vba.ForceOneRowForFrame[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2751  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].SwathHeightY = mode_lib->vba.SwathHeightYThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2752  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].SwathHeightC = mode_lib->vba.SwathHeightCThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2753  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2754  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2755  			{
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2756  				dml32_CalculateVMRowAndSwath(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2757  						mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2758  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2759  						mode_lib->vba.SurfaceSizeInMALL,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2760  						mode_lib->vba.PTEBufferSizeInRequestsLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2761  						mode_lib->vba.PTEBufferSizeInRequestsChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2762  						mode_lib->vba.DCCMetaBufferSizeBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2763  						mode_lib->vba.UseMALLForStaticScreen,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2764  						mode_lib->vba.UsesMALLForPStateChange,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2765  						mode_lib->vba.MALLAllocatedForDCNFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2766  						mode_lib->vba.SwathWidthYThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2767  						mode_lib->vba.SwathWidthCThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2768  						mode_lib->vba.GPUVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2769  						mode_lib->vba.HostVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2770  						mode_lib->vba.HostVMMaxNonCachedPageTableLevels,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2771  						mode_lib->vba.GPUVMMaxPageTableLevels,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2772  						mode_lib->vba.GPUVMMinPageSizeKBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2773  						mode_lib->vba.HostVMMinPageSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2774  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2775  						/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2776  						mode_lib->vba.PTEBufferSizeNotExceededPerState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2777  						mode_lib->vba.DCCMetaBufferSizeNotExceededPerState,
01cf387b1c7f60 Alex Deucher              2022-06-22  2778  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0],
01cf387b1c7f60 Alex Deucher              2022-06-22  2779  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[1],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2780  						mode_lib->vba.dpte_row_height,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2781  						mode_lib->vba.dpte_row_height_chroma,
01cf387b1c7f60 Alex Deucher              2022-06-22  2782  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[2],
01cf387b1c7f60 Alex Deucher              2022-06-22  2783  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[3],
01cf387b1c7f60 Alex Deucher              2022-06-22  2784  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[4],
01cf387b1c7f60 Alex Deucher              2022-06-22  2785  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[5],
01cf387b1c7f60 Alex Deucher              2022-06-22  2786  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[6],
01cf387b1c7f60 Alex Deucher              2022-06-22  2787  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[7],
01cf387b1c7f60 Alex Deucher              2022-06-22  2788  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[8],
01cf387b1c7f60 Alex Deucher              2022-06-22  2789  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[9],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2790  						mode_lib->vba.meta_row_height,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2791  						mode_lib->vba.meta_row_height_chroma,
01cf387b1c7f60 Alex Deucher              2022-06-22  2792  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[10],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2793  						mode_lib->vba.dpte_group_bytes,
01cf387b1c7f60 Alex Deucher              2022-06-22  2794  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[11],
01cf387b1c7f60 Alex Deucher              2022-06-22  2795  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[12],
01cf387b1c7f60 Alex Deucher              2022-06-22  2796  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[13],
01cf387b1c7f60 Alex Deucher              2022-06-22  2797  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[14],
01cf387b1c7f60 Alex Deucher              2022-06-22  2798  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[15],
01cf387b1c7f60 Alex Deucher              2022-06-22  2799  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[16],
01cf387b1c7f60 Alex Deucher              2022-06-22  2800  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[17],
01cf387b1c7f60 Alex Deucher              2022-06-22  2801  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[18],
01cf387b1c7f60 Alex Deucher              2022-06-22  2802  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[19],
01cf387b1c7f60 Alex Deucher              2022-06-22  2803  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[20],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2804  						mode_lib->vba.PrefetchLinesYThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2805  						mode_lib->vba.PrefetchLinesCThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2806  						mode_lib->vba.PrefillY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2807  						mode_lib->vba.PrefillC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2808  						mode_lib->vba.MaxNumSwY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2809  						mode_lib->vba.MaxNumSwC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2810  						mode_lib->vba.meta_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2811  						mode_lib->vba.dpte_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2812  						mode_lib->vba.DPTEBytesPerRowThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2813  						mode_lib->vba.PDEAndMetaPTEBytesPerFrameThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2814  						mode_lib->vba.MetaRowBytesThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2815  						mode_lib->vba.use_one_row_for_frame_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2816  						mode_lib->vba.use_one_row_for_frame_flip_this_state,
01cf387b1c7f60 Alex Deucher              2022-06-22  2817  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0], // Boolean UsesMALLForStaticScreen[]
01cf387b1c7f60 Alex Deucher              2022-06-22  2818  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[1], // Boolean PTE_BUFFER_MODE[]
01cf387b1c7f60 Alex Deucher              2022-06-22  2819  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[21]); // Long BIGK_FRAGMENT_SIZE[]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2820  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2821  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2822  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2823  				mode_lib->vba.PrefetchLinesY[i][j][k] = mode_lib->vba.PrefetchLinesYThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2824  				mode_lib->vba.PrefetchLinesC[i][j][k] = mode_lib->vba.PrefetchLinesCThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2825  				mode_lib->vba.meta_row_bandwidth[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2826  						mode_lib->vba.meta_row_bandwidth_this_state[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2827  				mode_lib->vba.dpte_row_bandwidth[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2828  						mode_lib->vba.dpte_row_bandwidth_this_state[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2829  				mode_lib->vba.DPTEBytesPerRow[i][j][k] = mode_lib->vba.DPTEBytesPerRowThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2830  				mode_lib->vba.PDEAndMetaPTEBytesPerFrame[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2831  						mode_lib->vba.PDEAndMetaPTEBytesPerFrameThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2832  				mode_lib->vba.MetaRowBytes[i][j][k] = mode_lib->vba.MetaRowBytesThisState[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2833  				mode_lib->vba.use_one_row_for_frame[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2834  						mode_lib->vba.use_one_row_for_frame_this_state[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2835  				mode_lib->vba.use_one_row_for_frame_flip[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2836  						mode_lib->vba.use_one_row_for_frame_flip_this_state[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2837  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2838  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2839  			mode_lib->vba.PTEBufferSizeNotExceeded[i][j] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2840  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2841  				if (mode_lib->vba.PTEBufferSizeNotExceededPerState[k] == false)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2842  					mode_lib->vba.PTEBufferSizeNotExceeded[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2843  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2844  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2845  			mode_lib->vba.DCCMetaBufferSizeNotExceeded[i][j] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2846  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2847  				if (mode_lib->vba.DCCMetaBufferSizeNotExceededPerState[k] == false)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2848  					mode_lib->vba.DCCMetaBufferSizeNotExceeded[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2849  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2850  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2851  			mode_lib->vba.UrgLatency[i] = dml32_CalculateUrgentLatency(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2852  					mode_lib->vba.UrgentLatencyPixelDataOnly,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2853  					mode_lib->vba.UrgentLatencyPixelMixedWithVMData,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2854  					mode_lib->vba.UrgentLatencyVMDataOnly, mode_lib->vba.DoUrgentLatencyAdjustment,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2855  					mode_lib->vba.UrgentLatencyAdjustmentFabricClockComponent,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2856  					mode_lib->vba.UrgentLatencyAdjustmentFabricClockReference,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2857  					mode_lib->vba.FabricClockPerState[i]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2858  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2859  			//bool   NotUrgentLatencyHiding[DC__NUM_DPP__MAX];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2860  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2861  				dml32_CalculateUrgentBurstFactor(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2862  						mode_lib->vba.UsesMALLForPStateChange[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2863  						mode_lib->vba.swath_width_luma_ub_this_state[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2864  						mode_lib->vba.swath_width_chroma_ub_this_state[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2865  						mode_lib->vba.SwathHeightYThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2866  						mode_lib->vba.SwathHeightCThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2867  						(double) mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2868  						mode_lib->vba.UrgLatency[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2869  						mode_lib->vba.CursorBufferSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2870  						mode_lib->vba.CursorWidth[k][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2871  						mode_lib->vba.CursorBPP[k][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2872  						mode_lib->vba.VRatio[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2873  						mode_lib->vba.VRatioChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2874  						mode_lib->vba.BytePerPixelInDETY[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2875  						mode_lib->vba.BytePerPixelInDETC[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2876  						mode_lib->vba.DETBufferSizeYThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2877  						mode_lib->vba.DETBufferSizeCThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2878  						/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2879  						&mode_lib->vba.UrgentBurstFactorCursor[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2880  						&mode_lib->vba.UrgentBurstFactorLuma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2881  						&mode_lib->vba.UrgentBurstFactorChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2882  						&mode_lib->vba.NoUrgentLatencyHiding[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2883  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2884  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2885  			dml32_CalculateDCFCLKDeepSleep(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2886  					mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2887  					mode_lib->vba.BytePerPixelY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2888  					mode_lib->vba.BytePerPixelC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2889  					mode_lib->vba.VRatio,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2890  					mode_lib->vba.VRatioChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2891  					mode_lib->vba.SwathWidthYThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2892  					mode_lib->vba.SwathWidthCThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2893  					mode_lib->vba.NoOfDPPThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2894  					mode_lib->vba.HRatio,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2895  					mode_lib->vba.HRatioChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2896  					mode_lib->vba.PixelClock,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2897  					mode_lib->vba.PSCL_FACTOR,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2898  					mode_lib->vba.PSCL_FACTOR_CHROMA,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2899  					mode_lib->vba.RequiredDPPCLKThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2900  					mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2901  					mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2902  					mode_lib->vba.ReturnBusWidth,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2903  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2904  					/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2905  					&mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2906  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2907  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2908  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2909  	//Calculate Return BW
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  2910  	for (i = start_state; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2911  		for (j = 0; j <= 1; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2912  			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2913  				if (mode_lib->vba.BlendingAndTiming[k] == k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2914  					if (mode_lib->vba.WritebackEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2915  						mode_lib->vba.WritebackDelayTime[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2916  							mode_lib->vba.WritebackLatency
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2917  						+ dml32_CalculateWriteBackDelay(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2918  							mode_lib->vba.WritebackPixelFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2919  							mode_lib->vba.WritebackHRatio[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2920  							mode_lib->vba.WritebackVRatio[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2921  							mode_lib->vba.WritebackVTaps[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2922  							mode_lib->vba.WritebackDestinationWidth[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2923  							mode_lib->vba.WritebackDestinationHeight[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2924  							mode_lib->vba.WritebackSourceHeight[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2925  							mode_lib->vba.HTotal[k])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2926  							/ mode_lib->vba.RequiredDISPCLK[i][j];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2927  					} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2928  						mode_lib->vba.WritebackDelayTime[k] = 0.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2929  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2930  					for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces - 1; m++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2931  						if (mode_lib->vba.BlendingAndTiming[m]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2932  								== k && mode_lib->vba.WritebackEnable[m] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2933  							mode_lib->vba.WritebackDelayTime[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2934  								dml_max(mode_lib->vba.WritebackDelayTime[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2935  									mode_lib->vba.WritebackLatency
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2936  								+ dml32_CalculateWriteBackDelay(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2937  									mode_lib->vba.WritebackPixelFormat[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2938  									mode_lib->vba.WritebackHRatio[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2939  									mode_lib->vba.WritebackVRatio[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2940  									mode_lib->vba.WritebackVTaps[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2941  									mode_lib->vba.WritebackDestinationWidth[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2942  									mode_lib->vba.WritebackDestinationHeight[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2943  									mode_lib->vba.WritebackSourceHeight[m],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2944  									mode_lib->vba.HTotal[m]) /
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2945  									mode_lib->vba.RequiredDISPCLK[i][j]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2946  						}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2947  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2948  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2949  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2950  			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2951  				for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces - 1; m++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2952  					if (mode_lib->vba.BlendingAndTiming[k] == m) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2953  						mode_lib->vba.WritebackDelayTime[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2954  								mode_lib->vba.WritebackDelayTime[m];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2955  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2956  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2957  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2958  			mode_lib->vba.MaxMaxVStartup[i][j] = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2959  			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2960  				mode_lib->vba.MaximumVStartup[i][j][k] = ((mode_lib->vba.Interlace[k] &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2961  								!mode_lib->vba.ProgressiveToInterlaceUnitInOPP) ?
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2962  								dml_floor((mode_lib->vba.VTotal[k] -
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2963  									mode_lib->vba.VActive[k]) / 2.0, 1.0) :
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2964  								mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k])
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2965  								- dml_max(1.0, dml_ceil(1.0 *
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2966  									mode_lib->vba.WritebackDelayTime[k] /
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2967  									(mode_lib->vba.HTotal[k] /
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2968  									mode_lib->vba.PixelClock[k]), 1.0));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2969  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2970  				// Clamp to max OTG vstartup register limit
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2971  				if (mode_lib->vba.MaximumVStartup[i][j][k] > 1023)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2972  					mode_lib->vba.MaximumVStartup[i][j][k] = 1023;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2973  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2974  				mode_lib->vba.MaxMaxVStartup[i][j] = dml_max(mode_lib->vba.MaxMaxVStartup[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2975  						mode_lib->vba.MaximumVStartup[i][j][k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2976  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2977  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2978  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2979  
7acc487ab57e07 Alex Deucher              2022-07-20  2980  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ReorderingBytes = mode_lib->vba.NumberOfChannels
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2981  			* dml_max3(mode_lib->vba.UrgentOutOfOrderReturnPerChannelPixelDataOnly,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2982  					mode_lib->vba.UrgentOutOfOrderReturnPerChannelPixelMixedWithVMData,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2983  					mode_lib->vba.UrgentOutOfOrderReturnPerChannelVMDataOnly);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2984  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2985  	dml32_CalculateMinAndMaxPrefetchMode(mode_lib->vba.AllowForPStateChangeOrStutterInVBlankFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2986  			&mode_lib->vba.MinPrefetchMode,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2987  			&mode_lib->vba.MaxPrefetchMode);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2988  
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  2989  	for (i = start_state; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2990  		for (j = 0; j <= 1; ++j)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2991  			mode_lib->vba.DCFCLKState[i][j] = mode_lib->vba.DCFCLKPerState[i];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2992  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2993  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2994  	/* Immediate Flip and MALL parameters */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2995  	mode_lib->vba.ImmediateFlipRequiredFinal = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2996  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2997  		mode_lib->vba.ImmediateFlipRequiredFinal = mode_lib->vba.ImmediateFlipRequiredFinal
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2998  				|| (mode_lib->vba.ImmediateFlipRequirement[k] == dm_immediate_flip_required);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  2999  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3000  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3001  	mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3002  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3003  		mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3004  				mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3005  						|| ((mode_lib->vba.ImmediateFlipRequirement[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3006  								!= dm_immediate_flip_required)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3007  								&& (mode_lib->vba.ImmediateFlipRequirement[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3008  										!= dm_immediate_flip_not_required));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3009  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3010  	mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3011  			mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3012  					&& mode_lib->vba.ImmediateFlipRequiredFinal;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3013  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3014  	mode_lib->vba.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3015  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3016  		mode_lib->vba.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3017  			mode_lib->vba.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe ||
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3018  			((mode_lib->vba.HostVMEnable == true || mode_lib->vba.ImmediateFlipRequirement[k] !=
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3019  					dm_immediate_flip_not_required) &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3020  			(mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_full_frame ||
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3021  			mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_phantom_pipe));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3022  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3023  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3024  	mode_lib->vba.InvalidCombinationOfMALLUseForPStateAndStaticScreen = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3025  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3026  		mode_lib->vba.InvalidCombinationOfMALLUseForPStateAndStaticScreen =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3027  			mode_lib->vba.InvalidCombinationOfMALLUseForPStateAndStaticScreen
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3028  			|| ((mode_lib->vba.UseMALLForStaticScreen[k] == dm_use_mall_static_screen_enable
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3029  			|| mode_lib->vba.UseMALLForStaticScreen[k] == dm_use_mall_static_screen_optimize)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3030  			&& (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_phantom_pipe))
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3031  			|| ((mode_lib->vba.UseMALLForStaticScreen[k] == dm_use_mall_static_screen_disable
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3032  			|| mode_lib->vba.UseMALLForStaticScreen[k] == dm_use_mall_static_screen_optimize)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3033  			&& (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_full_frame));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3034  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3035  
7acc487ab57e07 Alex Deucher              2022-07-20  3036  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.FullFrameMALLPStateMethod = false;
7acc487ab57e07 Alex Deucher              2022-07-20  3037  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SubViewportMALLPStateMethod = false;
7acc487ab57e07 Alex Deucher              2022-07-20  3038  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.PhantomPipeMALLPStateMethod = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3039  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3040  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3041  		if (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_full_frame)
7acc487ab57e07 Alex Deucher              2022-07-20  3042  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.FullFrameMALLPStateMethod = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3043  		if (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_sub_viewport)
7acc487ab57e07 Alex Deucher              2022-07-20  3044  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SubViewportMALLPStateMethod = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3045  		if (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_phantom_pipe)
7acc487ab57e07 Alex Deucher              2022-07-20  3046  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.PhantomPipeMALLPStateMethod = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3047  	}
7acc487ab57e07 Alex Deucher              2022-07-20  3048  	mode_lib->vba.InvalidCombinationOfMALLUseForPState = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SubViewportMALLPStateMethod
7acc487ab57e07 Alex Deucher              2022-07-20  3049  			!= v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.PhantomPipeMALLPStateMethod) || (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SubViewportMALLPStateMethod && v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.FullFrameMALLPStateMethod);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3050  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3051  	if (mode_lib->vba.UseMinimumRequiredDCFCLK == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3052  		dml32_UseMinimumDCFCLK(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3053  				mode_lib->vba.UsesMALLForPStateChange,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3054  				mode_lib->vba.DRRDisplay,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3055  				mode_lib->vba.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3056  				mode_lib->vba.MaxInterDCNTileRepeaters,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3057  				mode_lib->vba.MaxPrefetchMode,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3058  				mode_lib->vba.DRAMClockChangeLatency,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3059  				mode_lib->vba.FCLKChangeLatency,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3060  				mode_lib->vba.SREnterPlusExitTime,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3061  				mode_lib->vba.ReturnBusWidth,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3062  				mode_lib->vba.RoundTripPingLatencyCycles,
7acc487ab57e07 Alex Deucher              2022-07-20  3063  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ReorderingBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3064  				mode_lib->vba.PixelChunkSizeInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3065  				mode_lib->vba.MetaChunkSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3066  				mode_lib->vba.GPUVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3067  				mode_lib->vba.GPUVMMaxPageTableLevels,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3068  				mode_lib->vba.HostVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3069  				mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3070  				mode_lib->vba.HostVMMinPageSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3071  				mode_lib->vba.HostVMMaxNonCachedPageTableLevels,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3072  				mode_lib->vba.DynamicMetadataVMEnabled,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3073  				mode_lib->vba.ImmediateFlipRequiredFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3074  				mode_lib->vba.ProgressiveToInterlaceUnitInOPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3075  				mode_lib->vba.MaxAveragePercentOfIdealSDPPortBWDisplayCanUseInNormalSystemOperation,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3076  				mode_lib->vba.PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3077  				mode_lib->vba.VTotal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3078  				mode_lib->vba.VActive,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3079  				mode_lib->vba.DynamicMetadataTransmittedBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3080  				mode_lib->vba.DynamicMetadataLinesBeforeActiveRequired,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3081  				mode_lib->vba.Interlace,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3082  				mode_lib->vba.RequiredDPPCLK,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3083  				mode_lib->vba.RequiredDISPCLK,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3084  				mode_lib->vba.UrgLatency,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3085  				mode_lib->vba.NoOfDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3086  				mode_lib->vba.ProjectedDCFCLKDeepSleep,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3087  				mode_lib->vba.MaximumVStartup,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3088  				mode_lib->vba.TotalNumberOfActiveDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3089  				mode_lib->vba.TotalNumberOfDCCActiveDPP,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3090  				mode_lib->vba.dpte_group_bytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3091  				mode_lib->vba.PrefetchLinesY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3092  				mode_lib->vba.PrefetchLinesC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3093  				mode_lib->vba.swath_width_luma_ub_all_states,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3094  				mode_lib->vba.swath_width_chroma_ub_all_states,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3095  				mode_lib->vba.BytePerPixelY,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3096  				mode_lib->vba.BytePerPixelC,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3097  				mode_lib->vba.HTotal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3098  				mode_lib->vba.PixelClock,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3099  				mode_lib->vba.PDEAndMetaPTEBytesPerFrame,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3100  				mode_lib->vba.DPTEBytesPerRow,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3101  				mode_lib->vba.MetaRowBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3102  				mode_lib->vba.DynamicMetadataEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3103  				mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3104  				mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3105  				mode_lib->vba.DCFCLKPerState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3106  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3107  				/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3108  				mode_lib->vba.DCFCLKState);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3109  	} // UseMinimumRequiredDCFCLK == true
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3110  
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  3111  	for (i = start_state; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3112  		for (j = 0; j <= 1; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3113  			mode_lib->vba.ReturnBWPerState[i][j] = dml32_get_return_bw_mbps(&mode_lib->vba.soc, i,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3114  					mode_lib->vba.HostVMEnable, mode_lib->vba.DCFCLKState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3115  					mode_lib->vba.FabricClockPerState[i], mode_lib->vba.DRAMSpeedPerState[i]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3116  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3117  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3118  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3119  	//Re-ordering Buffer Support Check
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  3120  	for (i = start_state; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3121  		for (j = 0; j <= 1; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3122  			if ((mode_lib->vba.ROBBufferSizeInKByte - mode_lib->vba.PixelChunkSizeInKByte) * 1024
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3123  					/ mode_lib->vba.ReturnBWPerState[i][j]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3124  					> (mode_lib->vba.RoundTripPingLatencyCycles + 32)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3125  							/ mode_lib->vba.DCFCLKState[i][j]
7acc487ab57e07 Alex Deucher              2022-07-20  3126  							+ v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ReorderingBytes / mode_lib->vba.ReturnBWPerState[i][j]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3127  				mode_lib->vba.ROBSupport[i][j] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3128  			} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3129  				mode_lib->vba.ROBSupport[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3130  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3131  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3132  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3133  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3134  	//Vertical Active BW support check
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3135  	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaxTotalVActiveRDBandwidth = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3136  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3137  	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3138  		v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaxTotalVActiveRDBandwidth += mode_lib->vba.ReadBandwidthLuma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3139  				+ mode_lib->vba.ReadBandwidthChroma[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3140  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3141  
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  3142  	for (i = start_state; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3143  		for (j = 0; j <= 1; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3144  			mode_lib->vba.MaxTotalVerticalActiveAvailableBandwidth[i][j] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3145  				dml_min3(mode_lib->vba.ReturnBusWidth * mode_lib->vba.DCFCLKState[i][j]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3146  					* mode_lib->vba.MaxAveragePercentOfIdealSDPPortBWDisplayCanUseInNormalSystemOperation / 100,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3147  					mode_lib->vba.FabricClockPerState[i]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3148  					* mode_lib->vba.FabricDatapathToDCNDataReturn
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3149  					* mode_lib->vba.MaxAveragePercentOfIdealFabricBWDisplayCanUseInNormalSystemOperation / 100,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3150  					mode_lib->vba.DRAMSpeedPerState[i]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3151  					* mode_lib->vba.NumberOfChannels
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3152  					* mode_lib->vba.DRAMChannelWidth
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3153  					* (i < 2 ? mode_lib->vba.MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperationSTROBE : mode_lib->vba.MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperation) / 100);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3154  
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3155  			if (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaxTotalVActiveRDBandwidth
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3156  					<= mode_lib->vba.MaxTotalVerticalActiveAvailableBandwidth[i][j]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3157  				mode_lib->vba.TotalVerticalActiveBandwidthSupport[i][j] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3158  			} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3159  				mode_lib->vba.TotalVerticalActiveBandwidthSupport[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3160  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3161  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3162  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3163  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3164  	/* Prefetch Check */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3165  
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  3166  	for (i = start_state; i < (int) v->soc.num_states; ++i) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3167  		for (j = 0; j <= 1; ++j) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3168  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3169  			mode_lib->vba.TimeCalc = 24 / mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3170  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3171  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3172  				mode_lib->vba.NoOfDPPThisState[k] = mode_lib->vba.NoOfDPP[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3173  				mode_lib->vba.swath_width_luma_ub_this_state[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3174  						mode_lib->vba.swath_width_luma_ub_all_states[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3175  				mode_lib->vba.swath_width_chroma_ub_this_state[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3176  						mode_lib->vba.swath_width_chroma_ub_all_states[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3177  				mode_lib->vba.SwathWidthYThisState[k] = mode_lib->vba.SwathWidthYAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3178  				mode_lib->vba.SwathWidthCThisState[k] = mode_lib->vba.SwathWidthCAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3179  				mode_lib->vba.SwathHeightYThisState[k] = mode_lib->vba.SwathHeightYAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3180  				mode_lib->vba.SwathHeightCThisState[k] = mode_lib->vba.SwathHeightCAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3181  				mode_lib->vba.UnboundedRequestEnabledThisState =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3182  						mode_lib->vba.UnboundedRequestEnabledAllStates[i][j];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3183  				mode_lib->vba.CompressedBufferSizeInkByteThisState =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3184  						mode_lib->vba.CompressedBufferSizeInkByteAllStates[i][j];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3185  				mode_lib->vba.DETBufferSizeInKByteThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3186  						mode_lib->vba.DETBufferSizeInKByteAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3187  				mode_lib->vba.DETBufferSizeYThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3188  						mode_lib->vba.DETBufferSizeYAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3189  				mode_lib->vba.DETBufferSizeCThisState[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3190  						mode_lib->vba.DETBufferSizeCAllStates[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3191  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3192  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3193  			mode_lib->vba.VActiveBandwithSupport[i][j] = dml32_CalculateVActiveBandwithSupport(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3194  					mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3195  					mode_lib->vba.ReturnBWPerState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3196  					mode_lib->vba.NoUrgentLatencyHiding,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3197  					mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3198  					mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3199  					mode_lib->vba.cursor_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3200  					mode_lib->vba.meta_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3201  					mode_lib->vba.dpte_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3202  					mode_lib->vba.NoOfDPPThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3203  					mode_lib->vba.UrgentBurstFactorLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3204  					mode_lib->vba.UrgentBurstFactorChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3205  					mode_lib->vba.UrgentBurstFactorCursor);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3206  
6d4727c80947de Dillon Varone             2022-11-08  3207  			mode_lib->vba.NotEnoughDETSwathFillLatencyHidingPerState[i][j] = dml32_CalculateDETSwathFillLatencyHiding(
6d4727c80947de Dillon Varone             2022-11-08  3208  					mode_lib->vba.NumberOfActiveSurfaces,
6d4727c80947de Dillon Varone             2022-11-08  3209  					mode_lib->vba.ReturnBWPerState[i][j],
6d4727c80947de Dillon Varone             2022-11-08  3210  					mode_lib->vba.UrgLatency[i],
6d4727c80947de Dillon Varone             2022-11-08  3211  					mode_lib->vba.SwathHeightYThisState,
6d4727c80947de Dillon Varone             2022-11-08  3212  					mode_lib->vba.SwathHeightCThisState,
6d4727c80947de Dillon Varone             2022-11-08  3213  					mode_lib->vba.swath_width_luma_ub_this_state,
6d4727c80947de Dillon Varone             2022-11-08  3214  					mode_lib->vba.swath_width_chroma_ub_this_state,
6d4727c80947de Dillon Varone             2022-11-08  3215  					mode_lib->vba.BytePerPixelInDETY,
6d4727c80947de Dillon Varone             2022-11-08  3216  					mode_lib->vba.BytePerPixelInDETC,
6d4727c80947de Dillon Varone             2022-11-08  3217  					mode_lib->vba.DETBufferSizeYThisState,
6d4727c80947de Dillon Varone             2022-11-08  3218  					mode_lib->vba.DETBufferSizeCThisState,
6d4727c80947de Dillon Varone             2022-11-08  3219  					mode_lib->vba.NoOfDPPThisState,
6d4727c80947de Dillon Varone             2022-11-08  3220  					mode_lib->vba.HTotal,
6d4727c80947de Dillon Varone             2022-11-08  3221  					mode_lib->vba.PixelClock,
6d4727c80947de Dillon Varone             2022-11-08  3222  					mode_lib->vba.VRatio,
6d4727c80947de Dillon Varone             2022-11-08  3223  					mode_lib->vba.VRatioChroma,
de930140bb578e Alvin Lee                 2023-02-24  3224  					mode_lib->vba.UsesMALLForPStateChange,
de930140bb578e Alvin Lee                 2023-02-24  3225  					mode_lib->vba.UseUnboundedRequesting);
6d4727c80947de Dillon Varone             2022-11-08  3226  
7acc487ab57e07 Alex Deucher              2022-07-20  3227  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.VMDataOnlyReturnBWPerState = dml32_get_return_bw_mbps_vm_only(&mode_lib->vba.soc, i,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3228  					mode_lib->vba.DCFCLKState[i][j], mode_lib->vba.FabricClockPerState[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3229  					mode_lib->vba.DRAMSpeedPerState[i]);
7acc487ab57e07 Alex Deucher              2022-07-20  3230  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3231  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3232  			if (mode_lib->vba.GPUVMEnable && mode_lib->vba.HostVMEnable)
7acc487ab57e07 Alex Deucher              2022-07-20  3233  				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor = mode_lib->vba.ReturnBWPerState[i][j]
7acc487ab57e07 Alex Deucher              2022-07-20  3234  						/ v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.VMDataOnlyReturnBWPerState;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3235  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3236  			mode_lib->vba.ExtraLatency = dml32_CalculateExtraLatency(
7acc487ab57e07 Alex Deucher              2022-07-20  3237  					mode_lib->vba.RoundTripPingLatencyCycles, v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ReorderingBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3238  					mode_lib->vba.DCFCLKState[i][j], mode_lib->vba.TotalNumberOfActiveDPP[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3239  					mode_lib->vba.PixelChunkSizeInKByte,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3240  					mode_lib->vba.TotalNumberOfDCCActiveDPP[i][j], mode_lib->vba.MetaChunkSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3241  					mode_lib->vba.ReturnBWPerState[i][j], mode_lib->vba.GPUVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3242  					mode_lib->vba.HostVMEnable, mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3243  					mode_lib->vba.NoOfDPPThisState, mode_lib->vba.dpte_group_bytes,
7acc487ab57e07 Alex Deucher              2022-07-20  3244  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor, mode_lib->vba.HostVMMinPageSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3245  					mode_lib->vba.HostVMMaxNonCachedPageTableLevels);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3246  
7acc487ab57e07 Alex Deucher              2022-07-20  3247  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState = mode_lib->vba.MinPrefetchMode;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3248  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3249  			mode_lib->vba.NextMaxVStartup = mode_lib->vba.MaxMaxVStartup[i][j];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3250  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3251  			do {
7acc487ab57e07 Alex Deucher              2022-07-20  3252  				mode_lib->vba.PrefetchModePerState[i][j] = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3253  				mode_lib->vba.MaxVStartup = mode_lib->vba.NextMaxVStartup;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3254  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3255  				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3256  					mode_lib->vba.TWait = dml32_CalculateTWait(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3257  							mode_lib->vba.PrefetchModePerState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3258  							mode_lib->vba.UsesMALLForPStateChange[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3259  							mode_lib->vba.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3260  							mode_lib->vba.DRRDisplay[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3261  							mode_lib->vba.DRAMClockChangeLatency,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3262  							mode_lib->vba.FCLKChangeLatency, mode_lib->vba.UrgLatency[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3263  							mode_lib->vba.SREnterPlusExitTime);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3264  
a1b6667ef90b38 Aurabindo Pillai          2022-10-20  3265  					memset(&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull, 0, sizeof(DmlPipe));
7acc487ab57e07 Alex Deucher              2022-07-20  3266  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.Dppclk = mode_lib->vba.RequiredDPPCLK[i][j][k];
7acc487ab57e07 Alex Deucher              2022-07-20  3267  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.Dispclk = mode_lib->vba.RequiredDISPCLK[i][j];
7acc487ab57e07 Alex Deucher              2022-07-20  3268  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.PixelClock = mode_lib->vba.PixelClock[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3269  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DCFClkDeepSleep = mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
7acc487ab57e07 Alex Deucher              2022-07-20  3270  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DPPPerSurface = mode_lib->vba.NoOfDPP[i][j][k];
7acc487ab57e07 Alex Deucher              2022-07-20  3271  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3272  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3273  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockWidth256BytesY = mode_lib->vba.Read256BlockWidthY[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3274  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockHeight256BytesY = mode_lib->vba.Read256BlockHeightY[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3275  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockWidth256BytesC = mode_lib->vba.Read256BlockWidthC[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3276  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockHeight256BytesC = mode_lib->vba.Read256BlockHeightC[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3277  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3278  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3279  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3280  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.HTotal = mode_lib->vba.HTotal[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3281  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.HActive = mode_lib->vba.HActive[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3282  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3283  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ODMMode = mode_lib->vba.ODMCombineEnablePerState[i][k];
7acc487ab57e07 Alex Deucher              2022-07-20  3284  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3285  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BytePerPixelY = mode_lib->vba.BytePerPixelY[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3286  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BytePerPixelC = mode_lib->vba.BytePerPixelC[k];
7acc487ab57e07 Alex Deucher              2022-07-20  3287  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ProgressiveToInterlaceUnitInOPP =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3288  							mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3289  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3290  					mode_lib->vba.NoTimeForPrefetch[i][j][k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3291  						dml32_CalculatePrefetchSchedule(
3b4e83a232244e Nathan Chancellor         2022-08-30  3292  							v,
3b4e83a232244e Nathan Chancellor         2022-08-30  3293  							k,
7acc487ab57e07 Alex Deucher              2022-07-20  3294  							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor,
7acc487ab57e07 Alex Deucher              2022-07-20  3295  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe,
3b4e83a232244e Nathan Chancellor         2022-08-30  3296  							v->DSCDelayPerState[i][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3297  							v->SwathWidthYThisState[k] / v->HRatio[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3298  							dml_min(v->MaxVStartup, v->MaximumVStartup[i][j][k]),
3b4e83a232244e Nathan Chancellor         2022-08-30  3299  							v->MaximumVStartup[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3300  							v->UrgLatency[i],
3b4e83a232244e Nathan Chancellor         2022-08-30  3301  							v->ExtraLatency,
3b4e83a232244e Nathan Chancellor         2022-08-30  3302  							v->TimeCalc,
3b4e83a232244e Nathan Chancellor         2022-08-30  3303  							v->PDEAndMetaPTEBytesPerFrame[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3304  							v->MetaRowBytes[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3305  							v->DPTEBytesPerRow[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3306  							v->PrefetchLinesY[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3307  							v->SwathWidthYThisState[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3308  							v->PrefillY[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3309  							v->MaxNumSwY[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3310  							v->PrefetchLinesC[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3311  							v->SwathWidthCThisState[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3312  							v->PrefillC[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3313  							v->MaxNumSwC[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3314  							v->swath_width_luma_ub_this_state[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3315  							v->swath_width_chroma_ub_this_state[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3316  							v->SwathHeightYThisState[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3317  							v->SwathHeightCThisState[k], v->TWait,
7e60ab4eb3e4ba Alvin Lee                 2023-05-11  3318  							(v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ || v->DCFCLKState[i][j] <= DCFCLK_FREQ_EXTRA_PREFETCH_REQ_MHZ) ?
01c0c124b9ecaa Dillon Varone             2022-10-27  3319  									mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3320  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3321  							/* Output */
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3322  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTXAfterScaler[k],
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3323  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTYAfterScaler[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3324  							&v->LineTimesForPrefetch[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3325  							&v->PrefetchBW[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3326  							&v->LinesForMetaPTE[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3327  							&v->LinesForMetaAndDPTERow[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3328  							&v->VRatioPreY[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3329  							&v->VRatioPreC[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3330  							&v->RequiredPrefetchPixelDataBWLuma[0][0][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3331  							&v->RequiredPrefetchPixelDataBWChroma[0][0][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3332  							&v->NoTimeForDynamicMetadata[i][j][k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3333  							&v->Tno_bw[k],
3b4e83a232244e Nathan Chancellor         2022-08-30  3334  							&v->prefetch_vmrow_bw[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3335  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0],         // double *Tdmdl_vm
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3336  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1],         // double *Tdmdl
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3337  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[2],         // double *TSetup
7acc487ab57e07 Alex Deucher              2022-07-20  3338  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer[0],         							    // unsigned int   *VUpdateOffsetPix
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3339  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[3],         // unsigned int   *VUpdateWidthPix
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3340  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[4]);        // unsigned int   *VReadyOffsetPix
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3341  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3342  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3343  				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3344  					dml32_CalculateUrgentBurstFactor(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3345  							mode_lib->vba.UsesMALLForPStateChange[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3346  							mode_lib->vba.swath_width_luma_ub_this_state[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3347  							mode_lib->vba.swath_width_chroma_ub_this_state[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3348  							mode_lib->vba.SwathHeightYThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3349  							mode_lib->vba.SwathHeightCThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3350  							mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3351  							mode_lib->vba.UrgLatency[i], mode_lib->vba.CursorBufferSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3352  							mode_lib->vba.CursorWidth[k][0], mode_lib->vba.CursorBPP[k][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3353  							mode_lib->vba.VRatioPreY[i][j][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3354  							mode_lib->vba.VRatioPreC[i][j][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3355  							mode_lib->vba.BytePerPixelInDETY[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3356  							mode_lib->vba.BytePerPixelInDETC[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3357  							mode_lib->vba.DETBufferSizeYThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3358  							mode_lib->vba.DETBufferSizeCThisState[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3359  							/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3360  							&mode_lib->vba.UrgentBurstFactorCursorPre[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3361  							&mode_lib->vba.UrgentBurstFactorLumaPre[k],
385c3e4c29e1d4 Paul Hsieh                2023-03-22  3362  							&mode_lib->vba.UrgentBurstFactorChromaPre[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3363  							&mode_lib->vba.NotUrgentLatencyHidingPre[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3364  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3365  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3366  				{
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3367  					dml32_CalculatePrefetchBandwithSupport(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3368  							mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3369  							mode_lib->vba.ReturnBWPerState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3370  							mode_lib->vba.NotUrgentLatencyHidingPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3371  							mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3372  							mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3373  							mode_lib->vba.RequiredPrefetchPixelDataBWLuma[0][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3374  							mode_lib->vba.RequiredPrefetchPixelDataBWChroma[0][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3375  							mode_lib->vba.cursor_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3376  							mode_lib->vba.meta_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3377  							mode_lib->vba.dpte_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3378  							mode_lib->vba.cursor_bw_pre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3379  							mode_lib->vba.prefetch_vmrow_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3380  							mode_lib->vba.NoOfDPPThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3381  							mode_lib->vba.UrgentBurstFactorLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3382  							mode_lib->vba.UrgentBurstFactorChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3383  							mode_lib->vba.UrgentBurstFactorCursor,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3384  							mode_lib->vba.UrgentBurstFactorLumaPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3385  							mode_lib->vba.UrgentBurstFactorChromaPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3386  							mode_lib->vba.UrgentBurstFactorCursorPre,
3a61570415690e Alvin Lee                 2023-01-31  3387  							v->PrefetchBW,
3a61570415690e Alvin Lee                 2023-01-31  3388  							v->VRatio,
3a61570415690e Alvin Lee                 2023-01-31  3389  							v->MaxVRatioPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3390  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3391  							/* output */
01cf387b1c7f60 Alex Deucher              2022-06-22  3392  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0],   // Single  *PrefetchBandwidth
01cf387b1c7f60 Alex Deucher              2022-06-22  3393  							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1],   // Single  *FractionOfUrgentBandwidth
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3394  							&mode_lib->vba.PrefetchSupported[i][j]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3395  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3396  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3397  				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3398  					if (mode_lib->vba.LineTimesForPrefetch[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3399  							< 2.0 || mode_lib->vba.LinesForMetaPTE[k] >= 32.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3400  							|| mode_lib->vba.LinesForMetaAndDPTERow[k] >= 16.0
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3401  							|| mode_lib->vba.NoTimeForPrefetch[i][j][k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3402  						mode_lib->vba.PrefetchSupported[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3403  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3404  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3405  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3406  				mode_lib->vba.DynamicMetadataSupported[i][j] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3407  				for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3408  					if (mode_lib->vba.NoTimeForDynamicMetadata[i][j][k] == true)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3409  						mode_lib->vba.DynamicMetadataSupported[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3410  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3411  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3412  				mode_lib->vba.VRatioInPrefetchSupported[i][j] = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3413  				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
7cd07d9de8711a Alvin Lee                 2023-01-25  3414  					if (mode_lib->vba.VRatioPreY[i][j][k] > mode_lib->vba.MaxVRatioPre
7cd07d9de8711a Alvin Lee                 2023-01-25  3415  							|| mode_lib->vba.VRatioPreC[i][j][k] > mode_lib->vba.MaxVRatioPre
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3416  							|| mode_lib->vba.NoTimeForPrefetch[i][j][k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3417  						mode_lib->vba.VRatioInPrefetchSupported[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3418  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3419  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3420  				mode_lib->vba.AnyLinesForVMOrRowTooLarge = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3421  				for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3422  					if (mode_lib->vba.LinesForMetaAndDPTERow[k] >= 16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3423  							|| mode_lib->vba.LinesForMetaPTE[k] >= 32) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3424  						mode_lib->vba.AnyLinesForVMOrRowTooLarge = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3425  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3426  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3427  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3428  				if (mode_lib->vba.PrefetchSupported[i][j] == true
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3429  						&& mode_lib->vba.VRatioInPrefetchSupported[i][j] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3430  					mode_lib->vba.BandwidthAvailableForImmediateFlip =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3431  							dml32_CalculateBandwidthAvailableForImmediateFlip(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3432  							mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3433  							mode_lib->vba.ReturnBWPerState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3434  							mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3435  							mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3436  							mode_lib->vba.RequiredPrefetchPixelDataBWLuma[0][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3437  							mode_lib->vba.RequiredPrefetchPixelDataBWChroma[0][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3438  							mode_lib->vba.cursor_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3439  							mode_lib->vba.cursor_bw_pre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3440  							mode_lib->vba.NoOfDPPThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3441  							mode_lib->vba.UrgentBurstFactorLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3442  							mode_lib->vba.UrgentBurstFactorChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3443  							mode_lib->vba.UrgentBurstFactorCursor,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3444  							mode_lib->vba.UrgentBurstFactorLumaPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3445  							mode_lib->vba.UrgentBurstFactorChromaPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3446  							mode_lib->vba.UrgentBurstFactorCursorPre);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3447  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3448  					mode_lib->vba.TotImmediateFlipBytes = 0.0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3449  					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3450  						if (!(mode_lib->vba.ImmediateFlipRequirement[k] ==
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3451  								dm_immediate_flip_not_required)) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3452  							mode_lib->vba.TotImmediateFlipBytes =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3453  									mode_lib->vba.TotImmediateFlipBytes
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3454  								+ mode_lib->vba.NoOfDPP[i][j][k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3455  								* mode_lib->vba.PDEAndMetaPTEBytesPerFrame[i][j][k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3456  								+ mode_lib->vba.MetaRowBytes[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3457  							if (mode_lib->vba.use_one_row_for_frame_flip[i][j][k]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3458  								mode_lib->vba.TotImmediateFlipBytes =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3459  									mode_lib->vba.TotImmediateFlipBytes + 2
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3460  								* mode_lib->vba.DPTEBytesPerRow[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3461  							} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3462  								mode_lib->vba.TotImmediateFlipBytes =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3463  									mode_lib->vba.TotImmediateFlipBytes
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3464  								+ mode_lib->vba.DPTEBytesPerRow[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3465  							}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3466  						}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3467  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3468  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3469  					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
7acc487ab57e07 Alex Deucher              2022-07-20  3470  						dml32_CalculateFlipSchedule(v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3471  							mode_lib->vba.ExtraLatency,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3472  							mode_lib->vba.UrgLatency[i],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3473  							mode_lib->vba.GPUVMMaxPageTableLevels,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3474  							mode_lib->vba.HostVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3475  							mode_lib->vba.HostVMMaxNonCachedPageTableLevels,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3476  							mode_lib->vba.GPUVMEnable,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3477  							mode_lib->vba.HostVMMinPageSize,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3478  							mode_lib->vba.PDEAndMetaPTEBytesPerFrame[i][j][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3479  							mode_lib->vba.MetaRowBytes[i][j][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3480  							mode_lib->vba.DPTEBytesPerRow[i][j][k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3481  							mode_lib->vba.BandwidthAvailableForImmediateFlip,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3482  							mode_lib->vba.TotImmediateFlipBytes,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3483  							mode_lib->vba.SourcePixelFormat[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3484  							(mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]),
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3485  							mode_lib->vba.VRatio[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3486  							mode_lib->vba.VRatioChroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3487  							mode_lib->vba.Tno_bw[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3488  								mode_lib->vba.DCCEnable[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3489  							mode_lib->vba.dpte_row_height[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3490  							mode_lib->vba.meta_row_height[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3491  							mode_lib->vba.dpte_row_height_chroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3492  							mode_lib->vba.meta_row_height_chroma[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3493  							mode_lib->vba.use_one_row_for_frame_flip[i][j][k], // 24
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3494  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3495  							/* Output */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3496  							&mode_lib->vba.DestinationLinesToRequestVMInImmediateFlip[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3497  							&mode_lib->vba.DestinationLinesToRequestRowInImmediateFlip[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3498  							&mode_lib->vba.final_flip_bw[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3499  							&mode_lib->vba.ImmediateFlipSupportedForPipe[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3500  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3501  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3502  					{
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3503  						dml32_CalculateImmediateFlipBandwithSupport(mode_lib->vba.NumberOfActiveSurfaces,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3504  								mode_lib->vba.ReturnBWPerState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3505  								mode_lib->vba.ImmediateFlipRequirement,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3506  								mode_lib->vba.final_flip_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3507  								mode_lib->vba.ReadBandwidthLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3508  								mode_lib->vba.ReadBandwidthChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3509  								mode_lib->vba.RequiredPrefetchPixelDataBWLuma[0][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3510  								mode_lib->vba.RequiredPrefetchPixelDataBWChroma[0][0],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3511  								mode_lib->vba.cursor_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3512  								mode_lib->vba.meta_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3513  								mode_lib->vba.dpte_row_bandwidth_this_state,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3514  								mode_lib->vba.cursor_bw_pre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3515  								mode_lib->vba.prefetch_vmrow_bw,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3516  								mode_lib->vba.DPPPerPlane,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3517  								mode_lib->vba.UrgentBurstFactorLuma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3518  								mode_lib->vba.UrgentBurstFactorChroma,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3519  								mode_lib->vba.UrgentBurstFactorCursor,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3520  								mode_lib->vba.UrgentBurstFactorLumaPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3521  								mode_lib->vba.UrgentBurstFactorChromaPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3522  								mode_lib->vba.UrgentBurstFactorCursorPre,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3523  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3524  								/* output */
01cf387b1c7f60 Alex Deucher              2022-06-22  3525  								&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0], //  Single  *TotalBandwidth
01cf387b1c7f60 Alex Deucher              2022-06-22  3526  								&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1], //  Single  *FractionOfUrgentBandwidth
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3527  								&mode_lib->vba.ImmediateFlipSupportedForState[i][j]); // Boolean *ImmediateFlipBandwidthSupport
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3528  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3529  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3530  					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3531  						if (!(mode_lib->vba.ImmediateFlipRequirement[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3532  								== dm_immediate_flip_not_required)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3533  								&& (mode_lib->vba.ImmediateFlipSupportedForPipe[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3534  										== false))
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3535  							mode_lib->vba.ImmediateFlipSupportedForState[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3536  					}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3537  				} else { // if prefetch not support, assume iflip not supported
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3538  					mode_lib->vba.ImmediateFlipSupportedForState[i][j] = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3539  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3540  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3541  				if (mode_lib->vba.MaxVStartup <= __DML_VBA_MIN_VSTARTUP__
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3542  						|| mode_lib->vba.AnyLinesForVMOrRowTooLarge == false) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3543  					mode_lib->vba.NextMaxVStartup = mode_lib->vba.MaxMaxVStartup[i][j];
7acc487ab57e07 Alex Deucher              2022-07-20  3544  					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState + 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3545  				} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3546  					mode_lib->vba.NextMaxVStartup = mode_lib->vba.NextMaxVStartup - 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3547  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3548  			} while (!((mode_lib->vba.PrefetchSupported[i][j] == true
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3549  					&& mode_lib->vba.DynamicMetadataSupported[i][j] == true
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3550  					&& mode_lib->vba.VRatioInPrefetchSupported[i][j] == true &&
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3551  					// consider flip support is okay if when there is no hostvm and the
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3552  					// user does't require a iflip OR the flip bw is ok
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3553  					// If there is hostvm, DCN needs to support iflip for invalidation
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3554  					((mode_lib->vba.HostVMEnable == false
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3555  							&& !mode_lib->vba.ImmediateFlipRequiredFinal)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3556  							|| mode_lib->vba.ImmediateFlipSupportedForState[i][j] == true))
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3557  					|| (mode_lib->vba.NextMaxVStartup == mode_lib->vba.MaxMaxVStartup[i][j]
7acc487ab57e07 Alex Deucher              2022-07-20  3558  							&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState > mode_lib->vba.MaxPrefetchMode)));
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3559  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3560  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3561  				mode_lib->vba.use_one_row_for_frame_this_state[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3562  						mode_lib->vba.use_one_row_for_frame[i][j][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3563  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3564  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3565  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3566  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.UrgentLatency = mode_lib->vba.UrgLatency[i];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3567  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.ExtraLatency = mode_lib->vba.ExtraLatency;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3568  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.WritebackLatency = mode_lib->vba.WritebackLatency;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3569  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.DRAMClockChangeLatency = mode_lib->vba.DRAMClockChangeLatency;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3570  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.FCLKChangeLatency = mode_lib->vba.FCLKChangeLatency;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3571  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SRExitTime = mode_lib->vba.SRExitTime;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3572  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SREnterPlusExitTime = mode_lib->vba.SREnterPlusExitTime;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3573  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SRExitZ8Time = mode_lib->vba.SRExitZ8Time;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3574  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SREnterPlusExitZ8Time = mode_lib->vba.SREnterPlusExitZ8Time;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3575  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.USRRetrainingLatency = mode_lib->vba.USRRetrainingLatency;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3576  			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3577  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3578  			{
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3579  				dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
1df7e569522486 Nathan Chancellor         2022-08-30  3580  						v,
1df7e569522486 Nathan Chancellor         2022-08-30  3581  						v->PrefetchModePerState[i][j],
1df7e569522486 Nathan Chancellor         2022-08-30  3582  						v->DCFCLKState[i][j],
1df7e569522486 Nathan Chancellor         2022-08-30  3583  						v->ReturnBWPerState[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3584  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters,
1df7e569522486 Nathan Chancellor         2022-08-30  3585  						v->SOCCLKPerState[i],
1df7e569522486 Nathan Chancellor         2022-08-30  3586  						v->ProjectedDCFCLKDeepSleep[i][j],
1df7e569522486 Nathan Chancellor         2022-08-30  3587  						v->DETBufferSizeYThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3588  						v->DETBufferSizeCThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3589  						v->SwathHeightYThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3590  						v->SwathHeightCThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3591  						v->SwathWidthYThisState, // 24
1df7e569522486 Nathan Chancellor         2022-08-30  3592  						v->SwathWidthCThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3593  						v->NoOfDPPThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3594  						v->BytePerPixelInDETY,
1df7e569522486 Nathan Chancellor         2022-08-30  3595  						v->BytePerPixelInDETC,
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3596  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTXAfterScaler,
d6aa8424bcac64 Aurabindo Pillai          2022-06-10  3597  						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTYAfterScaler,
1df7e569522486 Nathan Chancellor         2022-08-30  3598  						v->UnboundedRequestEnabledThisState,
1df7e569522486 Nathan Chancellor         2022-08-30  3599  						v->CompressedBufferSizeInkByteThisState,
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3600  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3601  						/* Output */
1df7e569522486 Nathan Chancellor         2022-08-30  3602  						&v->DRAMClockChangeSupport[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3603  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single2[0], // double *MaxActiveDRAMClockChangeLatencySupported
7acc487ab57e07 Alex Deucher              2022-07-20  3604  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer[0], // Long SubViewportLinesNeededInMALL[]
1df7e569522486 Nathan Chancellor         2022-08-30  3605  						&v->FCLKChangeSupport[i][j],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3606  						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single2[1], // double *MinActiveFCLKChangeLatencySupported
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3607  						&mode_lib->vba.USRRetrainingSupport[i][j],
a3c9b4c7a75a66 Alvin Lee                 2022-08-15  3608  						mode_lib->vba.ActiveDRAMClockChangeLatencyMarginPerState[i][j]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3609  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3610  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3611  	} // End of Prefetch Check
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3612  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3613  	/*Cursor Support Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3614  	mode_lib->vba.CursorSupport = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3615  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3616  		if (mode_lib->vba.CursorWidth[k][0] > 0.0) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3617  			if (mode_lib->vba.CursorBPP[k][0] == 64 && mode_lib->vba.Cursor64BppSupport == false)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3618  				mode_lib->vba.CursorSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3619  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3620  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3621  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3622  	/*Valid Pitch Check*/
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3623  	mode_lib->vba.PitchSupport = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3624  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3625  		mode_lib->vba.AlignedYPitch[k] = dml_ceil(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3626  				dml_max(mode_lib->vba.PitchY[k], mode_lib->vba.SurfaceWidthY[k]),
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3627  				mode_lib->vba.MacroTileWidthY[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3628  		if (mode_lib->vba.DCCEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3629  			mode_lib->vba.AlignedDCCMetaPitchY[k] = dml_ceil(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3630  					dml_max(mode_lib->vba.DCCMetaPitchY[k], mode_lib->vba.SurfaceWidthY[k]),
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3631  					64.0 * mode_lib->vba.Read256BlockWidthY[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3632  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3633  			mode_lib->vba.AlignedDCCMetaPitchY[k] = mode_lib->vba.DCCMetaPitchY[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3634  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3635  		if (mode_lib->vba.SourcePixelFormat[k] != dm_444_64 && mode_lib->vba.SourcePixelFormat[k] != dm_444_32
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3636  				&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3637  				&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3638  				&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3639  				&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_8) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3640  			mode_lib->vba.AlignedCPitch[k] = dml_ceil(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3641  					dml_max(mode_lib->vba.PitchC[k], mode_lib->vba.SurfaceWidthC[k]),
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3642  					mode_lib->vba.MacroTileWidthC[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3643  			if (mode_lib->vba.DCCEnable[k] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3644  				mode_lib->vba.AlignedDCCMetaPitchC[k] = dml_ceil(
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3645  						dml_max(mode_lib->vba.DCCMetaPitchC[k],
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3646  								mode_lib->vba.SurfaceWidthC[k]),
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3647  						64.0 * mode_lib->vba.Read256BlockWidthC[k]);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3648  			} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3649  				mode_lib->vba.AlignedDCCMetaPitchC[k] = mode_lib->vba.DCCMetaPitchC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3650  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3651  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3652  			mode_lib->vba.AlignedCPitch[k] = mode_lib->vba.PitchC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3653  			mode_lib->vba.AlignedDCCMetaPitchC[k] = mode_lib->vba.DCCMetaPitchC[k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3654  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3655  		if (mode_lib->vba.AlignedYPitch[k] > mode_lib->vba.PitchY[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3656  				|| mode_lib->vba.AlignedCPitch[k] > mode_lib->vba.PitchC[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3657  				|| mode_lib->vba.AlignedDCCMetaPitchY[k] > mode_lib->vba.DCCMetaPitchY[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3658  				|| mode_lib->vba.AlignedDCCMetaPitchC[k] > mode_lib->vba.DCCMetaPitchC[k]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3659  			mode_lib->vba.PitchSupport = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3660  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3661  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3662  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3663  	mode_lib->vba.ViewportExceedsSurface = false;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3664  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3665  		if (mode_lib->vba.ViewportWidth[k] > mode_lib->vba.SurfaceWidthY[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3666  				|| mode_lib->vba.ViewportHeight[k] > mode_lib->vba.SurfaceHeightY[k]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3667  			mode_lib->vba.ViewportExceedsSurface = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3668  			if (mode_lib->vba.SourcePixelFormat[k] != dm_444_64
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3669  					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_32
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3670  					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3671  					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_8
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3672  					&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3673  				if (mode_lib->vba.ViewportWidthChroma[k] > mode_lib->vba.SurfaceWidthC[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3674  						|| mode_lib->vba.ViewportHeightChroma[k]
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3675  								> mode_lib->vba.SurfaceHeightC[k]) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3676  					mode_lib->vba.ViewportExceedsSurface = true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3677  				}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3678  			}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3679  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3680  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3681  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3682  	/*Mode Support, Voltage State and SOC Configuration*/
1b54a0121dba12 Rodrigo Siqueira          2022-07-22  3683  	mode_support_configuration(v, mode_lib);
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3684  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3685  	MaximumMPCCombine = 0;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3686  
3a9c6f9a6159d8 Ilya Bakoulin             2022-11-24  3687  	for (i = v->soc.num_states; i >= start_state; i--) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3688  		if (i == v->soc.num_states || mode_lib->vba.ModeSupport[i][0] == true ||
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3689  				mode_lib->vba.ModeSupport[i][1] == true) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3690  			mode_lib->vba.VoltageLevel = i;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3691  			mode_lib->vba.ModeIsSupported = mode_lib->vba.ModeSupport[i][0] == true
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3692  					|| mode_lib->vba.ModeSupport[i][1] == true;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3693  
7e6d5cf8e3e3f8 Rodrigo Siqueira          2022-09-22  3694  			if (mode_lib->vba.ModeSupport[i][0] == true)
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3695  				MaximumMPCCombine = 0;
7e6d5cf8e3e3f8 Rodrigo Siqueira          2022-09-22  3696  			else
80fb575678b488 Samson Tam                2022-04-11  3697  				MaximumMPCCombine = 1;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3698  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3699  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3700  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3701  	mode_lib->vba.ImmediateFlipSupport =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3702  			mode_lib->vba.ImmediateFlipSupportedForState[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3703  	mode_lib->vba.UnboundedRequestEnabled =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3704  			mode_lib->vba.UnboundedRequestEnabledAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3705  	mode_lib->vba.CompressedBufferSizeInkByte =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3706  			mode_lib->vba.CompressedBufferSizeInkByteAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine]; // Not used, informational
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3707  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3708  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3709  		mode_lib->vba.MPCCombineEnable[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3710  				mode_lib->vba.MPCCombine[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3711  		mode_lib->vba.DPPPerPlane[k] = mode_lib->vba.NoOfDPP[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3712  		mode_lib->vba.SwathHeightY[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3713  				mode_lib->vba.SwathHeightYAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3714  		mode_lib->vba.SwathHeightC[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3715  				mode_lib->vba.SwathHeightCAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3716  		mode_lib->vba.DETBufferSizeInKByte[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3717  			mode_lib->vba.DETBufferSizeInKByteAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3718  		mode_lib->vba.DETBufferSizeY[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3719  				mode_lib->vba.DETBufferSizeYAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3720  		mode_lib->vba.DETBufferSizeC[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3721  				mode_lib->vba.DETBufferSizeCAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3722  		mode_lib->vba.OutputType[k] = mode_lib->vba.OutputTypePerState[mode_lib->vba.VoltageLevel][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3723  		mode_lib->vba.OutputRate[k] = mode_lib->vba.OutputRatePerState[mode_lib->vba.VoltageLevel][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3724  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3725  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3726  	mode_lib->vba.DCFCLK = mode_lib->vba.DCFCLKState[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3727  	mode_lib->vba.DRAMSpeed = mode_lib->vba.DRAMSpeedPerState[mode_lib->vba.VoltageLevel];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3728  	mode_lib->vba.FabricClock = mode_lib->vba.FabricClockPerState[mode_lib->vba.VoltageLevel];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3729  	mode_lib->vba.SOCCLK = mode_lib->vba.SOCCLKPerState[mode_lib->vba.VoltageLevel];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3730  	mode_lib->vba.ReturnBW = mode_lib->vba.ReturnBWPerState[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3731  	mode_lib->vba.DISPCLK = mode_lib->vba.RequiredDISPCLK[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3732  	mode_lib->vba.maxMpcComb = MaximumMPCCombine;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3733  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3734  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3735  		if (mode_lib->vba.BlendingAndTiming[k] == k) {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3736  			mode_lib->vba.ODMCombineEnabled[k] =
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3737  					mode_lib->vba.ODMCombineEnablePerState[mode_lib->vba.VoltageLevel][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3738  		} else {
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3739  			mode_lib->vba.ODMCombineEnabled[k] = dm_odm_combine_mode_disabled;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3740  		}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3741  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3742  		mode_lib->vba.DSCEnabled[k] = mode_lib->vba.RequiresDSC[mode_lib->vba.VoltageLevel][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3743  		mode_lib->vba.FECEnable[k] = mode_lib->vba.RequiresFEC[mode_lib->vba.VoltageLevel][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3744  		mode_lib->vba.OutputBpp[k] = mode_lib->vba.OutputBppPerState[mode_lib->vba.VoltageLevel][k];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3745  	}
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3746  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3747  	mode_lib->vba.UrgentWatermark = mode_lib->vba.Watermark.UrgentWatermark;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3748  	mode_lib->vba.StutterEnterPlusExitWatermark = mode_lib->vba.Watermark.StutterEnterPlusExitWatermark;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3749  	mode_lib->vba.StutterExitWatermark = mode_lib->vba.Watermark.StutterExitWatermark;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3750  	mode_lib->vba.WritebackDRAMClockChangeWatermark = mode_lib->vba.Watermark.WritebackDRAMClockChangeWatermark;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3751  	mode_lib->vba.DRAMClockChangeWatermark = mode_lib->vba.Watermark.DRAMClockChangeWatermark;
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3752  	mode_lib->vba.UrgentLatency = mode_lib->vba.UrgLatency[mode_lib->vba.VoltageLevel];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3753  	mode_lib->vba.DCFCLKDeepSleep = mode_lib->vba.ProjectedDCFCLKDeepSleep[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3754  
dda4fb85e433f7 Aurabindo Pillai          2022-02-21  3755  	/* VBA has Error type to Error Msg output here, but not necessary for DML-C */
dda4fb85e433f7 Aurabindo Pillai          2022-02-21 @3756  } // ModeSupportAndSystemConfigurationFull

:::::: The code at line 3756 was first introduced by commit
:::::: dda4fb85e433f761eedaed0005a2bc20d705d504 drm/amd/display: DML changes for DCN32/321

:::::: TO: Aurabindo Pillai <aurabindo.pillai@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
