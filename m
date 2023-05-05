Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762326F8848
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjEER5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjEER5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:57:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E62A1C0CC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:57:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so3646743a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683309456; x=1685901456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aC6upq4hMnuQ8SDIGcpvAAUjMMnLUmqc58zEeP4t4Dg=;
        b=VLIbAU0K5WFem2Y/yQX84tVRz/1uUf7LH5Y2T7SdXicBb5FPoP7R6jDWUVB/XER0/D
         J75neyb1+Wz5P3WKSHX6sAkbH7OCxHXFu3rVanDupHSK04oRQ4Y7MDV8MwLJUet20sXP
         MxnZHbt6eBokbce4N4nIPY3WZraaKMuJDthewUheDXuV1ZluwvJnXJzNZhLsbPweBJ4h
         U1xMTDSZzdiVFMeDz/AmPAFz6Mu15VmY5uuw3saJVx0TWabJktQzAWkEwk5Ch8ozcS1e
         eHjMkL15JKLM6NK0v6N9a2cH+hBEF1OLvrEk9GwvO/7RcB0zb0kNrPyWnlmqAsTn11VR
         wP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683309456; x=1685901456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aC6upq4hMnuQ8SDIGcpvAAUjMMnLUmqc58zEeP4t4Dg=;
        b=bhoUyTgu+fyx+P8+6y3PZNEZaeaLX5bzIf7Us/+Pp37X5Hq2y/0Ng0b2eQtcbwUDS+
         4+QqRVQsC98E7VQ4DILVYCU7CeoPr+VGTqiHpBnqj1BgWN5ujxYjC/jFeirao/5Waqnk
         PxZQIRFmSs7W5ZY9Ia+0fu/WSJr3vnoEqFbBFzSWcL/JbuM9ehVMdwEbgauB9HHbceIM
         j+/afj3j9wZzVLk7JZrsOW/R5RLv64d+ANUnGxvab+5TmvsgwSir4zuEy7IRVABdEFR7
         qvSYcDR50thxs6R9pBQZD0tfRrp9ikS8+PzTWCyUyMRDurq78HAeWIoSBl/CASD6EZhX
         CNWg==
X-Gm-Message-State: AC+VfDyOcf0n6CkfKWdu1uy86+HS8Y0SMnobqe9C82K/zuaklD1QY87b
        dKV7/hOG81wkYnk2Jy/Gn6X5Mg==
X-Google-Smtp-Source: ACHHUZ4y13Pa+Discnufl5zTqukvbc2ENAxRhITb8VPA5/sIzeO3nCWwcl/w/z24ZPUR895/9Xh1QA==
X-Received: by 2002:a50:e602:0:b0:50b:c56a:feec with SMTP id y2-20020a50e602000000b0050bc56afeecmr2053950edm.17.1683309456398;
        Fri, 05 May 2023 10:57:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id s16-20020aa7d790000000b0050a276e7ba8sm3106378edq.36.2023.05.05.10.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 10:57:35 -0700 (PDT)
Message-ID: <6dc848f9-9955-5785-246e-53371d0a274d@linaro.org>
Date:   Fri, 5 May 2023 19:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/5] dt-bindings: soc: qcom: eud: Add SM6115 / SM4250
 support
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
 <20230505064039.1630025-3-bhupesh.sharma@linaro.org>
 <fe326d38-ee52-b0a4-21d8-f00f22449417@linaro.org>
 <CAH=2NtyqZVVwqk1FsCGrsGn25wxvzuhV-3z+q=5+JmpOoNm-vQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAH=2NtyqZVVwqk1FsCGrsGn25wxvzuhV-3z+q=5+JmpOoNm-vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 18:31, Bhupesh Sharma wrote:
> HI Krzysztof,
> 
> On Fri, 5 May 2023 at 21:54, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 05/05/2023 08:40, Bhupesh Sharma wrote:
>>> Add dt-bindings for EUD found on Qualcomm SM6115 / SM4250 SoC.
>>>
>>> On this SoC (and derivatives) the enable bit inside 'tcsr_check_reg'
>>> needs to be set first to 'enable' the eud module.
>>>
>>> So, update the dt-bindings to accommodate the third register
>>> property (TCSR Base) required by the driver on these SoCs.
>>>
>>> Also for these SoCs, introduce a new bool property
>>> 'qcom,secure-mode-enable', which indicates that the mode manager
>>> needs to be accessed only via the secure world.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> ---
>>>  .../devicetree/bindings/soc/qcom/qcom,eud.yaml   | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
>>> index f2c5ec7e6437..3b92cdf4e306 100644
>>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
>>> @@ -18,17 +18,33 @@ properties:
>>>      items:
>>>        - enum:
>>>            - qcom,sc7280-eud
>>> +          - qcom,sm6115-eud
>>>        - const: qcom,eud
>>>
>>>    reg:
>>> +    minItems: 2
>>>      items:
>>>        - description: EUD Base Register Region
>>>        - description: EUD Mode Manager Register
>>> +      - description: TCSR Base Register Region
>>> +
>>> +  reg-names:
>>> +    minItems: 2
>>> +    items:
>>> +      - const: eud-base
>>> +      - const: eud-mode-mgr
>>> +      - const: tcsr-base
>>>
>>>    interrupts:
>>>      description: EUD interrupt
>>>      maxItems: 1
>>>
>>> +  qcom,secure-mode-enable:
>>> +    type: boolean
>>> +    description:
>>> +      Indicates that the mode manager needs to be accessed only via the secure
>>> +      world (through 'scm' calls).
>>
>> I understood tcsr-base aplies only to SM6115, so this should be further
>> constrained in allOf:if:then:.
> 
> Please refer to my reply to your query in another review.
> I can see that secure access to mode_mgr register via TCSR will be
> exposed by other Qualcomm SoCs as well (from the available EUD
> documentation). So, maybe keeping it generic instead of limiting it to
> sm6115 only would be more useful, for future changes.

Your reply does not say that qcom,sc7280-eud uses it, so I don't
understand. This is not valid to qcom,sc7280-eud, so allowing it there
is not correct.

Best regards,
Krzysztof

