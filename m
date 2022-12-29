Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64710658C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 12:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiL2Lbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 06:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiL2Lbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 06:31:35 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9813DF9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 03:31:33 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m6so16754392lfj.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 03:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQDxoBS/o/39TrH1qe45eXS30LOpQBp1BK407ABXLfk=;
        b=tNpYVaVAsbbviDjADfCQME8VsRaT2ukWQpzL3RsY3j51GVwQvkH70JlekgOwUDKpza
         9f8IoTlMG4hRrs2mva6Hce+gRg4WNq0T+wfK0ctsg8l5OChH5A/CQfhfKxktRnJhAaJn
         U5BNbEXbZSIWQ3aVTf4RPhoVQI8DNwiyUp+4OI5d0rkVMqa9oj33QD4WyazsDA919SV2
         Yv0x2/ZA4G/PBj4kfzL7IyQSRcqT4eysH5sLfI+co64jKP7YTELhRMq+yEffj2rxYNZd
         adgxe1SwLP9RBBS+XHb5z8ZMpOnDEu4pQvLbmyhWcvhEIWQboDLk5iVjQjQ8KnQyOLJp
         B2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQDxoBS/o/39TrH1qe45eXS30LOpQBp1BK407ABXLfk=;
        b=HZVUfRhauFHsss/mHNbxrwpNrKliQWaq9cS4ddlpZluI/IMqAApFmLK1b0pUi6/eSl
         xts1yOy8RIkLZ6RxXhw3oH7DRpbE1C09bFlsUnduydrq0jsnO/DFllbfpm30N4b+vTqD
         q4FpKlYRWA3+GfWDfwB0Icti0Ly1J2M4lEa9uzM66wKSc47YG8QIC6H4ziDiqrtV/gKt
         iRHpefkiRzEhwQKtvQWBKpEsQaV0Ry9XxK8sqii6ME3J/bsux4D+Xo406X3VmmTUncRJ
         THvLWliOsb2yERlg6hopdF64axdwsJBUTJb/dhqou0iKy5Wb7Fk1+sG4JucFLE1/UwxT
         TFTw==
X-Gm-Message-State: AFqh2koEcmaflyY0/4JD4/AmaBVm1OdhGauQx1wpz5z+3eGp28fX50Q0
        8iCG5t89fAwEIxSuTSbS9lDHsQ==
X-Google-Smtp-Source: AMrXdXv8NQZRUm/WQTClSW9gKM7555QdSJfE3CZZ3i1we7CBGcg/d4BOuq888+1ZGIdoYqvDzNKbdw==
X-Received: by 2002:a05:6512:3c97:b0:4a5:42ba:d827 with SMTP id h23-20020a0565123c9700b004a542bad827mr8766477lfv.14.1672313491952;
        Thu, 29 Dec 2022 03:31:31 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512390e00b004b5872a7003sm3046435lfu.98.2022.12.29.03.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 03:31:31 -0800 (PST)
Message-ID: <24837866-9da2-9c9d-4094-d604db19cebd@linaro.org>
Date:   Thu, 29 Dec 2022 12:31:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/7] arm64: dts: qcom: sm8450: add spmi node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221229103212.984324-1-konrad.dybcio@linaro.org>
 <7b32e414-96a9-7265-efee-f872badb32b2@linaro.org>
 <71d7a162-569d-1443-9e53-3ba374d06ccd@linaro.org>
 <ee24809b-cf9b-c555-9c30-956949be25a4@linaro.org>
 <c4cc7365-df3e-f591-58b8-b844d5bf1737@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c4cc7365-df3e-f591-58b8-b844d5bf1737@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2022 12:04, Konrad Dybcio wrote:
> 
> 
> On 29.12.2022 11:57, Krzysztof Kozlowski wrote:
>> On 29/12/2022 11:45, Konrad Dybcio wrote:
>>>
>>>
>>> On 29.12.2022 11:42, Krzysztof Kozlowski wrote:
>>>> On 29/12/2022 11:32, Konrad Dybcio wrote:
>>>>> From: Vinod Koul <vkoul@kernel.org>
>>>>>
>>>>> Add the spmi bus as found in the SM8450 SoC
>>>>>
>>>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>>> [Konrad: 0x0 -> 0, move #cells down, make reg-names a vertical list]
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>>> v1 -> v2:
>>>>> No changes
>>>>>
>>>>>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 22 ++++++++++++++++++++++
>>>>>  1 file changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> index 570475040d95..b9b59c5223eb 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> @@ -2715,6 +2715,28 @@ aoss_qmp: power-controller@c300000 {
>>>>>  			#clock-cells = <0>;
>>>>>  		};
>>>>>  
>>>>> +		spmi_bus: spmi@c42d000 {
>>>>
>>>> Hmm looks different than reg.
>>>>
>>>>> +			compatible = "qcom,spmi-pmic-arb";
>>>>> +			reg = <0 0x0c400000 0 0x00003000>,
>>>>> +			      <0 0x0c500000 0 0x00400000>,
>>>>> +			      <0 0x0c440000 0 0x00080000>,
>>>>> +			      <0 0x0c4c0000 0 0x00010000>,
>>>>> +			      <0 0x0c42d000 0 0x00010000>;
>>>> x
>>> Hm, my guess would be that Vinod chose to put the "cnfg" reg
>>> instead of "core" in the unit address, as 8450 has 2 SPMI bus
>>> hosts and they both share the core reg, so it would have been
>>> impossible to have two spmi@core nodes..
>>
>> Eh? SM8450 has 2 SPMI hosts both using 0x0c400000? How does that work?
>> Usually address can be mapped only once.
> No idea either!
> 
>>
>> Where is the second SPMI? I cannot find it in linux-next.
> It's only there on downstream and I'm not sure how useful it is
> really, only some debug subdevice is attached to it.. Perhaps
> we could ignore its existence for now and I could use the core
> reg in unit address for spmi0?

I see it indeed in downstream. core, chnls and obsrvr IO are the same.
There is quite of debug devices attached.

There is a comment in PMIC arbiter code to use a IO mapping allowing
simultaneous mappings, so this is actually valid.

Anyway, DT expects unit address to match first reg, so if we want to
have second PMIC, we need to change the order of reg entries.

We can ignore this problem till we add second PMIC...

Best regards,
Krzysztof

