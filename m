Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B965E5F40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiIVKD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiIVKDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:03:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DE6AB1A2;
        Thu, 22 Sep 2022 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663841003; x=1695377003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lFppjMkWFpyHqnWeDyV5+GEziwj7bkXvG42zrnF0Ric=;
  b=L9xohizv2RHKryIo3wiW42+p3a549bqo7gNv57C5VF5IMGjLellukhIW
   UBBIitfBpBHnCkq0bQQFRncGCzYshBxA2PWhKyY2JmsfiOPb124urXW7+
   clzZkGMl2PbqutL+IXCPLZV6zzgSWhhaJFj6q/TzjXfN4Xunxn9Dca4HJ
   VWS5/0IxETRIGpQrauEMFB2OFq2Bp/jf+uAVLvwsC80NyRo8S/XL1O5P2
   L5l4+V6g2uX8B0PTCx9K2cn+MCQme1OQwzUUg5OLYzxRA7pRRzSXNQTYO
   NUbhnh4MJHOhSHUjdaSRsuasPPgvOK4cTkjTXP82i+SpmjMWk4qyD6jHT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="300241304"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="300241304"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 03:03:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="570902947"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 03:03:19 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obJ38-0004a0-2h;
        Thu, 22 Sep 2022 10:03:18 +0000
Date:   Thu, 22 Sep 2022 18:02:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prathamesh Shete <pshete@nvidia.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, anrao@nvidia.com, smangipudi@nvidia.com,
        pshete@nvidia.com, kyarlagadda@nvidia.com
Subject: Re: [PATCH v3 2/4]  mmc: sdhci-tegra: Add support to program MC
 stream ID
Message-ID: <202209221747.z0EBLZBB-lkp@intel.com>
References: <20220920123752.21027-2-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920123752.21027-2-pshete@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prathamesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tegra/for-next]
[also build test ERROR on linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prathamesh-Shete/mmc-sdhci-tegra-Separate-Tegra194-and-Tegra234-SoC-data/20220920-203924
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: arc-randconfig-r002-20220921 (https://download.01.org/0day-ci/archive/20220922/202209221747.z0EBLZBB-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8087ec8183ffb01cc85647de0977c2dd369b324d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Prathamesh-Shete/mmc-sdhci-tegra-Separate-Tegra194-and-Tegra234-SoC-data/20220920-203924
        git checkout 8087ec8183ffb01cc85647de0977c2dd369b324d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-tegra.c: In function 'sdhci_tegra_probe':
>> drivers/mmc/host/sdhci-tegra.c:1794:54: error: 'struct iommu_fwspec' has no member named 'ids'
    1794 |                         tegra_host->streamid = fwspec->ids[0] & 0xffff;
         |                                                      ^~


vim +1794 drivers/mmc/host/sdhci-tegra.c

  1640	
  1641	static int sdhci_tegra_probe(struct platform_device *pdev)
  1642	{
  1643		const struct sdhci_tegra_soc_data *soc_data;
  1644		struct sdhci_host *host;
  1645		struct sdhci_pltfm_host *pltfm_host;
  1646		struct sdhci_tegra *tegra_host;
  1647		struct iommu_fwspec *fwspec;
  1648		struct clk *clk;
  1649		int rc;
  1650	
  1651		soc_data = of_device_get_match_data(&pdev->dev);
  1652		if (!soc_data)
  1653			return -EINVAL;
  1654	
  1655		host = sdhci_pltfm_init(pdev, soc_data->pdata, sizeof(*tegra_host));
  1656		if (IS_ERR(host))
  1657			return PTR_ERR(host);
  1658		pltfm_host = sdhci_priv(host);
  1659	
  1660		tegra_host = sdhci_pltfm_priv(pltfm_host);
  1661		tegra_host->ddr_signaling = false;
  1662		tegra_host->pad_calib_required = false;
  1663		tegra_host->pad_control_available = false;
  1664		tegra_host->soc_data = soc_data;
  1665	
  1666		if (soc_data->nvquirks & NVQUIRK_HAS_ANDROID_GPT_SECTOR)
  1667			host->mmc->caps2 |= MMC_CAP2_ALT_GPT_TEGRA;
  1668	
  1669		if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
  1670			rc = tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
  1671			if (rc == 0)
  1672				host->mmc_host_ops.start_signal_voltage_switch =
  1673					sdhci_tegra_start_signal_voltage_switch;
  1674		}
  1675	
  1676		/* Hook to periodically rerun pad calibration */
  1677		if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
  1678			host->mmc_host_ops.request = tegra_sdhci_request;
  1679	
  1680		host->mmc_host_ops.hs400_enhanced_strobe =
  1681				tegra_sdhci_hs400_enhanced_strobe;
  1682	
  1683		if (!host->ops->platform_execute_tuning)
  1684			host->mmc_host_ops.execute_tuning =
  1685					tegra_sdhci_execute_hw_tuning;
  1686	
  1687		rc = mmc_of_parse(host->mmc);
  1688		if (rc)
  1689			goto err_parse_dt;
  1690	
  1691		if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
  1692			host->mmc->caps |= MMC_CAP_1_8V_DDR;
  1693	
  1694		/* HW busy detection is supported, but R1B responses are required. */
  1695		host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
  1696	
  1697		/* GPIO CD can be set as a wakeup source */
  1698		host->mmc->caps |= MMC_CAP_CD_WAKE;
  1699	
  1700		tegra_sdhci_parse_dt(host);
  1701	
  1702		tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
  1703								 GPIOD_OUT_HIGH);
  1704		if (IS_ERR(tegra_host->power_gpio)) {
  1705			rc = PTR_ERR(tegra_host->power_gpio);
  1706			goto err_power_req;
  1707		}
  1708	
  1709		/*
  1710		 * Tegra210 has a separate SDMMC_LEGACY_TM clock used for host
  1711		 * timeout clock and SW can choose TMCLK or SDCLK for hardware
  1712		 * data timeout through the bit USE_TMCLK_FOR_DATA_TIMEOUT of
  1713		 * the register SDHCI_TEGRA_VENDOR_SYS_SW_CTRL.
  1714		 *
  1715		 * USE_TMCLK_FOR_DATA_TIMEOUT bit default is set to 1 and SDMMC uses
  1716		 * 12Mhz TMCLK which is advertised in host capability register.
  1717		 * With TMCLK of 12Mhz provides maximum data timeout period that can
  1718		 * be achieved is 11s better than using SDCLK for data timeout.
  1719		 *
  1720		 * So, TMCLK is set to 12Mhz and kept enabled all the time on SoC's
  1721		 * supporting separate TMCLK.
  1722		 */
  1723	
  1724		if (soc_data->nvquirks & NVQUIRK_HAS_TMCLK) {
  1725			clk = devm_clk_get(&pdev->dev, "tmclk");
  1726			if (IS_ERR(clk)) {
  1727				rc = PTR_ERR(clk);
  1728				if (rc == -EPROBE_DEFER)
  1729					goto err_power_req;
  1730	
  1731				dev_warn(&pdev->dev, "failed to get tmclk: %d\n", rc);
  1732				clk = NULL;
  1733			}
  1734	
  1735			clk_set_rate(clk, 12000000);
  1736			rc = clk_prepare_enable(clk);
  1737			if (rc) {
  1738				dev_err(&pdev->dev,
  1739					"failed to enable tmclk: %d\n", rc);
  1740				goto err_power_req;
  1741			}
  1742	
  1743			tegra_host->tmclk = clk;
  1744		}
  1745	
  1746		clk = devm_clk_get(mmc_dev(host->mmc), NULL);
  1747		if (IS_ERR(clk)) {
  1748			rc = dev_err_probe(&pdev->dev, PTR_ERR(clk),
  1749					   "failed to get clock\n");
  1750			goto err_clk_get;
  1751		}
  1752		pltfm_host->clk = clk;
  1753	
  1754		tegra_host->rst = devm_reset_control_get_exclusive(&pdev->dev,
  1755								   "sdhci");
  1756		if (IS_ERR(tegra_host->rst)) {
  1757			rc = PTR_ERR(tegra_host->rst);
  1758			dev_err(&pdev->dev, "failed to get reset control: %d\n", rc);
  1759			goto err_rst_get;
  1760		}
  1761	
  1762		rc = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
  1763		if (rc)
  1764			goto err_rst_get;
  1765	
  1766		pm_runtime_enable(&pdev->dev);
  1767		rc = pm_runtime_resume_and_get(&pdev->dev);
  1768		if (rc)
  1769			goto err_pm_get;
  1770	
  1771		rc = reset_control_assert(tegra_host->rst);
  1772		if (rc)
  1773			goto err_rst_assert;
  1774	
  1775		usleep_range(2000, 4000);
  1776	
  1777		rc = reset_control_deassert(tegra_host->rst);
  1778		if (rc)
  1779			goto err_rst_assert;
  1780	
  1781		usleep_range(2000, 4000);
  1782	
  1783		rc = sdhci_tegra_add_host(host);
  1784		if (rc)
  1785			goto err_add_host;
  1786	
  1787		/* Program MC streamID for DMA transfers */
  1788		if (soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
  1789			fwspec = dev_iommu_fwspec_get(&pdev->dev);
  1790			if (fwspec == NULL) {
  1791				dev_warn(mmc_dev(host->mmc),
  1792					"iommu fwspec is NULL, continue without stream ID\n");
  1793			} else {
> 1794				tegra_host->streamid = fwspec->ids[0] & 0xffff;
  1795				tegra_sdhci_writel(host, (tegra_host->streamid &
  1796							SDHCI_TEGRA_STREAMID_MASK) |
  1797							((tegra_host->streamid <<
  1798							SDHCI_TEGRA_WRITE_STREAMID_SHIFT)
  1799							& SDHCI_TEGRA_STREAMID_MASK),
  1800							SDHCI_TEGRA_CIF2AXI_CTRL_0);
  1801			}
  1802		}
  1803	
  1804		return 0;
  1805	
  1806	err_add_host:
  1807		reset_control_assert(tegra_host->rst);
  1808	err_rst_assert:
  1809		pm_runtime_put_sync_suspend(&pdev->dev);
  1810	err_pm_get:
  1811		pm_runtime_disable(&pdev->dev);
  1812	err_rst_get:
  1813	err_clk_get:
  1814		clk_disable_unprepare(tegra_host->tmclk);
  1815	err_power_req:
  1816	err_parse_dt:
  1817		sdhci_pltfm_free(pdev);
  1818		return rc;
  1819	}
  1820	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
