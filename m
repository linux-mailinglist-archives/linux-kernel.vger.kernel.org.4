Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6887767EA74
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjA0QKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjA0QKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:10:07 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0F4693
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:10:05 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p26so3770757ejx.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6hYblwHKmgqVkmsJ9UZAUT9JkBgORQlbn65CKL9uyI=;
        b=pEdVYKgiCE1Y+jJbN5tbtUpN3WagKaPX+4PZ6vA9nT8FVliXiYaiq0DrByxVNVcB0Y
         GcxfxU2I2WoWsFQ3UD3InmnmdH7om6ab+K2cN+iHG7zzPLtN2fF+AvEdc+V70GBDzJf8
         kg8OJI0HAVIG2EIkRE38/UhgGbrJypJ3zuCajKt7Ha1BUAUyyCQpHX/g2cR95VTaIy0j
         gWLkKhEttZq1AiGvlK7bE7IWzjlJTZHS9zE02cKJ1YOW2bRsv+yKdUPgD0EHzoCaBdt3
         Y6lIpewSB3lh+aiJoWo24NSAUZlbkazmNICOXnkfR2xLXbzFubuSCwlLm3X0hj/QwPQ5
         pRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6hYblwHKmgqVkmsJ9UZAUT9JkBgORQlbn65CKL9uyI=;
        b=ryg06JkjQqzKTqeKDzryzCi3AurE3OC5LMiKfx8OpKkUCGw8PH2IxBw9ydHQ8vU/mL
         dMYx0whlcYRY8erlZ6r5PGoodYCrp1TZRHoGNbSlnIysI2u4VrNsyAvgAGZfEsGNMgHl
         Cfxj4gvlAypOIoeNbwTp0XtzWROykarGvRRuH6Kv7i/9SbNNmiJNTDu4mpHJzbNcVzKB
         0W/myAX82o8yRyUE02/2zzr3txn2sypyepVVMvWO4OrufQX7isj9u89LqnDk88TGpKua
         1JFT3N3MxiTNpkkhkBkT+jEn7v2oQYWiasJzw9f1WIdB2VojaU+6HUuIQT6bP7WY7zD/
         uDuw==
X-Gm-Message-State: AFqh2krDDnthkWn/pWu2jPyQfWx6PyZgod2+6L/NU+EKsnyG9j3Wiavy
        RBkKuiBe/+grZAoDLGQ25hPyRA==
X-Google-Smtp-Source: AMrXdXv74DU7bH8g9TK2uD+jfBqsC15r8M7+fqI2a+NFe9gykAGGqbwsAa2b/0RkjFCWOi6siVMfKw==
X-Received: by 2002:a17:907:cf48:b0:86b:914a:576 with SMTP id uv8-20020a170907cf4800b0086b914a0576mr40536216ejc.6.1674835804263;
        Fri, 27 Jan 2023 08:10:04 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id fp35-20020a1709069e2300b00878683acac3sm2475821ejc.112.2023.01.27.08.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 08:10:03 -0800 (PST)
Message-ID: <cc037133-7c45-325f-4a1d-9855d033ae5c@linaro.org>
Date:   Fri, 27 Jan 2023 17:10:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 6/6] regulator: qcom_smd: Add support to define the bootup
 voltage
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
 <20230113150310.29709-7-quic_devipriy@quicinc.com>
 <77d84408-166e-8a02-227a-67654a4d31f2@linaro.org>
 <df6c1cd6-ea70-e65c-b4e8-3da80697242f@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <df6c1cd6-ea70-e65c-b4e8-3da80697242f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.01.2023 17:07, Devi Priya wrote:
> 
> 
> On 1/13/2023 9:07 PM, Konrad Dybcio wrote:
>>
>>
>> On 13.01.2023 16:03, devi priya wrote:
>>> Kernel does not know the initial voltage set by the bootloaders.
>>> During regulator registration, the voltage variable is just declared
>>> and it is zero. Based on that, the regulator framework considers current
>>> the voltage as zero and tries to bring up each regulator to minimum
>>> the supported voltage.
>>>
>>> This introduces a dip in the voltage during kernel boot and gets
>>> stabilized once the voltage scaling comes into picture.
>>>
>>> To avoid the voltage dip, adding support to define the
>>> bootup voltage set by the boodloaders and based on it, regulator
>>> framework understands that proper voltage is already set
>>>
>>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>>> ---
>> Or maybe hook it up to the spmi_regulator_common_get_voltage()
>> from the SPMI regulator driver and read the real voltage instead
>> of relying on hardcoded values thay may differ between boards?
>>
>> Konrad
> In IPQ9574, SPMI regulator is not used. We are using RPM-Glink communication and the regulators are controlled by RPM.
> In this case, we don't have an option to readback the bootup voltage and so, we have hardcoded the values
Unless something changed, RPM regulator framework is simply a
fancy front-end for communicating with the PMIC over SPMI, AFAIK..

Konrad
> 
>>>   drivers/regulator/qcom_smd-regulator.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
>>> index 1eb17d378897..49a36b07397c 100644
>>> --- a/drivers/regulator/qcom_smd-regulator.c
>>> +++ b/drivers/regulator/qcom_smd-regulator.c
>>> @@ -800,6 +800,7 @@ struct rpm_regulator_data {
>>>       u32 id;
>>>       const struct regulator_desc *desc;
>>>       const char *supply;
>>> +    int boot_uV; /* To store the bootup voltage set by bootloaders */
>>>   };
>>>     static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>>> @@ -809,7 +810,7 @@ static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>>>   };
>>>     static const struct rpm_regulator_data rpm_ipq9574_mp5496_regulators[] = {
>>> -    { "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1" },
>>> +    { "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1", 875000 },
>>>       {}
>>>   };
>>>   @@ -1394,6 +1395,9 @@ static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev
>>>       vreg->type    = rpm_data->type;
>>>       vreg->id    = rpm_data->id;
>>>   +    if (rpm_data->boot_uV)
>>> +        vreg->uV = rpm_data->boot_uV;
>>> +
>>>       memcpy(&vreg->desc, rpm_data->desc, sizeof(vreg->desc));
>>>       vreg->desc.name = rpm_data->name;
>>>       vreg->desc.supply_name = rpm_data->supply;
> Best Regards,
> Devi Priya
