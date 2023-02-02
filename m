Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86822687DD6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjBBMr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjBBMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:47:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262548B7FD;
        Thu,  2 Feb 2023 04:47:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1286828wms.4;
        Thu, 02 Feb 2023 04:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaQNzpUAjABy/UuXZLlOvvbqix9SotqgoJqkxFf1bDI=;
        b=Dofe0UtJYuhFHBDhvyTjPY051/tbsKRICVxIYfMj5JzEAyp2XhCRekp3ml+P4V+LS9
         Z+LnmX3TS4gVgdva0YjNRrc46M5xVZGMEjqsy0kFVia2NTHodf4IpZfgn45bITRnCSSQ
         OoLQtyJr74R3iS7eaJNIbYaIn9jgZVaog4j7J4yWGR6PuuYbA92juuLjRQNQlFDqqd3V
         xHyjLlVs1lfaxINC1fy5PtatZqNQdCwCqes92EQ6v+nLOADICuBXGM2JLuglOUbdB+oD
         OmDkJX0nOY/VOH9Xory0LJQiyYbRxqmoS5LYcqfFQGV9U9gdxD0oXFvo1OhkT6k/JDFB
         nwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaQNzpUAjABy/UuXZLlOvvbqix9SotqgoJqkxFf1bDI=;
        b=JFIp225TvSVPWo1M3nTYvg9Cie07nrlBs81INySMwchPabU4/8GBR6nhzvS6RvC6Op
         hgcf0bD0pZqSDcqdjnFxlc/WOyW5HXjqxXssBRoEcub6zfgsyAm7dS1RKLN+kAvbV7AF
         PdCSGVxgOa7jOSG5MKS74lpbbYJbDKinZ0P25ZY7TwkmHkdD2X+IXHPqyZvGKPHGXgtU
         msk4viSwnnycDvk0sr13e6aEINJOk5N5ChKMkSG7guPQk6K2w0D6YqMtkU/7BSgU5AYC
         h+sMpk8vUT2w3uONgLZNCAhGSEjNTIGe8n9IMgl3p2uwxDV/q0/MMQZ414F7vopzpn6u
         mqSw==
X-Gm-Message-State: AO0yUKXTz7qahnkZJ37RT1C6giMeByTQfSD/oIqG62GYqmqMj5Yk7ib/
        0TfkhuQ4AfFCNqL9dOCRR3w=
X-Google-Smtp-Source: AK7set+x2AmWIDXdhFrfTy/bx8g3UJH2OP9HnUmuyCSGvsnxLo89d5Ks7yWreZh1w0d4SEIBf2+OWw==
X-Received: by 2002:a05:600c:3513:b0:3df:b5ae:5289 with SMTP id h19-20020a05600c351300b003dfb5ae5289mr2730154wmq.8.1675341990082;
        Thu, 02 Feb 2023 04:46:30 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003dafbd859a6sm5105962wmq.43.2023.02.02.04.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 04:46:29 -0800 (PST)
Message-ID: <2e616aea-0a38-b33e-20d5-0c6254cdd616@gmail.com>
Date:   Thu, 2 Feb 2023 13:46:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 2/3] soc: mediatek: mtk-svs: use common function to
 disable restore voltages
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230202124104.16504-1-roger.lu@mediatek.com>
 <20230202124104.16504-3-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230202124104.16504-3-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/02/2023 13:41, Roger Lu wrote:
> The timing of disabling SVS bank and restore default voltage is more
> than one place. Therefore, add a common function to use for removing
> the superfluous codes.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Queued for the next merge window.

Thanks!

> ---
>   drivers/soc/mediatek/mtk-svs.c | 54 ++++++++++++++--------------------
>   1 file changed, 22 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index c9899f5df60a..299f580847bd 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -624,6 +624,25 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
>   	return ret;
>   }
>   
> +static void svs_bank_disable_and_restore_default_volts(struct svs_platform *svsp,
> +						       struct svs_bank *svsb)
> +{
> +	unsigned long flags;
> +
> +	if (svsb->mode_support == SVSB_MODE_ALL_DISABLE)
> +		return;
> +
> +	spin_lock_irqsave(&svs_lock, flags);
> +	svsp->pbank = svsb;
> +	svs_switch_bank(svsp);
> +	svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
> +	svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
> +	spin_unlock_irqrestore(&svs_lock, flags);
> +
> +	svsb->phase = SVSB_PHASE_ERROR;
> +	svs_adjust_pm_opp_volts(svsb);
> +}
> +
>   #ifdef CONFIG_DEBUG_FS
>   static int svs_dump_debug_show(struct seq_file *m, void *p)
>   {
> @@ -700,7 +719,6 @@ static ssize_t svs_enable_debug_write(struct file *filp,
>   {
>   	struct svs_bank *svsb = file_inode(filp)->i_private;
>   	struct svs_platform *svsp = dev_get_drvdata(svsb->dev);
> -	unsigned long flags;
>   	int enabled, ret;
>   	char *buf = NULL;
>   
> @@ -716,16 +734,8 @@ static ssize_t svs_enable_debug_write(struct file *filp,
>   		return ret;
>   
>   	if (!enabled) {
> -		spin_lock_irqsave(&svs_lock, flags);
> -		svsp->pbank = svsb;
> +		svs_bank_disable_and_restore_default_volts(svsp, svsb);
>   		svsb->mode_support = SVSB_MODE_ALL_DISABLE;
> -		svs_switch_bank(svsp);
> -		svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
> -		svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
> -		spin_unlock_irqrestore(&svs_lock, flags);
> -
> -		svsb->phase = SVSB_PHASE_ERROR;
> -		svs_adjust_pm_opp_volts(svsb);
>   	}
>   
>   	kfree(buf);
> @@ -1508,16 +1518,7 @@ static int svs_init02(struct svs_platform *svsp)
>   out_of_init02:
>   	for (idx = 0; idx < svsp->bank_max; idx++) {
>   		svsb = &svsp->banks[idx];
> -
> -		spin_lock_irqsave(&svs_lock, flags);
> -		svsp->pbank = svsb;
> -		svs_switch_bank(svsp);
> -		svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
> -		svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
> -		spin_unlock_irqrestore(&svs_lock, flags);
> -
> -		svsb->phase = SVSB_PHASE_ERROR;
> -		svs_adjust_pm_opp_volts(svsb);
> +		svs_bank_disable_and_restore_default_volts(svsp, svsb);
>   	}
>   
>   	return ret;
> @@ -1563,23 +1564,12 @@ static int svs_suspend(struct device *dev)
>   {
>   	struct svs_platform *svsp = dev_get_drvdata(dev);
>   	struct svs_bank *svsb;
> -	unsigned long flags;
>   	int ret;
>   	u32 idx;
>   
>   	for (idx = 0; idx < svsp->bank_max; idx++) {
>   		svsb = &svsp->banks[idx];
> -
> -		/* This might wait for svs_isr() process */
> -		spin_lock_irqsave(&svs_lock, flags);
> -		svsp->pbank = svsb;
> -		svs_switch_bank(svsp);
> -		svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
> -		svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
> -		spin_unlock_irqrestore(&svs_lock, flags);
> -
> -		svsb->phase = SVSB_PHASE_ERROR;
> -		svs_adjust_pm_opp_volts(svsb);
> +		svs_bank_disable_and_restore_default_volts(svsp, svsb);
>   	}
>   
>   	ret = reset_control_assert(svsp->rst);
