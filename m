Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847506E3997
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDPPEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDPPEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:04:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E10E6C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:04:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a5so1259076ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681657489; x=1684249489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7knCr9Rw+t/6alapTgwg/iEzfEkJZjn1612eROrLe0=;
        b=XaR//UYbfZ9tT/9t67VsysxxBdnm84ST9QijxZCd8TEMnylMyj9VhQcx71ux05BA7X
         gvF55lWW47c0Bw/mwLgQzQD8fVM2+Uz7LYnQ9giWTZJ+fD1QPAas00GxJGeT5f5x82bY
         /ozxls8s/s2xn/tZ0lmEn2Abr28OKO+3cBhmPntSX4koURbI4C53Gd4Wd/b/s2n1icDL
         wBgDEteu6u8HjX9KYayX8Beyo7FtMdY+LlLOyOBHRHn0xIkgKxHq5QBqnm7m5ePcq8s2
         jlBO4tKK4AL1u3BdACgHyA0YLBD1lGjbNiLufR33TGn7ve4qzKpfRHNqkVJC35YsOquF
         5u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681657489; x=1684249489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7knCr9Rw+t/6alapTgwg/iEzfEkJZjn1612eROrLe0=;
        b=BLbMN4JU3+Nj1wQTr1ek0WRCr/3yBrzVrbBDeNHdXFoUquIBsfP71zctI/jJV3RGpl
         qqThxu7w0CYiYbOoPLcguuVD5Wbf3dar6JUEfh8xBIguI9XLMipJQJLUsjDJovVUmkfl
         I5KRzpPd3fpEMNSUjPR/zcbvoS6EYRvOeV1S4TJGoU3xsdQVYgAcjWySwUvGqwB3nw64
         taAqNpwyt5cPrJqS7681E2ld0uSRoFna973869c6YMVg6uuzlIJJRPuc2rzbICMpqNsr
         waDlzBEaTd9g8RluTsdVZwpGH8KWL7VOi34uVGPnZiqhNeUQipuMuLi3LYcEWLZ24ZSX
         XFOA==
X-Gm-Message-State: AAQBX9elglaouGwIWhfFe3o4seeN8emGTdUyZ0hi6ygqX19WnVlXRI20
        U2gd7MdErzQuUsmTym5QsrhNDw==
X-Google-Smtp-Source: AKy350ZmvaPyK/34orGOz6gZvivnaCzSPH+AWBjfFvkNmokL7H4Sbk94KYMRpcm+UnV25l3Pqe1/jA==
X-Received: by 2002:a17:906:ad87:b0:94a:4b7a:9886 with SMTP id la7-20020a170906ad8700b0094a4b7a9886mr4729072ejb.12.1681657488988;
        Sun, 16 Apr 2023 08:04:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba4d:301c:484d:5c9? ([2a02:810d:15c0:828:ba4d:301c:484d:5c9])
        by smtp.gmail.com with ESMTPSA id tk9-20020a170907c28900b0094f5179540fsm955274ejc.83.2023.04.16.08.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 08:04:48 -0700 (PDT)
Message-ID: <3877cb9e-9647-0acf-f705-d34fe2c731ff@linaro.org>
Date:   Sun, 16 Apr 2023 17:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 03/18] dt-bindings: interrupt-controller: qcom-pdc: add
 compatible for sa8775p
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
References: <20230327125316.210812-1-brgl@bgdev.pl>
 <20230327125316.210812-4-brgl@bgdev.pl>
 <CAMRc=Mfe6gCM=Mz6Can6xsSsrjX-9T_aR2Yev+b57koky_az-A@mail.gmail.com>
 <CAMRc=Mfw+4Co8JPz51_E+DSawijO8EB6rMmFXEmM0e5F3Fg_8A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMRc=Mfw+4Co8JPz51_E+DSawijO8EB6rMmFXEmM0e5F3Fg_8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 11:33, Bartosz Golaszewski wrote:
> On Thu, Apr 6, 2023 at 4:10 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> On Mon, Mar 27, 2023 at 2:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Add a compatible for the Power Domain Controller on SA8775p platforms.
>>> Increase the number of PDC pin mappings.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> ---
>>>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml     | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>>> index 94791e261c42..641ff32e4a6c 100644
>>> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>>> @@ -26,6 +26,7 @@ properties:
>>>    compatible:
>>>      items:
>>>        - enum:
>>> +          - qcom,sa8775p-pdc
>>>            - qcom,sc7180-pdc
>>>            - qcom,sc7280-pdc
>>>            - qcom,sc8280xp-pdc
>>> @@ -53,7 +54,7 @@ properties:
>>>    qcom,pdc-ranges:
>>>      $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>>      minItems: 1
>>> -    maxItems: 32 # no hard limit
>>> +    maxItems: 38 # no hard limit

I don't think the limit is correct. I still see warnings with this
patch. We already have 57 elements, so limit should be I guess 128 or
something.

Best regards,
Krzysztof

