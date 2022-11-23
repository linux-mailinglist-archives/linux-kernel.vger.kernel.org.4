Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3BD6351E3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiKWIGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbiKWIGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:06:41 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF31B7211F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:06:38 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z24so20531030ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6cOJ2RyO4287A5TDNYLOHVXILZYrUSo7rBAF/7psbU=;
        b=yZqDJewosUXUBvEyc+i+WXnmApQ6mehi697kfcSvCEgD1EF5xhcMMUjzG2F7g6qzBL
         8/IghwHdV01ms8QTLmpslZRGNAcNUlc6iK1IjMYC/ynKcHp9Co7pmkknD4+1VKUZoAqg
         DPrDNjii7QlVfWsd0b1wLMjR1d79zCHi4m0Ri4AWVGteMMQHylwARCNY4z5b9eSO3bzC
         m2vvzM9eSPu8VejF6dVY3QAMxLkXX0oRXgce4a+4ClE4xXDG+Ytq6BVer2tFyh1yzH+c
         zcDM6ViYZMAQyvmEaFRHVNnthGKW+JbObW4u7/Z5NfHL1Hax1mzzmy7ukfcrK2xzRQuv
         zAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6cOJ2RyO4287A5TDNYLOHVXILZYrUSo7rBAF/7psbU=;
        b=lvOrs0Z4LF3QuGiy9xVgZqfSJoKpEQRdFMpIhhaw+pe2N5l10B2rMDmNnrw+DvHqyn
         5mERH44KJ1njJwLjG3K8tLsFetZn6BuM2jABOM9dazlO10UeKFXSD6MdW4gDiQsGWO3W
         YUy9UOu6W/sQ4L5L8FO+0QEIdLraQQJWsr5UlLoH5qFQ5ltCJn6N7mw+muHL8Er9pN6l
         xI7N1sJiqf+EIvQK5b8Gr27viDjN+pK+ZHy3cdrtlZWs2iR3rfTo7mIhZRZPKfBe3//L
         nAo7zR6AyymAscGxiGaAwZ5KkX6Hzp4pcU807XtPYfJvewhwprQbbA2dNbebmuLzVBN1
         wWBA==
X-Gm-Message-State: ANoB5pm9bNsvC1uNPLqr18mnWPEs7eUzDes1KNcBa/51HxHxkuCRmEhU
        IFgpAacbz7SXXQY1z4vF9MNcBw==
X-Google-Smtp-Source: AA0mqf6WUDTgWlouRyuC8lK93w5GFF+vwsReaMBl9jKSV8AY3j+3Hq0TqYz3DrOZSeIHYlIAn1PHMA==
X-Received: by 2002:a2e:2ac2:0:b0:26d:d55f:f1cf with SMTP id q185-20020a2e2ac2000000b0026dd55ff1cfmr8033907ljq.175.1669190797104;
        Wed, 23 Nov 2022 00:06:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c5-20020ac244a5000000b00494a603953dsm2825230lfm.89.2022.11.23.00.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:06:36 -0800 (PST)
Message-ID: <1d13e913-d425-8cb0-d954-d1d7bc340f38@linaro.org>
Date:   Wed, 23 Nov 2022 09:06:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and
 QRU1000 pinctrl
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118182039.29236-1-quic_molvera@quicinc.com>
 <20221118182039.29236-2-quic_molvera@quicinc.com>
 <528648f2-17df-ab19-8ad4-76423bbc0ae4@linaro.org>
 <faf2d137-efab-93ab-f325-1fa507f166a7@quicinc.com>
 <03174a04-440d-a840-1e54-fbdbdfe296c3@linaro.org>
 <2a50b68f-d2dd-bae5-29b3-f608813d5a3f@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2a50b68f-d2dd-bae5-29b3-f608813d5a3f@quicinc.com>
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

On 22/11/2022 16:23, Melody Olvera wrote:
> 
> 
> On 11/22/2022 1:48 AM, Krzysztof Kozlowski wrote:
>> On 21/11/2022 21:38, Melody Olvera wrote:
>>>
>>> On 11/20/2022 4:58 AM, Krzysztof Kozlowski wrote:
>>>> On 18/11/2022 19:20, Melody Olvera wrote:
>>>>> Add device tree bindings for QDU1000 and QRU1000 TLMM devices.
>>>>>
>>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>>> ---
>>>>>  .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml   | 134 ++++++++++++++++++
>>>>>  1 file changed, 134 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..cb0c496d8666
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>>>> @@ -0,0 +1,134 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-tlmm.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
>>>>> +
>>>>> +maintainers:
>>>>> +  - Melody Olvera <quic_molvera@quicinc.com>
>>>>> +
>>>>> +description: |
>>>>> +  This Top Level Mode Multiplexer block (TLMM) is found in the QDU1000 and
>>>>> +  QRU1000 platforms.
>>>> It's better to keep consistent style which allows to do easy
>>>> search/replace, than to have new files using their own sentences. So
>>>> keep it the same as was unified in few recent commits.
>>> Ok... Just making sure that's what you want. Last PS you gave comments to change
>>> the wording of this description to remove "This binding describes..." as we've done
>>> in all the other qcom pinctrl/tlmm bindings. I can change the wording back to the
>>> original, just want to be clear here.
>> I propose to have the same wording as other Qualcomm TLMM bindings,
>> however you changed it to something not the same. Therefore I wonder -
>> why having here different wording than all other bindings?
>>
>> By going back to original - what do you mean? If it matches all others,
>> then yes, but I doubt it.
>>
>> Just to be sure - are you working on proper (recent) trees or something old?
> 
> Original matched how it was done on other Qualcomm TLMM bindings. Feedback
> was to drop "This binding describes..." from [1], but all the Qualcomm TLMM
> bindings start with "This binding describes...". I'm looking at qcom tree for-next
> branch; should be recent, no?

No. It's not recent for anything else than managed by Bjorn. You need to
base the patches on maintainer's trees, which is usually the easiest to
achieve via linux-next (especially that these changes were in my tree
for some time before I sent them to Linus).

Your all other patches might have similar issues - wrong base or not
good example/starting point.

Best regards,
Krzysztof

