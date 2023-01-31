Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5EB682E27
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjAaNk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjAaNkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:40:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C59B5143F;
        Tue, 31 Jan 2023 05:40:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so10646323wmq.0;
        Tue, 31 Jan 2023 05:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFfnKzW9khIrRw3lbxbS734cPxF5yNl0uJsJQazws/8=;
        b=T9+RLizSsnKshbSBWeeW9niEYTMA4aK8QJGntvDs58DAs2bQE5DmB4KM2UrFxz47yv
         9xgskCl2Vu+Nb69q9FZp2QbJCBe6M8AB9KpwlJJ3Z/5Z7/kQaTiNioV37W9XH+G0IxTJ
         QDelaSU9HpVExuchwQ2L/HoUDh/NC5KnSAbim6YHbYE1wrNWw8LzmC8tyT/37jMGFoq0
         UtLjzEs91A/9qgC7ZmHAMRMZJKdlEjxHy8lcIxY2tOMNhb6ZBwii8EOCJOPFJeSMDSUV
         JjBeqqCLDxKKg1C/51MXUSgN8qCPJp/LqaK8xADKrMUWiIgDcZVPGZf7wqIenJeOwEWP
         bH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFfnKzW9khIrRw3lbxbS734cPxF5yNl0uJsJQazws/8=;
        b=lI8D8zCcTTZl8GA9ZDPVBGN6YwztNDqlkc6EWUYfW/EhoeH/22dOvsmf/23Zijkuyf
         4uO8MWoctGld6z97UgdY8zivCwQxl6MtOUKGiW2svo8nesVBeDCmn5fOJWP+w66ZtQPj
         Qi783ALvKIxiKNlzRSOQgcl7Y6SxaC15v5JZkuxAtEL6hYd8ttUhQhjWsmiUQVlpHh6m
         BSemt77GY0B2lRHCLl4K151r8nnwFKDbrO7xnGXc0xVXCDO9oJa7oovSwrNJiloNa4Pg
         uNUk1Ek3uGScOUcvJfTgxD8nCXijoiR+Pop7n2Jaqt91ixCkat4BU3JkqFNzJxJDsXFD
         3hzw==
X-Gm-Message-State: AO0yUKW9L/yd4ImC5jLjVbzOGoXi3IrD91TIdrySKASv3RAsEeJ9zY5l
        UAB8s1evUBhah4dPD+0Spc8=
X-Google-Smtp-Source: AK7set88Xp9NVoXxldr7uLaJ0otyv5du9npLziyeCkNyEz4Sim7shGX6WN1XMa+HkK5cSNS3PfTbjA==
X-Received: by 2002:a1c:7312:0:b0:3dd:62fe:9914 with SMTP id d18-20020a1c7312000000b003dd62fe9914mr2100438wmb.18.1675172421680;
        Tue, 31 Jan 2023 05:40:21 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p7-20020a1c5447000000b003dc433355aasm12513740wmi.18.2023.01.31.05.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:40:21 -0800 (PST)
Message-ID: <64702a9b-6c78-3065-8335-28d31c6fc1ab@gmail.com>
Date:   Tue, 31 Jan 2023 14:40:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 13/14] soc: mediatek: mtk-svs: use common function to
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
References: <20230111074528.29354-1-roger.lu@mediatek.com>
 <20230111074528.29354-14-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-14-roger.lu@mediatek.com>
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



On 11/01/2023 08:45, Roger Lu wrote:
> The timing of disabling SVS bank and restore default voltage is more
> than one place. Therefore, add a common function to use for removing
> the superfluous codes.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Same here, change looks good. Could you please rebase and resend:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/soc/mediatek/mtk-svs.c | 54 ++++++++++++++--------------------
>   1 file changed, 22 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index a7f0a6f02d52..89117807e85d 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -648,6 +648,25 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
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
> @@ -724,7 +743,6 @@ static ssize_t svs_enable_debug_write(struct file *filp,
>   {
>   	struct svs_bank *svsb = file_inode(filp)->i_private;
>   	struct svs_platform *svsp = dev_get_drvdata(svsb->dev);
> -	unsigned long flags;
>   	int enabled, ret;
>   	char *buf = NULL;
>   
> @@ -740,16 +758,8 @@ static ssize_t svs_enable_debug_write(struct file *filp,
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
> @@ -1532,16 +1542,7 @@ static int svs_init02(struct svs_platform *svsp)
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
> @@ -1587,7 +1588,6 @@ static int svs_suspend(struct device *dev)
>   {
>   	struct svs_platform *svsp = dev_get_drvdata(dev);
>   	struct svs_bank *svsb;
> -	unsigned long flags;
>   	int ret;
>   	u32 idx;
>   
> @@ -1599,17 +1599,7 @@ static int svs_suspend(struct device *dev)
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
