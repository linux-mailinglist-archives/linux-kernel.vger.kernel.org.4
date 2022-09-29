Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3EB5EF42C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiI2LVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiI2LVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:21:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1521126B72
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:21:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so1043730pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sCaynwcp4f26Qsuas0gm084M63BBFBWC/hIFRDkk3Uw=;
        b=tegmkaiPhW3cNmFDnub5MjTxArl0I20BRME+tLmlGxvQMKqNELC4Lu0bz+FdmpapSG
         +6LU34q2RN17fs/xdyQaxIobLucq+S4NEAoF3PPkmOcwY+7o/4d+mnFK7Merc18/aND3
         J2dHhtSk5ULfx1fCST65ll60SPlMrxErT/AKm6jcOC5Ye7TZdSqbpDBZjWel0BjD5xnI
         4GsuK+xI+zyKEAARB3ktNSqOOCYfzHXV20YDfI6W3+/Xr47YJLOCS2bg5G05aTdNJk/v
         C/qfztBwtKKt3oI566phuyGXKMY6wzYdNsZq3vaUEzgVbjnh9HAM1PMdoq31Z+S/UJb3
         M5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sCaynwcp4f26Qsuas0gm084M63BBFBWC/hIFRDkk3Uw=;
        b=gIOHitSmePI6AIGDawUzm5L3vtuIlwNUhbPWUQTAg25TtlxV1IVs6XNEGKWAgbUpuw
         u3+ZiYpdng89BwVzhk/fvPytpsoTlSAa3KDyWc1anU083e62cWuFl1iXu+Es6wrn6k0U
         y6SyjdtOIUg3YfOdPy/54V27xrO+E/oZtrYlIJQF1hJt29eV+Yiqn5M79Y+ZpQzyNg9v
         X/6dZF1WJw3t2wV8FFe9SL1EQjaklfc9qnpIcUrvxJyrHM46eJG4lbckMgK2mn8DIKMW
         YrwM/Ha3gPPOMSlCAQ+LPw9PK4Jg3DeYpyj6tBk6YECaaAkLtJ6SfBf5FhrwniX/BgAI
         Kz9Q==
X-Gm-Message-State: ACrzQf10G+phM5uygXfhE4xxaZ+3MvMUGHRFKRAvBGrprrPya2Udgnny
        mxFz1MzqKNOYZXl5XA0K0f7Qc3DFE10n1aEZ/W/xzg==
X-Google-Smtp-Source: AMsMyM7PjjksYIL3HcmPj9LulM/zObjITKi55mnpApJWRDOIQBM+olQxhw0R6qsZVsb6XY5E4dAqRQBy4y7gVobhsvg=
X-Received: by 2002:a17:90a:aa96:b0:205:bb67:a85f with SMTP id
 l22-20020a17090aaa9600b00205bb67a85fmr3169404pjq.202.1664450465517; Thu, 29
 Sep 2022 04:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220928165420.1212284-1-dinguyen@kernel.org> <20220928165420.1212284-3-dinguyen@kernel.org>
In-Reply-To: <20220928165420.1212284-3-dinguyen@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Sep 2022 13:20:28 +0200
Message-ID: <CAPDyKFpF3rxYiHVeDyUCirciQKzrOJjPayZFQkFCoX6JXf8P1Q@mail.gmail.com>
Subject: Re: [PATCHv4 3/3] mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sept 2022 at 18:54, Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> The clock-phase settings for the SDMMC controller in the SoCFPGA
> Strarix10/Agilex/N5X platforms reside in a register in the System
> Manager. Add a method to access that register through the syscon
> interface.
>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v4: no change
> v3: add space before &socfpga_drv_data
> v2: simplify clk-phase calculations
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 41 ++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 9901208be797..0f07fa6d0150 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -17,10 +17,16 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
> +#include <linux/mfd/altera-sysmgr.h>
> +#include <linux/regmap.h>
>
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
>
> +#define SOCFPGA_DW_MMC_CLK_PHASE_STEP  45
> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
> +       ((((smplsel) & 0x7) << 4) | (((drvsel) & 0x7) << 0))
> +
>  int dw_mci_pltfm_register(struct platform_device *pdev,
>                           const struct dw_mci_drv_data *drv_data)
>  {
> @@ -62,9 +68,42 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
>  };
>  EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
>
> +static int dw_mci_socfpga_priv_init(struct dw_mci *host)
> +{
> +       struct device_node *np = host->dev->of_node;
> +       struct regmap *sys_mgr_base_addr;
> +       u32 clk_phase[2] = {0}, reg_offset;
> +       int i, rc, hs_timing;
> +
> +       rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
> +       if (rc) {

This looks wrong, as rc may contain a negative error code,when there
is no clk-phase-sd-hs property found.

Instead, we probably want to check "if (rc < 0)" here instead, then
bail out, but without breaking backwards compatibility.

> +               sys_mgr_base_addr =
> +                       altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
> +               if (IS_ERR(sys_mgr_base_addr)) {
> +                       pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
> +                       return 1;
> +               }
> +       } else
> +               return 1;
> +
> +       of_property_read_u32_index(np, "altr,sysmgr-syscon", 1, &reg_offset);
> +
> +       for (i = 0; i < ARRAY_SIZE(clk_phase); i++)
> +               clk_phase[i] /= SOCFPGA_DW_MMC_CLK_PHASE_STEP;
> +
> +       hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
> +       regmap_write(sys_mgr_base_addr, reg_offset, hs_timing);
> +
> +       return 0;
> +}
> +
> +static const struct dw_mci_drv_data socfpga_drv_data = {
> +       .init           = dw_mci_socfpga_priv_init,
> +};
> +
>  static const struct of_device_id dw_mci_pltfm_match[] = {
>         { .compatible = "snps,dw-mshc", },
> -       { .compatible = "altr,socfpga-dw-mshc", },
> +       { .compatible = "altr,socfpga-dw-mshc", .data = &socfpga_drv_data, },
>         { .compatible = "img,pistachio-dw-mshc", },
>         {},
>  };
> --
> 2.25.1
>

Kind regards
Uffe
