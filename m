Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811305FEEC3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJNNi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJNNiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:38:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B8C1CF54D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:38:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h10so4781059plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fim10Nn883YUuRB2/zDNHur11GszoVSITqSX1+3i+0g=;
        b=bs7c64n6kbvSh5qiJsiElDDFXFU1VVybCgFb6Lkt0knUuNLMmDDQFoAba8s7bOm6tc
         HBXZ/k7XqDvFn2taimFdCCw35vtrJ9cnU7Puqc0NbAtrEgInxi065txtnd+a7zfNDhXq
         JFHULWlzRvUFdZ0jjry0MNw0WXPeyDvMdMPDvU0AATLo/3264KC8HPBp2XDrkrmz+/Ts
         +VdbQAPDxQmrp0qPpfy4tcSx63LcXOHZDC/L5Y0L9yTNozWxGouAqNF/SDPtBzH0wrin
         kZqojhBj0upDKWISx1YKO8Oi4480ftPuz86dG+hJF+deJEqIxjH2S9K1NFADuSOt0Evn
         Be/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fim10Nn883YUuRB2/zDNHur11GszoVSITqSX1+3i+0g=;
        b=8O+UgHLj3NKPNLw5F8HzVvLN1IFFLlwwPjY91yq6+yNxxC3Mb0sVHejudLwiDEYhXn
         Zke7YPnlCXxQj9OyGssVTtsgatBAydHyIzuhBg2uiZ0Zl2E+f+ZtSocQ7oZHSUJL/sPP
         4r9kEhFxUW172db///kWqzuyNKOMKjSqf20tVCk+TfGbByU7R7D7oJgd/DadJ6C+SprE
         ISTShKcShnmg8H01gMI4chkkL7O7DvO0MPZLt2WO+EAZrS5TI0nzI5xku7wvW7KjGgaI
         AugmexhmbD/05BXj1wOFgVkrf3W6XFBzlxjYTKdt8rau8d1RE0NXxJPaQ4Y2NqnQlTX2
         1lBw==
X-Gm-Message-State: ACrzQf26Rrpn9yRAALEPKxdh8Gijj/G1ah610qUJ22m0eOKkDnstdccF
        G1oyd0yWBW7IxNY8Ubv4mp9HrWGOVkYgtNfBBqPy7A==
X-Google-Smtp-Source: AMsMyM6IyYAWSgGy7Wfh5gYeg/kE2f9/kZGqWyNKDL/n4TD+JNio2ZbU9nxwvu6gC+RdB+bq8FYZptK2XTDEibOl1Hc=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr17878182pjb.164.1665754733353; Fri, 14
 Oct 2022 06:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFq5hNTdwT7CMvsxG=_5u+xvG2k3-PfbGhAbHfHbGqK81w@mail.gmail.com>
 <20221014072456.28953-1-pshete@nvidia.com> <20221014072456.28953-2-pshete@nvidia.com>
In-Reply-To: <20221014072456.28953-2-pshete@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Oct 2022 15:38:16 +0200
Message-ID: <CAPDyKFoJS8oewB71Swo2dBsfG3qsBf+fWbWn3rfL8Acdh0zqKQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] mmc: sdhci-tegra: Add support to program MC stream ID
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     adrian.hunter@intel.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, anrao@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 at 09:25, Prathamesh Shete <pshete@nvidia.com> wrote:
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
>  drivers/mmc/host/sdhci-tegra.c | 42 ++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index a6c5bbae77b4..0cd7c3f7e6f4 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -25,6 +25,10 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/ktime.h>
> +#ifdef CONFIG_IOMMU_API

This ifdef can be removed, the compiler should sort this out for us.

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
> @@ -1630,6 +1641,33 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
>         return ret;
>  }
>
> +/* Program MC streamID for DMA transfers */
> +#ifdef CONFIG_IOMMU_API
> +static void program_stream_id(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +       struct iommu_fwspec *fwspec;
> +
> +       if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
> +               fwspec = dev_iommu_fwspec_get(dev);
> +               if (!fwspec) {
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
> +}
> +#else
> +static void program_stream_id(struct device *dev) { }
> +#endif
> +
>  static int sdhci_tegra_probe(struct platform_device *pdev)
>  {
>         const struct sdhci_tegra_soc_data *soc_data;
> @@ -1775,6 +1813,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>         if (rc)
>                 goto err_add_host;
>
> +       program_stream_id(&pdev->dev);
> +
>         return 0;
>
>  err_add_host:
> @@ -1871,6 +1911,8 @@ static int sdhci_tegra_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> +       program_stream_id(dev);
> +
>         ret = sdhci_resume_host(host);
>         if (ret)
>                 goto disable_clk;
> --
> 2.17.1
>

Other than the minor nitpick, this looks good to me!

Kind regards
Uffe
