Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94007482B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjGELJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjGELJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:09:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689941722
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 04:09:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fba74870abso7644336e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 04:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688555338; x=1691147338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8cYA7q56z8UCDFhXJUoPF4Hs2h/3aSmBTFzm6jnknrI=;
        b=Y+xZrKQcxcOAXxkre6DCpqb6au1aqmB8vgKFGj85xzIzfOiymDrBqiZtj/UhLqDm3K
         OVzjRe6GslLdtfRjP1KeSmTBsp33eRyFyW4UVguQ9XQjYUoPrpFMaDlg7cQxBzFl/2AD
         lsbVymnq8oN5KL2oKe89XYM7anov0NoroISe65jydA8HbwudDn6VzZqba8ZqBEPyZFr3
         JN/Vw3gFp9E+yks3bk8OLaqTTlcEVzM6IxDEmKaFD0og2n6mSksoLEwexfolf5Lgkpk0
         3bzCmKDIqpO/X2FbOOvynQ9EURWPNejkkDBdICBUg+Wsa1AsLWIIPyB5x7sdUvwKeOIw
         PUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688555338; x=1691147338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cYA7q56z8UCDFhXJUoPF4Hs2h/3aSmBTFzm6jnknrI=;
        b=fOQVocTwaljHV48Eyz1NH5y5wXyHiEo233LZzz89IBhBRsXoth6Afw5whVY9tgJGhU
         /XJm7E/46UNDxtNmn4kvu/AUAiOb/UGZZGGgQNQh6CvQCLWlIyFTvBE+SGH2oC1ENuBx
         a302Ajagj8lts6c4aQAhGdRhmegUHmDm5UIwLaRGnGTfyle0QJqXk3ZMx54voumyiXgR
         nJP+9+ElddIk8FxtHx0CzBjkhgi7WeuXukvXYBnzQfYwmW+t26dClulLB2yYjsDf1PbV
         IdJIh1P/vvegMI93r49v5su6iuPNhU2Ix1ppCW/aI8zJhOIaNoMWU/uOJhyQ3GascPaM
         5NFA==
X-Gm-Message-State: ABy/qLbqhslog/QZE7cdLOw+Qkyfh5MZLYPvT02p4PkfQSpHOv4dzaNN
        jYGlgqU4yHk40h/xHknoRy3o5w==
X-Google-Smtp-Source: APBJJlFrZLcEbIW4U3eWNaqsqfzHNx73Dkh7DONT0KurkHuqw2NSgkKEkyeBHR4apfFEItXNygI+Cw==
X-Received: by 2002:a05:6512:2006:b0:4fb:751a:98d5 with SMTP id a6-20020a056512200600b004fb751a98d5mr9981330lfb.18.1688555338635;
        Wed, 05 Jul 2023 04:08:58 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id er20-20020a05651248d400b004fad8b001f0sm5238764lfb.253.2023.07.05.04.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 04:08:58 -0700 (PDT)
Message-ID: <e285a22e-4943-4c9e-50d6-2dcac30703d3@linaro.org>
Date:   Wed, 5 Jul 2023 13:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved memory
 region
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230705053914.9759-1-quic_kbajaj@quicinc.com>
 <20230705053914.9759-2-quic_kbajaj@quicinc.com>
 <CAA8EJpo406gV-5H8+y4SJbbRqnWFRo5wrR6a9KJ2arbN61tS2Q@mail.gmail.com>
 <db283531-36a2-0535-4fe2-d1571b3fa8cb@quicinc.com>
 <CAA8EJpotQs_C_b+qvR1gXcasOtcw6SA8hCgJfuHFa7PnvPeobQ@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpotQs_C_b+qvR1gXcasOtcw6SA8hCgJfuHFa7PnvPeobQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.07.2023 11:42, Dmitry Baryshkov wrote:
> On Wed, 5 Jul 2023 at 10:06, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>>
>>
>>
>> On 7/5/2023 11:19 AM, Dmitry Baryshkov wrote:
>>> On Wed, 5 Jul 2023 at 08:40, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>>>> Add missing reserved regions as described in QDU1000 memory map.
>>>>
>>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 26 ++++++++++++++++++++++++
>>>>   1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>>> index 1d22f87fd238..3f5512ec0a90 100644
>>>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>>> @@ -448,6 +448,32 @@ &qupv3_id_0 {
>>>>          status = "okay";
>>>>   };
>>>>
>>>> +&reserved_memory{
>>>> +       #address-cells = <2>;
>>>> +       #size-cells = <2>;
>>>> +       ranges;
>>>> +
>>>> +       ecc_meta_data_reserved_mem:ecc_meta_data_reserved_region@e0000000{
>>> no_underscores_in_node_names. Ever.
>>>
>>> Also, if you have checked other platforms, you'd have seen that other
>>> platforms use a much more generic node name for 'memory' nodes (which
>>> you should have used too).
>>
>> These memory nodes are new to QDU platform, so will it be okay if I keep
>> these names without region suffix?
> 
> Just use 'memory@abcd'.
Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml

  Following the generic-names recommended practice, node names should
  reflect the purpose of the node (ie. "framebuffer" or "dma-pool").
  Unit address (@<address>) should be appended to the name if the node
  is a static allocation.

Konrad
> 
>>
>> Thanks
>> Komal
>>
>>>
>>>> +               no-map;
>>>> +               reg = <0x0 0xe0000000 0x0 0x20000000>;
>>>> +       };
>>>> +
>>>> +       harq_buffer_mem:harq_buffer_region@800000000{
>>>> +               no-map;
>>>> +               reg = <0x8 0x0 0x0 0x80000000>;
>>>> +       };
>>>> +
>>>> +       tenx_sp_buffer_mem:tenx_sp_buffer_region@880000000{
>>>> +               no-map;
>>>> +               reg = <0x8 0x80000000 0x0 0x50000000>;
>>>> +       };
>>>> +
>>>> +       fapi_buffer_mem:fapi_buffer_region@8d0000000{
>>>> +               no-map;
>>>> +               reg = <0x8 0xd0000000 0x0 0x20000000>;
>>>> +       };
>>>> +};
>>>> +
>>>>   &sdhc {
>>>>          pinctrl-0 = <&sdc_on_state>;
>>>>          pinctrl-1 = <&sdc_off_state>;
>>>> --
>>>> 2.40.1
>>>>
>>>
>>
> 
> 
