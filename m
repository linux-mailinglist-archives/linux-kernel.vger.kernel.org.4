Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE23162DC21
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiKQM6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiKQM6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:58:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3F2D1FF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:58:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id r12so2673867lfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/Ym4H+GfMviN6/G1FhFGdK0zwCiyAfv5x1OUJDNIlY=;
        b=ZbxBs8x57tViKk8dVG4W/fkLcsnZT2gppAREc2LdVbeTgxqD/1ZHMkdrZ9I74TzPMY
         Q9U1yUOTl7P9Od7dwn5G89vjhe79ux2WNr6C2j/1h1C1DVKozMVzAEUA9TApVKROZ15I
         AH8sJQK2RNJAp8FLKHYxGZmKk4YiHjy7oaAupkkhNGC62r9pSKsmJZQRyA9fL7D0tjT1
         rOU2ENSFG0Mc5PECnFKIi2f8GOXSBP33jtpsXivaZjDxvxAgKfbkgWSva5zI2DOW3+Tx
         x2FR3N3WorLmKSZwdYEJIfxhYZ1/JNRrormrp7U3YS2SKdSZnXgf4dV1lsT/md1XnibW
         fpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/Ym4H+GfMviN6/G1FhFGdK0zwCiyAfv5x1OUJDNIlY=;
        b=4vKhIJEeUKQue9OTW+Jgnoss4++flNEi+Juh0vDcm0hhd6GtuslpE/kUkwaGdIl822
         VWCHfhkbf4RDry9CZVoSWNuKoakspV4jNWaI7gBwzmBPdkquLzwzPdgBlTsW7Z0jZadl
         jG8mo+4oo0Q2Hzk2ToMgLslW+IKz9mVVNxQTGH3v9sJteyKuayliGTLarGNcvagKoPmp
         BCFy38DGlQFNUvOX22J/B+jPrj9XMBaLkeMyFXauAZYikOxGOGMCFG2Iy6URSfDV5K5O
         YCQy8CXleql6A+p4+leJuOXS/y1AVoFVZHjyiVrC1dhb389rdty3DrGYF/zEhgYlRrGo
         V4mw==
X-Gm-Message-State: ANoB5pkbQ0GCj8fNdvtAFXWTjMaLpeeRmlFRjJuwP/kWy30wrwzNv43v
        u1ZfNRdiVcdL2rIn2eZNaV98wg==
X-Google-Smtp-Source: AA0mqf6CahUyXo5c2XC3fgjghDAZPTCYLIkRDSTrxOCJK4a0guVWdA7pQcn0TaJj7XPlFRL86NnNBQ==
X-Received: by 2002:a19:5e58:0:b0:4a7:5a63:71e1 with SMTP id z24-20020a195e58000000b004a75a6371e1mr873041lfi.399.1668689897798;
        Thu, 17 Nov 2022 04:58:17 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b0048cc076a03dsm135517lfg.237.2022.11.17.04.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 04:58:17 -0800 (PST)
Message-ID: <c818f6d8-94e1-5ac4-ec67-f6f872780c38@linaro.org>
Date:   Thu, 17 Nov 2022 13:58:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Add compatible for
 sm8550
Content-Language: en-US
To:     neil.armstrong@linaro.org, Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-tsens-v1-0-0e169822830f@linaro.org>
 <4dd96db7-b667-7b8f-f80d-a250ac63f223@linaro.org>
 <cb94a2f5-6521-19b5-ca30-c68ffd2068a4@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cb94a2f5-6521-19b5-ca30-c68ffd2068a4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 09:06, Neil Armstrong wrote:
> Hi,
> 
> On 16/11/2022 12:26, Krzysztof Kozlowski wrote:
>> On 16/11/2022 11:09, Neil Armstrong wrote:
>>> The Qualcomm SM8550 platform has three instances of the tsens block,
>>> add a compatible for these instances.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>> To: Andy Gross <agross@kernel.org>
>>> To: Bjorn Andersson <andersson@kernel.org>
>>> To: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> To: Amit Kucheria <amitk@kernel.org>
>>> To: Thara Gopinath <thara.gopinath@gmail.com>
>>> To: "Rafael J. Wysocki" <rafael@kernel.org>
>>> To: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> To: Zhang Rui <rui.zhang@intel.com>
>>> To: Rob Herring <robh+dt@kernel.org>
>>> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>>> Cc: linux-arm-msm@vger.kernel.org
>>> Cc: linux-pm@vger.kernel.org
>>> Cc: devicetree@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> index f0bd4b979e28..09dbd96d380e 100644
>>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> @@ -58,6 +58,7 @@ properties:
>>>                 - qcom,sm8250-tsens
>>>                 - qcom,sm8350-tsens
>>>                 - qcom,sm8450-tsens
>>> +              - qcom,sm8550-tsens
>>
>> alOf:if:then should be updated.
> 
> I thought the -v2 fallback would be enough since 8450 isn't present either in the alOf:if:then either.
> 
> Anyway, will fix this.


No, you are right. The v2 fallback is already in several allOf:if:then,
so this should be fine.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

