Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF8D63ED89
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiLAKVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiLAKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:21:17 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09C898956
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:21:07 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j4so1828356lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJWC4EnSIdOHOak+Y01i6W7TmDZjyxRR2uPhy+FOZLk=;
        b=czOauT1/LL1bLcLrnxMZ7LyUIUmobSmtcydtd7PTiowxd5khBSoAy8Q5Jh0363tYBX
         mK6jk8DukOA5/cDl1CBuODKtFLZZ4KfXpQGGA5QLqsxFd8hb8DU8/pWLYe5lT8KxvPHX
         2+605fUYdZQDOI8zSJuqoHxbtfkc1czcwu19yr+IB2DL/MOcMz5r+65zOnMIyKXdmHjH
         RR9S+Bb+UGytEvll9EFZUpNH1RYOlvOsEomq0QEkxeStmNzb8RCAKaFyyayaLEcisv8A
         kD0BdlRMNBTNf3S8XK1Jsl6LMH5QKLS/hEAotw654okuI+vL/RhU4XWmIcVm5hAEREqj
         s+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJWC4EnSIdOHOak+Y01i6W7TmDZjyxRR2uPhy+FOZLk=;
        b=qkTIH2PbBeWduH8zGdvClXha1TValrqFPrRtVEP4xq4XakV9c1KZwOYtC2QTljOIc0
         NUrSi+7arQD8rMmRdp7bKiZAEsMp1emaZF1fhms6Ko02G6O4Oz7gOG2S7vG6mDtWMAcJ
         dkMhsKHjPF5oMKyUiXHYNX0zCYEPuqc2v3XphX7zWhpcCav33WQ37Xz2sm6F55teTrvG
         psee2oi2xqWU+Le5Hy7a3HLAAtUTUSBxl6p79rfLqZtJ6ePErUEOwoZGH05WPH2jvuhC
         i0jnqPvvx4TljBr9btHm6qz27UjEzgYPEARHN282NlAFrqVMMNvKZwUW+Eb16H2PA9zE
         voOw==
X-Gm-Message-State: ANoB5pkglOfAUqyvQ3pfqz6Hvc3YFwINym3bZRDJKt+n2Z4WbRRBqpr+
        0CMFGXu+6zw09YW99WPOyMnSkg==
X-Google-Smtp-Source: AA0mqf6CUSYZrSFSc59I2YqsCSJOMbf+X1AkF2Fb2hvkfIrHoAJHah4FhaNgx3RzM/yZ3iPB9Yg2fA==
X-Received: by 2002:ac2:4316:0:b0:4b5:d8e:c12 with SMTP id l22-20020ac24316000000b004b50d8e0c12mr7626503lfh.665.1669890066328;
        Thu, 01 Dec 2022 02:21:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b4-20020a2eb904000000b00279cbcfd7dbsm290384ljb.30.2022.12.01.02.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 02:21:05 -0800 (PST)
Message-ID: <4e94c635-4cbb-449e-24af-f6fee47fb45e@linaro.org>
Date:   Thu, 1 Dec 2022 11:21:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 09/14] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-10-hal.feng@starfivetech.com>
 <1d62f95f-0edc-afd4-abb4-37fadc0b6a47@linaro.org>
 <72b3d10e-5a8e-ed42-6808-f53773913422@starfivetech.com>
 <768c2add-4c1f-0b36-5709-dbcdd560f504@starfivetech.com>
 <1fb1474b-ec13-e83a-973e-bd9e9a86cb44@linaro.org>
 <98d1bac7-8af5-f481-59b2-d58ca4c228ee@starfivetech.com>
 <9183bac6-121e-0027-a88b-d77d5c9a077e@linaro.org>
 <e954511b-e74a-2c3a-95ec-d33c938b146f@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e954511b-e74a-2c3a-95ec-d33c938b146f@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 19:05, Hal Feng wrote:
> On Wed, 30 Nov 2022 16:19:06 +0100, Krzysztof Kozlowski wrote:
>> On 30/11/2022 16:12, Hal Feng wrote:
>>> On Wed, 30 Nov 2022 12:48:30 +0100, Krzysztof Kozlowski wrote:
>>>> On 30/11/2022 10:47, Hal Feng wrote:
>>>>> On Fri, 25 Nov 2022 14:41:12 +0800, Hal Feng wrote:
>>>>>> On Mon, 21 Nov 2022 09:47:08 +0100, Krzysztof Kozlowski wrote:
>>>>>>> On 18/11/2022 02:06, Hal Feng wrote:
>>>>>>>> From: Emil Renner Berthing <kernel@esmil.dk>
>>>>>>>>
>>>>>>>> Add bindings for the system clock and reset generator (SYSCRG) on the
>>>>>>>> JH7110 RISC-V SoC by StarFive Ltd.
>>>>>>>>
>>>>>>>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>>>>>>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>>>>>>
>>>>>>> Binding headers are coming with the file bringing bindings for the
>>>>>>> device, so you need to squash patches.
>>>>>>
>>>>>> As we discussed in patch 7, could I merge patch 7, 8, 9, 10 and add the
>>>>>> following files in one commit?
>>>>>>
>>>>>> include/dt-bindings/clock/starfive,jh7110-crg.h
>>>>>> include/dt-bindings/reset/starfive,jh7110-crg.h
>>>>>> Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>>>>>> Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
>>>>>
>>>>> Hi, Krzysztof,
>>>>>
>>>>> Could you please give me some suggestions?
>>>>
>>>> You can keep aon and sys split. First add one of them with their own
>>>> headers. Then add second with their own defines.
>>>
>>> You mean split patch 7 and patch 8 into sys part and aon part
>>> respectively? There are totally five regions (sys/aon/stg/isp/vout)
>>> for clocks and resets in JH7110. If we do that, there will be 5
>>> headers for JH7110 in either clock or reset directory finally. Is
>>> that OK if there are too many headers for just one SoC?
>>
>>
>> Sorry, I lost the track of what patches you have. The comment was -
>> bindings include both the doc and headers. You want to split some, some
>> merge, sorry, no clue. I did not propose splitting headers...
> 
> It's ok. The problem was that the header
> 
> include/dt-bindings/clock/starfive,jh7110-crg.h
> 
> was used in both
> 
> Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> 
> and
> 
> Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml.
> 
> The same for include/dt-bindings/reset/starfive,jh7110-crg.h.
> So should I add these four files in one patch?

No. I think I wrote proposed flow of patches:
1. syscrg bindings with header
2. aoncrg bindings with changes to header

Why do you need to merge anything?

Best regards,
Krzysztof

