Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F99629D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiKOPRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKOPRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:17:03 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD6F2D755
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:17:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g7so24942180lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Y1Unr3jk2bOCLfcHXLh0v2yUNwm4KjpCvyCco0aj3w=;
        b=YN5FADMEILtvu2IUFFRBSils1wlS+leCNFvwasIFdUGEW6+JdUgV2vmuctzZ2gHSQl
         fjteLNGD8+XSIzZfElynrxHrZBCbz3/PF4JKMu1o7dMdHc4xhls1bopQztdJzPNh4++1
         SQ2C5kRZluYQ76UdjTAooOZsXQk9xqUbLluQZw5b8XACz2q3stesvZLUzKzSXMbrw5dp
         lWE3nAONb+uQ6UF3koVEt9AGb+2WNjIU+gf6wv6HDjCklIEJ2yqXNWDdiK8XHQeoLufg
         f95QFOe+KuIgmmP0IeSVekicjhRefmuNgsCdUCD184BT5OSm1AG3Bw2996SlWx/d4T/z
         X+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y1Unr3jk2bOCLfcHXLh0v2yUNwm4KjpCvyCco0aj3w=;
        b=zeDj2VlaFUj20nMPSuzRDeo1MhQ4k4bm7tT7qit7NMiyAFCQlNt1hWY4vvx+32v/vd
         Ua5Vrf1P6r8e0kHafVNoKrh5h21qaTVUjvFHfpN5NLPIoJXrsuk8u0tM3X8UmH50YoIB
         GT0XhAqLjz+GIDxqm/P6DYFWEi5rbGTTHxmifzN9BS6f3oUujmCosXBRiFeUxsmazq+Q
         SW0AEjiYe+jmLtoH8wXKscF3qg4Av4/7ZW08/GGSTT2zIbfFm82JkXPc99f0ga2ooGE+
         bb72FPVZa1F6kNlg1Su2xEt3QqkdAfeCiu/54jGDFzx9Z6im0x6MuQlEOubLSz3wPMZ8
         t2OA==
X-Gm-Message-State: ANoB5pmwdlHZg5NWodbWT2IpmjavBsA3xM2SRMnrKxEhaKF9o/7tblwE
        qdovFl/0mRbAJqd3/pUDE3Q1gQ==
X-Google-Smtp-Source: AA0mqf5PN9m2bdys3cfOygrhya+5SbkH0Qn9BXfjeKcoi/QWIyM/gH03wLlofI4HUJIbzRZDnSsymA==
X-Received: by 2002:ac2:5cda:0:b0:4a2:3f29:5e8a with SMTP id f26-20020ac25cda000000b004a23f295e8amr5722536lfq.221.1668525419800;
        Tue, 15 Nov 2022 07:16:59 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z6-20020a056512370600b004a459799bc3sm2234005lfr.283.2022.11.15.07.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 07:16:59 -0800 (PST)
Message-ID: <5c0dfcad-956d-e3cd-fd06-7671b85c4ae7@linaro.org>
Date:   Tue, 15 Nov 2022 16:16:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm
 Ramp Controller
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     marijn.suijten@somainline.org, konrad.dybcio@somainline.org,
        kernel@collabora.com, andersson@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org
References: <20221104142204.156333-1-angelogioacchino.delregno@collabora.com>
 <20221104142204.156333-2-angelogioacchino.delregno@collabora.com>
 <166758411781.2066027.6365889663189109123.robh@kernel.org>
 <160cb3fc-176e-bc0e-1bff-9334478af8ec@collabora.com>
 <342d556a-e710-590c-3c81-fcc60bbaa6e7@linaro.org>
 <3e9deab6-58ca-3a58-5f06-c1e4d181bc94@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3e9deab6-58ca-3a58-5f06-c1e4d181bc94@collabora.com>
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

On 15/11/2022 15:44, AngeloGioacchino Del Regno wrote:

>>>> Please check and re-submit.
>>>>
>>>
>>> I'm unsure about what I should do about this one.
>>> This is a power-controller, but does *not* need any #power-domain-cells, as it is
>>> standalone and doesn't require being attached to anything.
>>
>> power-domain-cells are for power domain providers, not consumers. The
>> generic binding expect that nodes called power-controller are exactly
>> like that.
>>
>> Solutions could be:
>> 1. Rename the node to something else. I cannot deduct the type of the
>> device based on description. What is "sequence ID" and how is it even
>> closely related to power control?
> 
> This uC is mainly controlling DCVS, automagically plays with voltages for
> each ramp up/down step and from what I understand also decides to shut down
> or bring up *power* to "certain clocks" before ungating (CPU related, mainly
> big cluster).
> This also interacts with LMH - setting the LMH part makes it possible to
> later use CPR (otherwise CPR errors out internally and won't start, as it
> requires this controller, SAW and LMH to be set up in order to work).
> 
> What I've seen is that without it I can't bring up the big cluster at all,
> not even at minimum frequency, as the HF2PLL (a clock source for that cluster)
> will not power up.
> All it takes is to initialize these params and start the controller, then
> everything goes as it should.
> 
> If you're wondering why my explanation may not be particularly satisfying,
> that's because downstream contains practically no information about this
> one, apart from a bunch of lines of code and because this controller is
> just a big black box.
> 
>>
>> 2. Narrow the node name in power-domain.yaml which would require changes
>> in multiple DTS and bindings.
>>
>> 3. Do not require power-domain-cells for power-controllers, only for
>> power-domains.
>>
> 
> Solutions 2 and 3... well, I don't think that this would be really feasible
> as I envision this being the one and only driver that will ever require
> that kind of thing.
> Also, this programming was later moved to bootloaders and the only SoCs that
> will ever require this are MSM8956/76, MSM8953 and.. I think MSM8952 as well,
> but nothing more.
> 
> Even if I can imagine the answer, I'm still tempted to ask: can we eventually
> just name it ramp-controller@xxxx or qcom-rc@xxxx or something "special" like
> that to overcome to this binding issue?

So maybe "cpu-power-controller"? This should already help for this warning.

Best regards,
Krzysztof

