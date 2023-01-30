Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA1F680B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbjA3LC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbjA3LC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:02:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6516134C3B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:01:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h12so10638923wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BmN+g/dAnuer7yOAtI/to5ZWjp6c/Vk223ZfFssWlmQ=;
        b=bkrkwX1ZmtQHtKR46u2m3FuzsAUs+wp6w0S6i+OD33iRdckKm8yFLdsaeA5VIfiPkc
         YHNgLa07djAT4QttWNg0ALSyHS0INYj3Qb61AQcnGIC3qn9RwRPf9HfYCKxOaXeTEc4S
         y5N24BQZpldNrz7NyCJDXTaVuN4NKQbhSrxDR/4HpRJxRv8G6Miz9xDaO6oy5FD48/+c
         ePn21hgP9E9+BTCI9CR7hajq8BzsqhWY2Ij5l4OkOAC8d+D0Fc3SHCeNUAbu0GO79gia
         +5Saj5QEERgTRCl2GPtzDvwrcRkwALjp9+1b6zyZnwR8tsILhwdTwzeJHJdwhjBflGux
         rUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmN+g/dAnuer7yOAtI/to5ZWjp6c/Vk223ZfFssWlmQ=;
        b=X+P0aUgT1qn0Oj8PVORWZcDGRApHb5D97V/GR/MeQH2rxWjc9gVVDmmZgmjKsPCAbI
         J2zr6wXlwm+hXCmjuh5/3qMImuVDz/qybGiymF9OBl+uT7Oo8QC67Rd8gAyFxG4dvZN8
         iOVRxC6kKJwDTNqPSh/VcWpZzxk2m/HTL75KxvnkqxJbHlHNksnNKzlzpnJd5ItdJHtx
         ei6PKjHI12eiwPXQdrUKkzoleenE3E2hUBPGYSIXad8oa2oR5zSPcgbLTNfrEi4QWYpu
         bGZDl5tayyXtGJWYYGraHM0FlwOWRYwPqKcObaGcBUXf5c3Vfbfn5WUJZwE268ZNs2nA
         L5WA==
X-Gm-Message-State: AFqh2ko+crHIFma6TCe3JiB9832NBr9qEl4cw7Pt6BtPAkxtBvmSRBhF
        bUDwMbcKGVCUDfX45oqm1Vug1g==
X-Google-Smtp-Source: AMrXdXu1MHbaat0/kWk30g5Bk1GkRBZQXl4XwxezF2rlzOZtqzjFvEjyu/AID3ezJDgJcjQGh3Fqzg==
X-Received: by 2002:a5d:5c07:0:b0:2bd:fa1d:5291 with SMTP id cc7-20020a5d5c07000000b002bdfa1d5291mr49366324wrb.67.1675076497821;
        Mon, 30 Jan 2023 03:01:37 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d4284000000b00241fde8fe04sm11614558wrq.7.2023.01.30.03.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:01:37 -0800 (PST)
Message-ID: <ea95f4fb-ccbb-8078-ddac-5254e1dbfc85@linaro.org>
Date:   Mon, 30 Jan 2023 12:01:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sm8450-hdk: add pmic glink node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
 <51d1c4a3-60bf-72df-e1d5-91c69514c36b@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <51d1c4a3-60bf-72df-e1d5-91c69514c36b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 30/01/2023 11:59, Konrad Dybcio wrote:
> 
> 
> On 30.01.2023 11:58, Neil Armstrong wrote:
>> On 30/01/2023 11:40, Konrad Dybcio wrote:
>>>
>>>
>>> On 30.01.2023 10:54, Neil Armstrong wrote:
>>>> Add the pmic glink node linked with the DWC3 USB controller
>>>> switched to OTG mode and tagged with usb-role-switch.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Missing commit message
>>
>> ??
>>
>>>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 34 ++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 33 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>>>> index 5bdc2c1159ae..5ab12c911bfe 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>>>> @@ -87,6 +87,31 @@ lt9611_3v3: lt9611-3v3-regulator {
>>>>            enable-active-high;
>>>>        };
>>>>    +    pmic-glink {
>>>> +        compatible = "qcom,sm8450-pmic-glink", "qcom,pmic-glink";
>>>> +
>>> You could remove this newline
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <0>;
>>>> +
>>>> +        connector@0 {
>>>> +            compatible = "usb-c-connector";
>>>> +            reg = <0>;
>>>> +            power-role = "dual";
>>>> +            data-role = "dual";
>>>> +
>>>> +            ports {
>>>> +                #address-cells = <1>;
>>>> +                #size-cells = <0>;
>>> And add one here
>>>
>>>> +                port@0 {
>>>> +                    reg = <0>;
>>> And here
>>>
>>
>> Ack
>>
>>>> +                    pmic_glink_dwc3_in: endpoint {
>>>> +                        remote-endpoint = <&usb_1_dwc3_out>;
>>>> +                    };
>>>> +                };
>>>> +            };
>>>> +        };
>>>> +    };
>>>> +
>>>>        vph_pwr: vph-pwr-regulator {
>>>>            compatible = "regulator-fixed";
>>>>            regulator-name = "vph_pwr";
>>>> @@ -724,7 +749,14 @@ &usb_1 {
>>>>    };
>>>>      &usb_1_dwc3 {
>>>> -    dr_mode = "peripheral";
>>>> +    dr_mode = "otg";
>>>> +    usb-role-switch;
>>>> +
>>>> +    port {
>>> Hm, maybe this could be moved to 8450 dtsi?
>>
>> Nop because it depends on the board layout, I think dr_mode
>> and eventual connector description should really stay in
>> the board dts.
> I just meant the port definition, would it cause any side
> effects to have it there?

Right, I don't think so, I don't have an opinion on that so whatever

Neil

> 
> Konrad
>>
>> Thanks,
>> Neil
>>
>>>
>>> Konrad
>>>> +        usb_1_dwc3_out: endpoint {
>>>> +              remote-endpoint = <&pmic_glink_dwc3_in>;
>>>> +          };
>>>> +    };
>>>>    };
>>>>      &usb_1_hsphy {
>>>>
>>

