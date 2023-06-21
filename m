Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E197381AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjFUKut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjFUKuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:50:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156C1721
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:49:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3111547c8f9so6701640f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687344544; x=1689936544;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kSSvabUBUnXeW9LfB4PKIgvF+V3qK0e4kNQdRRELKjA=;
        b=VnYvCVAYHVO4VMS0djbImAQXbjrqyZMzOmTeIIayX+axyG2E9igfSWNdduR8gFx1N+
         nOxfDXwLaGPhDv731jTSngcXJOg8hz8cBbRMoKWdrWpMQbEVfTH7qReo5BtD9ImUZQ7p
         /xohRgmdFoctFvSUXgv/69gMY0KdeUi3qA+ygBTOeYH26H/M68dWhM9394ZsekjQFKWe
         Y8orW7lf+ybuNmzTu7Q9tg7YipJfCo/+KRdi4B0R+oH+6Us6S0p7UJMKa+tR5ZOUQEZY
         SiTPlQUbzhpdU1XTH6Kpya753S9uEh7GAfJqu5p/wrKVJ7FukOtbLa5WUJPgdheHimCH
         +rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687344544; x=1689936544;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSSvabUBUnXeW9LfB4PKIgvF+V3qK0e4kNQdRRELKjA=;
        b=hPt1fy72eRxSGv7SLhzh+LOwsRpd2gviJzGzR3S3PK0rGurcAl5lNZH4RN0Udxi8MB
         +Z399BHfek3NnIAuBGe0obT0we9LVQaDsV+InIogUu7pKXu2MZL8F2BfTGSZxng3A9qe
         aBViL6yv93HKpao4ZM56zI5/6GvDB5C5r7cdq/FTFkecH+MVDpVuz9zqoGpQqf+y9I9O
         I9Ls1AkFQDpwlArj1NQIUMM1z7P4bOEQFGgAhZ6i7E4quUoH7xys/yk5PsQ/0Biy/PB6
         fDNzvvENdiU3dSWnMAW2sdb8t/5MzmoSaVXWXEM+QRy9g4IAwQ5sQ5E8J+HBKKLTOCKC
         cXxw==
X-Gm-Message-State: AC+VfDyi52CpBMeHYax5tAVO+wyFm5D3Q1cpbdINu/SPWsBncBEbyu+q
        /kVR5kHyKFJYd0jsQDg3svZoJw==
X-Google-Smtp-Source: ACHHUZ4LBWYDkzkeR1AqOSommXpvfp5YhZJhqqvtatLLunDO6StzKCxv2iCqegxqAJQUU1YxIFgX4A==
X-Received: by 2002:a5d:6ad1:0:b0:30a:e69d:7219 with SMTP id u17-20020a5d6ad1000000b0030ae69d7219mr12095130wrw.65.1687344544457;
        Wed, 21 Jun 2023 03:49:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b158:3e69:8736:455d? ([2a01:e0a:982:cbb0:b158:3e69:8736:455d])
        by smtp.gmail.com with ESMTPSA id a7-20020adfed07000000b003112ab916cdsm4155821wro.73.2023.06.21.03.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 03:49:03 -0700 (PDT)
Message-ID: <2f0ddd6d-4099-fdaa-c8f5-95dba7fe87fd@linaro.org>
Date:   Wed, 21 Jun 2023 12:49:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: add missing power-domains
 property to usb qmpphy node
Content-Language: en-US
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230621-topic-sm8450-upstream-usb-phy-missing-power-domains-v1-1-d850c086c43c@linaro.org>
 <e31ad5ac-77ab-cf04-2e3e-d0857ccfdecf@linaro.org>
 <6180134a-2919-0f13-e37c-bb64b6403692@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <6180134a-2919-0f13-e37c-bb64b6403692@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 12:39, Neil Armstrong wrote:
> Hi,
> 
> On 21/06/2023 12:01, Konrad Dybcio wrote:
>> On 21.06.2023 11:55, Neil Armstrong wrote:
>>> Add the missing property to fix the bindings check error:
>>> arch/arm64/boot/dts/qcom/sm8450-hdk.dtb: phy@88e8000: 'power-domains' is a required property
>>>      From schema: Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>> Are you sure about this one? Historically PHYs have had their own GDSCs.
>>
>> May just be a wrong binding fwiw
> 
> Indeed you're right, forget this patch USB30_PRIM_GDSC id for the controller
> and starting from SM8550 a new one is used USB3_PHY_GDSC.
> 
> I'll fix the bindings.

https://lore.kernel.org/all/20230521202321.19778-2-dmitry.baryshkov@linaro.org/ does exactly that,
so no need to fix anything.

Neil

> 
> Neil
> 
>>
>> Konrad
>>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> index 5cd7296c7660..f921bd520e40 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> @@ -2046,6 +2046,8 @@ usb_1_qmpphy: phy@88e8000 {
>>>                    <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
>>>               clock-names = "aux", "ref", "com_aux", "usb3_pipe";
>>> +            power-domains = <&gcc USB30_PRIM_GDSC>;
>>> +
>>>               resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
>>>                    <&gcc GCC_USB3_PHY_PRIM_BCR>;
>>>               reset-names = "phy", "common";
>>>
>>> ---
>>> base-commit: 15e71592dbae49a674429c618a10401d7f992ac3
>>> change-id: 20230621-topic-sm8450-upstream-usb-phy-missing-power-domains-499a3d6c725f
>>>
>>> Best regards,
> 

