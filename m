Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7236D9F08
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbjDFRnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239818AbjDFRna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:43:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D6159CD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:43:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id k37so51879388lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680802996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GE0mb6UJq7k1JZFQybibif1iBmfmBVtXpkVkOVYFr94=;
        b=KCXSgxfHJOJRBE8Mo/Q6geTHsjWfIX/yBihfFCizuqYFEC5Io35i0x2DSGa/o3Eb6X
         wF2wFRPGlkdcNtkjONVwvKSeM50zs1h7Ho7TxljKwA5+nK2bSwwUKcX6zb2MvcAJ98yV
         RgYTaJ/9bgoXbYf5ARVL+30KxRG+yv+dDNBhhkPBac6+1JIPJfSeyXhU4M+FTUJ09aNF
         g79QMFjsW3la5qkQZHXzAc33LhcLiYKhd4p5Mf9G7rYFkKDanDzbbsOdnxFUhE5Mxb1g
         aZ/GwKEg6FVq8xaLZF9MbcxPSyIAMLT79k7hKfg4up75If6tOnk5/slDZErX0Hn7NA6l
         +b3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680802996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GE0mb6UJq7k1JZFQybibif1iBmfmBVtXpkVkOVYFr94=;
        b=RnTriTZajpfvban83d7T7OLKG7M3FzEaTcuYqI64QDG8meDOgcB4s5MPuamIy2X4Ns
         iP5NDmWX5w0Kpgy3zQSNlADVsAjsOhJC1lb8tU08LJ4m09b3ABQ+PKE9nzCUqT/TZ9a1
         R84oWQQjBrMohClGe1rF4uvckIRqqre5Brsds4fbCZaUd0FpOuuEBZZoLtdgI3URiuJL
         sPuTuM1On9BZ/Srf9ADeJWxJOcy/KKJCPc3Bs/vUQWxYr71td5aDPJvFvqDmsGEEkZtn
         1DfhcI8+7CUMcN/vaPpaBiNnDZYmf0RCNQVBnsJde3rQfPA1sEAKV07exiYkiTwZt4wA
         8UoQ==
X-Gm-Message-State: AAQBX9cA012g2B0xjduXZ75L1mgyoNvBNlTghlt//vqq7Aay495EOrba
        JZX2lPlfiisJTNl3UnrUXB0jdg==
X-Google-Smtp-Source: AKy350arRvD9FFEhmLTRYiEWRAZeo9TS7ivgO91feUtEA0w3g1Xqi6EzeQx9CMu1LhG/tsrDbZWjrg==
X-Received: by 2002:ac2:4836:0:b0:4eb:3b97:417c with SMTP id 22-20020ac24836000000b004eb3b97417cmr10646lft.49.1680802995900;
        Thu, 06 Apr 2023 10:43:15 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e7-20020ac25467000000b004dd0bbc89a1sm346070lfn.244.2023.04.06.10.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:43:15 -0700 (PDT)
Message-ID: <2a94b361-2dff-e673-ba54-b4890d2bdaf8@linaro.org>
Date:   Thu, 6 Apr 2023 20:43:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] thermal/drivers/tsens: Describe sensor registers via
 a structure
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406145850.357296-1-bryan.odonoghue@linaro.org>
 <20230406145850.357296-3-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230406145850.357296-3-bryan.odonoghue@linaro.org>
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
> Define sensor identifiers and optional shifts in a single data-structure.
> This facilitates extraction of calibration data from non-contiguous
> addresses.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/thermal/qcom/tsens-v0_1.c | 56 +++++++++++++++++++++++++++++--
>   drivers/thermal/qcom/tsens.c      |  5 +--
>   drivers/thermal/qcom/tsens.h      | 16 ++++++++-
>   3 files changed, 72 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index e89c6f39a3aea..c20c002d98650 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -319,10 +319,31 @@ static const struct tsens_ops ops_8916 = {
>   	.get_temp	= get_temp_common,
>   };
>   
> +struct tsens_reg_data reg_8916[] = {
> +	{
> +		.id = 0,
> +	},
> +	{
> +		.id = 1,
> +	},
> +	{
> +		.id = 2,
> +	},
> +	{
> +		.id = 3,
> +	},
> +	{
> +		.id = 4,
> +	},
> +	{
> +		.id = 5,
> +	},
> +};
> +
>   struct tsens_plat_data data_8916 = {
>   	.num_sensors	= 5,
>   	.ops		= &ops_8916,
> -	.hw_ids		= (unsigned int []){0, 1, 2, 4, 5 },
> +	.reg		= reg_8916,
>   
>   	.feat		= &tsens_v0_1_feat,
>   	.fields	= tsens_v0_1_regfields,
> @@ -334,10 +355,41 @@ static const struct tsens_ops ops_8939 = {
>   	.get_temp	= get_temp_common,
>   };
>   
> +struct tsens_reg_data reg_8939[] = {
> +	{
> +		.id = 0,
> +	},
> +	{
> +		.id = 1,
> +	},
> +	{
> +		.id = 2,
> +	},
> +	{
> +		.id = 3,
> +	},
> +	{
> +		.id = 5,
> +	},
> +	{
> +		.id = 6,
> +	},
> +	{
> +		.id = 7,
> +	},
> +	{
> +		.id = 8,
> +	},
> +	{
> +		.id = 9,

Sensor 9 is contiguous. It's sensor with hwid=10, who requires two reads.

> +		.p2_shift = 8,
> +	},
> +};
> +
>   struct tsens_plat_data data_8939 = {
>   	.num_sensors	= 9,
>   	.ops		= &ops_8939,
> -	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, /* 10 */ },
> +	.reg		= reg_8939,
>   
>   	.feat		= &tsens_v0_1_feat,
>   	.fields	= tsens_v0_1_regfields,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 7165b0bfe8b9f..a260f563b4889 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1274,13 +1274,14 @@ static int tsens_probe(struct platform_device *pdev)
>   	priv->num_sensors = num_sensors;
>   	priv->ops = data->ops;
>   	for (i = 0;  i < priv->num_sensors; i++) {
> -		if (data->hw_ids)
> -			priv->sensor[i].hw_id = data->hw_ids[i];
> +		if (data->reg)
> +			priv->sensor[i].hw_id = data->reg[i].id;
>   		else
>   			priv->sensor[i].hw_id = i;
>   	}
>   	priv->feat = data->feat;
>   	priv->fields = data->fields;
> +	priv->reg = data->reg;
>   
>   	platform_set_drvdata(pdev, priv);
>   
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index dba9cd38f637c..31f67da03bce6 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -517,18 +517,31 @@ struct tsens_features {
>   	int trip_max_temp;
>   };
>   
> +/**
> + * struct tsens_reg_data - describes register data retrieved non-contiguously
> + * @id: thermal sensor identifier
> + * @p1_shift: When non-zero is the # of bits to right shift p1 MSB by
> + * @p2_shift: When non-zero is the # of bits to right shift p2 MSB by
> + */
> +struct tsens_reg_data {
> +	unsigned int id;
> +	unsigned int p1_shift;
> +	unsigned int p2_shift;
> +};
> +
>   /**
>    * struct tsens_plat_data - tsens compile-time platform data
>    * @num_sensors: Number of sensors supported by platform
>    * @ops: operations the tsens instance supports
>    * @hw_ids: Subset of sensors ids supported by platform, if not the first n
> + * @reg: Describe sensor id and calibration shifts
>    * @feat: features of the IP
>    * @fields: bitfield locations
>    */
>   struct tsens_plat_data {
>   	const u32		num_sensors;
>   	const struct tsens_ops	*ops;
> -	unsigned int		*hw_ids;
> +	struct tsens_reg_data	*reg;
>   	struct tsens_features	*feat;
>   	const struct reg_field		*fields;
>   };
> @@ -575,6 +588,7 @@ struct tsens_priv {
>   	struct regmap_field		*rf[MAX_REGFIELDS];
>   	struct tsens_context		ctx;
>   	struct tsens_features		*feat;
> +	struct tsens_reg_data		*reg;
>   	const struct reg_field		*fields;
>   	const struct tsens_ops		*ops;
>   

-- 
With best wishes
Dmitry

