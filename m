Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39836607885
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiJUNcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiJUNca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:32:30 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A111C272119
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:32:22 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a5so1984015qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+e3tfZKD8wPLq+xcmy+Hq7e5zoVdL8VVcXpDbD3Ib4=;
        b=Yx8xloWDhbEQ67y0pJkRiQj2ByUZYLHTkUmjgXvkWGU/moYFskJONIRkSscwkXJuKl
         7RSpTwuxzRQhww/X3kFwMir6d0xDIAwHLFDpaPpShmyrrrh3dvf+wLup6XNfeG+hgrYY
         MMdOUkLsv/m9pSrImhvsnUUeWLn/3lyk78qiq4fhkZn7sso9wygWmffE/9B2E9U4zaqu
         2KI6roiiVu+XhxlVNWv7WQ4Vql2wJ+91YP3jejvsL9cxAhBtU8iiIFdxBvAbv9uFnLCd
         NV6qtkS//cq2mEUw7E1JJWEsebbN2i+T+DLSeeSCHl40e9ODk871N2jg+j5D+ASwq9EA
         /K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+e3tfZKD8wPLq+xcmy+Hq7e5zoVdL8VVcXpDbD3Ib4=;
        b=iVzyJHGX7mQUVGFWVJkxegojGFqXjzlicSBxVWHSGcV5rjxRsJbVWQGaT6ORxXZY/d
         MSZZhn7IHre7vqdwlAOtm68AFxLNsyt8fnw5qXURXQ6G8EBd1JaNXH+cZEQ8IcmmHK+7
         12BN2umwNgCvTuk3aSLkNcwfBs2Hnc914bwZE8tC4QkCTD/LSluhMVXnc/jRQdqSWSar
         b38D1o2RuqvAuY9+vYpnFZSZPHJwAFjs0CsQ1n+JB6RgOYWmVoO2JGAcyM76nlPZ/q2K
         D/o6i4gr8WNx0ReWnACUKnEmBt+DCxWCfwKtyJwHc3v83Tarp6qjBrqD6bHcQalntHKF
         +O2g==
X-Gm-Message-State: ACrzQf22fjYVACaqdtCr/JeSVXF3YCaN+xWtW7pEaM5M6jZaYdJqqzIb
        6I27C+0Jg9X3alrZCj6PWtMBVg==
X-Google-Smtp-Source: AMsMyM6u87pLEnDFK4teTs0zAB89izZ7kLNHzzpukigPaqu6PxsLer0iBEt8sYL/DMFxF9c/ggx3Tg==
X-Received: by 2002:ae9:ef4e:0:b0:6ee:80b6:2ee4 with SMTP id d75-20020ae9ef4e000000b006ee80b62ee4mr13415282qkg.126.1666359140868;
        Fri, 21 Oct 2022 06:32:20 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id l3-20020a37f903000000b006ee2953fac4sm9387945qkj.136.2022.10.21.06.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 06:32:20 -0700 (PDT)
Message-ID: <b74f37ba-d2e3-ab73-a035-739ffb2b0334@linaro.org>
Date:   Fri, 21 Oct 2022 09:32:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCHv5 4/6] mmc: dw_mmc-pltfm: socfpga: add method to configure
 clk-phase
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221019170657.68014-1-dinguyen@kernel.org>
 <20221019170657.68014-5-dinguyen@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019170657.68014-5-dinguyen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 13:06, Dinh Nguyen wrote:
> The clock-phase settings for the SDMMC controller in the SoCFPGA
> platforms reside in a register in the System Manager. Add a method
> to access that register through the syscon interface.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v5: change error handling from of_property_read_variable_u32_array()
>     support arm32 by reading the reg_shift
> v4: no change
> v3: add space before &socfpga_drv_data
> v2: simplify clk-phase calculations
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 43 ++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 9901208be797..74421d13f466 100644
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
> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel, reg_shift) \
> +	((((smplsel) & 0x7) << reg_shift) | (((drvsel) & 0x7) << 0))
> +
>  int dw_mci_pltfm_register(struct platform_device *pdev,
>  			  const struct dw_mci_drv_data *drv_data)
>  {
> @@ -62,9 +68,44 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
>  };
>  EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
>  
> +static int dw_mci_socfpga_priv_init(struct dw_mci *host)
> +{
> +	struct device_node *np = host->dev->of_node;
> +	struct regmap *sys_mgr_base_addr;
> +	u32 clk_phase[2] = {0}, reg_offset, reg_shift;
> +	int i, rc, hs_timing;
> +
> +	rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
> +	if (rc < 0) {
> +		dev_err(host->dev, "clk-phase-sd-hs not found!\n");
> +		return rc;
> +	}
> +
> +	sys_mgr_base_addr = altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
> +	if (IS_ERR(sys_mgr_base_addr)) {
> +		dev_err(host->dev, "failed to find altr,sys-mgr regmap!\n");
> +		return -ENODEV;

Isn't this now an ABI break? I have an impression we talked about this...

Best regards,
Krzysztof

