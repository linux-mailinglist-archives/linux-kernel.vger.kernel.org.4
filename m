Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB95969FE33
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjBVWMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjBVWMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:12:01 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FD1460AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:11:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id t11so1001977lfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2M/okC0ikS9uDwZLSlit4bWXZfj2iKqcWmr+GvGYOvs=;
        b=MOSTb+TlyzknQi1Pu6dI3l3bIngMQLG5b8Vfyl3M9fHUqa+N6PZHWpCAX+MszvkN4l
         Du7u/M0jey4cb/DirqsZ06dSrs8ABDgnUk3c//Qae0iWlkIKpIjPTshY1CfMVHXdjcSI
         2/somtLmtlCrfBGUCNwhP1C8Z2fJMaue5Hl0w/uQqFg0ISum5Es3XVF5bIdO70TTGdm2
         oB76ATz5DWg+V/M2oy6thr0hFKjyb1KiHcXMKNZRlClFQIQNRzlsjlIz3FsoTs+qlTac
         /1pyxEftQm1aLsxXeWfKAZ21L5rQsTebbTphBleBDBqYLCgMXKVOtAdppB7CuCjaFRqu
         VNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2M/okC0ikS9uDwZLSlit4bWXZfj2iKqcWmr+GvGYOvs=;
        b=K0wVkGNaLy4/PrenEVDaepa5E2jmWigAGst1wjB4hDOYhfmI8ryMBh4W5Nn/m6sML+
         okRIkHXCX11iW+LOBPjOBd1YcaqHNuLCOkAkTmN26AQfWa4qcdEB9R4O/9P8BhLFTdEA
         KKeGXmjsmwwZDLdnulrADZBc0TbrqFMEbFJsMmwpr//Sz9+aiZCzRtSndFc9MS1muuUS
         hH2pvAlyZunWcV+nie+Y0tG4IIFIuRTK+k00SJA6XvqddKLTvqjKE/u/Q7h82rC1Mu/2
         ElPZlCwctrLv/38WJ9VbU0icO4FwsUTEMzzpuTSx+7mVDoAdfwYWLllbhdJw/WzuObf6
         UC4A==
X-Gm-Message-State: AO0yUKV7cHT6+oVU0OxMiaFOygKHm8viiv9WMbpgEO9NGEzjmuCI0WIf
        uqDSaPcN5/ncnEzQtTeGPR/JsQ==
X-Google-Smtp-Source: AK7set8S6Lw1AvpZQ6hKQcPF8ONbxTN/08nxsClBKMYdoGLZ7+WIdP+5+S0V+wjw4aIJVaxR3Q1T0Q==
X-Received: by 2002:a05:6512:10c2:b0:4ca:ffe0:e754 with SMTP id k2-20020a05651210c200b004caffe0e754mr4411168lfg.18.1677103904923;
        Wed, 22 Feb 2023 14:11:44 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id z18-20020ac24f92000000b004d51b590772sm909349lfs.255.2023.02.22.14.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 14:11:44 -0800 (PST)
Message-ID: <907628d1-b88d-5ac6-ed9d-7f63e2875738@linaro.org>
Date:   Wed, 22 Feb 2023 23:11:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 4/6] regulator: qcom_smd: Add support to define the
 bootup voltage
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
 <20230217142030.16012-5-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230217142030.16012-5-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.02.2023 15:20, Devi Priya wrote:
> Kernel does not know the initial voltage set by the bootloaders.
> During regulator registration, the voltage variable is just declared
> and it is zero. Based on that, the regulator framework considers current
> the voltage as zero and tries to bring up each regulator to minimum
> the supported voltage.
> 
> This introduces a dip in the voltage during kernel boot and gets
> stabilized once the voltage scaling comes into picture.
> 
> To avoid the voltage dip, adding support to define the
> bootup voltage set by the boodloaders and based on it, regulator
> framework understands that proper voltage is already set
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
Thinking about it again, this seems like something that could be
generalized and introduced into regulator core.. Hardcoding this
will not end well.. Not to mention it'll affect all mp5496-using
boards that are already upstream.

WDYT about regulator-init-microvolts Mark?

Konrad
>  Changes in V2:
> 	- Added the bootup voltages to s2 and l2 regulators
> 
>  drivers/regulator/qcom_smd-regulator.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> index a40e66cea7e7..5f9fe6b9d368 100644
> --- a/drivers/regulator/qcom_smd-regulator.c
> +++ b/drivers/regulator/qcom_smd-regulator.c
> @@ -800,12 +800,13 @@ struct rpm_regulator_data {
>  	u32 id;
>  	const struct regulator_desc *desc;
>  	const char *supply;
> +	int boot_uV; /* To store the bootup voltage set by bootloaders */
>  };
>  
>  static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
> -	{ "s1", QCOM_SMD_RPM_SMPA, 1, &mp5496_smpa1, "s1" },
> -	{ "s2", QCOM_SMD_RPM_SMPA, 2, &mp5496_smpa2, "s2" },
> -	{ "l2", QCOM_SMD_RPM_LDOA, 2, &mp5496_ldoa2, "l2" },
> +	{ "s1", QCOM_SMD_RPM_SMPA, 1, &mp5496_smpa1, "s1", 875000  },
> +	{ "s2", QCOM_SMD_RPM_SMPA, 2, &mp5496_smpa2, "s2", 875000  },
> +	{ "l2", QCOM_SMD_RPM_LDOA, 2, &mp5496_ldoa2, "l2", 2950000 },
>  	{}
>  };
>  
> @@ -1388,6 +1389,9 @@ static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev
>  	vreg->type	= rpm_data->type;
>  	vreg->id	= rpm_data->id;
>  
> +	if (rpm_data->boot_uV)
> +		vreg->uV = rpm_data->boot_uV;
> +
>  	memcpy(&vreg->desc, rpm_data->desc, sizeof(vreg->desc));
>  	vreg->desc.name = rpm_data->name;
>  	vreg->desc.supply_name = rpm_data->supply;
