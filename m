Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770E060BB34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiJXUvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiJXUvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:51:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE85A187DE7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:58:02 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id r19so6184722qtx.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqGBPdHQZiFqUka1kDcHbUhHs0PplNnmpo9lzEnhfhE=;
        b=bw0emhiUidncaichi3Vs/0u0jfym+MDqp1eOW9vF6cemZ8f2+cvCLG29+nBrYsWpMh
         SKBbMW7cuWPVuNiRvOyi6FpyXATyV5EHdKfofc+I1AthLSamsZsLb9Z4pfoCqWr+6j06
         3OYrzeY3aZdtTCrm0Y5nfMif4DWqTS0oM5it1ksTxmN/143y8BaEWmBSBpmPy34xHGT6
         Uj8vf58vC13PpHIBSvvON2IaUSUQQDixm24OabegjWXtEwT0wW4pU1THQzw37/e406s5
         ONR05STYbKGNcaHn7LC3LMQwwcB6aPQA7ey6dZsCgfB1q9UAxdaRl1DaVGwlSmoKughK
         WPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqGBPdHQZiFqUka1kDcHbUhHs0PplNnmpo9lzEnhfhE=;
        b=4pcxSsjP0qopLbKq0d2TSJG2YC4IVT5wEgYYvEvpX/+o1u9ZLLd49LCWTIRJsMBPKE
         W0y6aIQH91PUFhZU9d7R/veNGM6y2LWMfttYWnNV3TIsXb+f9i4ZHcKkGBr2uJiN9na/
         IqoWbJyiw9p2dbBqt4C57/63PvL6vO57Sm/TwI3D+JOT8LcDL0rCPyXJECD5leLN4JZQ
         1Id2c5v8wPfoTjHTtgEvJTr/Y2oksKNFw5Z8SzeF6FCuh+JiWh3OsyOO/EFlNjUPo760
         AM3lFZVzwb2pOkomfwA7E1HY4BGAXUHRznBnmN77sKpEWPwsmTLVuyce0ziggd61nt4H
         Mq8w==
X-Gm-Message-State: ACrzQf1Cazf71QSz+oqDErUdimeBzPGxC2myCCrbSCeG6LakMj2udL2W
        PJHOXKm3onD84fknQYLkF41X/4keiyGUNg==
X-Google-Smtp-Source: AMsMyM7qADn0FOHMfkSwAlnDytaDQrl/fPHJ55zOMl6gP82fbHXNjnm09mZUi4Ab6e3NRNbmdf4Ifw==
X-Received: by 2002:a05:622a:187:b0:39c:f998:8963 with SMTP id s7-20020a05622a018700b0039cf9988963mr25930035qtw.603.1666637783762;
        Mon, 24 Oct 2022 11:56:23 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id s15-20020ac85ccf000000b0039cc22a2c49sm355571qta.47.2022.10.24.11.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 11:56:23 -0700 (PDT)
Message-ID: <d5726896-e62b-d19d-454b-700dd1c42222@linaro.org>
Date:   Mon, 24 Oct 2022 14:56:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 10/13] arm64: dts: qcom: sm8450: add spmi node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211209103505.197453-1-vkoul@kernel.org>
 <20211209103505.197453-11-vkoul@kernel.org>
 <5035b6a3-164b-afa0-b714-4deb886f9f90@linaro.org>
 <9f696023-f2b4-ccd0-34a0-6f4d5848e862@linaro.org>
 <8c1428a6-f268-cb03-3e55-887d30236924@linaro.org>
 <3af48606-731f-6047-92ca-80435f401ae3@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3af48606-731f-6047-92ca-80435f401ae3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 12:48, Dmitry Baryshkov wrote:
> On 24/10/2022 19:46, Krzysztof Kozlowski wrote:
>> On 24/10/2022 12:45, Dmitry Baryshkov wrote:
>>> On 24/10/2022 17:56, Krzysztof Kozlowski wrote:
>>>> On 09/12/2021 05:35, Vinod Koul wrote:
>>>>> Add the spmi bus as found in the SM8450 SoC
>>>>>
>>>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>>> ---
>>>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
>>>>>    1 file changed, 18 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> index f75de777f6ea..b80e34fd3fe1 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> @@ -645,6 +645,24 @@ pdc: interrupt-controller@b220000 {
>>>>>    			interrupt-controller;
>>>>>    		};
>>>>>    
>>>>> +		spmi_bus: spmi@c42d000 {
>>>>> +			compatible = "qcom,spmi-pmic-arb";
>>>>> +			reg = <0x0 0x0c400000 0x0 0x00003000>,
>>>>> +			      <0x0 0x0c500000 0x0 0x00400000>,
>>>>> +			      <0x0 0x0c440000 0x0 0x00080000>,
>>>>> +			      <0x0 0x0c4c0000 0x0 0x00010000>,
>>>>> +			      <0x0 0x0c42d000 0x0 0x00010000>;
>>>>
>>>> This is a patch from December 2021. Is there anything blocking it from
>>>> being merged?
>>>>
>>>> The same applies to several other patches here.
>>>
>>> As far as I know, Stephen still didn't pick up the spmi-pmic-arb support
>>> for the PMIC on the SM8450 platform. Thus we also can not merge the DT
>>> parts.
>>
>> Why we cannot merge DTS? How is DTS with new nodes depending on any
>> driver changes?
> 
> In this particular case, there was an open question, what should be the 
> bindings for the PMIC ARB v7.

Ah, so it is about PMIC ARB v7 bindings? Then it's reasonable to wait
with this one. I just had an impression that it's about driver changes...

> 
>>
>> Just like I replied to Konrad - if that's true, bindings are simply
>> wrong and should be fixed.
> 
> Maybe I missed the reply. Which email are you referring to?

I meant about this one:

https://lore.kernel.org/linux-arm-msm/8c1428a6-f268-cb03-3e55-887d30236924@linaro.org/T/#m50f4c72775492046f9b0a172e974cab83563af3c

Best regards,
Krzysztof

