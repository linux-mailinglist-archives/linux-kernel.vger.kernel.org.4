Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC26D6C24
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbjDDSci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjDDScU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:32:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A1786BC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:29:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y15so43494874lfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680632960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZnRY6GCnSRZNXywZZo4l1rL8NGJjtnx2H6wkhAyYWk=;
        b=shPTuFyBpgascOHCQZKYa+oOwmJx2xp7ljljYQnrtgOSL4EViBsr9HddFXNvSu6Ukp
         5m2iUAmK4NapyHEkiwJj0Q7qWUIW2YUJsgHQCuDHCbyXpY4Sw6uCHfI5piUv6PYy1OzO
         bILPZuwtBfXmdORJZrK4RYfjOLsTSnhuCJtn0BV4xM0PsvXVlMFLgGn2TVL9jjZelLpa
         Y2zhmMCIJGTggQFEO+vzeT/WsyauqP4He44WFMAX9d0rsQS87QjheSWNmk/SUsnOBSdU
         3AxLkeC0dsDD0WXzAw09oNkQj6rphs7fr0EH+o/DNlW7zANb1xx3k4r0CJ8jrp5xTw8u
         2ETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZnRY6GCnSRZNXywZZo4l1rL8NGJjtnx2H6wkhAyYWk=;
        b=CgP/XE8nP7Ka+xK+gtQQ7CujwR7U/3raxzxsOYgoy56hiI8ZSQhGG6kMhCnRah9k0Z
         ldHRKtX09+mU8fgcjNc5gsnQq3wAUeeuMiWddGJl4d0+RGCGJo4qETLATePFXDhTW9I9
         ut9Urk7p5AcrSvy10I1v3vM1ChHkfp9dw4qj5q1QN592kfh2m3oVs6yGxnhBNQ0z6AtN
         kdSArVZ+flnDTvgAAPcCVHbgRllqSD5Rfmw8ChvOZTk9Znzr3Jbf0lJscpSbgwqnGeeE
         uG8KPAB/H2OTqUav7KEkApet1mwm8HWp0gJNzWKTLXa4YHc+WMfihamCZ5rSgLny7cTz
         t5dQ==
X-Gm-Message-State: AAQBX9dGAzc/GC9tGAdyVVTZ89yFDOfsdqcSubFZsiHNRoCdRR/WtCCL
        pmpSsqjsAMmg+0HUPrz7pR1vOA==
X-Google-Smtp-Source: AKy350ZmSYfYlwZPnNHVDATV64SYe5QWLbWWsdNOT/zJWVbwUsTFUWcbVGVOKvFojnRzHPpYxV+QJw==
X-Received: by 2002:ac2:4903:0:b0:4ea:f5dd:8aa1 with SMTP id n3-20020ac24903000000b004eaf5dd8aa1mr906187lfi.18.1680632959749;
        Tue, 04 Apr 2023 11:29:19 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id w4-20020ac25984000000b004e84d64ab51sm2439181lfn.58.2023.04.04.11.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 11:29:19 -0700 (PDT)
Message-ID: <cbb1a2fb-ff42-9f04-b817-13cde184a16d@linaro.org>
Date:   Tue, 4 Apr 2023 20:29:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 4/6] dts: qcom: arm64: qcom: sdm845: use defines for
 VMIDs
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230401173523.15244-1-me@dylanvanassche.be>
 <20230401173523.15244-5-me@dylanvanassche.be>
 <ea03bfb6-34c4-45e2-c179-74ecafad559f@linaro.org>
 <2d9d001f14036caf4f6d47448d4d2fdb0b188101.camel@dylanvanassche.be>
 <bf7b5218-56ba-5525-fcb8-7be71b114a79@linaro.org>
 <744f2ddc80ba9d9216ecd90b97e08aa5bd5452cd.camel@dylanvanassche.be>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <744f2ddc80ba9d9216ecd90b97e08aa5bd5452cd.camel@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.04.2023 18:22, Dylan Van Assche wrote:
> Hi,
> 
> On Mon, 2023-04-03 at 17:47 +0200, Krzysztof Kozlowski wrote:
>> On 03/04/2023 17:32, Dylan Van Assche wrote:
>>> Hi Krzysztof,
>>>
>>> On Mon, 2023-04-03 at 11:20 +0200, Krzysztof Kozlowski wrote:
>>>> On 01/04/2023 19:35, Dylan Van Assche wrote:
>>>>> Use VMID defines for SLPI's FastRPC node in the Qualcomm SDM845
>>>>> DTS
>>>>> instead of hardcoded magic values.
>>>>>
>>>>> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>> index 1f25a7f4e02b..dc4b553cbe2e 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>> @@ -13,6 +13,7 @@
>>>>>  #include <dt-bindings/clock/qcom,rpmh.h>
>>>>>  #include <dt-bindings/clock/qcom,videocc-sdm845.h>
>>>>>  #include <dt-bindings/dma/qcom-gpi.h>
>>>>> +#include <dt-bindings/firmware/qcom,scm.h>
>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>>>>  #include <dt-bindings/interconnect/qcom,sdm845.h>
>>>>> @@ -3372,7 +3373,8 @@ fastrpc {
>>>>>                                         qcom,glink-channels =
>>>>> "fastrpcglink-apps-dsp";
>>>>>                                         label = "sdsp";
>>>>>                                         qcom,non-secure-domain;
>>>>> -                                       qcom,vmids = <0x3 0xF
>>>>> 0x5
>>>>> 0x6>;
>>>>
>>>> Didn't you just add it in previous patch? Don't add incorrect
>>>> code
>>>> which
>>>> you immediately change.
>>>>
>>>
>>> Both are similar, the code is in fact the same. I followed what
>>> Konrad
>>> suggested in v3 to make a patch on top:
>>
>> I don't understand. Device nodes are similar, but they are different?
>> If
>> you add a line in patch X and change it in patch X+1, then something
>> is
>> wrong. Isn't this the case here or these are different device nodes?
>>
> 
> They are the same node.
> In the original patch the values are hex values, but Konrad asked to
> make a patch on top depending on the qcom scm header which has these
> magic hex values with defines.
Sorry if that wasn't clear, but what I meant to ask for is "pick this
patch that will get in soon and add the VMIDs you need on top of it
so that you can send it in parallel and Bjorn can merge both easily"
and had nothing to do with splitting out its inclusion in the dts

Konrad
> I can make the defines as default, no problem. Will do in v5.
> 
> Kind regards,
> Dylan
> 
>>
>> Best regards,
>> Krzysztof
>>
> 
