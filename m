Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1C63612F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbiKWOKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbiKWOKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:10:39 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBDB2A267;
        Wed, 23 Nov 2022 06:08:40 -0800 (PST)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 23 Nov
 2022 22:08:38 +0800
Message-ID: <69008e98-2dad-9999-9ebc-e5fc0d384808@amlogic.com>
Date:   Wed, 23 Nov 2022 22:08:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V5 3/4] clk: meson: s4: add s4 SoC peripheral clock
 controller driver and bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <kelvin.zhang@amlogic.com>
References: <20221123021346.18136-1-yu.tu@amlogic.com>
 <20221123021346.18136-4-yu.tu@amlogic.com>
 <09a443b3-4e27-a751-ba2c-057d69363a13@linaro.org>
 <cf7295c7-3ec6-3017-0c21-167da06e3214@amlogic.com>
 <2418f79c-ae56-9e4e-46e2-f1ca757642ee@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <2418f79c-ae56-9e4e-46e2-f1ca757642ee@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/11/23 21:06, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 23/11/2022 12:22, Yu Tu wrote:
>>
>>
>> On 2022/11/23 18:09, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On 23/11/2022 03:13, Yu Tu wrote:
>>>> Add the peripherals clock controller found and bindings in the s4 SoC family.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>    .../clock/amlogic,s4-peripherals-clkc.yaml    |  105 +
>>>
>>> No, this is total mess now.
>>>
>>> Additionally, you received a lot of feedback but your changelog says only:
>>> "V3 -> V4: change format and clock flags."
>>> so you ignored entire feedback?
>>>
>>> That's not the way to work with patches.
>>
>> Hi Krzysztof,
>> 	You can check the previous email reply. Now I don't know who to follow
>> your advice or Jerome's. I'm confused. Maybe you need to come to a
>> conclusion. So I can change it in the next patch.
> 
> I don't understand your comment. You received a lot of things to change
> for your v3. You said here "change format and clock flagS", so all other
> feedbacks from me were ignored? They were not contradicting to Jerome's
> comments, so either you implement them and mention this in changelog, or
> you keep discussing.
> 

I'm sorry I didn't write that clearly. The reality is that V4 I have 
changed some of the suggestions from Jerome. But there was a part that 
didn't agree before I sent V4, which Jerome chose to skip. Let's 
continue with V3, and then prepare this V5.

> Best regards,
> Krzysztof
> 
> .
