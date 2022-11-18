Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8046762F8B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbiKRPDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbiKRPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:02:22 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1760A6A763
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:59:20 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id d20so7034921ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1vkUR8YAnqZ4Gmspjd5PeeHcLQng8YjSz/aBrIzt54=;
        b=avQqepXRGOMiCl/xMFE1uP/3KA3LEqmoXTWV2qVo5CzBMncRUwuCWGtnUnuMvdToNM
         B+YFFJbg96NijW3YLMDb4bdq05Sqg1zRQgZqRNHbXfXDNHDqoH65Ob6EVqhO55npKSKr
         /c6psYoFn0TbhFKWu/M69CM0+anrMCj9/lwekt4ldc4c4Omo8ndMAdDazTRsy4sxRV0O
         nSb6TVl8ctRxFaUVELfIEB+RRZ4rnQoqIgVC8CBf3gYy/NVSAe2QUMPL7tFtPyAJbT8S
         V2kF+8mzFb9KybABlu/F3zQ0cA+9ehmKsF5yUmH2JOwDlfU+40la3HtUbwlY26kZy14q
         tdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1vkUR8YAnqZ4Gmspjd5PeeHcLQng8YjSz/aBrIzt54=;
        b=SjVDyYz/fKvC3+K1HITpPS2mV62RB0w3N/pcBeZvh+V4TiDDTfw1crcCjA7uBP2jTC
         PdAChhFQ1UxreTiqH6MI1IouVFj9IKKgrM1pamWt8qxuZjMEpnZUNGI7tUptHvpsxTq9
         cajMxNXDJDaVFgBrf2rS+Z+UZqKtXbl2hETErYBtFA+LVxr7S4bPv20syHkGpYwXw2Ia
         sz+9S5iSA3KEQQL4c6GkXEUBWN2amHHxzM2Iri6rGsRln2hpIqdAfZKUuslsU+vD8B+B
         5SF8VtDdlUR1QoX3+hZwdioDfP55i7a6cxbJr2+qM0D0BRtmO0ND72SJocfu6269hv7Z
         emlg==
X-Gm-Message-State: ANoB5pmjko1VJzMT6fH4Oumpf6LWXODkNUBLTyYQ7rjo9tDcBhcKnksH
        iUsrfr6yQ1KSe9kZzsEfEk+7cQ==
X-Google-Smtp-Source: AA0mqf6GOZ/jnDHS1zP/HsD2n03gp75MP8J2C6vKYU7NIKBJa2NY4Bgj/FYE4/p+K29m0IE8doUnvA==
X-Received: by 2002:a2e:b631:0:b0:277:890a:f1cc with SMTP id s17-20020a2eb631000000b00277890af1ccmr2643117ljn.395.1668783558496;
        Fri, 18 Nov 2022 06:59:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t14-20020a056512208e00b004ae24559388sm686908lfr.111.2022.11.18.06.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:59:17 -0800 (PST)
Message-ID: <3a84d45c-6550-7ae2-2511-9f61d15894d1@linaro.org>
Date:   Fri, 18 Nov 2022 15:59:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 03/10] arm64: dts: qcom: Add pm8010 pmic dtsi
Content-Language: en-US
To:     neil.armstrong@linaro.org, Abel Vesa <abel.vesa@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
 <20221116103146.2556846-4-abel.vesa@linaro.org>
 <76560659-7c90-3846-c250-24bfb072ec0e@linaro.org>
 <15ac1d06-5da7-ebd2-92ff-764c8df803a1@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <15ac1d06-5da7-ebd2-92ff-764c8df803a1@linaro.org>
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

On 18/11/2022 15:58, Neil Armstrong wrote:
> On 17/11/2022 13:51, Krzysztof Kozlowski wrote:
>> On 16/11/2022 11:31, Abel Vesa wrote:
>>> From: Neil Armstrong <neil.armstrong@linaro.org>
>>>
>>> Add nodes for pm8010 in separate dtsi file.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/pm8010.dtsi | 84 ++++++++++++++++++++++++++++
>>>   1 file changed, 84 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/pm8010.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/pm8010.dtsi b/arch/arm64/boot/dts/qcom/pm8010.dtsi
>>> new file mode 100644
>>> index 000000000000..0ea641e12209
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/pm8010.dtsi
>>> @@ -0,0 +1,84 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>
>> Any reason why this is licensed BSD-3 clause? It's not a recommended
>> license (2 clause is). Same for other patches.
> 
> Probably a bad copy-paste from other existing files.
> 
> While checking, the majority of arch/arm64/boot/dts/qcom/pm*.dtsi uses BSD-3-Clause
> so it seems this was done for quite a while now.

If it is derivative work (of upstrea, downstream), then you might have
to keep BSD-3. But if not, how about changing it to BSD-2?

Best regards,
Krzysztof

