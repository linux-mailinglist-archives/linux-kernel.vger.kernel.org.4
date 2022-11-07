Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94D961FD8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiKGS2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbiKGS2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:28:41 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5833313E1B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:28:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id r12so17966146lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdp7PDi0T7BQyAwkQUhSfvaQ6xRVmE/EG/6MvECjXbE=;
        b=uuadWkdCxNQeLEDr/RNoiZGpYCm7HXdRuNfjc6nZ8jTbjDCDb1W8PnYCE6V7sOJywA
         8+1uBCvsqT+UMdS/Bb8zisl8pmTNqD3lW7aQ8tqEtkVUki9Gukbzb/QxGvDQrjzSXb6a
         R2p5eH4RwbDQ2xVDqRjdPTM5m5NXrFiUX3WmQ0Wz7aHzBnDad54KAMjQPRWocC89E4i/
         oB7f64FItvZILL5UFCMBEVkfCJG7gUTtttfqUIfC/pGiViGu1/TWtgEA6CtLKBgpphtq
         unwJdYs8F8CmEuayXFNst5C7PjQBL5myT0KASV705GuY7KsHMAjlZL/Wif5EowNEWXLu
         iNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdp7PDi0T7BQyAwkQUhSfvaQ6xRVmE/EG/6MvECjXbE=;
        b=3Ef6XMb9iz+/7gZ2vZeRgQyfo2Tld52FWjT0pdvhZOoPI8cnN+ZbnRIYCvfwRQP73w
         KwKlFhVtb3TOlGykSga6Zy5B4GQTnLMqLVhp/pr/khftkGR++mAZ5sNSopNNuJW95sCH
         znRn8snVkl/XL1R3XiPRIU6b6YYWgnQxG58b3lF0ySBAPVcr+4FhBdPssMkvO7DsBxVS
         jlxy9G6gx3tT6XGYgE8HQrOwtthwo8JWqSFLLQZqbazK+RmvVTQJr2h/NLSQ+PnNowF7
         VwPd4+njw38swI2V08qFA9tZqe3yjOmPPJD+xZs2zuMk06ksEy+CvxptIoAECzJGNGq7
         7eTg==
X-Gm-Message-State: ACrzQf2NOA3lbVzOsY6KjrETUR7/dxZ9GEAnM8O8iEaVy6N0O6xXcr08
        wOBlS/hUrMD9WVu8QHNzomYF6Q==
X-Google-Smtp-Source: AMsMyM4Fch0PTguwDhppGmnjE9bqmftS6Hp4ihDF4ZawlEs716t6BvwccW5CVSk4fPZ8D4+0ydYL3g==
X-Received: by 2002:a05:6512:2fb:b0:4b0:620:b106 with SMTP id m27-20020a05651202fb00b004b00620b106mr19073030lfq.470.1667845717694;
        Mon, 07 Nov 2022 10:28:37 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id 18-20020ac24d52000000b004ab2cb8deb5sm1363225lfp.18.2022.11.07.10.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 10:28:36 -0800 (PST)
Message-ID: <225f3ff2-62cb-7f11-3eb1-f677360b4359@linaro.org>
Date:   Mon, 7 Nov 2022 19:28:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/3] dt-bindings: interconnect: Remove required reg
 field
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221026190520.4004264-1-quic_molvera@quicinc.com>
 <20221026190520.4004264-2-quic_molvera@quicinc.com>
 <a214f513-fe28-2096-c2b0-2107e97f3ce2@linaro.org>
 <64d0e5ef-fd36-6f25-2c39-00e8e1346af7@quicinc.com>
 <1a7fd1fd-4f0d-bec3-ddd5-7c6a99a2ab01@linaro.org>
 <7d2c43b7-1507-7c30-27f7-3081c6ec77ba@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7d2c43b7-1507-7c30-27f7-3081c6ec77ba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 15:36, Georgi Djakov wrote:
> Hi,
> 
> On 2.11.22 23:11, Krzysztof Kozlowski wrote:
>> On 31/10/2022 19:29, Melody Olvera wrote:
>>>
>>>
>>> On 10/27/2022 8:29 AM, Krzysztof Kozlowski wrote:
>>>> On 26/10/2022 15:05, Melody Olvera wrote:
>>>>> Many of the *-virt compatible devices do not have a reg field
>>>>> so remove it as required from the bindings.
>>>> and some virt have it... This should be probably separate binding or if
>>>> the list is small - allOf:if:then.
>>> I attempted this; however I'm still seeing failures in dtb_check. I've added this
>>> to the binding; does this look correct?
>>>   allOf:
>>>     - $ref: qcom,rpmh-common.yaml#
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,qdu1000-clk-virt
>>> +              - qcom,qdu1000-mc-virt
>>> +
>>> +    then:
>>> +      required:
>>> +        - compatible
>>
>> No, because we talk about reg, not compatible. You should not require
>> reg instead for some compatibles... but then the schema is getting
>> complicated.
>>
>> It's difficult to give you recommendation because I do not know what are
>> all these "virt" interconnects. Why some have unit address, why some do not?
> 
> My understanding is that the "reg" property is required for the NoCs that have
> registers for controlling the QoS settings for the ports from Linux side.
> Other NoCs might be controlled by some remote processor and direct access from
> Linux may not be possible, so they do not have unit address and are outside of
> the soc DT node.
> Do we need to strictly define when exactly the "reg" property is required,
> can't we just mark it as optional?

It's preferred to make it strictly required or not allowed, so the
bindings are specific. This also allows to validate for mistakes. It
would be a bit different case if such test for req would make the
bindings complicated. I think it's not the case because we could just
split the bindings into two files:
1. One for controlled by AP, with reg.
2. One for controller by remote processors, without reg.

Best regards,
Krzysztof

