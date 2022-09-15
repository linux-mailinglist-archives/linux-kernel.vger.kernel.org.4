Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA0C5BA1C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIOUVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIOUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:21:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EABF5FAC8;
        Thu, 15 Sep 2022 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663273308; x=1694809308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vtpUHguAKafT6MIJU3D9kCLnwfOZK7+XR5i4gGc43qk=;
  b=X7g6sCOMV1tcBwc81WMLAaFqS1zEp7wWXSy+Zcat2DIz2TRzSF1xdS7K
   UN0E+GjQd5IUud15Fkx2Y5GVE7j7dyviHuvtIbSXgOogBU2QeMZqWgGOg
   JLY7mvZ+r3cCKPrw2TXSKzH06riJirmms7iulcr0J5qclLjQ70UeSmwiz
   iYKikg5O7ri+bWg21UuN9g0DSxz8qsho5B31dpzvHntv3UyGjjGu2pfmp
   TSxbeZ2fDn2sCkJnCFrVCXwnfnA/c6xZ7TACGUdK2EtRfmo7imYzuxpFL
   Mn1lHP36nuTNyCFL9wdYsVQ81G1AvPlwfrRHRk4ncbVhUYzFxwcERRAv6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="278558591"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="278558591"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 13:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="568576780"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Sep 2022 13:21:44 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYvMl-0000xf-1W;
        Thu, 15 Sep 2022 20:21:43 +0000
Date:   Fri, 16 Sep 2022 04:21:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prathamesh Shete <pshete@nvidia.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, anrao@nvidia.com,
        smangipudi@nvidia.com, pshete@nvidia.com, kyarlagadda@nvidia.com
Subject: Re: [PATCH v2 2/4] mmc: sdhci-tegra: Add support to program MC
 streamID
Message-ID: <202209160420.bcAdUgK2-lkp@intel.com>
References: <20220914095628.26093-2-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914095628.26093-2-pshete@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prathamesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tegra/for-next]
[also build test ERROR on linus/master v6.0-rc5 next-20220915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prathamesh-Shete/mmc-sdhci-tegra-Separate-T19x-and-T23x-SoC-data/20220914-175832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: hexagon-randconfig-r045-20220915 (https://download.01.org/0day-ci/archive/20220916/202209160420.bcAdUgK2-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9817941f43bffe4de367526928377b9723068fb5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Prathamesh-Shete/mmc-sdhci-tegra-Separate-T19x-and-T23x-SoC-data/20220914-175832
        git checkout 9817941f43bffe4de367526928377b9723068fb5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-tegra.c:1795:35: error: no member named 'ids' in 'struct iommu_fwspec'
                           tegra_host->streamid = fwspec->ids[0] & 0xffff;
                                                  ~~~~~~  ^
   1 error generated.


vim +1795 drivers/mmc/host/sdhci-tegra.c

  1638	
  1639	static int sdhci_tegra_probe(struct platform_device *pdev)
  1640	{
  1641		const struct sdhci_tegra_soc_data *soc_data;
  1642		struct sdhci_host *host;
  1643		struct sdhci_pltfm_host *pltfm_host;
  1644		struct sdhci_tegra *tegra_host;
  1645		struct clk *clk;
  1646		struct iommu_fwspec *fwspec;
  1647		int rc;
  1648	
  1649		soc_data = of_device_get_match_data(&pdev->dev);
  1650		if (!soc_data)
  1651			return -EINVAL;
  1652	
  1653		host = sdhci_pltfm_init(pdev, soc_data->pdata, sizeof(*tegra_host));
  1654		if (IS_ERR(host))
  1655			return PTR_ERR(host);
  1656		pltfm_host = sdhci_priv(host);
  1657	
  1658		tegra_host = sdhci_pltfm_priv(pltfm_host);
  1659		tegra_host->ddr_signaling = false;
  1660		tegra_host->pad_calib_required = false;
  1661		tegra_host->pad_control_available = false;
  1662		tegra_host->soc_data = soc_data;
  1663	
  1664		if (soc_data->nvquirks & NVQUIRK_HAS_ANDROID_GPT_SECTOR)
  1665			host->mmc->caps2 |= MMC_CAP2_ALT_GPT_TEGRA;
  1666	
  1667		if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
  1668			rc = tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
  1669			if (rc == 0)
  1670				host->mmc_host_ops.start_signal_voltage_switch =
  1671					sdhci_tegra_start_signal_voltage_switch;
  1672		}
  1673	
  1674		/* Hook to periodically rerun pad calibration */
  1675		if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
  1676			host->mmc_host_ops.request = tegra_sdhci_request;
  1677	
  1678		host->mmc_host_ops.hs400_enhanced_strobe =
  1679				tegra_sdhci_hs400_enhanced_strobe;
  1680	
  1681		if (!host->ops->platform_execute_tuning)
  1682			host->mmc_host_ops.execute_tuning =
  1683					tegra_sdhci_execute_hw_tuning;
  1684	
  1685		rc = mmc_of_parse(host->mmc);
  1686		if (rc)
  1687			goto err_parse_dt;
  1688	
  1689		if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
  1690			host->mmc->caps |= MMC_CAP_1_8V_DDR;
  1691	
  1692		/* HW busy detection is supported, but R1B responses are required. */
  1693		host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
  1694	
  1695		/* GPIO CD can be set as a wakeup source */
  1696		host->mmc->caps |= MMC_CAP_CD_WAKE;
  1697	
  1698		tegra_sdhci_parse_dt(host);
  1699	
  1700		tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
  1701								 GPIOD_OUT_HIGH);
  1702		if (IS_ERR(tegra_host->power_gpio)) {
  1703			rc = PTR_ERR(tegra_host->power_gpio);
  1704			goto err_power_req;
  1705		}
  1706	
  1707		/*
  1708		 * Tegra210 has a separate SDMMC_LEGACY_TM clock used for host
  1709		 * timeout clock and SW can choose TMCLK or SDCLK for hardware
  1710		 * data timeout through the bit USE_TMCLK_FOR_DATA_TIMEOUT of
  1711		 * the register SDHCI_TEGRA_VENDOR_SYS_SW_CTRL.
  1712		 *
  1713		 * USE_TMCLK_FOR_DATA_TIMEOUT bit default is set to 1 and SDMMC uses
  1714		 * 12Mhz TMCLK which is advertised in host capability register.
  1715		 * With TMCLK of 12Mhz provides maximum data timeout period that can
  1716		 * be achieved is 11s better than using SDCLK for data timeout.
  1717		 *
  1718		 * So, TMCLK is set to 12Mhz and kept enabled all the time on SoC's
  1719		 * supporting separate TMCLK.
  1720		 */
  1721	
  1722		if (soc_data->nvquirks & NVQUIRK_HAS_TMCLK) {
  1723			clk = devm_clk_get(&pdev->dev, "tmclk");
  1724			if (IS_ERR(clk)) {
  1725				rc = PTR_ERR(clk);
  1726				if (rc == -EPROBE_DEFER)
  1727					goto err_power_req;
  1728	
  1729				dev_warn(&pdev->dev, "failed to get tmclk: %d\n", rc);
  1730				clk = NULL;
  1731			}
  1732	
  1733			clk_set_rate(clk, 12000000);
  1734			rc = clk_prepare_enable(clk);
  1735			if (rc) {
  1736				dev_err(&pdev->dev,
  1737					"failed to enable tmclk: %d\n", rc);
  1738				goto err_power_req;
  1739			}
  1740	
  1741			tegra_host->tmclk = clk;
  1742		}
  1743	
  1744		clk = devm_clk_get(mmc_dev(host->mmc), NULL);
  1745		if (IS_ERR(clk)) {
  1746			rc = dev_err_probe(&pdev->dev, PTR_ERR(clk),
  1747					   "failed to get clock\n");
  1748			goto err_clk_get;
  1749		}
  1750		pltfm_host->clk = clk;
  1751	
  1752		tegra_host->rst = devm_reset_control_get_exclusive(&pdev->dev,
  1753								   "sdhci");
  1754		if (IS_ERR(tegra_host->rst)) {
  1755			rc = PTR_ERR(tegra_host->rst);
  1756			dev_err(&pdev->dev, "failed to get reset control: %d\n", rc);
  1757			goto err_rst_get;
  1758		}
  1759	
  1760		rc = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
  1761		if (rc)
  1762			goto err_rst_get;
  1763	
  1764		pm_runtime_enable(&pdev->dev);
  1765		rc = pm_runtime_resume_and_get(&pdev->dev);
  1766		if (rc)
  1767			goto err_pm_get;
  1768	
  1769		rc = reset_control_assert(tegra_host->rst);
  1770		if (rc)
  1771			goto err_rst_assert;
  1772	
  1773		usleep_range(2000, 4000);
  1774	
  1775		rc = reset_control_deassert(tegra_host->rst);
  1776		if (rc)
  1777			goto err_rst_assert;
  1778	
  1779		usleep_range(2000, 4000);
  1780	
  1781		rc = sdhci_tegra_add_host(host);
  1782		if (rc)
  1783			goto err_add_host;
  1784	
  1785		/* Program MC streamID for DMA transfers */
  1786		if (soc_data->nvquirks & NVQUIRK_PROGRAM_MC_STREAMID) {
  1787			fwspec = dev_iommu_fwspec_get(&pdev->dev);
  1788			if (fwspec == NULL) {
  1789				rc = -ENODEV;
  1790				dev_err(mmc_dev(host->mmc),
  1791					"failed to get MC streamid: %d\n",
  1792					rc);
  1793				goto err_rst_get;
  1794			} else {
> 1795				tegra_host->streamid = fwspec->ids[0] & 0xffff;
  1796				tegra_sdhci_writel(host, tegra_host->streamid |
  1797							(tegra_host->streamid << 8),
  1798							SDHCI_TEGRA_CIF2AXI_CTRL_0);
  1799			}
  1800		}
  1801	
  1802		return 0;
  1803	
  1804	err_add_host:
  1805		reset_control_assert(tegra_host->rst);
  1806	err_rst_assert:
  1807		pm_runtime_put_sync_suspend(&pdev->dev);
  1808	err_pm_get:
  1809		pm_runtime_disable(&pdev->dev);
  1810	err_rst_get:
  1811	err_clk_get:
  1812		clk_disable_unprepare(tegra_host->tmclk);
  1813	err_power_req:
  1814	err_parse_dt:
  1815		sdhci_pltfm_free(pdev);
  1816		return rc;
  1817	}
  1818	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
