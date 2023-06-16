Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422B57333B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345441AbjFPOfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbjFPOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:35:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A50630EF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:35:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f78a32266bso6904655e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686926111; x=1689518111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTmK7Yo9kOdMiFpI4ABNY0faae2/HSfAxiI+PtYHiC8=;
        b=A9jJzABZw2QMnOVwswzAgH2NzPjhWBi1MIrHPxQWt1X9oKMFiioJZrhgP7sbhqfnMO
         7NV2ETpGP45ubS7Wi4FpeCN4ucSIEvggOjj6zSAdjoIgIDMMMzBqLvDn2JC1/hstYoke
         aX/AW65KCOo+xeZvCoAy1IkMapB3sWLrya1tAS6ESVABrXlnyiVCoVVl1T2lAjTrLtAR
         JHQ1g+aXqVb82IfVhxqkUlv0ROkc/KWDb0/JbFZyF1ZraEWPgvH0QfY4FKbpI1PRRn8q
         aslzS41Zud/Glmwd1AX8Buig639YkGrks+u5iOvdo0Q+95d1/BczmMt4P34/+MzSK7u8
         Pb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686926111; x=1689518111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTmK7Yo9kOdMiFpI4ABNY0faae2/HSfAxiI+PtYHiC8=;
        b=cn0Oxpoq7LnFRO5UMnqRyJ8PZdghYb7UR1ZQgioi+rfP//zS9Rws3cN3TVVivu339X
         LKcF/Ml9zbb7RNK3ZlNfoLYsD5FmrT+RIMurPzhaq8VdkzSt/Y7ad5r5LDVGV+HMa/JC
         R0uSXTqxcxMdkjSz7Ebbxd0LNd0y0GCaXntvmmY5SukSef2mK6MdxkV/X3SqZSnngVir
         KxKKN3Ri7HRpVfZb615WEfL7WE+Vur2majfqXfw8QY9ArVcL8PAVHVfI/8DeVLqtz/Pa
         AFKIL5RW3jEuDfS1HTWUcAbAaKwhIc9QFWBlZcZL320lM8HT8u+beuoJM3zHr+QzbXRe
         A0iw==
X-Gm-Message-State: AC+VfDw3lBpBrTN74FUt1XgoVQJBwunHD3fQwMPBOiHroJE2oPQ8yspQ
        ofEoryFSGpKkqP+wUwGwy2bOCA==
X-Google-Smtp-Source: ACHHUZ7J6rlw+Fu3K5IsLp/iIjwzEW1tdtEmQfR2zgPHjO4vSOqCrrPckqYA5PhhXFfkmkRDMo1ybA==
X-Received: by 2002:a1c:7204:0:b0:3f7:e8e2:f377 with SMTP id n4-20020a1c7204000000b003f7e8e2f377mr2117276wmc.12.1686926110725;
        Fri, 16 Jun 2023 07:35:10 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:4aa0:8c56:eebe:c05c? ([2a05:6e02:1041:c10:4aa0:8c56:eebe:c05c])
        by smtp.googlemail.com with ESMTPSA id n20-20020a1c7214000000b003f78fd2cf5esm2328344wmc.40.2023.06.16.07.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 07:35:10 -0700 (PDT)
Message-ID: <9c12ece8-3a85-105b-d8d3-208fe816734a@linaro.org>
Date:   Fri, 16 Jun 2023 16:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal/drivers/loongson2: Fix thermal zone private data
 access
Content-Language: en-US
To:     zhuyinbo@loongson.cn
Cc:     rafael@kernel.org, loongson-kernel@lists.loongnix.cn,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <8ca44091-35fd-cc24-9896-0317772c5620@loongson.cn>
 <20230616143407.689515-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230616143407.689515-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 16:34, Daniel Lezcano wrote:
> The thermal zone device won't be accessible directly anymore.
> 
> Use the private data accessor.

To be folded with your next version

Thanks

> Cc: zhuyinbo <zhuyinbo@loongson.cn>
> Cc: Yinbo Zhu <zhuyinbo@loongson.cn>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/loongson2_thermal.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
> index 6a338e6e490e..9a07409c3bd2 100644
> --- a/drivers/thermal/loongson2_thermal.c
> +++ b/drivers/thermal/loongson2_thermal.c
> @@ -56,7 +56,7 @@ static int loongson2_thermal_set(struct loongson2_thermal_data *data,
>   static int loongson2_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>   {
>   	u32 reg_val;
> -	struct loongson2_thermal_data *data = tz->devdata;
> +	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
>   
>   	reg_val = readl(data->regs + LOONGSON2_TSENSOR_OUT);
>   	*temp = ((reg_val & 0xff) - 100) * 1000;
> @@ -67,7 +67,7 @@ static int loongson2_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>   static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
>   {
>   	struct thermal_zone_device *tzd = dev;
> -	struct loongson2_thermal_data *data = tzd->devdata;
> +	struct loongson2_thermal_data *data = thermal_zone_device_priv(tzd);
>   
>   	/* clear interrupt */
>   	writeb(0x3, data->regs + LOONGSON2_TSENSOR_STATUS);
> @@ -79,7 +79,7 @@ static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
>   
>   static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
>   {
> -	struct loongson2_thermal_data *data = tz->devdata;
> +	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
>   
>   	return loongson2_thermal_set(data, low/1000, high/1000, true);
>   }

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

