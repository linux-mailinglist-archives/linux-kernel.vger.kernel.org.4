Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4485FAFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJKJ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJKJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:59:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4670278BCD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:59:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n7so12771255plp.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1fXIF1ijmUUQRNRT6RqsO+cCak4LIbfujlHnLa3spbE=;
        b=TOU4554m4mknJa8WO5FSKYj1BXHhRBxih0kfHM5fKTH8ifPjvdf58jUWMz0uYZbsOi
         b/g06HHxN8XKncuX9uoCTh6FwSUsSaLTXJZ4gEth1RQEdjPo2tQtQmwHqlPjW1tTr/da
         VyX96sSoSCz9yMGN5ljUdZFYUWj2EJ/dOmbEAKWdOb/BsJ7/7IWoMeQM8II/OkEUmoXF
         E772xvdESGaeOKYbIzlMTwzLtnFqB6gjV8ay25u8DItdEs6jBUDhwOYbyWOjlgfsqmpe
         QeC0kI5Qvv0ZodMxrb8IceSlZ/quXEVMZVKAXOYud+EcV1QbOU97s+dIVgARGzsrJfU/
         WNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fXIF1ijmUUQRNRT6RqsO+cCak4LIbfujlHnLa3spbE=;
        b=AGXSLCybai12xUoszQKE50kVmGw5xAX8KQULjMV33JZLI1lPAeQhtFwNNX2o+KPIV1
         Xx56PKhuSq2tv3fvbh8fr8zTkwMnetN61aqYCs0gy/lrSb8Vc3sNt9+q3oSKAdRH6/6F
         f7cpvblpgxLXk/MT7tUhIv20wKmeKH0KV5Xbs+BoJGFY2/LFS4tjz2PyGWkx5z2vl31f
         LbnWuhi5+G1g2YptKGVwnGp+Jkf8ymFn/MyQGtAV5oLaAD25adBt+/vv9jmcz6rovUto
         yMXH96xXXOihNTz+zO21rCgfAF59q1pNhR/lEWs9q5ojQs709bWBHWumuERw+oRwX5Mk
         U6oA==
X-Gm-Message-State: ACrzQf3cSXoX3vpDl+ETBHdbYV3JVKztGcjhBw77RhjZPritgzxD1lxk
        Y81KZ1kWRFMC7ABB27uD2M8goc4i6A94+pGZ9/Ublg==
X-Google-Smtp-Source: AMsMyM4rzQOVkVBtuVL7hnZkW9ofbYaogPcAQggjCSqL7tNLB01YTOQhg6IvJt6qfr6wbifv3YiXITiyFfiePq0Z374=
X-Received: by 2002:a17:90a:7b8c:b0:20b:1f3b:f6fd with SMTP id
 z12-20020a17090a7b8c00b0020b1f3bf6fdmr25515588pjc.202.1665482372756; Tue, 11
 Oct 2022 02:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <Yz6zfrVq9cP/wrJb@orome> <20221006130622.22900-1-pshete@nvidia.com>
 <20221006130622.22900-2-pshete@nvidia.com>
In-Reply-To: <20221006130622.22900-2-pshete@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Oct 2022 11:58:56 +0200
Message-ID: <CAPDyKFr_Yi2EgrBUzsORnM4mOkf25WR8+7_dfF2h4XzRDPm9-w@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mmc: sdhci-tegra: Add support to program MC stream ID
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     adrian.hunter@intel.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, anrao@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 at 15:07, Prathamesh Shete <pshete@nvidia.com> wrote:
>
> SMMU clients are supposed to program stream ID from
> their respective address spaces instead of MC override.
> Define NVQUIRK_PROGRAM_STREAMID and use it to program
> SMMU stream ID from the SDMMC client address space.
>
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 53 ++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index a6c5bbae77b4..e88294a6912d 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -25,6 +25,10 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/ktime.h>
> +#ifdef CONFIG_IOMMU_API
> +#include <linux/iommu.h>
> +#include <linux/bitops.h>
> +#endif
>
>  #include <soc/tegra/common.h>
>
> @@ -94,6 +98,8 @@
>  #define SDHCI_TEGRA_AUTO_CAL_STATUS                    0x1ec
>  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE                    BIT(31)
>
> +#define SDHCI_TEGRA_CIF2AXI_CTRL_0                     0x1fc
> +
>  #define NVQUIRK_FORCE_SDHCI_SPEC_200                   BIT(0)
>  #define NVQUIRK_ENABLE_BLOCK_GAP_DET                   BIT(1)
>  #define NVQUIRK_ENABLE_SDHCI_SPEC_300                  BIT(2)
> @@ -121,6 +127,7 @@
>  #define NVQUIRK_HAS_TMCLK                              BIT(10)
>
>  #define NVQUIRK_HAS_ANDROID_GPT_SECTOR                 BIT(11)
> +#define NVQUIRK_PROGRAM_STREAMID                       BIT(12)
>
>  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
>  #define SDHCI_TEGRA_CQE_BASE_ADDR                      0xF000
> @@ -177,6 +184,9 @@ struct sdhci_tegra {
>         bool enable_hwcq;
>         unsigned long curr_clk_rate;
>         u8 tuned_tap_delay;
> +#ifdef CONFIG_IOMMU_API

I would rather avoid these kinds of "#ifdef" micro optimizations.
Please just add the streamid without the #ifdef.

> +       u32 streamid;
> +#endif
>  };
>
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -1564,6 +1574,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
>                     NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
>                     NVQUIRK_ENABLE_SDR50 |
>                     NVQUIRK_ENABLE_SDR104 |
> +                   NVQUIRK_PROGRAM_STREAMID |
>                     NVQUIRK_HAS_TMCLK,
>         .min_tap_delay = 95,
>         .max_tap_delay = 111,
> @@ -1775,6 +1786,25 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>         if (rc)
>                 goto err_add_host;
>
> +       /* Program MC streamID for DMA transfers */
> +#ifdef CONFIG_IOMMU_API

Again, please drop the #ifdefs here.

We already have stub functions for dev_iommu_fwspec_get() in case
CONFIG_IOMMU_API is unset.

> +       if (soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
> +               struct iommu_fwspec *fwspec;
> +
> +               fwspec = dev_iommu_fwspec_get(&pdev->dev);
> +               if (fwspec == NULL) {
> +                       dev_warn(mmc_dev(host->mmc),
> +                               "iommu fwspec is NULL, continue without stream ID\n");
> +               } else {
> +                       tegra_host->streamid = fwspec->ids[0] & 0xff;
> +                       tegra_sdhci_writel(host, tegra_host->streamid |
> +                                               FIELD_PREP(GENMASK(15, 8),
> +                                               tegra_host->streamid),
> +                                               SDHCI_TEGRA_CIF2AXI_CTRL_0);
> +               }
> +       }
> +#endif
> +
>         return 0;
>
>  err_add_host:
> @@ -1861,6 +1891,10 @@ static int sdhci_tegra_suspend(struct device *dev)
>  static int sdhci_tegra_resume(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
> +#ifdef CONFIG_IOMMU_API

Ditto.

> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +#endif
>         int ret;
>
>         ret = mmc_gpio_set_cd_wake(host->mmc, false);
> @@ -1871,6 +1905,25 @@ static int sdhci_tegra_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> +       /* Re-program MC streamID for DMA transfers */
> +#ifdef CONFIG_IOMMU_API

Ditto.

> +       if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
> +               struct iommu_fwspec *fwspec;
> +
> +               fwspec = dev_iommu_fwspec_get(dev);
> +               if (fwspec == NULL) {
> +                       dev_warn(mmc_dev(host->mmc),
> +                               "iommu fwspec is NULL, continue without stream ID\n");
> +               } else {
> +                       tegra_host->streamid = fwspec->ids[0] & 0xff;
> +                       tegra_sdhci_writel(host, tegra_host->streamid |
> +                                               FIELD_PREP(GENMASK(15, 8),
> +                                               tegra_host->streamid),
> +                                               SDHCI_TEGRA_CIF2AXI_CTRL_0);
> +               }
> +       }
> +#endif
> +
>         ret = sdhci_resume_host(host);
>         if (ret)
>                 goto disable_clk;
> --
> 2.17.1
>

Kind regards
Uffe
