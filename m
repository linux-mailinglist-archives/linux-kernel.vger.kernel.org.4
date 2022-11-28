Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3631A639E84
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 01:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiK1AwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 19:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK1AwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 19:52:11 -0500
X-Greylist: delayed 177 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Nov 2022 16:52:05 PST
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7535BC2C;
        Sun, 27 Nov 2022 16:52:05 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 7CDB324DE73;
        Mon, 28 Nov 2022 08:49:05 +0800 (CST)
Received: from EXMBX065.cuchost.com (172.16.6.65) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 28 Nov
 2022 08:49:06 +0800
Received: from [192.168.125.66] (183.27.97.81) by EXMBX065.cuchost.com
 (172.16.6.65) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 28 Nov
 2022 08:49:04 +0800
Message-ID: <0ceba170-f844-e733-a49e-e67746f9f836@starfivetech.com>
Date:   Mon, 28 Nov 2022 08:48:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/5] dt-bindings: pinctrl: Add StarFive JH7110 pinctrl
 definitions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20221118011108.70715-1-hal.feng@starfivetech.com>
 <20221118011108.70715-2-hal.feng@starfivetech.com>
 <eb3974a3-f715-f5b0-cac7-551af26bd17b@linaro.org>
 <08db0f3b-5222-9460-26ba-0e6380d16583@linaro.org>
Content-Language: en-US
From:   Jianlong Huang <jianlong.huang@starfivetech.com>
In-Reply-To: <08db0f3b-5222-9460-26ba-0e6380d16583@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.81]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX065.cuchost.com
 (172.16.6.65)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 09:39:46 +0100, Krzysztof Kozlowski wrote:
> On 21/11/2022 09:38, Krzysztof Kozlowski wrote:
>> On 18/11/2022 02:11, Hal Feng wrote:
>>> From: Jianlong Huang <jianlong.huang@starfivetech.com>
>>>
>>> Add pinctrl definitions for StarFive JH7110 SoC.
>>>
>>> Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
>>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>>> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>> ---
>>>  .../pinctrl/pinctrl-starfive-jh7110.h         | 427 ++++++++++++++++++
>>>  1 file changed, 427 insertions(+)
>>>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-starfive-jh7110.h
>>>
>>> diff --git a/include/dt-bindings/pinctrl/pinctrl-starfive-jh7110.h b/include/dt-bindings/pinctrl/pinctrl-starfive-jh7110.h
>>> new file mode 100644
>>> index 000000000000..fb02345caa27
>>> --- /dev/null
>>> +++ b/include/dt-bindings/pinctrl/pinctrl-starfive-jh7110.h
>>> @@ -0,0 +1,427 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
>>> +/*
>>> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
>>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>>> + */
>>> +
>>> +#ifndef __DT_BINDINGS_PINCTRL_STARFIVE_JH7110_H__
>>> +#define __DT_BINDINGS_PINCTRL_STARFIVE_JH7110_H__
>>> +
>>> +/*
>>> + * mux bits:
>>> + *  | 31 - 24 | 23 - 16 | 15 - 10 |  9 - 8   |  7 - 0  |
>>> + *  |  din    |  dout   |  doen   | function | gpio nr |
>>> + *
>>> + * dout:     output signal
>>> + * doen:     output enable signal
>>> + * din:      optional input signal, 0xff = none
>>> + * function:
>>> + * gpio nr:  gpio number, 0 - 63
>>> + */
>>> +#define GPIOMUX(n, dout, doen, din) ( \
>>> +		(((din)  & 0xff) << 24) | \
>>> +		(((dout) & 0xff) << 16) | \
>>> +		(((doen) & 0x3f) << 10) | \
>>> +		((n) & 0x3f))
>>> +
>> 
>> 
>> (...)
>> 
>>> +/* sys_iomux doen */
>>> +#define GPOEN_ENABLE				 0
>>> +#define GPOEN_DISABLE				 1
>>> +#define GPOEN_SYS_HDMI_CEC_SDA			 2
>>> +#define GPOEN_SYS_HDMI_DDC_SCL			 3
>>> +#define GPOEN_SYS_HDMI_DDC_SDA			 4
>>> +#define GPOEN_SYS_I2C0_CLK			 5
>>> +#define GPOEN_SYS_I2C0_DATA			 6
>>> +#define GPOEN_SYS_HIFI4_JTAG_TDO		 7
>>> +#define GPOEN_SYS_JTAG_TDO			 8
>>> +#define GPOEN_SYS_PWM0_CHANNEL0			 9
>>> +#define GPOEN_SYS_PWM0_CHANNEL1			10
>>> +#define GPOEN_SYS_PWM0_CHANNEL2			11
>>> +#define GPOEN_SYS_PWM0_CHANNEL3			12
>>> +#define GPOEN_SYS_SPI0_NSSPCTL			13
>>> +#define GPOEN_SYS_SPI0_NSSP			14
>>> +#define GPOEN_SYS_TDM_SYNC			15
>>> +#define GPOEN_SYS_TDM_TXD			16
>>> +#define GPOEN_SYS_I2C1_CLK			17
>>> +#define GPOEN_SYS_I2C1_DATA			18
>>> +#define GPOEN_SYS_SDIO1_CMD			19
>>> +#define GPOEN_SYS_SDIO1_DATA0			20
>>> +#define GPOEN_SYS_SDIO1_DATA1			21
>>> +#define GPOEN_SYS_SDIO1_DATA2			22
>>> +#define GPOEN_SYS_SDIO1_DATA3			23
>>> +#define GPOEN_SYS_SDIO1_DATA4			24
>>> +#define GPOEN_SYS_SDIO1_DATA5			25
>>> +#define GPOEN_SYS_SDIO1_DATA6			26
>>> +#define GPOEN_SYS_SDIO1_DATA7			27
>>> +#define GPOEN_SYS_SPI1_NSSPCTL			28
>>> +#define GPOEN_SYS_SPI1_NSSP			29
>>> +#define GPOEN_SYS_I2C2_CLK			30
>>> +#define GPOEN_SYS_I2C2_DATA			31
>>> +#define GPOEN_SYS_SPI2_NSSPCTL			32
>>> +#define GPOEN_SYS_SPI2_NSSP			33
>>> +#define GPOEN_SYS_I2C3_CLK			34
>>> +#define GPOEN_SYS_I2C3_DATA			35
>>> +#define GPOEN_SYS_SPI3_NSSPCTL			36
>>> +#define GPOEN_SYS_SPI3_NSSP			37
>>> +#define GPOEN_SYS_I2C4_CLK			38
>>> +#define GPOEN_SYS_I2C4_DATA			39
>>> +#define GPOEN_SYS_SPI4_NSSPCTL			40
>>> +#define GPOEN_SYS_SPI4_NSSP			41
>>> +#define GPOEN_SYS_I2C5_CLK			42
>>> +#define GPOEN_SYS_I2C5_DATA			43
>>> +#define GPOEN_SYS_SPI5_NSSPCTL			44
>>> +#define GPOEN_SYS_SPI5_NSSP			45
>>> +#define GPOEN_SYS_I2C6_CLK			46
>>> +#define GPOEN_SYS_I2C6_DATA			47
>>> +#define GPOEN_SYS_SPI6_NSSPCTL			48
>>> +#define GPOEN_SYS_SPI6_NSSP			49
>>> +
>>> +/* aon_iomux doen */
>>> +#define GPOEN_AON_PTC0_OE_N_4			2
>>> +#define GPOEN_AON_PTC0_OE_N_5			3
>>> +#define GPOEN_AON_PTC0_OE_N_6			4
>>> +#define GPOEN_AON_PTC0_OE_N_7			5
>>> +
>> 
>> It looks like you add register constants to the bindings. Why? The
>> bindings are not the place to represent hardware programming model. Not
>> mentioning that there is no benefit in this.
> 
> Also: this entire file should be dropped, but if it stays, you have to
> name it matching bindings or compatible (vendor,device.h).

Thanks your comments.
These macros are used to configure pinctrl in dts, so the file should stay,
and will change the name as "starfive,jh7110-pinctrl.h" to match bindings or compatible.

Best regards,
Jianlong Huang


