Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BB2674957
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjATC03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATC02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:26:28 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2FFA1007;
        Thu, 19 Jan 2023 18:25:44 -0800 (PST)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 20 Jan
 2023 10:25:42 +0800
Message-ID: <9c34a8fc-de76-4beb-8841-9bcfd1a55cd1@amlogic.com>
Date:   Fri, 20 Jan 2023 10:25:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V6 1/3] dt-bindings: clock: document Amlogic S4 SoC PLL &
 peripheral clock controller
To:     Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "kelvin . zhang" <Kelvin.Zhang@amlogic.com>,
        "qi . duan" <qi.duan@amlogic.com>
References: <20230116074214.2326-1-yu.tu@amlogic.com>
 <20230116074214.2326-2-yu.tu@amlogic.com>
 <02b6b3a6-e2ad-8cbc-fa15-fbd2db6ada64@linaro.org>
 <7c0133a2-ea4d-645e-3df2-2bb832bbd498@amlogic.com>
 <7hwn5jqrxf.fsf@baylibre.com>
Content-Language: en-US
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <7hwn5jqrxf.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Kevin,

On 2023/1/19 8:38, Kevin Hilman wrote:
> [ EXTERNAL EMAIL ]
> 
> Yu Tu <yu.tu@amlogic.com> writes:
> 
>> On 2023/1/16 16:29, Krzysztof Kozlowski wrote:
> 
> [...]
> 
>>>> diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>> new file mode 100644
>>>> index 000000000000..bbec5094d5c3
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>> @@ -0,0 +1,131 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>>
>>> Unusual license... are you sure to license the bindings under GPLv4 or
>>> GPLv5? Fine by me.
>>>
>>
>> Yes.
> 
> The rest of the bindings for Amlogic SoCs are GPL-2.0 (without the '+').
> Adding the dual-license for MIT seems fine, but adding the '+' is
> curious.
> 
> It would be helpful if you could please explain why you'd like these
> bindings to be licensed differently than the rest of the SoC family.
> 

I actually refer to the previous g12a Soc.
https://elixir.bootlin.com/linux/v6.2-rc4/source/include/dt-bindings/clock/g12a-clkc.h
https://elixir.bootlin.com/linux/v6.2-rc4/source/include/dt-bindings/clock/axg-clkc.h
[...]

So if you think it is not necessary, I will delete the '+' as you 
suggested. Don't know what you choose?

> Kevin
> 
