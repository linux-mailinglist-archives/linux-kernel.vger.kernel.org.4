Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7759C6530C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiLUMZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiLUMY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:24:57 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEBF23301
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:24:54 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id v11so15415317ljk.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7e57CVStI07OWBg/LHZpcyGd4gQwHot2GvYOQMHNZvs=;
        b=t5k3PBtNvxj5VZWpsUzBPvbnTQobaNdQkW6t3KqGCvX8KIX1e+nM7dF9Qklgd5ihO8
         xNxINYwrAxLUk+gnhZ6SWrCxQ87rcuWevR7AbMWMvzrNmSUFm6ZX3saqmfsPN/CFa9wc
         pFIUqx0M78X+Y+OXKEuCWu/cKCII2NfnvzVXqVigWkdT+BUAyzhY+J07wmtwCiw1r/a0
         oIW+7rYdKxGrOYejr2tapwscmZxaOc8JnXd2AOphoXPYh7Pew5MbaIc9aE0HRsm4BrTo
         /CVSNS1HXRUTLBvGNN7jOLYT4+TSa/vW60aEANq4o/peH6/Hj+OCdZCX/HNavIzSIks9
         gXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e57CVStI07OWBg/LHZpcyGd4gQwHot2GvYOQMHNZvs=;
        b=qJCtDGjEcsTEGXSxPVik4Ci1e5yhJX2H4R5dLzDzulmikLeYRJNxj7Cq3i0aB9eiyO
         hVNU81yeswLiL5MRYH1yZkZ/D/rhXKLjnw+2A5OEdcS2/TR3GFMREIj7o+1ItrOpCF2l
         KgxkJCZiptcfAHR1QBtq3LfWFZHTmhzqKAbN3hwad4lEGaxHPrQOcLDEPCWSvBNS/aQx
         nONP8ayLDFH5zCwERW/950fspcQk4+ppcI+iQ7SiQ3Nb8If+2hoZVKS4B6P0gmAlBwNj
         aQV/AssFloigelG0/iE/CYU8svZ9Ni6SwjfCog5vXyg1Jz6KmZZjvPbXRQaLtfzBtlKA
         CD2Q==
X-Gm-Message-State: AFqh2kpI3EtF+EtjK4awVqdulmMClcrkNoodSSKfOJTWMl8KNJj50GD1
        Jrmf0uZTl6QLu1S4LiIPjlPvPw==
X-Google-Smtp-Source: AMrXdXt3lqXaZuqf0Hd+ULV+pfNBUMGFEuaf2x4rRw9R9xPvFYQqPwp5tmkGATgLbfnS8bLjxfOmnQ==
X-Received: by 2002:a2e:8802:0:b0:26f:db35:7e40 with SMTP id x2-20020a2e8802000000b0026fdb357e40mr509832ljh.15.1671625493110;
        Wed, 21 Dec 2022 04:24:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651c118c00b00279e41de7e6sm1302652ljo.3.2022.12.21.04.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 04:24:52 -0800 (PST)
Message-ID: <5ff6e569-ad9f-f884-ea0e-41114afcaf7d@linaro.org>
Date:   Wed, 21 Dec 2022 13:24:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: SC7280: Add resets for LPASS
 audio clock controller
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
References: <1671618061-6329-1-git-send-email-quic_srivasam@quicinc.com>
 <1671618061-6329-2-git-send-email-quic_srivasam@quicinc.com>
 <f138f9de-4ecf-3126-97bd-668c96612913@linaro.org>
 <b6172e20-114a-b7e2-2200-0932f803cb20@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b6172e20-114a-b7e2-2200-0932f803cb20@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 13:22, Srinivasa Rao Mandadapu wrote:
> 
> On 12/21/2022 4:12 PM, Krzysztof Kozlowski wrote:
> Thanks for your time Krzyszto!!!
>> On 21/12/2022 11:21, Srinivasa Rao Mandadapu wrote:
>>> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
>>> for audioreach based SC7280 platforms.
>> Use subject prefixes matching the subsystem (git log --oneline -- ...).
>> The final prefix should be "qcom,sc7280-lpasscc" and then the actual

                                ^^^^^^^ it's written here

>> subject should drop redundant pieces.
> 
> Sorry. I didn't understand much from your statement.
> 
> Do you mean subject should something like below?
> 
>   dt-bindings: clock: qcom: sc7280-lpasscc: Add resets for audio clock 
> controller

1. The last prefix should be "qcom,sc7280-lpasscc:".
2. And then drop "audio clock controller" because it is obvious, isn't it?

> 
>>
>>>   ...
>> Best regards,
>> Krzysztof
>>

Best regards,
Krzysztof

