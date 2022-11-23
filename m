Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7193D635B83
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiKWLXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiKWLW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:22:58 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A1E6316E;
        Wed, 23 Nov 2022 03:22:07 -0800 (PST)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 23 Nov
 2022 19:22:05 +0800
Message-ID: <cf7295c7-3ec6-3017-0c21-167da06e3214@amlogic.com>
Date:   Wed, 23 Nov 2022 19:22:05 +0800
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
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <09a443b3-4e27-a751-ba2c-057d69363a13@linaro.org>
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



On 2022/11/23 18:09, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 23/11/2022 03:13, Yu Tu wrote:
>> Add the peripherals clock controller found and bindings in the s4 SoC family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   .../clock/amlogic,s4-peripherals-clkc.yaml    |  105 +
> 
> No, this is total mess now.
> 
> Additionally, you received a lot of feedback but your changelog says only:
> "V3 -> V4: change format and clock flags."
> so you ignored entire feedback?
> 
> That's not the way to work with patches.

Hi Krzysztof,
	You can check the previous email reply. Now I don't know who to follow 
your advice or Jerome's. I'm confused. Maybe you need to come to a 
conclusion. So I can change it in the next patch.

> 
> Best regards,
> Krzysztof
> 
> .
