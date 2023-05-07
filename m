Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C576F9B93
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjEGUkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEGUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:40:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023C19EFE
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 13:40:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f137dbaa4fso4360190e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 13:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683492032; x=1686084032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEobT5d9kdcRp8dixdijtxMKVPc5uyxDMFTSv3z+3hw=;
        b=p7wBaVX8KcmhGljoYijHz2tFbfgc/9/cuVs5i5XvZJ65xSOAyJRDxfdEkzpOkEHu8u
         6cFUuD3L9Yfxks5JSar3QArBkbRyBhgf6mj+fSjcE9kJaFvwchfMC8paEpXk+2I56UyV
         X7QsSR50fuIYK8ayYmzjXgHqVgVD/5dGkDbAOwDuY1LsTZ8gvpn/GMN4016lPmJ5D72l
         9nrBW6wKb+yZvbx7W7yCajLozhxs7tozRxhAikQmReAwwv34c4BZceCjccVKqYzsVgD2
         oKtIqKHWbLpUF+rR681DkcyMOKjklhxkLZpHvLEpI9tIavcrBWjGJ/nl07JszfhX8OJh
         3Q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683492032; x=1686084032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEobT5d9kdcRp8dixdijtxMKVPc5uyxDMFTSv3z+3hw=;
        b=SBXlayvT2uwpqYZ8vATbGx+NixVjofKjyRcWPYS4xWmuQCR4pymmGRXALyF9Wionf7
         84f43VdGe6DdcTaT8ZqHT98dSkj7bvoqYFUvyTLBCyeiDe0/H/QGp+bb6xfY+/MXtKVF
         c04eJlQ7/RBAxBdi+VMFU7bdrYjm98A3pAes5TTgBGaaLOFlRxfrG9l31MQAvayxcpIY
         XMJoNIBsWm89DoUnt0xXbsMETiXE+FTWhkyEt/aOeBpwZSSD7JU0NkkbZquCu3MRr5bO
         yWt2RKxaOCiGTe+bHKiP0TuBw4pISep6s6CaOVhz+jQ1JC8JLpue+KC+ByYSLohZt6f1
         DcLA==
X-Gm-Message-State: AC+VfDzyNxedEHtLyJZID/uAWFdrrPTm8+biNZnqGOM3PgBSP4pKk4GQ
        WpnRauefMero0E1wA8RX7UaMag==
X-Google-Smtp-Source: ACHHUZ6DUWb0v7gajAvrjJqzDjwveiMcMITjQKezCfJuXDL/DxFW+VI2hAem/FWaxmDWdKsNBfoJAg==
X-Received: by 2002:ac2:558d:0:b0:4e1:36a:eda5 with SMTP id v13-20020ac2558d000000b004e1036aeda5mr2120141lfg.30.1683492032191;
        Sun, 07 May 2023 13:40:32 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id 10-20020ac2568a000000b004e9b307d2c8sm1073669lfr.238.2023.05.07.13.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 13:40:31 -0700 (PDT)
Message-ID: <33d373fa-91cc-2ab6-b59b-34967dff1109@linaro.org>
Date:   Sun, 7 May 2023 23:40:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/6] thermal/drivers/qcom/tsens-v0_1: Add support for
 MSM8226
Content-Language: en-GB
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
 <20230507201225.89694-4-matti.lehtimaki@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230507201225.89694-4-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2023 23:12, Matti Lehtimäki wrote:
> The MSM8226 TSENS IP has 6 thermal sensors in a TSENS v0.1 block.
> The thermal sensors use non-standard slope values.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Note, the driver from 3.10 also provides custom data for non-calibrated 
mode. We can either ignore that (in the hope that all devices leaving 
the factory are calibrated), or fix it in the manner close to 8x74.

> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
>   drivers/thermal/qcom/tsens-v0_1.c | 27 ++++++++++++++++++++++++++-
>   drivers/thermal/qcom/tsens.c      |  3 +++
>   drivers/thermal/qcom/tsens.h      |  2 +-
>   3 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index e89c6f39a3ae..ad57ab94546b 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -243,6 +243,18 @@ static int calibrate_8974(struct tsens_priv *priv)
>   	return 0;
>   }
>   
> +static int __init init_8226(struct tsens_priv *priv)
> +{
> +	priv->sensor[0].slope = 2901;
> +	priv->sensor[1].slope = 2846;
> +	priv->sensor[2].slope = 3038;
> +	priv->sensor[3].slope = 2955;
> +	priv->sensor[4].slope = 2901;
> +	priv->sensor[5].slope = 2846;
> +
> +	return init_common(priv);
> +}
> +
>   static int __init init_8939(struct tsens_priv *priv) {
>   	priv->sensor[0].slope = 2911;
>   	priv->sensor[1].slope = 2789;
> @@ -258,7 +270,7 @@ static int __init init_8939(struct tsens_priv *priv) {
>   	return init_common(priv);
>   }
>   
> -/* v0.1: 8916, 8939, 8974, 9607 */
> +/* v0.1: 8226, 8916, 8939, 8974, 9607 */
>   
>   static struct tsens_features tsens_v0_1_feat = {
>   	.ver_major	= VER_0_1,
> @@ -313,6 +325,19 @@ static const struct tsens_ops ops_v0_1 = {
>   	.get_temp	= get_temp_common,
>   };
>   
> +static const struct tsens_ops ops_8226 = {
> +	.init		= init_8226,
> +	.calibrate	= tsens_calibrate_common,
> +	.get_temp	= get_temp_common,
> +};
> +
> +struct tsens_plat_data data_8226 = {
> +	.num_sensors	= 6,
> +	.ops		= &ops_8226,
> +	.feat		= &tsens_v0_1_feat,
> +	.fields	= tsens_v0_1_regfields,
> +};
> +
>   static const struct tsens_ops ops_8916 = {
>   	.init		= init_common,
>   	.calibrate	= calibrate_8916,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 8020ead2794e..eb33a8bf0488 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1095,6 +1095,9 @@ static const struct of_device_id tsens_table[] = {
>   	}, {
>   		.compatible = "qcom,mdm9607-tsens",
>   		.data = &data_9607,
> +	}, {
> +		.compatible = "qcom,msm8226-tsens",
> +		.data = &data_8226,
>   	}, {
>   		.compatible = "qcom,msm8916-tsens",
>   		.data = &data_8916,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index dba9cd38f637..433eba370998 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -635,7 +635,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
>   extern struct tsens_plat_data data_8960;
>   
>   /* TSENS v0.1 targets */
> -extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
> +extern struct tsens_plat_data data_8226, data_8916, data_8939, data_8974, data_9607;
>   
>   /* TSENS v1 targets */
>   extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;

-- 
With best wishes
Dmitry

