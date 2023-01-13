Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A843F669C53
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjAMPbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAMPbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:31:16 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D4B93C36
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:24:30 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id cf42so33639419lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5neXXvR4xShgIQ+mBGlETi+Hmx/OfLeRgPrvDQqsMM=;
        b=lgYwpaRKm0lkoFxPYt4FB+s3m286q8Altyh+EMp/DStxeiUb4AVUHZputDOFj5ejeR
         Om03kDdoWEB6MtHZVZjoJJNJbZX8OFhwNNg0i5NbvEX41WIPVj0p3z4oxTxH2EqnqhLD
         WkBQT96hDUI9UN6I43VG4wo0+NDg9fZx+XV7ZvSC50fSPav4/c7XPM0+AL+wJpujt/8F
         p2UoCfQ+K+qtC3w8WurMjPaduDbAn0oKREFn8OnnfkcT9OyeXQeuhQtv3BxU+gB+FTzl
         oRqIMOlQ2/3WVF0J/3ZGwKkpCeiW2WGE2KqDoXtjlRqg07Fz2iCG+0MUpld2slkdbeG8
         7TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5neXXvR4xShgIQ+mBGlETi+Hmx/OfLeRgPrvDQqsMM=;
        b=Nvk1lf4fzw927QnTZ3EhoTAXNmVQIrao2DyprDdv898VuowuQRIj3pQRbeWBMERA2I
         6szHurBehjPfNiom5cki8S6RUWYJ0FVJYMIiDXOrKt2mv2jn+yIrK4G7ssosQGDGiqd4
         mokmtbVinoDvD4S1iFx/6JclwrNKntn54kgUeseUT0+zFvclGMTNSXtWn/uPvMJAasKb
         X3+07KkXycoihy86p2Gwp5yOdGf7/QsTq0LDC75CtDRXyhBj7Jj0C6tE4RR2M3fjjCKo
         FVmqKVG0vSmyNVUirguCy94xWwnrBt4v+nPhKk6bZWALeHscAosou4ElqLC2+eQ0DZiz
         0zhQ==
X-Gm-Message-State: AFqh2kpqpZrrBNTEV787gV5z+PKKYvRHLfwSmgbnqY6Gsy9XiT9NgG0L
        4oOrIR5AkDHpR66DBWrs65Z7+Q==
X-Google-Smtp-Source: AMrXdXvAg3JiBLhBzGE5SuTRLQ5LoXvDpRYLITqKt41wh2MJYE/w8yrIo3AaWGcX9fSggjw86D7F2A==
X-Received: by 2002:ac2:53b0:0:b0:4cc:a108:ca0a with SMTP id j16-20020ac253b0000000b004cca108ca0amr41337lfh.46.1673623468437;
        Fri, 13 Jan 2023 07:24:28 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id x2-20020a056512130200b004a8f824466bsm3886305lfu.188.2023.01.13.07.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 07:24:27 -0800 (PST)
Message-ID: <552e75a9-179a-7720-3d37-59f1846266b1@linaro.org>
Date:   Fri, 13 Jan 2023 16:24:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/6] regulator: qcom_smd: Add MP5496 regulators
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-4-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230113150310.29709-4-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.01.2023 16:03, devi priya wrote:
> Adding support for PMIC MP5496 on IPQ9574 SoC
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
Please simply extend the existing MP5496 support with this
S1 regulator. If you don't explicitly define and set voltages
for the other vregs, they will not be probed.

Konrad
>  drivers/regulator/qcom_smd-regulator.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> index 9f2b58458841..1eb17d378897 100644
> --- a/drivers/regulator/qcom_smd-regulator.c
> +++ b/drivers/regulator/qcom_smd-regulator.c
> @@ -767,6 +767,15 @@ static const struct regulator_desc mp5496_ldoa2 = {
>  	.ops = &rpm_mp5496_ops,
>  };
>  
> +static const struct regulator_desc ipq9574_mp5496_smpa1 = {
> +	.linear_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(600000, 0, 37, 12500),
> +	},
> +	.n_linear_ranges = 1,
> +	.n_voltages = 38,
> +	.ops = &rpm_mp5496_ops,
> +};
> +
>  static const struct regulator_desc pm2250_lvftsmps = {
>  	.linear_ranges = (struct linear_range[]) {
>  		REGULATOR_LINEAR_RANGE(320000, 0, 269, 4000),
> @@ -799,6 +808,11 @@ static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>  	{}
>  };
>  
> +static const struct rpm_regulator_data rpm_ipq9574_mp5496_regulators[] = {
> +	{ "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1" },
> +	{}
> +};
> +
>  static const struct rpm_regulator_data rpm_pm2250_regulators[] = {
>  	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm2250_lvftsmps, "vdd_s1" },
>  	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm2250_lvftsmps, "vdd_s2" },
> @@ -1320,6 +1334,8 @@ static const struct rpm_regulator_data rpm_pms405_regulators[] = {
>  };
>  
>  static const struct of_device_id rpm_of_match[] = {
> +	{ .compatible = "qcom,rpm-ipq9574-mp5496-regulators",
> +		.data = &rpm_ipq9574_mp5496_regulators },
>  	{ .compatible = "qcom,rpm-mp5496-regulators", .data = &rpm_mp5496_regulators },
>  	{ .compatible = "qcom,rpm-pm2250-regulators", .data = &rpm_pm2250_regulators },
>  	{ .compatible = "qcom,rpm-pm6125-regulators", .data = &rpm_pm6125_regulators },
