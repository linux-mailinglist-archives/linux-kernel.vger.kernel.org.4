Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E893E63C2F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbiK2Oqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiK2Oqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:46:34 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ABB4D5F9;
        Tue, 29 Nov 2022 06:46:27 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D4D5C24E06F;
        Tue, 29 Nov 2022 22:46:19 +0800 (CST)
Received: from EXMBX065.cuchost.com (172.16.6.65) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 29 Nov
 2022 22:46:19 +0800
Received: from [192.168.0.104] (219.128.233.15) by EXMBX065.cuchost.com
 (172.16.6.65) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 29 Nov
 2022 22:46:17 +0800
Message-ID: <3db802d6-114f-097a-6c69-e7b40e4d2764@starfivetech.com>
Date:   Tue, 29 Nov 2022 22:46:54 +0800
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
 <0ceba170-f844-e733-a49e-e67746f9f836@starfivetech.com>
 <093ea507-4c42-1af9-4896-64c1a918432e@linaro.org>
 <30c21787-0c48-ff50-1d63-8e69bdcdbe30@starfivetech.com>
 <339be655-aee7-e1a4-51be-28ea20de6792@linaro.org>
Content-Language: en-US
From:   Jianlong Huang <jianlong.huang@starfivetech.com>
In-Reply-To: <339be655-aee7-e1a4-51be-28ea20de6792@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [219.128.233.15]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX065.cuchost.com
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

On Tue, 29 Nov 2022 08:49:49 +0100, Krzysztof Kozlowski wrote:
> On 29/11/2022 02:47, Jianlong Huang wrote:
>> On Mon, 28 Nov 2022 09:32:45 +0100, Krzysztof Kozlowski wrote:
>>> On 28/11/2022 01:48, Jianlong Huang wrote:
>>>
>>>>>>> +/* aon_iomux doen */
>>>>>>> +#define GPOEN_AON_PTC0_OE_N_4			2
>>>>>>> +#define GPOEN_AON_PTC0_OE_N_5			3
>>>>>>> +#define GPOEN_AON_PTC0_OE_N_6			4
>>>>>>> +#define GPOEN_AON_PTC0_OE_N_7			5
>>>>>>> +
>>>>>>
>>>>>> It looks like you add register constants to the bindings. Why? The
>>>>>> bindings are not the place to represent hardware programming model. Not
>>>>>> mentioning that there is no benefit in this.
>>>>>
>>>>> Also: this entire file should be dropped, but if it stays, you have to
>>>>> name it matching bindings or compatible (vendor,device.h).
>>>>
>>>> Thanks your comments.
>>>> These macros are used to configure pinctrl in dts, so the file should stay,
>>>
>>> Why they should stay? What's the reason? If it is not a constant used by
>>> driver, then register values should not be placed in the bindings, so
>>> drop it.
>>>
>> 
>> Thanks.
>> 
>> These macros in binding header(example, DOUT, DOEN etc) will be used in DTS,
>> and driver will parse the DT for pinctrl configuration.
>> 
>> Example in dts:
>> uart0_pins: uart0-0 {
>> 	tx-pins {
>> 		pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX, GPOEN_ENABLE, GPI_NONE)>;
> 
> This is usage in DTS and is not an argument to store register
> addresses/offsets as bindings. What is the usage (of define, not value)
> in the driver?
> 

The existing implementation reuse the macros for DTS and driver.
Do you mean we need to separate the macros, one for DTS and one for driver usage?
Or you have any better suggestion?

These macros are the value of register, not register addresses/offsets,
except for with prefix of GPI.

Drivers rarely reference macros directly, mostly parsing dts and writing them to registers.
 
Best regards,
Jianlong Huang

