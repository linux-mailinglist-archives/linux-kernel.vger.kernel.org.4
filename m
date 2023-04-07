Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB15D6DB449
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjDGTgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDGTgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:36:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8664359CD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:36:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z8so1314618lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680896201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKYRcl+d8w5lofbNEMKNydH5lmt1IjXJEdkQVh+xrI4=;
        b=J6OW0erYAmJG7NOOvdaxo2cSQlrnxa0EW0kawWyVUeSr/MrnnFwTaW0dBqWUELritq
         f0o4I3DeP86Jp6bzj2VQ4i4Kb4zq2xAr3s02oZdOmu8aZ2HwHt77x4+DSOTuEtFM/NLK
         0ccUfcAqbmvLuKUV/DiL0CfEjG+Ybb0Eoy+q2mCVy6RZjvUNQeLlCsd0IaPUEviAk5sg
         A+p/E+7ykm8DoZUuqxMUyNWypx7HNz5WzoAxrx8HCd+Yoc6Hmfef1pV2wSKNnLPW07wf
         sI8W1NELfaV+lQC2De0TEywIpvgJySQdeLHxwujRaeUWYe1jTpEg9M526ZUpqcr4k++t
         GH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680896201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKYRcl+d8w5lofbNEMKNydH5lmt1IjXJEdkQVh+xrI4=;
        b=EUtqSvb25kJPEY/I3rqQP2H8yrpmEARIJmPAI3PtoXRtJM/M0evkqzEI5X91Jp6WcR
         AibY9NIqpaackbDkcfyKwssZLUQG9A3qqhT+DLHyx+NVaFMmnX9numCWpRiHy+TJ5hZ2
         YtBAuxdWXeNiNUrVmVsCjE3MrFg1ERDbiaJ3LMSyTpvY7apC0ENQR8RjpIClnTSFkjEL
         /GikkeST0BVpoZ3hGb+DK92uwQyfmgVBsgr3dZE2OCGwdOb6k4Szmeo78WaGk29Gg0TW
         NL1lIA2NKXbqQH3H4pC0yiyPuThio5vHqyMrB98Kp4uVbyUAANAY8kGSF0zwRCiLNMw7
         rYaw==
X-Gm-Message-State: AAQBX9e3GJxoi74L54YN9l4DEjX1rVVz2TmdbozbP76R/dDebPxqdu0u
        Yb7TEmZleS8NXDr/YSmOXTsNzA==
X-Google-Smtp-Source: AKy350YBR6zNVDEar+oV1BSDq/1Y8u/fnKTZ8b9oW3xMoF5v8rx+6HcUbkBOB7TQSRiNhoyKS+KJFw==
X-Received: by 2002:ac2:5485:0:b0:4eb:11dc:d9a5 with SMTP id t5-20020ac25485000000b004eb11dcd9a5mr1021070lfk.32.1680896200757;
        Fri, 07 Apr 2023 12:36:40 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id k18-20020a2e8892000000b002958a51df76sm957200lji.92.2023.04.07.12.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 12:36:40 -0700 (PDT)
Message-ID: <d935029e-9ba1-a89e-67e8-79e832d7c736@linaro.org>
Date:   Fri, 7 Apr 2023 21:36:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V4 2/5] regulator: qcom_smd: Add MP5496 S1 regulator
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com
References: <20230407155727.20615-1-quic_devipriy@quicinc.com>
 <20230407155727.20615-3-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230407155727.20615-3-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.04.2023 17:57, Devi Priya wrote:
> Adding support for MP5496 S1 regulator on IPQ9574 SoC.
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  Changes in V4:
> 	- Dropped struct mp5496_smpa1 which was the same as mp5496_smpa2
> 	  and renamed mp5496_smpa2 to mp5496_smps as suggested by Konrad
> 	
>  drivers/regulator/qcom_smd-regulator.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> index 6f722b2d682e..18189f35db68 100644
> --- a/drivers/regulator/qcom_smd-regulator.c
> +++ b/drivers/regulator/qcom_smd-regulator.c
> @@ -749,7 +749,7 @@ static const struct regulator_desc pms405_pldo600 = {
>  	.ops = &rpm_smps_ldo_ops,
>  };
>  
> -static const struct regulator_desc mp5496_smpa2 = {
> +static const struct regulator_desc mp5496_smps = {
>  	.linear_ranges = (struct linear_range[]) {
>  		REGULATOR_LINEAR_RANGE(600000, 0, 127, 12500),
>  	},
> @@ -794,7 +794,8 @@ struct rpm_regulator_data {
>  };
>  
>  static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
> -	{ "s2", QCOM_SMD_RPM_SMPA, 2, &mp5496_smpa2, "s2" },
> +	{ "s1", QCOM_SMD_RPM_SMPA, 1, &mp5496_smps, "s1" },
> +	{ "s2", QCOM_SMD_RPM_SMPA, 2, &mp5496_smps, "s2" },
>  	{ "l2", QCOM_SMD_RPM_LDOA, 2, &mp5496_ldoa2, "l2" },
>  	{}
>  };
