Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A3F6F6F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjEDPjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjEDPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:39:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5822F49CD
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:39:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f1958d3a53so7061175e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683214760; x=1685806760;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q1qzICLY+awPTJTKj/ZDI6Y3pb3jBNUD1TpCiipf2+0=;
        b=kvylJedD42tijvCA3i93QZpSZxkMKJz27m0fqkYIqAbD5lJM6FDzi+7NQxm8NdfJJ5
         DPaJVXlz8AKhqGjuxtnsYliYtPYLoxfUFKuYKphTmJivFcjZRuJ7+DyKKZg6LeVSUhV3
         5a/+ZpRMmoKPiE/m1qwiRXxx+KfqV7fvjzE+Gk1t4x2vDHs4Hogh3a0LuLUBpC8WJMS2
         NHCzb324bkknrvZyrE2TuU5WgFjsVtGcQ36d0UEpIEnKYk1c48sC3oqtvEnXhM+I0S4C
         ojgTZQirApNFoUodyqHMGPO2PFowYhMSz6rRKM3vrXLL+jy7P8+EIdCP3/g2/Cvw5Stf
         GuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683214760; x=1685806760;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1qzICLY+awPTJTKj/ZDI6Y3pb3jBNUD1TpCiipf2+0=;
        b=WaBpBheZUYMgVj0Vet+VrEnbUs4OdqWlvTRf7h8wxKvIvGlFyaVzM067ATGSVuszK4
         swc2O+ND1rdiyIhj/doKSkBU9E+oNafW/0VQdrq6kZq/PiBYExB9WGAij0NpFUxucl/q
         CUvf5XWBAa2rCQPdlZ0aulhzzOKBo/7SSytjo5qgT8oD1kaYboNuePmNqSHb5kYw19Mo
         ARUYZZtlkeK/VOMgJnCIz9p5JC/VMIvahVE3hnFhdWQJH6dVcnwakfNgCZwJE+j085LV
         zoHrXwQ2/KiUdUfZRZsuGslp2K/WdBRtqlSmUk90exXGBsfmkggyIuePnYLm1n9tyJZm
         FftA==
X-Gm-Message-State: AC+VfDydgpKkID6+Sq8mndvl3uHw+DJeukx8VotfLN93luAOo9/6scZ3
        HGTl9XI1z8W1S4ZP2JTg9qNmTA==
X-Google-Smtp-Source: ACHHUZ7+UcKd5kIya/9FuPMw7sdQ2NCXE4pnxpVRi0a1IYZOVxyheor/BgmGfvvbaeu6HjuJiOgP1A==
X-Received: by 2002:a05:600c:258:b0:3f1:96a1:1dcb with SMTP id 24-20020a05600c025800b003f196a11dcbmr99555wmj.6.1683214760478;
        Thu, 04 May 2023 08:39:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:52fb:80bd:bee3:f741? ([2a01:e0a:982:cbb0:52fb:80bd:bee3:f741])
        by smtp.gmail.com with ESMTPSA id e8-20020adfdbc8000000b003047d5b8817sm28146085wrj.80.2023.05.04.08.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:39:19 -0700 (PDT)
Message-ID: <2c7c2fe8-85c4-581b-c34a-561652d4de4c@linaro.org>
Date:   Thu, 4 May 2023 17:39:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sm8350: add ports subnodes in usb1
 qmpphy node
Content-Language: en-US
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
 <20230503-topic-sm8450-graphics-dp-next-v1-1-d1ee9397f2a6@linaro.org>
 <4ce083f8-1ad1-c5c9-59cb-7511211b574f@linaro.org>
 <4eda7a33-991c-598e-0531-13959be0a912@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <4eda7a33-991c-598e-0531-13959be0a912@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 14:57, Neil Armstrong wrote:
> On 04/05/2023 09:38, Konrad Dybcio wrote:
>>
>>
>> On 3.05.2023 15:10, Neil Armstrong wrote:
>>> Add the USB3+DP Combo QMP PHY port subnodes in the SM8350 SoC DTSI
>>> to avoid duplication in the devices DTs.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> index ebcb481571c2..d048f4d35c89 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> @@ -2149,6 +2149,32 @@ usb_1_qmpphy: phy@88e9000 {
>>>               #phy-cells = <1>;
>>>               status = "disabled";
>>> +
>>> +            ports {
>>> +                #address-cells = <1>;
>>> +                #size-cells = <0>;
>>> +
>>> +                port@0 {
>>> +                    reg = <0>;
>>> +
>>> +                    usb_1_qmpphy_out: endpoint {
>>> +                    };
>>> +                };
>>> +
>>> +                port@1 {
>>> +                    #address-cells = <1>;
>>> +                    #size-cells = <0>;
>>> +                    reg = <1>;
>>> +
>>> +                    usb_1_qmpphy_usb_ss_in: endpoint@0 {
>>> +                        reg = <0>;
>>> +                    };
>>> +
>>> +                    usb_1_qmpphy_dp_in: endpoint@1 {
>>> +                        reg = <1>;
>>> +                    };
>> Shouldn't dp be a separate port@2?
> 
> Probably yes, but it should be the same issue for makena, but on makena
> we do not describe the USB SS and HS links separately, but only a single
> port for QMP input has been defined in the bindings.

Forget my comment, there's the 2 ports in the bindings, I was confused
after the bindings reviews...

Neil

> 
> Neil
> 
>>
>> Konrad
>>> +                };
>>> +            };
>>>           };
>>>           usb_2_qmpphy: phy-wrapper@88eb000 {
>>>
> 

