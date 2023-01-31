Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCED682DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjAaNWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjAaNWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:22:06 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD98B40F1;
        Tue, 31 Jan 2023 05:22:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so5015265wms.1;
        Tue, 31 Jan 2023 05:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jr1LFm9oA7+foo+bfSwGKpAHgIHcluy5xuCOann7pyQ=;
        b=HYCL6Z8jvYMOh3R1SPFZxahL/annJqPo4HTtLg8EFsx6FnL2WqrUtS3PeevzRryilE
         1RSzOuMRt15k8Sb4N1i8RgAti3ochDwPwvWwKRe6pXn7jV4wC092o0tXKUrSgHvcp8Kx
         tUg7A2l1wU1lkVTPnAwihysAPSS4zauzZeSb/KJrNQywkgXDVwNN313OfsqISgns3wMw
         R2HDv9iS2MwOdsLQFqSzz6jG9/Z4kzWhxfVQlP1hr4k60FdjK6zn28XATIc1dXDUP/xX
         q2BrIG96dy2vHNGz05hXCqx348YPB4BQDjHESI8KUMsNLfRqUh+zZQVKlkvw7NIibnBM
         Hnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr1LFm9oA7+foo+bfSwGKpAHgIHcluy5xuCOann7pyQ=;
        b=BSIcyvPsHTrWM4/AYG3tSoxcPJbnT4t5RmvkqtXLnf1sR8qE/794BEuVpqvYYLqmUv
         /scQlQ6EcHZdldU589ycKbGTOc/vyi3hb/jg8LKkHdtXUgM4+nmCVtwhCw9n6QiY7nH4
         xhbEtT15q53XLV+wyx731TtqIShZU/K0/jERxI/GVClhzaJp5tClPQzg2Tz5a4oP+Mbz
         O5C4fvmHC3V0/KaQDoGDl1doZoCQ1n0ZDP7mg6kPQIAdvmkyQCVXfOV9mqNL8WlXd86C
         WBfblWWqCrUL9DPgF9Qu85kKZpjm57QnbFebEzZH6TiVACm42CmnBGYMwyMJc+vGLYiA
         ry6A==
X-Gm-Message-State: AFqh2kpIzp8N5sPgoYHf03dCcIK0e0HCI6v0aPNFPI5HHV+uVSNlc+jH
        ZkvZFC1iV1Febl+0FnuB88SKQuOkqqM=
X-Google-Smtp-Source: AMrXdXuvvddG0FTWrGWrwSEzgoKZht0FgNrkaUZipnCC0rF/Ib9qQ06Mv+6JlCf/IPSVU6/AnWLrzw==
X-Received: by 2002:a05:600c:a4e:b0:3db:14d0:65be with SMTP id c14-20020a05600c0a4e00b003db14d065bemr48477657wmq.34.1675171324336;
        Tue, 31 Jan 2023 05:22:04 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j39-20020a05600c48a700b003db12112fcfsm1716851wmp.4.2023.01.31.05.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:22:03 -0800 (PST)
Message-ID: <3d9ba55f-68fb-3643-9ab5-dacb903a5996@gmail.com>
Date:   Tue, 31 Jan 2023 14:22:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 01/14] soc: mediatek: mtk-svs: restore default voltages
 when svs_init02() fail
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
 <20230111074528.29354-2-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-2-roger.lu@mediatek.com>
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
> If svs init02 fail, it means we cannot rely on svs bank voltages anymore.
> We need to disable svs function and restore DVFS opp voltages back to the
> default voltages for making sure we have enough DVFS voltages.
> 
> Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
> Fixes: 0bbb09b2af9d ("soc: mediatek: SVS: add mt8192 SVS GPU driver")
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mtk-svs.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 0469c9dfeb04..2df30a6bca28 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1461,6 +1461,7 @@ static int svs_init02(struct svs_platform *svsp)
>   {
>   	struct svs_bank *svsb;
>   	unsigned long flags, time_left;
> +	int ret;
>   	u32 idx;
>   
>   	for (idx = 0; idx < svsp->bank_max; idx++) {
> @@ -1479,7 +1480,8 @@ static int svs_init02(struct svs_platform *svsp)
>   							msecs_to_jiffies(5000));
>   		if (!time_left) {
>   			dev_err(svsb->dev, "init02 completion timeout\n");
> -			return -EBUSY;
> +			ret = -EBUSY;
> +			goto out_of_init02;
>   		}
>   	}
>   
> @@ -1497,12 +1499,30 @@ static int svs_init02(struct svs_platform *svsp)
>   		if (svsb->type == SVSB_HIGH || svsb->type == SVSB_LOW) {
>   			if (svs_sync_bank_volts_from_opp(svsb)) {
>   				dev_err(svsb->dev, "sync volt fail\n");
> -				return -EPERM;
> +				ret = -EPERM;
> +				goto out_of_init02;
>   			}
>   		}
>   	}
>   
>   	return 0;
> +
> +out_of_init02:
> +	for (idx = 0; idx < svsp->bank_max; idx++) {
> +		svsb = &svsp->banks[idx];
> +
> +		spin_lock_irqsave(&svs_lock, flags);
> +		svsp->pbank = svsb;
> +		svs_switch_bank(svsp);
> +		svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
> +		svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
> +		spin_unlock_irqrestore(&svs_lock, flags);
> +
> +		svsb->phase = SVSB_PHASE_ERROR;
> +		svs_adjust_pm_opp_volts(svsb);
> +	}
> +
> +	return ret;
>   }
>   
>   static void svs_mon_mode(struct svs_platform *svsp)
