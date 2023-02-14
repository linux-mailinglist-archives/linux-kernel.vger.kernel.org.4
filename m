Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAB7695ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjBNHsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBNHsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:48:03 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AE01C32D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:48:01 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r18so10333304wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9LBYoecALcKMnLalAfr6maJR0nbtDLWWltXeqYNnRQ=;
        b=IlhY5d8bfT2GtFTzvc9TZ3Dmy0aKn8gG9uG2DaaOWibrPk5vh9mNu2/xizO1wOcXE5
         YmDDkJsmZkeRX5UW31SJ5RbvTJoN5MJlOUYJAltfbqM72+QX2WY0Zfba95PktLhsPqmY
         qfqqKVgaAE3iiBnIMKJyHhvHrwk+B7OrG/tFmytrou9l/kRutdW/cSeen0YogA0M6P6O
         iThPvG9Grq3ewRJ/IX3Za1sApz50CtPSCt9q4pYzVOkot7GL3voQKjvU77/L3ECpVSM/
         mYOVh6jErMyXNn4qsrrdHjYi82CSvur4MmjP3bRx6jN1iJmTQ0DaLYyu7UrnraxsdPnv
         gzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9LBYoecALcKMnLalAfr6maJR0nbtDLWWltXeqYNnRQ=;
        b=hPJRbCmFfpSSQANxkvJGpEpVNXLJ1JFGjcEgcEkzG8eaWqcgke98kemWShcb7EDIhs
         8zXCUUExY98u3LoDqNvTRXt90JaMC6k0+gWaX+Pao2yhEshwOTE+VNvdmPBmMu1pmAnY
         qPcMnMHwY8rZJsfu8XotxNPIAHYmxoURWtTLGzG9io/yJ0rUWQtNUfcNGCGl/U+RGQkN
         HNbeOH+2y+jZexiBF34zt/exfewbLRoDGnkRlmqAhq90Ptd91pqDoQEymlMF2b+2DHML
         jGpOwx/INCt4t/qQ43lH98E7MveNnFGaspNNOIDJbyxkLp95pim9hkAwNHp1Hhrzp7en
         bu+A==
X-Gm-Message-State: AO0yUKW0fM5qC+u3wfKCoOu9vctgQQ/qozHsZAMGO0WYtMNWs0Gn2FKE
        0X7Ux2TJcqhBvkgD0mLkyaubYA==
X-Google-Smtp-Source: AK7set/WcU9lIqJ4Po60aUXsXakm5IcLvtMq6WakgTIVlgI22GmN5OrN1R/DMwYP88rmSbfZrjIjwQ==
X-Received: by 2002:a1c:f012:0:b0:3d9:f769:2115 with SMTP id a18-20020a1cf012000000b003d9f7692115mr1094919wmb.26.1676360880577;
        Mon, 13 Feb 2023 23:48:00 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600c4b1000b003dc4fd6e624sm15658892wmp.19.2023.02.13.23.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:48:00 -0800 (PST)
Message-ID: <e569e7e8-4d7f-1e69-5a4b-ee4c4f83d7ce@linaro.org>
Date:   Tue, 14 Feb 2023 08:47:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 2/5] arm64: dts: qcom: Add support for Crashdump
 collection on IPQ9574
Content-Language: en-US
To:     POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        robimarko@gmail.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230208053332.16537-1-quic_poovendh@quicinc.com>
 <20230208053332.16537-3-quic_poovendh@quicinc.com>
 <dbc93125-afd5-9ed9-7b45-0d79f728b4a5@linaro.org>
 <1a9ad881-7753-935a-ce7d-a2a79d34f16c@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1a9ad881-7753-935a-ce7d-a2a79d34f16c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 05:11, POOVENDHAN SELVARAJ wrote:
> 
> On 2/8/2023 1:29 PM, Krzysztof Kozlowski wrote:
>> On 08/02/2023 06:33, Poovendhan Selvaraj wrote:
>>> Enable Crashdump collection in ipq9574
>>>
>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Co-developed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>> ---
>>>   Changes in V3:
>>> 	- No changes
>>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 26 +++++++++++++++++++++++++-
>>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> index 2b86ba17bb32..9c4523f50a57 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> @@ -81,6 +81,13 @@
>>>   		reg = <0x0 0x40000000 0x0 0x0>;
>>>   	};
>>>   
>>> +	firmware {
>>> +		scm {
>>> +			compatible = "qcom,scm-ipq9574", "qcom,scm";
>>> +			qcom,dload-mode = <&tcsr_boot_misc 0>;
>>> +		};
>>> +	};
>>> +
>>>   	pmu {
>>>   		compatible = "arm,cortex-a73-pmu";
>>>   		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>>> @@ -95,11 +102,17 @@
>>>   		#address-cells = <2>;
>>>   		#size-cells = <2>;
>>>   		ranges;
>>> -
>> I don't think anything improved here - still unrelated change.
>>
>>
>> Best regards,
>> Krzysztof
> 
> Okay sure...next series will add required smem and download mode nodes 
> in different patches.

I commented the diff - specific hunk - which is unrelated.

Best regards,
Krzysztof

