Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FAE669EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjAMQxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjAMQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:52:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE378271
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:49:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v6so31881634edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0Hwf435NI9x+XW4Wj0FsZq4Qu4oztZjGcQONywLmh8=;
        b=L8lwqLpWBsOLOn8/6W0GxhxaHljuv6GWrzyiwr6PVLBp3jXW+Cx4znhTaYzLaimrx6
         KtwfOQ8X3Gu31WqI4Xp9+2n8rVkmg7NqWbcmopvl/Z+n+GEs40IYQyd54NBG2kIUCoPA
         eVTz77cX3BTCM6m3IrEgg1/evqc8cxilBhCM/S9K4VlOnFsVug3CBLOG4witg3Lg9EzW
         bSwvz9FccElsNA/i3Uhs1cEgNveli9D/I2SJk2RgOg4AVA8PVSfNBJod2kyPllvIMoil
         mi469QB7XMmhAIXRld78pqVadUrnCIKyBl5+kOHmI/of2PFdfHYEnESU0Z9xx9oFAx7p
         vqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0Hwf435NI9x+XW4Wj0FsZq4Qu4oztZjGcQONywLmh8=;
        b=o3xlS+Qkv59I2uxF6sLuXIpqzxooxKrRcE/3x4KncYM6jc7+bCfCP7VenuAvbwJtMW
         ql4HhTntsTIMJrABylAgsQIzPDFAbtvXnkw0/MoTzzXq35HjwbyBB5Hfl2FHV09NzXCK
         8Y4Q6GzpwcylnTyJBv5UMVvu1SNzyz4Ul9fIWAH6HUlsUzx0xEYzOocf39BZL5OrnRxd
         jr7LbvkH+W2DquljPImmRJsXcx+DtlAafHWztP+WADPsDkDXK2uBBfxxLGxcpezJ930m
         XjsSDEnw49nGQOOJSDEUUqorp1aykkqpQTvd/NtzF4MaZnhhGbip7jmkKPKsmdq9cY1t
         9S7g==
X-Gm-Message-State: AFqh2kqwDnv2ZWMCYyyuPhNlvf+MahZVRZYQS+WVk0s1DIj8tNCE3zRk
        GP8qDzbGoqo8uVbtwG8f46BjpA==
X-Google-Smtp-Source: AMrXdXtpIsmBMd0PLUTqbePBHzOiSxh9soqvgLUnTlOwzhQlxgDe0YF+PTLlO5KRRmPFZRyCKGrP1A==
X-Received: by 2002:aa7:df17:0:b0:499:d297:334e with SMTP id c23-20020aa7df17000000b00499d297334emr10427423edy.20.1673628585847;
        Fri, 13 Jan 2023 08:49:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h26-20020a0564020e9a00b0045ce419ecffsm8320724eda.58.2023.01.13.08.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 08:49:45 -0800 (PST)
Message-ID: <5c046bb8-3d74-04c2-f32e-b6fd450f80fc@linaro.org>
Date:   Fri, 13 Jan 2023 17:49:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] Revert "dt-bindings: power: rpmpd: Add SM4250
 support"
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
References: <20230113152232.2624545-1-konrad.dybcio@linaro.org>
 <20230113152232.2624545-2-konrad.dybcio@linaro.org>
 <e1782f36-5a28-1fe4-47d5-b3bc00317b57@linaro.org>
 <92b7955c-bcac-20ad-ccde-3eef17f092b6@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <92b7955c-bcac-20ad-ccde-3eef17f092b6@linaro.org>
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

On 13/01/2023 17:36, Konrad Dybcio wrote:
> 
> 
> On 13.01.2023 17:33, Krzysztof Kozlowski wrote:
>> On 13/01/2023 16:22, Konrad Dybcio wrote:
>>> SM4250 and SM6115 use a shared device tree and the RPMPDs are
>>> identical. There's no need for a separate entry, so remove it.
>>>
>>> This reverts commit 45ac44ed10e58cf9b510e6552317ed7d2602346f.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  .../devicetree/bindings/power/qcom,rpmpd.yaml          |  1 -
>>>  include/dt-bindings/power/qcom-rpmpd.h                 | 10 ----------
>>>  2 files changed, 11 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>>> index 633d49884019..5bb9f59d196f 100644
>>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>>> @@ -39,7 +39,6 @@ properties:
>>>        - qcom,sdm845-rpmhpd
>>>        - qcom,sdx55-rpmhpd
>>>        - qcom,sdx65-rpmhpd
>>> -      - qcom,sm4250-rpmpd
>>
>> Yet, dedicated compatibles are usually recommended. Maybe this should be
>> used with fallback:
>> "qcom,sm4250-rpmpd", "qcom,sm6115-rpmpd"
> The compatible has never been used so far and it's really the
> same situation as SDM630/660 AFAIK, so I don't think it makes
> much sense.

OK, assuming these are almost the same SoCs in that aspect:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

