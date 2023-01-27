Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8809967EA59
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjA0QES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbjA0QDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:03:45 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED8288CD3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:03:18 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id m2so14485751ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouNSiolddHK0ABNNgbLbeD34KPL1pBTYa3+PFcb6NFk=;
        b=jEI7Gsr7eKoIvG6PA/WsCTBOnpEIvSfwWKrtVAtRt8VP6SEqNnTWqGYm5BRe3rMVji
         v0/S7/8ZSBpClQ3IZG6GdtNa8u2wv8Jh9Bg+yGy9IEYutgC6CSwI0/rQpX7oinWpUPbt
         ltFtVTkZBaX6iV+dvm5Vgib87UE2oA8IZs60lGy7UxNU8Gz9f3YCyDNEQgryPEzTc6gr
         IfJIdAPHvfP93+pO3O5vCcpbDo8rDG4ZIF3XFCh5u7onfVNNW38yaou9lOXrtdFESAF1
         FLubkHDERTVewHYKmQv+EHw3f34veRzzKnrQoobsPF5fspdcnWXavX7iECzYMvN2T7Fm
         7d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouNSiolddHK0ABNNgbLbeD34KPL1pBTYa3+PFcb6NFk=;
        b=bciAT+i/3GKihQll7d7YDMvTS03Rb0zfwjwmkZkZHaF9+k8YKTOUQ3g0wYYfO6dJs8
         6Nu23KxVdAewNhmEVXx32I7rxRc3o9/BhjFOfq/0X8KC7wSFNK9Nw3TfikTX7h4dIVDH
         22VcLa5fvGRnWgXcfWzp4eLcOplIi9Qh5b4vkD+t2EN6Pgq/Tcu/ta8kyMIhfd8kTWlX
         lRuCV71FVTK4cfwnkChPZakidTCuQru3IxyLJEvbffLiTDOOLWjEgNA7IDP8hyLDo0aj
         fAQmlIwYEfvPK750MB7WHzJKNwvs+uLSJv9Ici/J/8uSuffT90qM8iRU7CKL1s00bO1e
         bnGA==
X-Gm-Message-State: AO0yUKW4k45UgabsmhmfkN+ui08pftHKSeyNuNhO/oPJCRoou44Ird1I
        w4UDyPWENttKG4s6QShhM1BZZQ==
X-Google-Smtp-Source: AK7set+aMV7UTq2Qwj8nT3oERno6Ss3fqbLfoBkSI9M+AsxDec+A6hOYkNnKa84r5JduMzxLnrzXrA==
X-Received: by 2002:a17:906:230b:b0:87b:d2a2:e7a6 with SMTP id l11-20020a170906230b00b0087bd2a2e7a6mr3033644eja.65.1674835393256;
        Fri, 27 Jan 2023 08:03:13 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id fy15-20020a1709069f0f00b0084c62b7b7d8sm2407085ejc.187.2023.01.27.08.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 08:03:12 -0800 (PST)
Message-ID: <0ef104a5-fc10-a043-a458-4e6d1e07a7a7@linaro.org>
Date:   Fri, 27 Jan 2023 17:03:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/6] regulator: qcom_smd: Add MP5496 regulators
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com, quic_ipkumar@quicinc.com
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-4-quic_devipriy@quicinc.com>
 <552e75a9-179a-7720-3d37-59f1846266b1@linaro.org>
 <2cc385d9-4f51-945d-cc59-2738011bd295@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2cc385d9-4f51-945d-cc59-2738011bd295@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.01.2023 17:01, Devi Priya wrote:
> 
> 
> On 1/13/2023 8:54 PM, Konrad Dybcio wrote:
>>
>>
>> On 13.01.2023 16:03, devi priya wrote:
>>> Adding support for PMIC MP5496 on IPQ9574 SoC
>>>
>>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>>> ---
>> Please simply extend the existing MP5496 support with this
>> S1 regulator. If you don't explicitly define and set voltages
>> for the other vregs, they will not be probed.
>>
>> Konrad
> IPQ6018 and IPQ9574 platforms use the same PMIC MP5496 but they have a different power layout. IPQ9574 has S2 regulator which will be used for NSS scaling but S2 in IPQ6018 serves a different purpose. Hence it would not be possible to extend the existing MP5496 support for IPQ9574
Does the s2 on IPQ9574 have a different voltage range than
the one on IPQ6018? No? Then there's nothing blocking you
from using the setup for both SoCs. As I've mentioned,
regulators that you don't add to the device tree will
not even be probed.

Konrad
>>>   drivers/regulator/qcom_smd-regulator.c | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
>>> index 9f2b58458841..1eb17d378897 100644
>>> --- a/drivers/regulator/qcom_smd-regulator.c
>>> +++ b/drivers/regulator/qcom_smd-regulator.c
>>> @@ -767,6 +767,15 @@ static const struct regulator_desc mp5496_ldoa2 = {
>>>       .ops = &rpm_mp5496_ops,
>>>   };
>>>   +static const struct regulator_desc ipq9574_mp5496_smpa1 = {
>>> +    .linear_ranges = (struct linear_range[]) {
>>> +        REGULATOR_LINEAR_RANGE(600000, 0, 37, 12500),
>>> +    },
>>> +    .n_linear_ranges = 1,
>>> +    .n_voltages = 38,
>>> +    .ops = &rpm_mp5496_ops,
>>> +};
>>> +
>>>   static const struct regulator_desc pm2250_lvftsmps = {
>>>       .linear_ranges = (struct linear_range[]) {
>>>           REGULATOR_LINEAR_RANGE(320000, 0, 269, 4000),
>>> @@ -799,6 +808,11 @@ static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>>>       {}
>>>   };
>>>   +static const struct rpm_regulator_data rpm_ipq9574_mp5496_regulators[] = {
>>> +    { "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1" },
>>> +    {}
>>> +};
>>> +
>>>   static const struct rpm_regulator_data rpm_pm2250_regulators[] = {
>>>       { "s1", QCOM_SMD_RPM_SMPA, 1, &pm2250_lvftsmps, "vdd_s1" },
>>>       { "s2", QCOM_SMD_RPM_SMPA, 2, &pm2250_lvftsmps, "vdd_s2" },
>>> @@ -1320,6 +1334,8 @@ static const struct rpm_regulator_data rpm_pms405_regulators[] = {
>>>   };
>>>     static const struct of_device_id rpm_of_match[] = {
>>> +    { .compatible = "qcom,rpm-ipq9574-mp5496-regulators",
>>> +        .data = &rpm_ipq9574_mp5496_regulators },
>>>       { .compatible = "qcom,rpm-mp5496-regulators", .data = &rpm_mp5496_regulators },
>>>       { .compatible = "qcom,rpm-pm2250-regulators", .data = &rpm_pm2250_regulators },
>>>       { .compatible = "qcom,rpm-pm6125-regulators", .data = &rpm_pm6125_regulators },
> Best Regards,
> Devi Priya
