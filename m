Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8F6719B3A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjFALxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjFALxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:53:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5FD129
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 04:53:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f99222e80so175902766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 04:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685620412; x=1688212412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rPSddxI86ctgmSDuBtXnLlRRIr8tu9Gup1nhM3MX8o=;
        b=hY9sZTgVGTJ6ujrAVw6O9rPaZR6ibpYsvN2iDDgzJsZPpJCkM69umjf9xxRzSH0L/o
         LIte5mTEpL1SczScuOLjsfunuoTCRvgEzOtTv7pukO3+4HpqlcyL8slEDSmrck1B22+8
         bVSZiyUr0fzzI/4wGpO8+2rN8pNfYzG06PwGZK3ZA3h4gkO9RaYWL7TBw8UrauDK2xXV
         volv/V9mc2kAH/1I6J+yGtlgobb+hKP+mV8mCK1p/lUTR1mG1DUnG2sgzAVS8aulw7sr
         eDz6hzOmpaOzRICapu6gfGFiAxIxxmdAK09CztKOew3ll/RehxnsuyLWxMiC5BgCaUtV
         kVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685620412; x=1688212412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rPSddxI86ctgmSDuBtXnLlRRIr8tu9Gup1nhM3MX8o=;
        b=l8mc1SxfS2ShhTNeNEiBh3z0v3PEsiTlmRHkWdhLrfuQh2ds5apa3bUtDMIwJH9kPa
         oaAYl5YREmoTUb8QUP7TtfeD0jGFUZfGRNbPKEJYq6wX+inKkoqYQyIW00GuCQKW6uv6
         4qoZ3EZxxKjD3AXKjds7143zh1wPaGDGdnJI8Wbb6GK1hu3EN3UdsYln765RphynFMJw
         Sk9Evk6plb7uFQrY2GW4XYLJ0z9wA/JQAj+8xm/Gs3mUEYrmLW4mxE89LxmQ0R7O3g9I
         QRfa+oMmuA3H1fqMNpDWBQT/Kqb+/7TZbKACX0uGznt/xAq5n2+/g77c55lRsHJzE2B4
         A6+w==
X-Gm-Message-State: AC+VfDxb9JVZ56/W9daUqcvcP96aNEWuis/IO7KbgUNLGoYStcgWCV2X
        EPeLAdAF4Govm6aPM5mFPQAAmg==
X-Google-Smtp-Source: ACHHUZ4Uv7R3KfoQyJ1EUmV0PsUvAeAKaVKQHwLWsx0ooq+a59XB1LpTQgA72lhOrF7YuXEaQx8UTw==
X-Received: by 2002:a17:907:7ea4:b0:96f:d04c:1d84 with SMTP id qb36-20020a1709077ea400b0096fd04c1d84mr1464614ejc.12.1685620411810;
        Thu, 01 Jun 2023 04:53:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id j1-20020a1709064b4100b009664cdb3fc5sm10402832ejv.138.2023.06.01.04.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 04:53:30 -0700 (PDT)
Message-ID: <eb109116-94eb-5b6d-0049-7bb31feada36@linaro.org>
Date:   Thu, 1 Jun 2023 13:53:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V7 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        andy.shevchenko@gmail.com
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robimarko@gmail.com
References: <20230519125409.497439-1-quic_srichara@quicinc.com>
 <20230519125409.497439-5-quic_srichara@quicinc.com>
 <CAHp75VfVx+oGYKcija3h9-eWc6jggMx8p5SAQTEHTBEbjTaJKw@mail.gmail.com>
 <1823419a-6bb4-03f7-d5ae-e32204c5e598@quicinc.com>
 <ZHTK7uEzO7kcx_cV@surfacebook>
 <aefd0df1-8dfb-1b69-589b-974dea312845@quicinc.com>
 <664940c3-9ec1-b4bd-9db5-fa3529e3d1ff@linaro.org>
 <8146f367-c539-bea5-12b6-424213018488@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8146f367-c539-bea5-12b6-424213018488@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 13:41, Sricharan Ramabadhran wrote:
> 
> 
> On 6/1/2023 3:21 PM, Krzysztof Kozlowski wrote:
>> On 01/06/2023 11:50, Sricharan Ramabadhran wrote:
>>>
>>>
>>> On 5/29/2023 9:25 PM, andy.shevchenko@gmail.com wrote:
>>>> Mon, May 29, 2023 at 03:58:09PM +0530, Sricharan Ramabadhran kirjoitti:
>>>>> On 5/20/2023 12:17 AM, Andy Shevchenko wrote:
>>>>>> On Fri, May 19, 2023 at 3:55 PM Sricharan Ramabadhran
>>>>>> <quic_srichara@quicinc.com> wrote:
>>>>
>>>> ...
>>>>
>>>>>>      depends on OF || COMPILE_TEST
>>>>>
>>>>>    Yeah sure. COMPILE_TEST could be standalone. Will fix it and repost.
>>>>
>>>> Standalone COMPILE_TEST will give you definitely NOT what you want.
>>>> And actually it's strange to have it standalone.
>>>>
>>>
>>>    Ho ok, i meant like this, "depends on ARM64 || COMPILE_TEST"
>>
>> Don't do it differently than all other drivers. Open the Kconfig and
>> look at existing entries.
>>
>    The latest added has this below, will use this
> 
> 	depends on OF || COMPILE_TEST

I would even drop this... Lemme check, it looks odd. We depend on
ARCH_QCOM which uses OF. We have few drivers which depend on ACPI, but
that also seems wrong. These are platform drivers so they should expect
platform select proper firmware interface. I think none of other
platform drivers do like this (neither Samsung pinctrl nor other
Qualcomm drivers)).

I will fix this. For your patch I would just skip OF entirely.

Best regards,
Krzysztof

