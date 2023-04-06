Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8416D9F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbjDFRrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbjDFRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:47:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6D6E4C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:47:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id br6so51811323lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680803232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2kphCzdyI8pFLM0XEcu5T4v/H3byCGSRbAeet3UKsQ=;
        b=wDBvHwA7TFNy7JGBWgBcjPeqww2KMYjGxDTyJpfdjbn0yRz8IK9VkJ4QLV8oYvMcNS
         UY+DsmQUN6SprUkBpgwlb6AdcA3jCYnvT2SComMrNGqJcJmgST5wbMpZ7ime7Gg/iRgI
         k4OxRtFGDhZRrnuisEoVwNZg2ZjVStRNpIrGLL/yM/OtLIgBR61+udnwaw4a+2FAgTzB
         tXRjfrpy6amxqkiAd6Oc5f6PF0/5qxN7Iino3SXatzD63d64Wvw2PP6ion3O9tFZIpVv
         vKZbRKu0Wm/LP81xZ4aGpcVt45fXpnm/NYXLMUU+bO7cyER01JU1lNUzspPSJmtETmzr
         3O5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680803232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2kphCzdyI8pFLM0XEcu5T4v/H3byCGSRbAeet3UKsQ=;
        b=crlrDx4Oq65clucFHnXWjz/MODvxSL5ztue4ra/3S3M14AB4hWoyiack4N1MBdXNyq
         uBiDDOTfX0ZyeumSgT0bDa3+3zV+Kmh6Ur9AIgVHFGf5UXrJfi8hqOI+F/F/HeWPc/JZ
         RULDO3gxQ3qLRAGDV2RTrrxxHJqJA6/zwKfEBNfHApwnHLtBflWUFExnwEZSSEln+utk
         /oEW06sn6WlHBok5mwROUzP/4y/7P2+OtjE7bI1XV6JZArKWozDBEhc0OFUtw5WZLiWe
         lIO56n5afnOLT72WFLepbIP4xhoTbAWyqojEws5nJvrGVLQ2Xys46WjIk/HkNVdww00W
         VU+Q==
X-Gm-Message-State: AAQBX9czkJSKuUxeypAY1mL7+O3EZg25YgfeqHzQgagXkMBqyXoo7zyU
        pSS2yOpt9ivz3lkYCg4a25hQfQ==
X-Google-Smtp-Source: AKy350aFVxyM/ori3/dci0NsR1+uV42sLIEpq5lHD/+dBdDEqIdqvBj1dMatOXAgwjo45isQTkIfpg==
X-Received: by 2002:a05:6512:991:b0:4dd:cb1d:b3cc with SMTP id w17-20020a056512099100b004ddcb1db3ccmr27761lft.11.1680803232479;
        Thu, 06 Apr 2023 10:47:12 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id z17-20020a19f711000000b004ec634b0e26sm50398lfe.307.2023.04.06.10.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:47:12 -0700 (PDT)
Message-ID: <ecf48eaf-b4b9-3749-894d-0f06d0b954e3@linaro.org>
Date:   Thu, 6 Apr 2023 20:47:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] thermal/drivers/tsens: Extract and shift-in optional
 MSB
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406145850.357296-1-bryan.odonoghue@linaro.org>
 <20230406145850.357296-4-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230406145850.357296-4-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 17:58, Bryan O'Donoghue wrote:
> In msm8939 some of the sensor calibration data traverses byte boundaries.
> Two examples of this are thermal sensor 2 point 1 and sensor 9 point 2.
> 
> For sensor 2 point 1 we can get away with a simple read traversing byte
> boundaries as the calibration most significant bits are adjacent to the
> least significant across the byte boundary.
> 
> In this case a read starting at the end of the first byte for nine bits
> will deliver up the data we want.
> 
> In the case of sensor 9 point 2 however, the most significant bits are not
> adjacent and so therefore we need to perform two reads and or the bits
> together.
> 
> If reg.p1_shift or reg.p2_shift is set then automatically search for
> pX_sY_msb in the dts applying pX_shift as a right shift or into the pX_sY
> value.

I think that having this in the common code is a bit of an overkill. No 
other platform has this 'peculiarity' up to now. So, it might be better 
to add 8939-specific calibration function that calls 
tsens_read_calibration(), mixes in the s10_p2_msb and then calls 
compute_intercept_slope().

> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/thermal/qcom/tsens.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index a260f563b4889..eff2c8671c343 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -74,6 +74,7 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
>   {
>   	u32 mode;
>   	u32 base1, base2;
> +	u32 msb;
>   	char name[] = "sXX_pY_backup"; /* s10_p1_backup */
>   	int i, ret;
>   
> @@ -122,6 +123,22 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
>   
>   		dev_dbg(priv->dev, "%s 0x%x\n", name, p1[i]);
>   
> +		if (priv->reg && priv->reg[i].p1_shift) {
> +			ret = snprintf(name, sizeof(name), "s%d_p1_msb",
> +				       priv->sensor[i].hw_id);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &msb);
> +			if (ret) {
> +				dev_err(priv->dev, "Failed to read %s\n", name);
> +				return ret;
> +			}
> +
> +			dev_dbg(priv->dev, "%s 0x%x\n", name, msb);
> +			p1[i] |= msb >> priv->reg[i].p1_shift;
> +		}
> +
>   		ret = snprintf(name, sizeof(name), "s%d_p2%s", priv->sensor[i].hw_id,
>   			       backup ? "_backup" : "");
>   		if (ret < 0)
> @@ -134,6 +151,22 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
>   		}
>   
>   		dev_dbg(priv->dev, "%s 0x%x\n", name, p2[i]);
> +
> +		if (priv->reg && priv->reg[i].p2_shift) {
> +			ret = snprintf(name, sizeof(name), "s%d_p2_msb",
> +				       priv->sensor[i].hw_id);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &msb);
> +			if (ret) {
> +				dev_err(priv->dev, "Failed to read %s\n", name);
> +				return ret;
> +			}
> +
> +			dev_dbg(priv->dev, "%s 0x%x\n", name, msb);
> +			p2[i] |= msb >> priv->reg[i].p2_shift;
> +		}
>   	}
>   
>   	switch (mode) {

-- 
With best wishes
Dmitry

