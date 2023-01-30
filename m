Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D695680B82
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbjA3LBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjA3LAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:00:24 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F92233475
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:00:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z11so10553621ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42nfxs7+j0auGTA9g4xWOyNLHLvDSidsXOT+f9td0DA=;
        b=jFzVZ/lHH2uSd6jOgWQqwozRiKpesIqvhdnot48LjyYSbK+6FHpPQXYx2BsoXdfPRN
         MYIDIsPKvX1/7lViVffaAfiZoqDiXOMoaXT5UtGtcqs5sDh/KfiRCdb/XtcS4HW0cGqU
         N3rnQTe5EiZ7ekhdGokb4uOJjxjwOQdwxVAwKoXFEwPc6cxkAIxm/mOmzT43vuNjjhre
         9OgxSUsG0xQ0y0mnV8mNzexYtnyjgrY/s3c13jV95pQ3o0/J40Q6Mi4pH73CIHEw3637
         adblGYQxLos3cvG3ezHkK1HOm+4OT7zVpWua57/O76ZhSEF3Qv6L0xCBotcJs+mPG9pa
         kxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42nfxs7+j0auGTA9g4xWOyNLHLvDSidsXOT+f9td0DA=;
        b=wBElGgUiqW7ub5TyuU8SsEz8RT++zPhqebhY7cyg5MfksSdLSAM9JC7UnhbalmXYTC
         3PFBJLIvoObjRELKpDKAjygRozLuRkqL3ia7NxFNqrfM1JxS/7JGv5vDZuSiPC5qd0fj
         pGVpRwqwOoc00EY0dwah2r5UOkKMqgaP5tj6rTv+TVs26cWi1TFJRoAE8NpJ+L3UFZ0k
         9v+09ORuwnJVD1h2cnGhLqRoaHg6/1vU6ifFPkkv2r7NNkOlVjnPAMb4JrZeizAT2Dxo
         xN53Phvu5JngqwKItqIYe3ySZKPivgQIOOuf20y0bkKUX36pnrdenvzqx/TZidTAIOjw
         oK4Q==
X-Gm-Message-State: AO0yUKU5CbQPvlRCJEedUcl24Rd8CQy7JbAN7QoA70RnycKBq0Kscl5g
        uyrfQjqQJiaNZov/zmogV6ygvA==
X-Google-Smtp-Source: AK7set85d0o7+cCe8nNxiPsQPHcIs8hggv+PhgtrPXuhoUHOpaEgeKsNsdQ0RG1HFwSTrrj6txuWdg==
X-Received: by 2002:a50:9eef:0:b0:4a0:8fc4:6be8 with SMTP id a102-20020a509eef000000b004a08fc46be8mr22328727edf.26.1675076400886;
        Mon, 30 Jan 2023 03:00:00 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id eg55-20020a05640228b700b0049f5ab4fa97sm6679693edb.86.2023.01.30.02.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:00:00 -0800 (PST)
Message-ID: <51d1c4a3-60bf-72df-e1d5-91c69514c36b@linaro.org>
Date:   Mon, 30 Jan 2023 11:59:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sm8450-hdk: add pmic glink node
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v1-5-0b0acfad301e@linaro.org>
 <1c3fa66b-651f-c3c1-1751-af3f43c86c49@linaro.org>
 <6cde6bce-ce28-2dd0-1f16-4868ae93fb3f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6cde6bce-ce28-2dd0-1f16-4868ae93fb3f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.01.2023 11:58, Neil Armstrong wrote:
> On 30/01/2023 11:40, Konrad Dybcio wrote:
>>
>>
>> On 30.01.2023 10:54, Neil Armstrong wrote:
>>> Add the pmic glink node linked with the DWC3 USB controller
>>> switched to OTG mode and tagged with usb-role-switch.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Missing commit message
> 
> ??
> 
>>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 34 ++++++++++++++++++++++++++++++++-
>>>   1 file changed, 33 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>>> index 5bdc2c1159ae..5ab12c911bfe 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>>> @@ -87,6 +87,31 @@ lt9611_3v3: lt9611-3v3-regulator {
>>>           enable-active-high;
>>>       };
>>>   +    pmic-glink {
>>> +        compatible = "qcom,sm8450-pmic-glink", "qcom,pmic-glink";
>>> +
>> You could remove this newline
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        connector@0 {
>>> +            compatible = "usb-c-connector";
>>> +            reg = <0>;
>>> +            power-role = "dual";
>>> +            data-role = "dual";
>>> +
>>> +            ports {
>>> +                #address-cells = <1>;
>>> +                #size-cells = <0>;
>> And add one here
>>
>>> +                port@0 {
>>> +                    reg = <0>;
>> And here
>>
> 
> Ack
> 
>>> +                    pmic_glink_dwc3_in: endpoint {
>>> +                        remote-endpoint = <&usb_1_dwc3_out>;
>>> +                    };
>>> +                };
>>> +            };
>>> +        };
>>> +    };
>>> +
>>>       vph_pwr: vph-pwr-regulator {
>>>           compatible = "regulator-fixed";
>>>           regulator-name = "vph_pwr";
>>> @@ -724,7 +749,14 @@ &usb_1 {
>>>   };
>>>     &usb_1_dwc3 {
>>> -    dr_mode = "peripheral";
>>> +    dr_mode = "otg";
>>> +    usb-role-switch;
>>> +
>>> +    port {
>> Hm, maybe this could be moved to 8450 dtsi?
> 
> Nop because it depends on the board layout, I think dr_mode
> and eventual connector description should really stay in
> the board dts.
I just meant the port definition, would it cause any side
effects to have it there?

Konrad
> 
> Thanks,
> Neil
> 
>>
>> Konrad
>>> +        usb_1_dwc3_out: endpoint {
>>> +              remote-endpoint = <&pmic_glink_dwc3_in>;
>>> +          };
>>> +    };
>>>   };
>>>     &usb_1_hsphy {
>>>
> 
