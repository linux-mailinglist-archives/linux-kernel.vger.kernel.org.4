Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751576285A9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbiKNQkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbiKNQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:40:28 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EB610AD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:39:31 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j16so20146771lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRqXGzvo9cPPr4fRxtRgnnbMGXtJMbDZqF+/lYOlf00=;
        b=wTbvrqe/IIQ/sYxFmhbQI7Fb4ae3p+rADJIUv90Vtlt1Ag/ZQ7ydl+nuCl/nszh9kq
         PFxTUsLP7qEpjr99yRhzNsee9/ota9wfoI96/sV1jivpfEsfcWKZN7OtiMNT4/qvMnBx
         G27QMfg58zZ+zVTw3eoRcqaBssHFC6hGFjaVPQ7fZBvRS4HPi7h6KKBfYw3uxorKrIAG
         CHR1tC+GD/hYqVQQhyxZmpKTVC0H3POTEPJbhDx1RPqjjrJEAK250B9pvAyeoJk8TsVr
         qw+lSK86guEAhyq+kwxtBKRotHTHpiGbJJfulIvtZylGWNRKKaIDa2/9nzZSTfBeI0Q5
         mvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRqXGzvo9cPPr4fRxtRgnnbMGXtJMbDZqF+/lYOlf00=;
        b=TPzNYXrYaFKjAy/yKFI2rH9kqlfjnKELECs9NNWbA+Cs0528jHRobwbzAtKbRazugc
         zJrd7ISjPw8tnupNsVEpIbN4T76p/lCz4WgIUhbCPFKkgqGQnngnyLCymDiISe/Je+Gk
         liKkqJ2yIt4MkyRCKdnS2WSRYGMs0vJxJp/UDtp6sVvnHxfC/i4w1+tSjdghIZTN3bZr
         TuBNWAXI4oLKADh4HvlKDdutrQqQZaVBntXoDJOhz+WTs3FtIaFber1kBacPFOsTVScs
         uH1tJtpzNrtH0/Vr5hSlWhGlitv73VsYe1Yl06gbJViPVRu/6myHcc9Kn+insHmv9LoF
         duBQ==
X-Gm-Message-State: ANoB5pkv2jUWLOgJwsl1JnTvWyqW3Vj1hPxW/4p60Tdu9idQKUvA+gwl
        vgca+PMS3ZjFtDx7hzGD2Z9OZg==
X-Google-Smtp-Source: AA0mqf5kGgC42u40i6jz80xhoj6ThHf5hs2Qeju0m3VkGndVwWFU0E7/2zz0/AIMU4DOYXmhbVIKfQ==
X-Received: by 2002:a05:6512:2152:b0:4b4:917a:c36c with SMTP id s18-20020a056512215200b004b4917ac36cmr3753226lfr.218.1668443968118;
        Mon, 14 Nov 2022 08:39:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id cf30-20020a056512281e00b00492ca820e15sm1869762lfb.270.2022.11.14.08.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:39:27 -0800 (PST)
Message-ID: <efd412d0-7411-8b0b-4700-9e183a592048@linaro.org>
Date:   Mon, 14 Nov 2022 17:39:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
 <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
 <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
 <02725b78-04ad-8f4a-25c2-9cdaa1e37ab7@linaro.org>
 <Y3JthM1jC2vH1Kn+@hovoldconsulting.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3JthM1jC2vH1Kn+@hovoldconsulting.com>
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

On 14/11/2022 17:32, Johan Hovold wrote:
> On Mon, Nov 14, 2022 at 04:49:37PM +0100, Krzysztof Kozlowski wrote:
>> On 14/11/2022 15:18, Johan Hovold wrote:
>>> On Mon, Nov 14, 2022 at 03:07:41PM +0100, Krzysztof Kozlowski wrote:
>>>> On 14/11/2022 14:27, Johan Hovold wrote:
>>>>> On Fri, Nov 11, 2022 at 04:17:29PM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 11/11/2022 10:24, Johan Hovold wrote:
>>>>>>> The current QMP USB3-DP PHY bindings are based on the original MSM8996
>>>>>>> binding which provided multiple PHYs per IP block and these in turn were
>>>>>>> described by child nodes.
>>>
>>>>>>> +  "#clock-cells":
>>>>>>> +    const: 1
>>>>>>> +
>>>>>>> +  clock-output-names:
>>>>>>> +    items:
>>>>>>> +      - const: usb3_pipe
>>>>>>> +      - const: dp_link
>>>>>>> +      - const: dp_vco_div
>>>>>>
>>>>>> Why defining here fixed names? The purpose of this field is to actually
>>>>>> allow customizing these - at least in most cases. If these have to be
>>>>>> fixed, then driver should just instantiate these clocks with such names,
>>>>>> right?
>>>>>
>>>>> I'm only using these names as documentation of the indexes. The driver
>>>>
>>>> What do you mean by documentation of indexes? You require these specific
>>>> entries and do not allow anything else.
>>>
>>> I'm using this property as documentation of the valid indexes that can
>>> be used when referring to clocks provided by this device.
>>>
>>> There are currently three and the mapping is described by the
>>> 'clock-output-names' property.
>>
>> That's not the purpose of this property. Drop it then. The names do not
>> define the ABI and do not document it, actually. You require now that
>> every DTB, if providing clock-output-names, will have exactly such names
>> instead of having fixed IDs. DTBs are not for defining the ABI.
> 
> Fair enough, I'll drop it. But there doesn't seem to be a good way to
> describe the indexes currently and most bindings simply ignore to do so.
> 
> So what is the preference then? Just leave things undocumented, listing
> indexes in a free-text 'description', or adding a free-text reference to
> a binding header file and using those define names in a free-text
> 'description'?

Either 2 or 3. Several bindings for small number of constants choose
option 2.

> 
> And if going with the last option, does this mean that every SoC and PHY
> type needs its own header for those three clocks or so to avoid having
> a common dumping ground header file where indexes will not necessarily
> be 0-based and consecutive.

phy-qcom-qmp-combo.c has one qcom_qmp_dp_clks_hw_get(), so why would you
have many of header files?

Best regards,
Krzysztof

