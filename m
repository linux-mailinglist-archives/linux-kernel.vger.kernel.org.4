Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8B26CBAFC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjC1Ja5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjC1JaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:30:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4B72B2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:29:11 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id br6so14908842lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679995744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dk18DfrsZuq+WUDLgd3KU7WGbTjCqrV4Y3VCrkv2ukQ=;
        b=nIDsD/3Uhou4S/AMUshlZp4REkr/B0iWYEkE6L4/jPyZHbFH8Ch8zzK4aJkHXXUrnT
         /2PQz1XFLXG8rsvASOXccqnRhAN8CSqqo9WhYimiuuWhoRZkfX1r1tRs5Jd0lJJ00Wd7
         e2LtZarRRPsvnEjVInvK0//wLA0tte8jIWd9f5xKCWaW+Nl/6YDMEJLwW6etgjayPXiG
         8exy33d9pFfkBFGK6lrxOn05rm6OhrUp+pQEX/YnpVd6O7krqhIatLwbPiUNgv/MVJtf
         0p47OKaHBOV1RQcaCTaUHC5eXtr0tz4hjKC1q0IjQ53D1LGfAXQr1qKrz5JS2OOiaXUV
         kqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dk18DfrsZuq+WUDLgd3KU7WGbTjCqrV4Y3VCrkv2ukQ=;
        b=Z5DwxlsZztCk2FMa4faqc4sXwWnJmwQy+3/vruc7fG6MrbyedjZRd/VGXUQKf0wxck
         IBZlbqvYNHiRyBNVjHKzcSEIfwCM0nCeN3gSc1E9M9VXm/t2yQtZiRMwVFUWqaZehCho
         ptZyuTLeltd1jTVLRvQG6ulLlhUcUkJj62YiiaLbcmOZKCKUFRoP0knynaxqNDB+2q95
         AayESvB3SFy7J6S21VP7kOJGh+G1itUf3LvKhAVP5XqqiZHIJvvCDEMPqhMQhO7rIA4g
         s+YH4l6mF9klCuSnUEe8vzenS63m0dCVK6GBxN3NlVN8sSHmRRh8PvAlIgX70iMth2Qp
         EozA==
X-Gm-Message-State: AAQBX9eGOLcUT6j8VdUwDJMQzluxvohQ8eXj935XyKZaMBJ07t9d8c54
        sKjRlW629/GYtR7TPjMi/ij4vg==
X-Google-Smtp-Source: AKy350Y28HG8gD7zXHaAV6SDfZ00y0AiPHuQdsm7OVeyfnyXgpemP5e6hR/H2LQr0pjNDeREEXw+WQ==
X-Received: by 2002:ac2:5a04:0:b0:4e8:487a:7c2e with SMTP id q4-20020ac25a04000000b004e8487a7c2emr4639191lfn.14.1679995743748;
        Tue, 28 Mar 2023 02:29:03 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id w18-20020a056512099200b004dab932248fsm4980080lft.180.2023.03.28.02.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 02:29:03 -0700 (PDT)
Message-ID: <ce24ffc4-3c0c-bf1b-354e-e5ee9db5d5c3@linaro.org>
Date:   Tue, 28 Mar 2023 11:29:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 17/18] regulator: qcom-rpmh: add support for pmm8654au
 regulators
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Mark Brown <broonie@kernel.org>
References: <20230327125316.210812-1-brgl@bgdev.pl>
 <20230327125316.210812-18-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230327125316.210812-18-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.03.2023 14:53, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the RPMH regulators exposed by the PMM8654au PMIC and its variants.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> ---
I can't check the validity of the regulator types and ranges, but
for the overall picture:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/regulator/qcom-rpmh-regulator.c | 55 +++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 4826d60e5d95..b0a58c62b1e2 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -694,6 +694,16 @@ static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
>  	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
>  };
>  
> +static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(1800000, 0, 187, 8000),
> +	.n_voltages = 188,
> +	.hpm_min_load_uA = 10000,
> +	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
> +	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
> +};
> +
>  static const struct rpmh_vreg_hw_data pmic5_nldo = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_drms_ops,
> @@ -704,6 +714,16 @@ static const struct rpmh_vreg_hw_data pmic5_nldo = {
>  	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
>  };
>  
> +static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 210, 8000),
> +	.n_voltages = 211,
> +	.hpm_min_load_uA = 30000,
> +	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
> +	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
> +};
> +
>  static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> @@ -749,6 +769,15 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps525_mv = {
>  	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
>  };
>  
> +static const struct rpmh_vreg_hw_data pmic5_ftsmps527 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> +	.n_voltages = 215,
> +	.pmic_mode_map = pmic_mode_map_pmic5_smps,
> +	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> +};
> +
>  static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> @@ -937,6 +966,28 @@ static const struct rpmh_vreg_init_data pmm8155au_vreg_data[] = {
>  	{}
>  };
>  
> +static const struct rpmh_vreg_init_data pmm8654au_vreg_data[] = {
> +	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps527,  "vdd-s1"),
> +	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps527,  "vdd-s2"),
> +	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps527,  "vdd-s3"),
> +	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps527,  "vdd-s4"),
> +	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps527,  "vdd-s5"),
> +	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps527,  "vdd-s6"),
> +	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps527,  "vdd-s7"),
> +	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps527,  "vdd-s8"),
> +	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps527,  "vdd-s9"),
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,    "vdd-s9"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo515,    "vdd-l2-l3"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,    "vdd-l2-l3"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo515,    "vdd-s9"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo515,    "vdd-s9"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo515,    "vdd-l6-l7"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_nldo515,    "vdd-l6-l7"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo515_mv, "vdd-l8-l9"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,       "vdd-l8-l9"),
> +	{}
> +};
> +
>  static const struct rpmh_vreg_init_data pm8350_vreg_data[] = {
>  	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
>  	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
> @@ -1431,6 +1482,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
>  		.compatible = "qcom,pmm8155au-rpmh-regulators",
>  		.data = pmm8155au_vreg_data,
>  	},
> +	{
> +		.compatible = "qcom,pmm8654au-rpmh-regulators",
> +		.data = pmm8654au_vreg_data,
> +	},
>  	{
>  		.compatible = "qcom,pmx55-rpmh-regulators",
>  		.data = pmx55_vreg_data,
