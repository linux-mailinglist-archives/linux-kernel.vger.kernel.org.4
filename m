Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A66F749BB1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGFM3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGFM3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:29:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C900E171A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:29:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso6840045e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 05:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688646553; x=1691238553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrwyGG22yUz0pXaaxwTuGI5EuvBFjwW6o/zgDSSwkOQ=;
        b=Lgf1cOi+4+QGjJ6vTEGvJWc7DzjQzfv4w5BKVmRE40HSst27WRxPaOwU150CLSXJ4j
         BO+HNRiJ1qXMampj7+/nE6mFbHRSRf0vi+7jG1/JddtB6urUwJiinZj33ugaWTSzNx3q
         A4c2ryH1s9an3latetN75IwkfRPlx+fk842mO63qnWoz5ADaoP1OmvMep52wcA+K3mcU
         HOZGbBB1RR9daw2jLO6jKBkgYgxjCY0S8W/Pgwgrnybzzyh1Dvqv6138oMRL+ikpYh9g
         /NWnaO7yQrhKl1UcQTelDCmA6+H7SEthcRmzLsGS4kvwV+ZJ2Foy2cLZYpr3ZSiUsKyT
         5TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688646553; x=1691238553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrwyGG22yUz0pXaaxwTuGI5EuvBFjwW6o/zgDSSwkOQ=;
        b=f1xh6yKYDcMiXLQuGwlo2UbbDY6EYzXGp7W9ktjcC4rIRA+tJkE2tdjVI9rg29Sptl
         hglWnfhLAvfCJmLt2o8ESk+TaveqUobviUENGRb95IR2OEJtzeMo5Ar+3evn5Z5SUm47
         AV7bY0kcxmslBuUUcjD00rvDaOTO4c7FqadXCpJQ6L+r7BC/Ys4tuZB5CwyCV90nRvOZ
         b2FVugHT0wEjZVPMfGHcFXKwpvgC+zyP/MNzNnmpi8ikaugL1PXhpATmjcH1d98JnvmQ
         jGhWStwxaqrSRcDFJqEMbXu3ullHmXgmIolL/grDqUcvtQpCE4CnA+wnkvq6MkmJFjJt
         NM5w==
X-Gm-Message-State: ABy/qLbB/NyYkMx9EYMwVhxYHQ+PnwBp41I7ED6+oa6FbnRm51+RN9vi
        QX2xlyi62IDTZuy0RmgHMJXsWg==
X-Google-Smtp-Source: APBJJlENtsBPpzfe/86erIipmcvmcmpI0mPj2K7COvY/9J7rNN04Fa6U7vYjLisS/xtXgMELnlW8qQ==
X-Received: by 2002:a7b:c5d4:0:b0:3fa:9e61:19ed with SMTP id n20-20020a7bc5d4000000b003fa9e6119edmr1221201wmk.23.1688646553292;
        Thu, 06 Jul 2023 05:29:13 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id f14-20020adff44e000000b003142ea7a661sm1799342wrp.21.2023.07.06.05.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 05:29:12 -0700 (PDT)
Message-ID: <55c3a448-e6c6-5e04-2cee-b2a18f0033e3@baylibre.com>
Date:   Thu, 6 Jul 2023 14:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pwm: mtk_disp: fix disp_pwm coverity issue
Content-Language: en-US
To:     Shuijing Li <shuijing.li@mediatek.com>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
References: <20230706100454.28998-1-shuijing.li@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230706100454.28998-1-shuijing.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2023 12:04, Shuijing Li wrote:
> There is a coverity issue in the original mtk_disp_pwm_get_state()
> function. In function call DIV64_U64_ROUND_UP, division by expression
> Which may be zero has undefined behavior.
> Fix this accordingly.
> 
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> ---
>   drivers/pwm/pwm-mtk-disp.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index 79e321e96f56..ca00058a6ef4 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -196,6 +196,14 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
>   		return err;
>   	}
>   
> +	rate = clk_get_rate(mdp->clk_main);
> +	if (rate <= 0) {
> +		dev_err(chip->dev, "Can't get rate: %pe\n", ERR_PTR(rate));
> +		clk_disable_unprepare(mdp->clk_mm);
> +		clk_disable_unprepare(mdp->clk_main);
> +		return err;
> +	}
> +
>   	/*
>   	 * Apply DISP_PWM_DEBUG settings to choose whether to enable or disable
>   	 * registers double buffer and manual commit to working register before
> @@ -206,7 +214,6 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
>   					 mdp->data->bls_debug_mask,
>   					 mdp->data->bls_debug_mask);
>   
> -	rate = clk_get_rate(mdp->clk_main);
>   	con0 = readl(mdp->base + mdp->data->con0);
>   	con1 = readl(mdp->base + mdp->data->con1);
>   	pwm_en = readl(mdp->base + DISP_PWM_EN);

IMHO, it should be done int the function `mtk_disp_pwm_apply` too.
Do you agree ?

-- 
Regards,
Alexandre
