Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF981654F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiLWLIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWLIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:08:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06B5B862;
        Fri, 23 Dec 2022 03:08:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h7so4267110wrs.6;
        Fri, 23 Dec 2022 03:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vk6+A4tk8mGgrfC6TqBrlZpIYBFUTW9URyU4ZXSSBjc=;
        b=qq7FbVL4agb4+DLYY/KOvhDFy8CVQLNkTzmUplVuwXRn3oXYAIMk8S6e5BhNVJvjI6
         OA7khhwl9WL9J4frGPBxyDKFmbssO0B66etORUWYtabLd+58s9RdWmreO2aPgXjmdts9
         JLyd17nuRVMVgBeYqCAwlA94aAtRR+hGIlnAnbOVl90oBYvfVgTWSSpzOJWWIsGl6ee3
         63wXY9fICjoCA0duFi4noJH5CGW/0iWT/A0Q+EomNVfc+LSnD0rw0d+KhjTTHUnqCsq9
         X4IWzGrHCcuO8mTcHKcQPNNg5bWdmJOlBFeuIz+EmLjHOHYGfe6kKUQcY4Sw8Wo+PMWx
         PT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vk6+A4tk8mGgrfC6TqBrlZpIYBFUTW9URyU4ZXSSBjc=;
        b=X+vK2xk4en7nx/Fuq3EqHwcKV6puyOuvJL8auWeKLMYyXZNast0375pzQKRfcGI5V/
         Wh1p+ALLQfb436WJkDwbm1vO7C/ZBo7ldx1tZMmCn6KALNY8rKzl3dkjn0wmbHzXr44W
         PSj+v+PEZrkLHSGnF6IxWnwUNAOhqJzSAdF0fTs+q446jeXRlNY+w+V3X05elgI/zt0f
         0SHMRwD17DU/ey8/CTBPGYdHSX4tu8Y0tAnOImc6hM2fXIxXE9aqqPeasQefN/y5pqws
         HZevZMh65ktkK8I9khEkk15jPkDaP+4Ty5iT29cmZzkDzpvCSlOV2lNUR0YZaxrK5mEE
         wZIQ==
X-Gm-Message-State: AFqh2krs6Q9G0SzRscmfZSye4Nwap23iUys8pDJxqweIrRnHnQAxU99t
        6QSM/Wj2uW1bSd2iDu48W4g=
X-Google-Smtp-Source: AMrXdXsbe+XVtoLPenVe20I/KG2XqX2i7u4VfI+9H4pqlQtxAbgcQ34pCc3FpVi6+0CeITtz9o3Y2g==
X-Received: by 2002:a5d:6e0a:0:b0:242:10ac:ac42 with SMTP id h10-20020a5d6e0a000000b0024210acac42mr5395743wrz.55.1671793682533;
        Fri, 23 Dec 2022 03:08:02 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z8-20020a056000110800b00241dd5de644sm2729300wrw.97.2022.12.23.03.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 03:08:02 -0800 (PST)
Date:   Fri, 23 Dec 2022 14:07:49 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Piyush Malgujar <pmalgujar@marvell.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        jannadurai@marvell.com, cchavva@marvell.com,
        Dhananjay Kangude <dkangude@cadence.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: Re: [PATCH 1/5] drivers: mmc: sdhci-cadence: SD6 controller support
Message-ID: <202212231541.7pOKEnhI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219142418.27949-2-pmalgujar@marvell.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piyush,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Piyush-Malgujar/drivers-mmc-sdhci-cadence-SD6-controller-support/20221219-222703
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20221219142418.27949-2-pmalgujar%40marvell.com
patch subject: [PATCH 1/5] drivers: mmc: sdhci-cadence: SD6 controller support
config: m68k-randconfig-m041-20221218
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/mmc/host/sdhci-cadence.c:1663 sdhci_cdns_probe() warn: passing zero to 'PTR_ERR'
drivers/mmc/host/sdhci-cadence.c:1664 sdhci_cdns_probe() warn: ignoring unreachable code.

vim +/PTR_ERR +1663 drivers/mmc/host/sdhci-cadence.c

d12990f9900f49 Piotr Sroka       2017-03-06  1642  
ff6af28faff53a Masahiro Yamada   2016-12-08  1643  static int sdhci_cdns_probe(struct platform_device *pdev)
ff6af28faff53a Masahiro Yamada   2016-12-08  1644  {
ff6af28faff53a Masahiro Yamada   2016-12-08  1645  	struct sdhci_host *host;
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1646  	const struct sdhci_cdns_of_data *data;
ff6af28faff53a Masahiro Yamada   2016-12-08  1647  	struct sdhci_pltfm_host *pltfm_host;
ff6af28faff53a Masahiro Yamada   2016-12-08  1648  	struct sdhci_cdns_priv *priv;
ff6af28faff53a Masahiro Yamada   2016-12-08  1649  	struct clk *clk;
ff6af28faff53a Masahiro Yamada   2016-12-08  1650  	int ret;
a89c472d8b55c5 Piotr Sroka       2017-03-21  1651  	struct device *dev = &pdev->dev;
ff6af28faff53a Masahiro Yamada   2016-12-08  1652  
edf98579065950 Piotr Sroka       2017-03-21  1653  	clk = devm_clk_get(dev, NULL);
ff6af28faff53a Masahiro Yamada   2016-12-08  1654  	if (IS_ERR(clk))
ff6af28faff53a Masahiro Yamada   2016-12-08  1655  		return PTR_ERR(clk);
ff6af28faff53a Masahiro Yamada   2016-12-08  1656  
ff6af28faff53a Masahiro Yamada   2016-12-08  1657  	ret = clk_prepare_enable(clk);
ff6af28faff53a Masahiro Yamada   2016-12-08  1658  	if (ret)
ff6af28faff53a Masahiro Yamada   2016-12-08  1659  		return ret;
ff6af28faff53a Masahiro Yamada   2016-12-08  1660  
18b587b45c13bb Masahiro Yamada   2020-03-12  1661  	data = of_device_get_match_data(dev);
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1662  	if (!data) {
8bcfc23a884699 Dhananjay Kangude 2022-12-19 @1663  		return PTR_ERR(clk);

ret = -EINVAL?

8bcfc23a884699 Dhananjay Kangude 2022-12-19 @1664  		goto disable_clk;

Dead code.

8bcfc23a884699 Dhananjay Kangude 2022-12-19  1665  	}
18b587b45c13bb Masahiro Yamada   2020-03-12  1666  
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1667  	host = sdhci_pltfm_init(pdev, data->pltfm_data, sizeof(*priv));
ff6af28faff53a Masahiro Yamada   2016-12-08  1668  	if (IS_ERR(host)) {
ff6af28faff53a Masahiro Yamada   2016-12-08  1669  		ret = PTR_ERR(host);
ff6af28faff53a Masahiro Yamada   2016-12-08  1670  		goto disable_clk;
ff6af28faff53a Masahiro Yamada   2016-12-08  1671  	}
ff6af28faff53a Masahiro Yamada   2016-12-08  1672  
ff6af28faff53a Masahiro Yamada   2016-12-08  1673  	pltfm_host = sdhci_priv(host);
ff6af28faff53a Masahiro Yamada   2016-12-08  1674  	pltfm_host->clk = clk;
ff6af28faff53a Masahiro Yamada   2016-12-08  1675  
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1676  	host->clk_mul = 0;
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1677  	host->max_clk = SDMCLK_MAX_FREQ;
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1678  	host->quirks |=  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1679  	host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
a232a8f2d10750 Masahiro Yamada   2017-08-23  1680  	priv = sdhci_pltfm_priv(pltfm_host);
ff6af28faff53a Masahiro Yamada   2016-12-08  1681  	priv->hrs_addr = host->ioaddr;
d12990f9900f49 Piotr Sroka       2017-03-06  1682  	priv->enhanced_strobe = false;
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1683  	priv->cdns_data = data->cdns_data;
ff6af28faff53a Masahiro Yamada   2016-12-08  1684  	host->ioaddr += SDHCI_CDNS_SRS_BASE;
d12990f9900f49 Piotr Sroka       2017-03-06  1685  	host->mmc_host_ops.hs400_enhanced_strobe =
d12990f9900f49 Piotr Sroka       2017-03-06  1686  				sdhci_cdns_hs400_enhanced_strobe;
ff6af28faff53a Masahiro Yamada   2016-12-08  1687  
861183f115cd80 Piotr Sroka       2017-04-11  1688  	sdhci_get_of_property(pdev);
861183f115cd80 Piotr Sroka       2017-04-11  1689  
ff6af28faff53a Masahiro Yamada   2016-12-08  1690  	ret = mmc_of_parse(host->mmc);
ff6af28faff53a Masahiro Yamada   2016-12-08  1691  	if (ret)
ff6af28faff53a Masahiro Yamada   2016-12-08  1692  		goto free;
ff6af28faff53a Masahiro Yamada   2016-12-08  1693  
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1694  	ret = data->phy_probe(pdev, priv);
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1695  	if (ret)
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1696  		goto free;
a232a8f2d10750 Masahiro Yamada   2017-08-23  1697  
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1698  	ret = priv->cdns_data->phy_init(priv);
a89c472d8b55c5 Piotr Sroka       2017-03-21  1699  	if (ret)
a89c472d8b55c5 Piotr Sroka       2017-03-21  1700  		goto free;
ff6af28faff53a Masahiro Yamada   2016-12-08  1701  
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1702  	sdhci_enable_v4_mode(host);
8bcfc23a884699 Dhananjay Kangude 2022-12-19  1703  	__sdhci_read_caps(host, NULL, NULL, NULL);
ff6af28faff53a Masahiro Yamada   2016-12-08  1704  	ret = sdhci_add_host(host);
ff6af28faff53a Masahiro Yamada   2016-12-08  1705  	if (ret)
ff6af28faff53a Masahiro Yamada   2016-12-08  1706  		goto free;
ff6af28faff53a Masahiro Yamada   2016-12-08  1707  
ff6af28faff53a Masahiro Yamada   2016-12-08  1708  	return 0;
ff6af28faff53a Masahiro Yamada   2016-12-08  1709  free:
ff6af28faff53a Masahiro Yamada   2016-12-08  1710  	sdhci_pltfm_free(pdev);
ff6af28faff53a Masahiro Yamada   2016-12-08  1711  disable_clk:
ff6af28faff53a Masahiro Yamada   2016-12-08  1712  	clk_disable_unprepare(clk);
ff6af28faff53a Masahiro Yamada   2016-12-08  1713  
ff6af28faff53a Masahiro Yamada   2016-12-08  1714  	return ret;
ff6af28faff53a Masahiro Yamada   2016-12-08  1715  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp


