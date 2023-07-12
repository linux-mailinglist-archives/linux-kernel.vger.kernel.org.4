Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53837750802
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGLMTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjGLMTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:19:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4796E9B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:19:22 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.goehrs@pengutronix.de>)
        id 1qJYoJ-0001cW-3E; Wed, 12 Jul 2023 14:19:11 +0200
Message-ID: <44633ed0-9401-6d03-000a-4fce5e16ae5c@pengutronix.de>
Date:   Wed, 12 Jul 2023 14:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 7/8] dt-bindings: arm: stm32: add extra SiP compatible
 for oct,stm32mp157c-osd32-red
Content-Language: en-US-large
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Sean Nyekjaer <sean@geanix.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        dantuguf14105@gmail.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230712062954.2194505-1-sean@geanix.com>
 <20230712062954.2194505-7-sean@geanix.com>
 <92f7f4cd-c9cc-8a1a-74c7-39eed955cd6a@pengutronix.de>
 <92C36A18-F359-497E-8267-03E5C62811F6@geanix.com>
 <d57fdae4-9931-6e37-56e1-9649074b3142@pengutronix.de>
From:   =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>
In-Reply-To: <d57fdae4-9931-6e37-56e1-9649074b3142@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.goehrs@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.07.23 11:18, Ahmad Fatoum wrote:
> On 12.07.23 11:11, Sean Nyekjaer wrote:
>>> On 12 Jul 2023, at 10.38, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>> On 12.07.23 08:29, Sean Nyekjaer wrote:
>>>> Add binding support for the Octavo OSD32MP1-RED development board.
>>>>
>>>> General features:
>>>> - STM32MP157C
>>>> - 512MB DDR3
>>>> - CAN-FD
>>>> - HDMI
>>>> - USB-C OTG
>>>> - UART
>>>>
>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> Just a heads up: The LXA TAC, another OSD32MP1 board has been merged into
>>> stm32-next yesterday, so applying your series onto that tree may result
>>> in conflicts. You may want to rebase for v4.
>>>
>>> Cheers,
>>> Ahmad
>>
>> Thanks, will do :)
>>
>> Can I get you to look at 4/8, 5/8 and 6/8 in this series? Will they break anything for LXA TAC?
> 
> Leonard, does the LXA TAC have an implicit dependency on any of the rails that Sean is
> now turning off by default?

No, removing the regulator-always-on for these three regulators on the LXA TAC should be fine.
We do not use v1v2_hdmi and v1v8_audio at all and already have
"/delete-property/regulator-always-on" in our stm32mp15xc-lxa-tac.dtsi for v3v3_hdmi,
which becomes obsolete with this patch.
I would appreciate it if you added patch to remove it from stm32mp15xc-lxa-tac.dtsi if you
send a v4.

You can add my Acked-by: Leonard Göhrs <l.goehrs@pengutronix.de> to these three patches,
if you like.

Greetings
Leonard

> Cheers,
> Ahmad
> 
>>
>> /Sean
>>
>>>
>>>
>>>> ---
>>>> Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 3 ++-
>>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>>>> index 13e34241145b..55e45db1af26 100644
>>>> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>>>> @@ -143,7 +143,8 @@ properties:
>>>>        - description: Octavo OSD32MP15x System-in-Package based boards
>>>>          items:
>>>>            - enum:
>>>> -              - lxa,stm32mp157c-mc1 # Linux Automation MC-1
>>>> +              - lxa,stm32mp157c-mc1       # Linux Automation MC-1
>>>> +              - oct,stm32mp157c-osd32-red # Octavo OSD32MP1 RED board
>>>>            - const: oct,stm32mp15xx-osd32
>>>>            - enum:
>>>>                - st,stm32mp157
>>>
>>> -- 
>>> Pengutronix e.K.                           |                             |
>>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>>
>>
>>
>>
> 
