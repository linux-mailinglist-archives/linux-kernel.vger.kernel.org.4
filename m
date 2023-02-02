Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD74F687E1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjBBM7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjBBM7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:59:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84108DAF7;
        Thu,  2 Feb 2023 04:58:59 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l8so1319637wms.3;
        Thu, 02 Feb 2023 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQZR41yrW5hifouCNZEVZPyRGNsodM8y6hSfE7iNvTo=;
        b=fF3JCMiX8mkvTkT5ZNo23U6odnQTH86X2nhVU3HUY3oWQqr86PhE/TlYbaW6P9ri56
         K6HjUDAm9+Ei0geO39jUw6PgUjFUCYuvPb4hXwBQIKrQFGp3bJzK+lbuHnkA+W/k/WP7
         pNlcOEanFkGyuoMRgnh83tMu49orcHOcSZJNcIwYLkzOmu9ch71tn4ajXq28Ac39hiA7
         dl6oSyae5PuEig5OIzwmAOWt8REPFMGol4C5AVjfalkY3Y7hRx5TJMmwa/LCAFdR+RF4
         0Rb6GMSDijlPu3par9bQf7/xAnDXCTkBia5ee87Ctyp+xhttcaBU4kh7nI/bAqPnWLig
         wC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQZR41yrW5hifouCNZEVZPyRGNsodM8y6hSfE7iNvTo=;
        b=QssLH+xZf6I0LMh52xkkTTkMAC5lZ4GYkiv45yRPBBVSO+pMO8+kEqGbAfnR331bM8
         x0zGo8H7/7u3E3uEpspZjL38qjIyhifKEQKJDgDc+s402uWe/iBRsM9UCzycNIL/lRPN
         q0P+wGkFk6Y3oaR/uT1Ig8nGNrK0w3FYAU39jHy6IaCf5Qn/zMePjyHuCCxsSGfyJI1Q
         hn+OzHqk8IhZDoXba3QZ0qUUFG74Nn/+NqCWM5SG1SN8WzxjBi8SuaxPkvz/S2I6XN3K
         49K+W2gRe73ijY/sVd/SEQD05RbnIFJCz6G2R1vSz3Kxp3q4zQtLpKKXxorAbjvep0C7
         3q7Q==
X-Gm-Message-State: AO0yUKU7eWrs62Lixlkfh3LGjaPjtIlVeOJr+cCGxQ8uFpfPxXZMxoP3
        ZdBkiHeCYnc8B+90KFgGti8=
X-Google-Smtp-Source: AK7set9pYAcqCnIIQvL4N/6JISt2d16d/ib/NhPMpMkq2zH6UbXwe2ClBsTBzQ24W0EeUPf4C0sHkg==
X-Received: by 2002:a05:600c:1da2:b0:3dc:4313:fd1e with SMTP id p34-20020a05600c1da200b003dc4313fd1emr5743709wms.34.1675342738188;
        Thu, 02 Feb 2023 04:58:58 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c2e0600b003dcc82ce53fsm4530755wmf.38.2023.02.02.04.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 04:58:57 -0800 (PST)
Message-ID: <26837308-4837-f252-d162-f8af4859b63e@gmail.com>
Date:   Thu, 2 Feb 2023 13:58:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
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
 <20230202124104.16504-4-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 3/3] soc: mediatek: mtk-svs: add thermal voltage
 compensation if needed
In-Reply-To: <20230202124104.16504-4-roger.lu@mediatek.com>
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

Hi Roger,

I have some doubts, please see below.

On 02/02/2023 13:41, Roger Lu wrote:
> Some extreme test environment may keep IC temperature very low or very high
> during system boot stage. For stability concern, we add thermal voltage
> compenstation if needed no matter svs bank phase is in init02 or mon mode.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/soc/mediatek/mtk-svs.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 299f580847bd..e104866d1ab5 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -558,7 +558,7 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
>   	}
>   
>   	/* Get thermal effect */
> -	if (svsb->phase == SVSB_PHASE_MON) {
> +	if (!IS_ERR_OR_NULL(svsb->tzd)) {
>   		ret = thermal_zone_get_temp(svsb->tzd, &tzone_temp);
>   		if (ret || (svsb->temp > SVSB_TEMP_UPPER_BOUND &&
>   			    svsb->temp < SVSB_TEMP_LOWER_BOUND)) {
> @@ -573,7 +573,8 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
>   			temp_voffset += svsb->tzone_ltemp_voffset;
>   
>   		/* 2-line bank update all opp volts when running mon mode */
> -		if (svsb->type == SVSB_HIGH || svsb->type == SVSB_LOW) {
> +		if (svsb->phase == SVSB_PHASE_MON && (svsb->type == SVSB_HIGH ||
> +						      svsb->type == SVSB_LOW)) {
>   			opp_start = 0;
>   			opp_stop = svsb->opp_count;
>   		}
> @@ -589,11 +590,6 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
>   			/* do nothing */
>   			goto unlock_mutex;
>   		case SVSB_PHASE_INIT02:
> -			svsb_volt = max(svsb->volt[i], svsb->vmin);
> -			opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
> -							     svsb->volt_step,
> -							     svsb->volt_base);
> -			break;
>   		case SVSB_PHASE_MON:
>   			svsb_volt = max(svsb->volt[i] + temp_voffset, svsb->vmin);
>   			opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
> @@ -1683,7 +1679,7 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
>   			}
>   		}
>   
> -		if (svsb->mode_support & SVSB_MODE_MON) {
> +		if (!IS_ERR_OR_NULL(svsb->tzone_name)) {
>   			svsb->tzd = thermal_zone_get_zone_by_name(svsb->tzone_name);
>   			if (IS_ERR(svsb->tzd)) {
>   				dev_err(svsb->dev, "cannot get \"%s\" thermal zone\n",
> @@ -2127,6 +2123,7 @@ static struct svs_bank svs_mt8192_banks[] = {
>   		.type			= SVSB_LOW,
>   		.set_freq_pct		= svs_set_bank_freq_pct_v3,
>   		.get_volts		= svs_get_bank_volts_v3,
> +		.tzone_name		= "gpu1",
>   		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT,
>   		.mode_support		= SVSB_MODE_INIT02,
>   		.opp_count		= MAX_OPP_ENTRIES,
> @@ -2144,6 +2141,10 @@ static struct svs_bank svs_mt8192_banks[] = {
>   		.core_sel		= 0x0fff0100,
>   		.int_st			= BIT(0),
>   		.ctl0			= 0x00540003,
> +		.tzone_htemp		= 85000,
> +		.tzone_htemp_voffset	= 0,
> +		.tzone_ltemp		= 25000,
> +		.tzone_ltemp_voffset	= 7,

Which is the exact same tzone then in the other bank. Which brings me to a good 
point:
Is the tzone bank specific or the same for all banks?
At least for mt8192 they are not. I suppose with this change to the code mt8183 
could take advantage of this on all it's banks as well. In that case, can we 
start to restructure the struct svs_bank to only have the tzone values declared 
once?

Background is that I'm very unhappy with the svs_bank data strucutre. It seems 
like a "throw it all in here". It should be structured for functional parts of 
the banks. Maybe using structs, maybe unions where possible. In any case having 
a flat struct of over 50 members isn't really what we want.

Regards,
Matthias

>   	},
>   	{
>   		.sw_id			= SVSB_GPU,
