Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D245B5ED75E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiI1IOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiI1IOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:14:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5541F0CF4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:14:09 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x29so13527506ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=v6QaMWdAPR76v9HKIzdz7EMFyf/2GU9QkgN/UVKiV6Q=;
        b=I6xwj2Uyc+woJUUx4zW40ZhrmpDSAgr4vg6n8b7SUfm+v6acq72a1R64wx/wyS0Y62
         nrJamq6SzWCkHQrbKHIGj9z36l1YPZd6tKFltdfErXyq69X3tC3oBlEbsUrE+D2RNn6n
         MMeoYP8Yu4NcdUJATBJhyKooqZIasb/iuVE3T345gzFG7y8coT2XuwV8g6rf3GA9xAID
         ffg/s3HOgaZIqYt8nW4cz/ulGKmWCl7uli+K1Q+/HF0hBw6ukc0P0i8qeTasJKe7mb/L
         1Wj1WHBB03SdXYS95QqIuOeFQmO7oWRLhdDVnRRqndCog/0JUV4T9jGQuUCpcyy7bMwn
         E3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=v6QaMWdAPR76v9HKIzdz7EMFyf/2GU9QkgN/UVKiV6Q=;
        b=JEO0H5vRaR80AopbsvMzdVoXEEp4nWXnHneQJbTrzTe88u554i5JtPKA0aciqoldP7
         tIV540S0y8lj3paXC+GnV4+vuReNo1K9f3NBJXsTrHIPHLpzLSllM7kJOHt1Ix70hJE7
         49tOaYlP3kTxvF4TUbiWTLR1wnb5UxBAYH5CEGFvc2bdkdYdwiC6hxetHr4JU8tydDJZ
         a6/6OX/+1fyPWKgbuPsnfZKpNZZFB+2CB9Aq2emi5Ogl/RMvq1Lfl37EWZYbw8Pum1nX
         EnEdKSvvj8Kj0n6NQj+6ePukqz6d/w9sZqwUPWZ/vFE0sXfSxFC6cm+Rudf75UNoJYuC
         Z5hg==
X-Gm-Message-State: ACrzQf3tpQulpMeV/DYezW14QXuUx8DE4x23CmYlV+LyYF4zR/KDxkwm
        mLf/BTIaoWk4N0wTpSuih4sjqw==
X-Google-Smtp-Source: AMsMyM7bQUgTnb422ZgN8i6D2p6VsWOyHwAGMhtHP7q1rzVeQubNK4LIf3LBDQYeOTfBOWZXFTxO4g==
X-Received: by 2002:a05:651c:1111:b0:26c:7178:ac4f with SMTP id e17-20020a05651c111100b0026c7178ac4fmr10510926ljo.461.1664352847551;
        Wed, 28 Sep 2022 01:14:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k7-20020a2eb747000000b0026c5bc6ed1asm361749ljo.69.2022.09.28.01.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:14:06 -0700 (PDT)
Message-ID: <3f2e62f5-a6e4-7011-3f5b-29a6657eae79@linaro.org>
Date:   Wed, 28 Sep 2022 10:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 1/5] dt-bindings: mfd: qcom-spmi-pmic: Add pm6125
 compatible
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926190148.283805-1-marijn.suijten@somainline.org>
 <20220926190148.283805-2-marijn.suijten@somainline.org>
 <052630d0-299e-e468-b2dd-266d371e2b0f@linaro.org>
 <20220928081055.p66huqct2wnrsrdx@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928081055.p66huqct2wnrsrdx@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 10:10, Marijn Suijten wrote:
> On 2022-09-28 09:35:40, Krzysztof Kozlowski wrote:
>> On 26/09/2022 21:01, Marijn Suijten wrote:
>>> Document support for the pm6125, typically paired with the sm6125 SoC.
>>>
>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>> ---
>>>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>>
>> Please add Acked-by/Reviewed-by tags when posting new versions. However,
>> there's no need to repost patches *only* to add the tags. The upstream
>> maintainer will do that for acks received on the version they apply.
>>
>> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>>
>> If a tag was not added on purpose, please state why and what changed.
>>
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> https://lore.kernel.org/linux-arm-msm/0ec65132-7d7a-2f8d-cc16-cb76efc343d6@linaro.org/
> 
> Thanks, I thought of it this morning while browsing lore, but only got
> to a screen just now so you beat me to it by ~30 minutes.
> 
> No need to lecture me on the rules, but I can't promise this won't
> happen again.


This is a automated message, don't get it too personal. A lot of people
are not aware they have to do it, so I just one, same reply. I don't
know whether you are aware of the process and just forgot to include it.
If that's the case, just ignore the message.

Best regards,
Krzysztof

