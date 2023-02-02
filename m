Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B838F687C87
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjBBLnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjBBLnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:43:47 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2FB8C1EA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:43:46 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id k4so5213390eje.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 03:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZAt+sBj7b9ea62wSim/pGj5JLU/j6Lhld7tQV45g/o=;
        b=y/rffQSEv8KB0tcUVGuq4maNsP9uwDHf8Zp2tRsQgdJz06O3iO55PddIUzZ9YqAzcG
         HDER74nq5Tw5ROmhthxAaDyttFd0urmpKaZK/sz4MiJnlEIkeOKabvKbstlAPqbPIRyD
         MeK2NOsoFir/PgJMCCqglnMceb8cyh5igIe+Y+VbvLfxgsOjddMqeK9NL7Qmw9/s919G
         mbtnZUBFEqfcClYSUEByczQkdfxF40MW2D3I7tnxAwOkUTqUv0X2i6lkoIxwi/wRjD9i
         OwsZjVJynSAuTWvE4Gt3F4npj8h9tROVId+5L78P2zMRnlF1J4eGILzpggqUpZJsa2lM
         NvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZAt+sBj7b9ea62wSim/pGj5JLU/j6Lhld7tQV45g/o=;
        b=wcCFS7FXj8TD9kXP6/G6AmCtMMdynywLbafC1RmOAuRI6CJaeUkz1Q/JkHrIw6ohSf
         Pq7Cq8O7nDeStqL/OF3YA2CR0Eeg8rGdt8hNudkP+PrNca3plu6D2f2yly+1v6QgKjRb
         P1jK4RhzEibFfwgXLCb90nNOKbnLt3JEFpItsgvYEZ5GXPJOvA0pK1/RH1PZ/rFuYkHj
         D39G4tMF1KvxGZD/kKNo5kRQy9eGUtsIj0fGDhSbYBK6c0WCpvgVCkDKBIvBUecMkaop
         4Hc3xkkJB/2jHJrpNOsaix70D/8t5Wy6Tyspk6tnz9gAy0fT9WiM9E/uz2qQuPhB3QaE
         K6ow==
X-Gm-Message-State: AO0yUKUTtpNbAgPkWqMOy8t5NIXURYV8M/FBTz+NUOrYWQRXIzyXteSA
        +7oA0o2Ky7PirDHAM3TrgRHDGA==
X-Google-Smtp-Source: AK7set+UstQhVXjt1uoO1Uw4d4FbGYZxZ2+/NYh4RIRme6OjpdxP19lGUozRH/aiEvHjLW9chzgkiA==
X-Received: by 2002:a17:906:3bc3:b0:87f:89f2:c012 with SMTP id v3-20020a1709063bc300b0087f89f2c012mr5968386ejf.24.1675338224778;
        Thu, 02 Feb 2023 03:43:44 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id aa7-20020a170907354700b00889310a3fcbsm5959229ejc.210.2023.02.02.03.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 03:43:44 -0800 (PST)
Message-ID: <bab449de-73c9-f65e-24fa-84749fbc51bb@linaro.org>
Date:   Thu, 2 Feb 2023 12:43:42 +0100
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
 <cc037133-7c45-325f-4a1d-9855d033ae5c@linaro.org>
 <6bb22160-5966-43d3-ffba-489b77b3a095@quicinc.com>
 <de6e69d6-18cd-2732-9a18-f4dfd29be6dd@linaro.org>
 <05c01db8-1ca1-475f-8cb4-41fddff8b85a@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <05c01db8-1ca1-475f-8cb4-41fddff8b85a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.02.2023 12:09, Devi Priya wrote:
> 
> 
> On 1/31/2023 6:14 PM, Konrad Dybcio wrote:
>>
>>
>> On 31.01.2023 10:28, Devi Priya wrote:
>>>
>>>
>>> On 1/27/2023 9:40 PM, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 27.01.2023 17:07, Devi Priya wrote:
>>>>>
>>>>>
>>>>> On 1/13/2023 9:07 PM, Konrad Dybcio wrote:
>>>>>>
>>>>>>
>>>>>> On 13.01.2023 16:03, devi priya wrote:
>>>>>>> Kernel does not know the initial voltage set by the bootloaders.
>>>>>>> During regulator registration, the voltage variable is just declared
>>>>>>> and it is zero. Based on that, the regulator framework considers current
>>>>>>> the voltage as zero and tries to bring up each regulator to minimum
>>>>>>> the supported voltage.
>>>>>>>
>>>>>>> This introduces a dip in the voltage during kernel boot and gets
>>>>>>> stabilized once the voltage scaling comes into picture.
>>>>>>>
>>>>>>> To avoid the voltage dip, adding support to define the
>>>>>>> bootup voltage set by the boodloaders and based on it, regulator
>>>>>>> framework understands that proper voltage is already set
>>>>>>>
>>>>>>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>>>>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>>>>>>> ---
>>>>>> Or maybe hook it up to the spmi_regulator_common_get_voltage()
>>>>>> from the SPMI regulator driver and read the real voltage instead
>>>>>> of relying on hardcoded values thay may differ between boards?
>>>>>>
>>>>>> Konrad
>>>>> In IPQ9574, SPMI regulator is not used. We are using RPM-Glink communication and the regulators are controlled by RPM.
>>>>> In this case, we don't have an option to readback the bootup voltage and so, we have hardcoded the values
>>>> Unless something changed, RPM regulator framework is simply a
>>>> fancy front-end for communicating with the PMIC over SPMI, AFAIK..
>>>>
>>>> Konrad
>>> Currently in our driver, the voltage write request will be sent to RPM via GLINK which then writes it to the PMIC over I2C using the below APIs
>>> qcom_rpm_smd_write -> rpmsg_send
>>> In IPQ9574, we do not have SPMI support or the support to readback voltage.
>> Okay, I didn't quite catch that there's *only* an i2c PMIC on this
>> platform.. Looking at the MP5496 datasheet though, reading back
>> the voltage should be possible via simply reading the fields that
>> are used to set it.
>>
>> Konrad
> The CPR regulator operates in closed loop mode and the RPM can independently update the PMIC voltage.
> So, Performing an i2c read to the PMIC would introduce conflicts when RPM uses the i2c for any of the voltage write or read operations.
So.. are we even going to set voltage from Linux at all, for example
for DCVS? If not, maybe we can simply not register the regulator and
let the non-APSS parts handle it themselves?

Konrad
>>>
>>>>>
>>>>>>>     drivers/regulator/qcom_smd-regulator.c | 6 +++++-
>>>>>>>     1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
>>>>>>> index 1eb17d378897..49a36b07397c 100644
>>>>>>> --- a/drivers/regulator/qcom_smd-regulator.c
>>>>>>> +++ b/drivers/regulator/qcom_smd-regulator.c
>>>>>>> @@ -800,6 +800,7 @@ struct rpm_regulator_data {
>>>>>>>         u32 id;
>>>>>>>         const struct regulator_desc *desc;
>>>>>>>         const char *supply;
>>>>>>> +    int boot_uV; /* To store the bootup voltage set by bootloaders */
>>>>>>>     };
>>>>>>>       static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>>>>>>> @@ -809,7 +810,7 @@ static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>>>>>>>     };
>>>>>>>       static const struct rpm_regulator_data rpm_ipq9574_mp5496_regulators[] = {
>>>>>>> -    { "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1" },
>>>>>>> +    { "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1", 875000 },
>>>>>>>         {}
>>>>>>>     };
>>>>>>>     @@ -1394,6 +1395,9 @@ static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev
>>>>>>>         vreg->type    = rpm_data->type;
>>>>>>>         vreg->id    = rpm_data->id;
>>>>>>>     +    if (rpm_data->boot_uV)
>>>>>>> +        vreg->uV = rpm_data->boot_uV;
>>>>>>> +
>>>>>>>         memcpy(&vreg->desc, rpm_data->desc, sizeof(vreg->desc));
>>>>>>>         vreg->desc.name = rpm_data->name;
>>>>>>>         vreg->desc.supply_name = rpm_data->supply;
>>>>> Best Regards,
>>>>> Devi Priya
>>> Best Regards,
>>> Devi Priya
