Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9F6E0951
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDMIul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDMIuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:50:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244198A61
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:50:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94771f05e20so467055166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681375835; x=1683967835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6mAVmlSqBlK97GI+OBS2IQeOpH152LcbvquHB//CeQ=;
        b=qBQKxSkg0B1ny6AKrI2JM4J00sV4tr5wSjLIsSLHqWeQQNThrxkz1/uKK/G9InUVv3
         Mo9x25u7mcDVhg5j0KTpldXUooJrhuQMu9fWJRuU1TabACrIJAyhQc5mVRnL7X5Uoitm
         P9QyyIG+y7m4LQKs9IOqTgK0s32MG7zK+bjkVAkIMlsuoZysL2zZJ69/62SRFxPsLe72
         0574RRl69Mu0UlKDgx2dWy8U4pPdqpvFPrOZMnsDNhnHhbvg+ejuzIkwlo7RD98E1Zuy
         guBIsYHfrix5W5BmScoNRt33NO+lBOC12YQofsDel11ibeE2tf9AlvIOe1YTH7tB32Q2
         Olow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375835; x=1683967835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6mAVmlSqBlK97GI+OBS2IQeOpH152LcbvquHB//CeQ=;
        b=J2zuKNqhwqxjwjhK9SQjjVdBJe9zPGz6KLeP5knULrsZFkyUGY9CxRjct3zSqg3XpU
         ColjtaJwbYMjDDyBfwkCqXC+pq5yfUMN0jK7LXNJ4Fs7j9g2iOTWPYlX3cCiVAMAzFlJ
         dTsuZmgKFeu576f9/zcy9Wt3l1ZX0vS+dwsZZJeisq4hLNgvy1d5qUTTdWcJ7elszMNW
         pFzUZYkU0h/r7JxM5nnPT46g1jZWwF5GVkY1OZydBASjF2rcJXRaCPuDmT9h9zbyjktp
         tN5Us/LietUq06EKhhjPw95XtrSFT7VN1Jb4clD8vhyqJd4pHOQCS61WRMp2ACq5Ujlg
         AQfw==
X-Gm-Message-State: AAQBX9c+vxIwAnZGgQFZzWknyp0e43cnWo64hlY7z6Dv8NXqIp1yg81S
        QuVuSyTh7icC+tlP4bn+g3O3Hg==
X-Google-Smtp-Source: AKy350ams2Rhgtj5ld9eUc37t1b+SyClKLb5d8tFO/xWnlQN/71bN5uirU2rOp0PEk4y8rjT+Aca6A==
X-Received: by 2002:aa7:d74d:0:b0:4fb:aa0a:5b72 with SMTP id a13-20020aa7d74d000000b004fbaa0a5b72mr1546251eds.5.1681375835504;
        Thu, 13 Apr 2023 01:50:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7? ([2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7dbcf000000b00501d51c23fbsm555672edt.6.2023.04.13.01.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 01:50:34 -0700 (PDT)
Message-ID: <6a9b1c25-2e17-a657-3a58-b2ff8d1c86d7@linaro.org>
Date:   Thu, 13 Apr 2023 10:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
 <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
 <168069726278.2356075.14351594478003012447.robh@kernel.org>
 <20230405134727.GA2461305-robh@kernel.org>
 <1e6e2590-ac78-400b-35ce-321d5e52f385@linaro.org>
 <9df12111-ec84-c4f7-fbcb-bccaef91b048@linaro.org>
 <3ce9b5ec-8b02-537a-c663-c849e80cab66@linaro.org>
 <ZDAAToSzNLVo6le8@gerhold.net>
 <198523f5-d06f-15cd-af6c-f391c02bcaa9@linaro.org>
 <1f8fc036-380b-0a42-bb29-a3e275ed6a33@linaro.org>
 <2e648a97-083e-8ee2-1695-4af299bb222a@linaro.org>
 <15f48b06-a6be-1295-5deb-d3594bce6699@linaro.org>
 <ec32fc8e-56e0-51a5-dd96-c7cc8b9cf71f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ec32fc8e-56e0-51a5-dd96-c7cc8b9cf71f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 19:06, Konrad Dybcio wrote:
> 
> 
> On 12.04.2023 18:53, Krzysztof Kozlowski wrote:
>> On 12/04/2023 14:09, Konrad Dybcio wrote:
>>>
>>>
>>> On 12.04.2023 13:55, Krzysztof Kozlowski wrote:
>>>> On 12/04/2023 13:47, Konrad Dybcio wrote:
>>>>>> For unrelated reasons I actually have some patches for this, that switch
>>>>>> the /smd top-level node to a "remoteproc-like" node dedicated to the
>>>>>> RPM, similar to how WCNSS/ADSP/Modem/etc are represented. I need this to
>>>>>> add additional (optional) properties like "resets" and "iommus" for the
>>>>>> RPM, but it would allow adding arbitrary subnodes as well:
>>>>>>
>>>>>> https://github.com/msm8916-mainline/linux/commit/35231ac28703805daa8220f1233847c7df34589e
>>>>>>
>>>>>> I could finish those up and post them if that would help...
>>>>> Krzysztof, what do you think?
>>>>
>>>> I don't know what is there in MSM8916 and how it should be represented.
>>> Similarly to other Qualcomm SoCs, MSM8916 has a RPM (Cortex-M3) core,
>>> which communicates over the SMD protocol (or G-LINK on >=8996).
>>>
>>> The Qualcomm firmware loads the RPM fw blob and sets it up early in
>>> the boot process, but msm8916-mainline folks managed to get TF-A
>>> going and due to it being less.. invasive.. than the Qualcomm TZ,
>>> RPM needs a bit more handling to be accessible.
>>>
>>> The M3 core is wired up through the CNoC bus and we communicate
>>> with it through the MSG RAM and the "APCS mailbox".
>>
>> Thanks, that's actually good description. Yet I still do not know what
>> is exactly the problem and the question. Linking some out of tree
>> commits does not give me the answer, at least I cannot get that answer
>> form the link.
>>
>> For example what I don't understand is: why additional resources (like
>> resets) can be provided only in new binding, but not in the old.
> The old binding dictates that the rpm node (which in turn
> holds all "devices" that only interface with RPM, like RPMCC) is
> a child of smd{}, which does not make sense logically, as SMD is
> a protocol (e.g. we don't place devices connected over i2c under
> /i2c{}).

We do. All devices connected over I2C are under i2c node which is the
controller. The example is different than what you have here...

>  The rpm node lacks a compatible, as it's representing
> an "smd channel", so there's no driver so there's no way to assert
> resets etc.

You have rpm-requests which has compatible. These are not its resources?

> 
> On newer SoCs that still implement SMD RPM (like 8996), we do
> actually have a driver and a parent node which it binds to
> (rpm-glink).

You want to add RPM resets to rpm-glink node? This also does not look right.

> 
> AFAIU:
> In both cases, the "final" drivers (rpmcc, rpmpd..) are bound
> after hitting a SMD/GLINK callback that tells Linux we're ready
> to rock. That's an issue for Stephan, as these callbacks won't
> ever happen if the RPM core is not initialized (and TF-A doesn't
> do that).

To me half or almost all of Qualcomm remote-proc-related bindings, like
SMD, GLINK and associated processors, are difficult to read, half-baked
and developed to match the current Linux/SW need. When the Linux drivers
changed, new bindings were added... If you want to fix it, sure go
ahead, but design everything to match something rational, not again to
match one specific SW/FW implementation.

Best regards,
Krzysztof

