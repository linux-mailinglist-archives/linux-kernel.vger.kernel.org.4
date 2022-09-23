Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D735E8125
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiIWRwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiIWRwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:52:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03CA1296BE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:52:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f9so1459692lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WLQdaK0gT7iFIkMGG2NMmKLaRu6A337CioiY0oTqO2E=;
        b=dUkWHMuMmDgAf2vkZVtzFOS+JLlED/B066IP5RzSUvCf/2aFRmvtM05vuUDsDVXzlJ
         APKFud9ZtMhWd0Lt/ChVvQPkV+5K+U1/elv6+PXCzEbBXow5JjQR6WvLeBAJ29A7ZsTA
         m9SNpoDkcYwUcsb/r65zOSs8UfWWWpY6hyxx02uL8+/loZH2OvCr4h91vQ4z1tbvuOs7
         s/nl7DxGezKkrsj4GdRq5A3t21wdRiQioiLtSPxSRru/gpKfwM6sDyQTfK+FeQay9S4B
         6DKJII8QMc5UxXkCQy5Orkj4wlGQbOraDlPEgWcKk/v0w0u7x2JGqzKpvxNyUNVEitmX
         ZN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WLQdaK0gT7iFIkMGG2NMmKLaRu6A337CioiY0oTqO2E=;
        b=nfktFlFF89gJrdOLGQJaz5U5wNJzDhh9u7/cv86anyOWLzsvsp2FV6GYbInsuYExkS
         QSUqG7k6FvabCP4gfDlIrON9SkX8dJ1cvBKk0CgraG5/DYEvCFx2FxwNsmUrAj3Rhab1
         VQgtnohqUDvjixp8TS3ffR229TpH423audGdx1hFs9EYZZ3KW8RNAe3r1BfmOVtJUsqZ
         6kGsrJUKFraNWvBCjcIHuXru+tv5FS+i1PfZb04o4t782uwr9sAljAvIh4JKUdiWadUw
         3BQv/uQFZsoQ0zCVdzN8SwU2YJhBVePkn5Vil7hogUaz9wO8tjwgXnc6GIF9W8sSwQVE
         biiw==
X-Gm-Message-State: ACrzQf1n+1ysX9Vy6/w9P/8ggP8nYsAzCTlSZkx2PREVvNBR4meqzB88
        W83Jw8u41o1jCy4SoWTAxkLIdw==
X-Google-Smtp-Source: AMsMyM59xNDc63uKxqgHdn3zrL6X9DlwBW8qQ1eHQUJLbaKFVW8Qca/GcAlOeB3NAoyilxmKWNYGZA==
X-Received: by 2002:a05:6512:1114:b0:49f:d13e:25b6 with SMTP id l20-20020a056512111400b0049fd13e25b6mr3855353lfg.483.1663955570345;
        Fri, 23 Sep 2022 10:52:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c8-20020a05651200c800b0049a0832ffc9sm1542596lfp.211.2022.09.23.10.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 10:52:49 -0700 (PDT)
Message-ID: <c9c11931-7193-ebee-51f0-df863dd7377b@linaro.org>
Date:   Fri, 23 Sep 2022 19:52:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv2 3/3] mmc: dw_mmc-pltfm: socfpga: add method to configure
 clk-phase
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220922220308.609422-1-dinguyen@kernel.org>
 <20220922220308.609422-4-dinguyen@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220922220308.609422-4-dinguyen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 00:03, Dinh Nguyen wrote:
> The clock-phase settings for the SDMMC controller in the SoCFPGA
> Strarix10/Agilex/N5X platforms reside in a register in the System
> Manager. Add a method to access that register through the syscon
> interface.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: simplify clk-phase calculations
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 41 ++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 9901208be797..5d64984d382f 100644
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
> +#define SOCFPGA_DW_MMC_CLK_PHASE_STEP	45
> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
> +	((((smplsel) & 0x7) << 4) | (((drvsel) & 0x7) << 0))
> +
>  int dw_mci_pltfm_register(struct platform_device *pdev,
>  			  const struct dw_mci_drv_data *drv_data)
>  {
> @@ -62,9 +68,42 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
>  };
>  EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
>  
> +static int dw_mci_socfpga_priv_init(struct dw_mci *host)
> +{
> +	struct device_node *np = host->dev->of_node;
> +	struct regmap *sys_mgr_base_addr;
> +	u32 clk_phase[2] = {0}, reg_offset;
> +	int i, rc, hs_timing;
> +
> +	rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
> +	if (rc) {
> +		sys_mgr_base_addr =
> +			altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");

I don't see the reason why this is conditional. Just creates unnecessary
indentation.

> +		if (IS_ERR(sys_mgr_base_addr)) {
> +			pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
> +			return 1;
> +		}
> +	} else
> +		return 1;

Why not -ERRNO (or rc)?

> +
> +	of_property_read_u32_index(np, "altr,sysmgr-syscon", 1, &reg_offset);
> +
> +	for (i = 0; i < ARRAY_SIZE(clk_phase); i++)
> +		clk_phase[i] /= SOCFPGA_DW_MMC_CLK_PHASE_STEP;
> +
> +	hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
> +	regmap_write(sys_mgr_base_addr, reg_offset, hs_timing);
> +
> +	return 0;
> +}
> +
> +static const struct dw_mci_drv_data socfpga_drv_data = {
> +	.init		= dw_mci_socfpga_priv_init,
> +};
> +
>  static const struct of_device_id dw_mci_pltfm_match[] = {
>  	{ .compatible = "snps,dw-mshc", },
> -	{ .compatible = "altr,socfpga-dw-mshc", },
> +	{ .compatible = "altr,socfpga-dw-mshc", .data =&socfpga_drv_data, },

Missing space before &

>  	{ .compatible = "img,pistachio-dw-mshc", },
>  	{},
>  };

Best regards,
Krzysztof

