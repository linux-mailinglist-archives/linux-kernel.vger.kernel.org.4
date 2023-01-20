Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC967495F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjATCcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATCcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:32:22 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F499CBA7;
        Thu, 19 Jan 2023 18:31:35 -0800 (PST)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 20 Jan
 2023 10:31:33 +0800
Message-ID: <d8e91e45-19a1-eedb-4b74-5df49b35ca0a@amlogic.com>
Date:   Fri, 20 Jan 2023 10:31:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V6 0/3] Add S4 SoC PLL and Peripheral clock controller
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "kelvin . zhang" <Kelvin.Zhang@amlogic.com>,
        "qi . duan" <qi.duan@amlogic.com>
References: <20230116074214.2326-1-yu.tu@amlogic.com>
 <1jilh2ydns.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jilh2ydns.fsf@starbuckisacylon.baylibre.com>
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

Hi Jerome,

On 2023/1/19 19:18, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Mon 16 Jan 2023 at 15:42, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> 1. Add S4 SoC PLL and Peripheral clock controller dt-bindings.
>> 2. Add PLL and Peripheral clock controller driver for S4 SOC.
>>
>> Yu Tu (3):
>>    dt-bindings: clock: document Amlogic S4 SoC PLL & peripheral clock
>>      controller
>>    clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver
>>    clk: meson: s4: add support for Amlogic S4 SoC peripheral clock
>>      controller
> 
> You are adding 2 controller driver with this series.
> Making 2 driver patches on clk/ is good. Please do the same for the bindings
> 
okay.I will change the next edition as you suggest.

Please check Krzysztof's opinion. Do you agree? Thank you!

>>
>> V5 -> V6: Change send patch series, as well change format and clock flags.
>> V4 -> V5: change format and clock flags and adjust the patch series as suggested
>> by Jerome.
>> V3 -> V4: change format and clock flags.
>> V2 -> V3: Use two clock controller.
>> V1 -> V2: Change format as discussed in the email.
>>
>> Link:https://lore.kernel.org/all/20221123021346.18136-1-yu.tu@amlogic.com/
>>
>>   .../clock/amlogic,s4-peripherals-clkc.yaml    |  104 +
>>   .../bindings/clock/amlogic,s4-pll-clkc.yaml   |   50 +
>>   MAINTAINERS                                   |    1 +
>>   drivers/clk/meson/Kconfig                     |   25 +
>>   drivers/clk/meson/Makefile                    |    2 +
>>   drivers/clk/meson/s4-peripherals.c            | 3874 +++++++++++++++++
>>   drivers/clk/meson/s4-peripherals.h            |  218 +
>>   drivers/clk/meson/s4-pll.c                    |  875 ++++
>>   drivers/clk/meson/s4-pll.h                    |   88 +
>>   .../clock/amlogic,s4-peripherals-clkc.h       |  131 +
>>   .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |   30 +
>>   11 files changed, 5398 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>   create mode 100644 drivers/clk/meson/s4-peripherals.c
>>   create mode 100644 drivers/clk/meson/s4-peripherals.h
>>   create mode 100644 drivers/clk/meson/s4-pll.c
>>   create mode 100644 drivers/clk/meson/s4-pll.h
>>   create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>   create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>
>>
>> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> 
