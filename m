Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8126BD0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjCPNfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCPNfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:35:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825C37DD2A;
        Thu, 16 Mar 2023 06:35:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id rj10so1657296pjb.4;
        Thu, 16 Mar 2023 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678973746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWReiIxPiu3lWTgfQW7DAo5O3p+FWpN4lR44L3foEj4=;
        b=BcChq6vFcL2Qf5V4rA/m0CDQ/E+Aq2iFuKunm2PUs1QSWAUHyrQLRSZMTvMUtHeJAX
         3qVgWK5yN/ZmvIitKfy2uVDRIYugps+52YRjFFQOEEy7qakaOPbSxLDrelp+jcWXbyRv
         SFrjY9F0Fmh3siiAYKPZyrBzxgyGOosRFci9JpNXaCozsudiT7zaq96XrF/SD5NlQQUJ
         Zh7/llMYYgMazeO7Tm3bQjBUP7qR3rIhXmoYW2cbsQnVSZlwi2t/WuZ8+6HZWDjOppcV
         5diLUKeRaW44vqFWYQutxJux3kCLlmmE2Lr7M1PTdlwu82cIvIhkl7SIur6g27/yNSw0
         Svag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678973746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWReiIxPiu3lWTgfQW7DAo5O3p+FWpN4lR44L3foEj4=;
        b=AmnwccVS4ifhl+jj+b9yRvMEj5Sj9l0+wLpGk2DYK1jezDtROdpsYQE5pHqVbnhTh9
         RndjsIOyogKH1R0tUGH345cdaHWt7dzX25j9P6AwkwccXJ+sI5x4ZDkm/J0wu83M60jR
         NiyTjju8HMxyyBlIV5yYg7seTN3oXfwFHADhI7kpYopDtY8nn0VUrSqbR1TcU6NLMitw
         FlLG0Eivpi9wKX2Ot7M+wi0RaFkDBgPACTBM4xS8OSAheKcBfusMC1UKbUIkfMmI0AQm
         e6qZyS7E0dtiNX0D+XbegfP2fA9gyn8L+qpg95MnlBnIZUjolubyUbbSHtQS+tmcFUZ4
         RILg==
X-Gm-Message-State: AO0yUKW3Ld+il2yA6ftxRYS844yuBtTm9Jo9g6FFox0vTZX7/uIDE6zH
        /EZeYkhZyPeVBqWNJxN4Z50=
X-Google-Smtp-Source: AK7set+xfxWsEPAmUNEyfEISpAvlFkDeCty32g2j/9Anp0cZ+TPdCkceJlYcmQHzO1B+ulpUgcyj0Q==
X-Received: by 2002:a17:90b:3e82:b0:233:f393:f6cd with SMTP id rj2-20020a17090b3e8200b00233f393f6cdmr3860657pjb.5.1678973745917;
        Thu, 16 Mar 2023 06:35:45 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090a660400b00230b572e90csm3223063pjj.35.2023.03.16.06.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 06:35:45 -0700 (PDT)
Message-ID: <fd60a5af-8831-3d58-41b0-b220130c9e05@gmail.com>
Date:   Thu, 16 Mar 2023 21:35:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 04/15] dt-bindings: clock: nuvoton: add binding for ma35d1
 clock controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-5-ychuang570808@gmail.com>
 <a64bbd77-cd5c-8149-51e6-262122fe954e@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <a64bbd77-cd5c-8149-51e6-262122fe954e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Krzysztof,



On 2023/3/16 下午 03:31, Krzysztof Kozlowski wrote:
> On 15/03/2023 08:28, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
>> between the clock controller and clock references in the dts.
> I don't see the device binding. They come together.

I should move 
Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
into this patch, right?

>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 253 ++++++++++++++++++
>>   1 file changed, 253 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
>>
>> diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
>> new file mode 100644
>> index 000000000000..6c569fdd6e06
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
>> @@ -0,0 +1,253 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> Dual license.

OK, I will fix it.


> Best regards,
> Krzysztof
>

