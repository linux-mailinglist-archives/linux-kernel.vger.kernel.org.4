Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122D95FA321
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJJSEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJJSEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:04:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B6378206;
        Mon, 10 Oct 2022 11:04:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y1so4255736pfr.3;
        Mon, 10 Oct 2022 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqm9CVgn+kW4HfPyiUnaMeFl30Q6IABDDhBs2wPsJt8=;
        b=A2PJRdVcfbhm6nKDfokFMdxjYrpiSG3A4L5AsylMNB7KWpc04WjyBf1DPB5kO4pZz6
         FHdpXDhtVD02kl7k145LFNvqafRpExtpXpvtiLiscsljc6GrdVbaMRyU5ZI9O9uuL95Q
         fVrvfW+B28HFKAPaZsLwIeww/gPenfcO6FdL9ikuvZDW3oBLTvcxAIAcy5Yqolty2SDo
         SXbpjGzqqFa5U/XEk1HqvY0a6ffFz6ScEQ0sa5HLpv0XcZYsFCLDUsWLTP3KOIi4PX4s
         BG/fjbo9bPuCikKWtlaZd1kJVUmukbZBGBr0JuAbPMCTzfTJ7q79Radhe1xeQlW+u/Af
         VLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqm9CVgn+kW4HfPyiUnaMeFl30Q6IABDDhBs2wPsJt8=;
        b=rn17EMxZeY8nElSH6YK1KOjHEgHm0JgVSulfRY3VzH+M1D5uhq9dZLUObg1c3xCxP0
         hsTzLS+y08fukIxLB6wIrLnahbHApUA6CX471dq0lW/4dEZDExnAJTzqJ/OH7YY8MvY6
         498IhK3HLQZDAmMmwduQ7KD5gaxpUrPSIszAEN66eeMBnjBAdghzdnS8RdQ9PpUr6CFb
         t2vR3nn1t3Yz69hqExhI+8i5vWaOQhs8dm9ncshb96b8e/mWNaJxAySkDrGvT+sFpBAd
         hQOvqxaMykxRrPdstl+6RybaEO8nBp+FogAuEAioz343cBC7gcSUMmEKNgU16RubpNtS
         1e0g==
X-Gm-Message-State: ACrzQf3nqOJE2YIiyc9ETiAHXQ6n3FM2h++xghU4wX4V2bsI089nqrS8
        TvrWsOd+XaNfkh54TWMWZsc=
X-Google-Smtp-Source: AMsMyM5J5FVo9mNe1Zc+Y7OpqNKgLUl0RAHmsZbJrDII9arkrOq1Q+BsxPnFewT4XfclXkbXoDbWGw==
X-Received: by 2002:a63:8ac2:0:b0:460:6480:8c59 with SMTP id y185-20020a638ac2000000b0046064808c59mr11102218pgd.472.1665425069945;
        Mon, 10 Oct 2022 11:04:29 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:bff:9bd3:c2da:5f42])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b00178ab008364sm7052943ple.37.2022.10.10.11.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:04:29 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:04:26 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v2 5/5] Input: mtk-pmic-keys: add MT6357 support
Message-ID: <Y0ReqmnLfKo20HO5@google.com>
References: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
 <20221005-mt6357-support-v2-5-f17ba2d2d0a9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mt6357-support-v2-5-f17ba2d2d0a9@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 04:57:25PM +0200, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add PMIC Keys support on MT6357 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please merge through MFD tree with the rest of the patches.

> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 9b34da0ec260..2a63e0718eb6 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/mt6323/registers.h>
>  #include <linux/mfd/mt6331/registers.h>
> +#include <linux/mfd/mt6357/registers.h>
>  #include <linux/mfd/mt6358/registers.h>
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6397/registers.h>
> @@ -90,6 +91,19 @@ static const struct mtk_pmic_regs mt6331_regs = {
>  	.rst_lprst_mask = MTK_PMIC_MT6331_RST_DU_MASK,
>  };
>  
> +static const struct mtk_pmic_regs mt6357_regs = {
> +	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6357_TOPSTATUS,
> +				   0x2, MT6357_PSC_TOP_INT_CON0, 0x5,
> +				   MTK_PMIC_PWRKEY_RST),
> +	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6357_TOPSTATUS,
> +				   0x8, MT6357_PSC_TOP_INT_CON0, 0xa,
> +				   MTK_PMIC_HOMEKEY_INDEX),
> +	.pmic_rst_reg = MT6357_TOP_RST_MISC,
> +	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
> +};
> +
>  static const struct mtk_pmic_regs mt6358_regs = {
>  	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
> @@ -276,6 +290,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
>  	}, {
>  		.compatible = "mediatek,mt6331-keys",
>  		.data = &mt6331_regs,
> +	}, {
> +		.compatible = "mediatek,mt6357-keys",
> +		.data = &mt6357_regs,
>  	}, {
>  		.compatible = "mediatek,mt6358-keys",
>  		.data = &mt6358_regs,
> 
> -- 
> b4 0.10.1

Thanks.

-- 
Dmitry
