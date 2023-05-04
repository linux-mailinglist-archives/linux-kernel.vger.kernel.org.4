Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997D16F6B53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjEDMcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjEDMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:32:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3696199
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:32:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-95369921f8eso69784966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683203524; x=1685795524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrbpIEMptg8Nu95mNsBTQ6WaBBHC6A4oRrtY3eFlfqs=;
        b=a5ecuECdq5V5WZ2pb8QPbrLujAGXrAJwfWNwdXd7bm+tmCsthMP1e33cpqChSe6GKk
         l3RYFR9DdDqdUmwY7nZFqa8sBo4+02hL1qBqzrWqLBC4JGVxIPsU9/X2AvC8Eef9x9OY
         fpIoUfyyNMuFs76uH/mU9MGTUbS0b4QoZ8+Esgft/09YyNJHZ8J//KlZQMRG+1rs0ehU
         s3f8N4Fe9FjBbz5jM1ZfJ15RayFLThFsuNXRam4v1H1c++tVDQaLCWuAQqt7NFhyBDGl
         QcADV5f8ovZfMd131yznZHQ4KqwBL95gmzGZBKWrMASnNSL9OvaV29Iz/Jb1kD49cc1f
         L5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683203524; x=1685795524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrbpIEMptg8Nu95mNsBTQ6WaBBHC6A4oRrtY3eFlfqs=;
        b=fwfI3V1mNnlGqbmhNf87CnNkImJ5h+e2DdSsbYW9p+j2FP3qph0XbNZDnzEotDZJRG
         MujMCurNfXAAOI41pdwFubjZ72cUwf2IKN338IW7OU04zg55CeTCpzfTOKRyV4Fob2ky
         Svb/17q1OfRgVzgv0Ypk7riOpMenPh7wXFK8zxJW5PV3GxWDOhhMulIJiMVj4yEoR5yz
         D6zWioTfblai3DTkr7acl8+EQhRlZP9J5TYuikq8Tt4B6y6tNTbvwgjoHFpL+BlbJuXQ
         6+UJQwIXvyYelvsF3TSGPljJtnk+M+shvQ29dt8ITydItZaEtQVzAsy4XVOs+fcaMD3c
         uy4Q==
X-Gm-Message-State: AC+VfDxQfEihH+p8h7p+N0uVbgo0OgGNr1GphKaeUT05Sxn7diDEwsuw
        RgPaBax2JILfwk7W2+C5occuXw==
X-Google-Smtp-Source: ACHHUZ7WP/SrQkpuJ4nYDyrtOsN3LKp6lH6RSLgSvg/FR7Pb9OEgE0TBtEvtuxZc4ExAKCwQHhpMDQ==
X-Received: by 2002:a17:906:ef08:b0:94f:3b83:a4d1 with SMTP id f8-20020a170906ef0800b0094f3b83a4d1mr5816986ejs.50.1683203524601;
        Thu, 04 May 2023 05:32:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id sk19-20020a170906631300b009572a8f86fbsm17151363ejc.165.2023.05.04.05.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 05:32:03 -0700 (PDT)
Message-ID: <a4118697-d575-6499-ed8e-656e51ca0da3@linaro.org>
Date:   Thu, 4 May 2023 14:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 07/18] arm64: defconfig: Enable Qualcomm minidump
 driver
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-8-git-send-email-quic_mojha@quicinc.com>
 <ad9915b2-56ff-3f95-7c92-fae597d6ed43@linaro.org>
 <4325c2e7-8ca1-7e45-db14-5ba8bc83f5d7@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4325c2e7-8ca1-7e45-db14-5ba8bc83f5d7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 13:45, Mukesh Ojha wrote:
> 
> 
> On 5/4/2023 4:53 PM, Krzysztof Kozlowski wrote:
>> On 03/05/2023 19:02, Mukesh Ojha wrote:
>>> Previous patches add the Qualcomm minidump driver support, so
>>> lets enable minidump config so that it can be used by kernel
>>> clients.
>>>
>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>
>> This patchset is split too much. Defconfig change is one change. Not two
>> or three.
>>
>>> ---
>>>   arch/arm64/configs/defconfig | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index a24609e..831c942 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -1250,6 +1250,7 @@ CONFIG_QCOM_STATS=m
>>>   CONFIG_QCOM_WCNSS_CTRL=m
>>>   CONFIG_QCOM_APR=m
>>>   CONFIG_QCOM_ICC_BWMON=m
>>> +CONFIG_QCOM_MINIDUMP=y
>>
>> This must be a module.
> 
> Why do you think this should be a module ?
> 
> Is it because, it is lying here among others '=m' ?

Because we want and insist on everything being a module. That's the
generic rule. There are exceptions, so if this justifies being an
exception, please bring appropriate arguments.

> 
> Or you have some other reasoning ? like it is for qcom specific
> soc and can not be used outside ? but that is not true for
> all configs mentioned here.
> 
> The reason behind making it as '=y' was, to collect information from 
> core kernel data structure as well as the information like percpu data, 
> run queue, irq stat kind of information on kernel crash on a target 
> running some perf configuration(android phone).

I don't understand why =m stops you from all that. What's more, I don't
understand why do you refer to the Android here. This is a development
and debugging Linux defconfig, not Android reference config for vendors...

Best regards,
Krzysztof

