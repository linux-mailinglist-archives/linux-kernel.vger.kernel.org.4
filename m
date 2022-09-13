Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209AF5B6EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiIMOA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiIMOAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:00:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A3613DFC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:00:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so13461708wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ntIzlODa8VHfVz9gaAWJZ+6KEvSuSPe+fV/RrMaRxgI=;
        b=JL6seYaEXYPiTaWHGPF7FCkGpC4o2c6grxWA9rfWEsEfxEj6dcYUFzGgj2cQBMIyYQ
         6lGuaQpXpI5+TlUMLZzoHvXPWLjWza8tiB688QY+qwcuMAC//BLZFbM2D+P5J2uusJEA
         PMz8l+Apv5et8f2+ePlK53Z4ix+DVpX3Cw+Kc3I7jTkhHc8NWZoKn6Wv7TQcoCIfra4D
         KQQzJgs/oWY+ghKZqmV5nQ/VI8tcxhsdj4IJeZjEC9zh1zwyxeLAHE8GREBoTpsdjoB4
         9xEZ+N6U7Jwk8Zl0tLeRepZQ1tlaRoCPT02pI59CpgUwq2JmhxFD9ZNbwQKBzx0LftEm
         MuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ntIzlODa8VHfVz9gaAWJZ+6KEvSuSPe+fV/RrMaRxgI=;
        b=FXIhWKKaEJuHZK4lthOuhBwRn7+bEbHV01pXP32wjPSiyHapXTZfbes1aIj8OLUXvF
         7T6KTk8iU3LObd78Q+0sGgXigMAHZz0VDYzVRz962vVMdxyyG9SQUoWAGKHh5Dsxc0LK
         ScSrBgo5SAIykklL/YJYbGCgHIUx5p5R0zuAO46S1Z4z7Dd8o6GbqI+RAdAcSIzcR/In
         v7ci7y4kQh0DhSBoT5NE3WZ0dZb4Tz/jsZQSYEgFv8KI5fKBqmFboO3jbUe9bx6UiK7J
         v5NKEYOwSAeGPG4pvtUc52d2upFKKyEP+rP9yW0+NQk8G1gc6NGIo0SgCKsxCUHqpOFG
         znIw==
X-Gm-Message-State: ACgBeo1AyYHq+sjiEceu10Vq3nqTV2dHRfH2CouVGoHvPfS66+rc6c3k
        c+34p6+ZLd5GGMdxIf6SzRCPFw==
X-Google-Smtp-Source: AA6agR7g5FY7wHdTehwMx55DpEZT3Z+gPuKa/lg/4WJyQ+Frjx8fhx7poC6RWkYD+0FuHdmLvbzpwg==
X-Received: by 2002:a05:600c:1c1b:b0:3b4:9504:98eb with SMTP id j27-20020a05600c1c1b00b003b4950498ebmr2584707wms.172.1663077619886;
        Tue, 13 Sep 2022 07:00:19 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.67])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c038a00b003b2878b9e0dsm13174284wmd.20.2022.09.13.07.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 07:00:19 -0700 (PDT)
Message-ID: <29758c95-e77a-5105-f03e-22ea94d9a569@linaro.org>
Date:   Tue, 13 Sep 2022 16:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 2/3] iommu/mediatek: Introduce new flag
 TF_PORT_TO_ADDR_MT8173
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, joro@8bytes.org
Cc:     yong.wu@mediatek.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org
References: <20220913122428.374280-1-angelogioacchino.delregno@collabora.com>
 <20220913122428.374280-3-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220913122428.374280-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 14:24, AngeloGioacchino Del Regno wrote:
> In preparation for adding support for MT6795, add a new flag named
> TF_PORT_TO_ADDR_MT8173 and use that instead of checking for m4u_plat
> type in mtk_iommu_hw_init() to avoid seeing a long list of m4u_plat
> checks there in the future.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 6 ++++--
>  drivers/memory/mtk-smi.c  | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 7e363b1f24df..b511359376f4 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -138,6 +138,7 @@
>  #define PM_CLK_AO			BIT(15)
>  #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
>  #define PGTABLE_PA_35_EN		BIT(17)
> +#define TF_PORT_TO_ADDR_MT8173		BIT(18)
>  
>  #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>  				((((pdata)->flags) & (mask)) == (_x))
> @@ -955,7 +956,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int ban
>  	 * Global control settings are in bank0. May re-init these global registers
>  	 * since no sure if there is bank0 consumers.
>  	 */
> -	if (data->plat_data->m4u_plat == M4U_MT8173) {
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, TF_PORT_TO_ADDR_MT8173)) {
>  		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
>  			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
>  	} else {
> @@ -1427,7 +1428,8 @@ static const struct mtk_iommu_plat_data mt8167_data = {
>  static const struct mtk_iommu_plat_data mt8173_data = {
>  	.m4u_plat     = M4U_MT8173,
>  	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
> -			HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM,
> +			HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM |
> +			TF_PORT_TO_ADDR_MT8173,
>  	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
>  	.banks_num    = 1,
>  	.banks_enable = {true},
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 5a9754442bc7..cd415ed1f4ca 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -462,6 +462,7 @@ static int mtk_smi_larb_sleep_ctrl_enable(struct mtk_smi_larb *larb)
>  	if (ret) {
>  		/* TODO: Reset this larb if it fails here. */
>  		dev_err(larb->smi.dev, "sleep ctrl is not ready(0x%x).\n", tmp);
> +		ret = -EAGAIN;

Doesn't look related nor explained in commit msg.


Best regards,
Krzysztof
