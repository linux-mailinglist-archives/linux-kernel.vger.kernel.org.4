Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73816D780F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbjDEJ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbjDEJ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:26:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2DE4200
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:26:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e18so35488305wra.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 02:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680686792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j86FY1X3mQJSpSUEyPXpteWdgUQhvm2ft4SxXMxYnjA=;
        b=JZe6wEaenAlkzh6A+1SZGKPIIY7+28I3FbXLdAPA642CT61U15GFayMED3USy2vRur
         cnbsEM61d76fdpGl1Fp43vpXgh/pbVd1RNpCtrcxKxodCsLRcn2TD10MV6TChmFOcmxq
         bAfQZN/1MLLqUqBa5MuDi80FDwDM9rsv3Cr8bzvonlV68Q2now/PCsJPotFN5h0SDUpi
         1hSyWfVY6gTWtsYurymkF8JgnXpoxqfKd2QV368FNEQneJd0WzHoFGH6Q49synXoxzMC
         bduw8wIButE9cgIZUbMablcXnwTNxIbaY3B9Xb2wXBV6xb9UmOQhfaNb0MQWZikYiVMH
         FX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680686792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j86FY1X3mQJSpSUEyPXpteWdgUQhvm2ft4SxXMxYnjA=;
        b=akIjI2ddLZHXF6lT038Dsi6v8NJDMovlZG3imordjArABcJvpPWFhgNmFRnPuN9TvV
         PF0AjSimBfqRi79rr5c6ZUobAL5p8rZPZc7Q2uxNcucExuta+WGtOja4csZMTSskIHwV
         LumLDINjNyjkjMN5HUkQzHMH6lLkqeJEFsIVkft5LpvWjGcql4PoxdqtJ4LdJods38wU
         kstb/fGAKY9I9QYPNXuKI9SfYDBy+41Ws3dXAgDf5ihV2KD3rCT4+9jDzsoMpZlm1Yii
         BcXmn6d7xlsNzYtkP2SS1yRk+MXaaJ2PKbCKu23ZL2QGE3j8l/ZnZa1l6uR/WL+BHL7I
         ouEw==
X-Gm-Message-State: AAQBX9cwL5s+PyM7YVI00pVO/ELdWMB4833+RBf8i8ULWlkUjSLm/rJO
        w3CbP6U8gIrICou5CBwaFvBoHw==
X-Google-Smtp-Source: AKy350a42YeJ75k615TMGQYvStQrB2Lwyie5IHBEE2n0FdEzZ/N7NZ9pnWljziB9hk5G3LjzKvWGSA==
X-Received: by 2002:adf:e30e:0:b0:2c7:46f:c410 with SMTP id b14-20020adfe30e000000b002c7046fc410mr3314136wrj.36.1680686792347;
        Wed, 05 Apr 2023 02:26:32 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id s12-20020adfeccc000000b002da1261aa44sm14576762wro.48.2023.04.05.02.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 02:26:31 -0700 (PDT)
Message-ID: <b9c35799-7abf-116a-d0f4-531d1d3cd7b2@baylibre.com>
Date:   Wed, 5 Apr 2023 11:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RESEND 1/2] pwm: mtk-disp: Disable shadow registers before
 setting backlight values
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        weiqing.kong@mediatek.com, jitao.shi@mediatek.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, wenst@chromium.org,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
References: <20230403133054.319070-1-angelogioacchino.delregno@collabora.com>
 <20230403133054.319070-2-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230403133054.319070-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 15:30, AngeloGioacchino Del Regno wrote:
> If shadow registers usage is not desired, disable that before performing
> any write to CON0/1 registers in the .apply() callback, otherwise we may
> lose clkdiv or period/width updates.
> 
> Fixes: cd4b45ac449a ("pwm: Add MediaTek MT2701 display PWM driver support")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/pwm/pwm-mtk-disp.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index 692a06121b28..82b430d881a2 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -138,6 +138,19 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	high_width = mul_u64_u64_div_u64(state->duty_cycle, rate, div);
>   	value = period | (high_width << PWM_HIGH_WIDTH_SHIFT);
>   
> +	if (mdp->data->bls_debug && !mdp->data->has_commit) {
> +		/*
> +		 * For MT2701, disable double buffer before writing register
> +		 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
> +		 */
> +		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
> +					 mdp->data->bls_debug_mask,
> +					 mdp->data->bls_debug_mask);
> +		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
> +					 mdp->data->con0_sel,
> +					 mdp->data->con0_sel);
> +	}
> +
>   	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
>   				 PWM_CLKDIV_MASK,
>   				 clk_div << PWM_CLKDIV_SHIFT);
> @@ -152,17 +165,6 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   		mtk_disp_pwm_update_bits(mdp, mdp->data->commit,
>   					 mdp->data->commit_mask,
>   					 0x0);
> -	} else {
> -		/*
> -		 * For MT2701, disable double buffer before writing register
> -		 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
> -		 */
> -		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
> -					 mdp->data->bls_debug_mask,
> -					 mdp->data->bls_debug_mask);
> -		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
> -					 mdp->data->con0_sel,
> -					 mdp->data->con0_sel);
>   	}
>   
>   	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,

Hi,

I've made a non-regression test for the mt8365-evk (i350-evk) board.
It's fine for me.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>

Regards,
Alex
