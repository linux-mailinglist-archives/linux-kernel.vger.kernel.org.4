Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9963D0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiK3Ibn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbiK3IbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:31:25 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F6B769E4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:27:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p8so25777712lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+lx3sySWedVDOe+3DR0W4CZhtHEM1KzEHeNBxVD2bIw=;
        b=zE9hpJtq+E0R0Qgz+pPl9E25bGmJQOEEcnTKv5ajZcCutfU5GAZC6ma04alI4nSMc0
         9IGp+zBymLKyaFMx2YTutQM65cC5mZba6qdDvOFmmAzLqrIsKovP/tTegxHY4GiiDICH
         Mq+el2jIQ//pHoVtEfRxjerpKW7g7fI1Q0OflIWhGpMni4EXQyEt+Ec3l/uLM+6JNnCG
         hD9I3zwTe1yHkY8oBsBveYdY6jncjihhrjCE81+HsMujHqK2ChrIqWEDxuLphR3WxD/b
         SlZE33i3Q518guZm2Mz5DUueprg5rIwmwVvvyfCUubiYhvLRiPxqRnLbt5ufnEE4T7fA
         GWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lx3sySWedVDOe+3DR0W4CZhtHEM1KzEHeNBxVD2bIw=;
        b=iJS6mx15X5NIH3ClgoB4y5DctdzQGjCn7vliiqBL5E4HiXDZLNNBZYoh2LZl99mxrP
         5/ehdCYg/TNseqEb5WA/14KK4KkRjKXuDBxwsZ4OC+eLT60dQLGqaFEXx96nNVds034Z
         L95BHOkxy8HmrFW5d5IpvA2U2DUz5Ezw80YNhehS+7vZchdd9QtlMcJbbNb7U6PElx6b
         cLTm+njCHG8IAB/x1NECcQU/QN3Rwuih8MAsGuU1HlIcc7HG8DnxG8hi35nQekk7vgdR
         9kI+WwiTFfEcwVbLt7ubTKn7AnicFJobsXh5cundA3ZcsrYz0WUEDKUYwOd1GAhJH0fg
         FM2Q==
X-Gm-Message-State: ANoB5pkFVHGd8JhQWHq0XpXynPjzCNsr5iZJkNLujqeqBjYeoB9J237y
        /MbMrnEXQ+pgymneiGstFp4sSQ==
X-Google-Smtp-Source: AA0mqf6zuoFrOxLVpa30q4aaP76XjuelQRS6AmxczJ7tcbu2jkeS8eUbn1/TiuPhLEuFIihQEvTAyQ==
X-Received: by 2002:a19:3853:0:b0:4a2:3955:109a with SMTP id d19-20020a193853000000b004a23955109amr23342473lfj.73.1669796838884;
        Wed, 30 Nov 2022 00:27:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c19-20020ac24153000000b00499aefcf68esm160746lfi.292.2022.11.30.00.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:27:18 -0800 (PST)
Message-ID: <7661de74-f68c-6617-6a4e-3b0eb76a2a2e@linaro.org>
Date:   Wed, 30 Nov 2022 09:27:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 1/2] dt-binding: soc: nuvoton: Add NPCM BPC LPC
 documentation
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        arnd@arndb.de, hasegawa-hitomi@fujitsu.com, marcan@marcan.st,
        nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        heiko@sntech.de, sven@svenpeter.dev, briannorris@chromium.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221122201232.107065-1-tmaimon77@gmail.com>
 <20221122201232.107065-2-tmaimon77@gmail.com>
 <cedc0013-f0c0-3180-6995-477b77b919f8@linaro.org>
 <CAP6Zq1iGwqOVOnhmF0ijYw=KoTRJj5CUpFv6WDouZmjVxXhQ-g@mail.gmail.com>
 <5c7a06bf-94e3-5c65-f202-105f74a41d29@linaro.org>
 <CAP6Zq1jdy-qDGFsk4sKcp3tx7d-nBMxOK72CRt3LLO8CrWJyKQ@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1jdy-qDGFsk4sKcp3tx7d-nBMxOK72CRt3LLO8CrWJyKQ@mail.gmail.com>
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

On 29/11/2022 17:44, Tomer Maimon wrote:
> hi Krzysztof,
> 
> Thanks for your comments.
> 
> On Thu, 24 Nov 2022 at 18:18, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 24/11/2022 16:38, Tomer Maimon wrote:
>>> Hi Krzysztof,
>>>
>>> Thanks a lot for your comments.
>>>
>>> On Wed, 23 Nov 2022 at 12:03, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 22/11/2022 21:12, Tomer Maimon wrote:
>>>>
>>>> 1. Subject: drop second, redundant "documentation" (dt-bindings are
>>>> documentation).
>>> O.K.
>>>>
>>>> 2. Use subject prefixes matching the subsystem (git log --oneline -- ...).
>>> this is what I did dt-binding: soc: nuvoton... do you mean dt-binding: nuvoton.
>>
>> You didn't run the command, did you?
> I did run this command "git log --oneline
> Documentation/devicetree/bindings/soc" and I got this log list
> e47206d71e67 dt-binding: soc: nuvoton: Add NPCM BPC LPC documentation
> 121494030c53 dt-bindings: soc: add i.MX93 mediamix blk ctrl
> 4fed4d20c59b dt-bindings: soc: add i.MX93 SRC
> c7ebd54158d3 dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
> 2345fc8dc2ec dt-bindings: soc: imx: add interconnect property for
> i.MX8MM vpu blk ctrl
> c1d9381ce430 dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
> f3894f969cf5 dt-bindings: soc: mediatek: Add display mutex support for MT6795
> b2d7616e13c4 dt-bindings: soc: qcom: apr: add missing properties
> 301628d80501 ASoC: dt-bindings: qcom,q6adm: convert to dtschema
> 7b0ad4629d1f ASoC: dt-bindings: qcom,q6asm: convert to dtschema
> b2496de1dfdd dt-bindings: soc: qcom: apr: correct service children
> 
> most of the subjects are similar to what I did, if it is not correct
> please let me know exactly what to write (beside the word
> documentation that I will remove)

None of them have "dt-binding", so fix that part.

Best regards,
Krzysztof

