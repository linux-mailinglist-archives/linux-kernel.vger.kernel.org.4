Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEB866DA31
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbjAQJmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbjAQJlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:41:15 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E008189;
        Tue, 17 Jan 2023 01:40:31 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A480810C;
        Tue, 17 Jan 2023 10:40:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673948428;
        bh=pwcY+nhMvG/TRw/6a23Tkmw05fU7m9erKXgldfhdtKs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cYB3srwjuy25uquA3HfrV9XgcNNZC0uzFWAmKVLDC88prn2l7TdA8UdpW1riCiTUw
         bI7W0xJvy84evkSzMYe0tyfBuelwxCmVcMXGkmy4d+7CMcOeg1y+z6HIrRxe+eBvlq
         onJ8cV9jePy0uL5vg5jixJwRgV8Kxw5xOa3+GE5c=
Message-ID: <367fba29-bc08-1f27-249c-09e406adfbbb@ideasonboard.com>
Date:   Tue, 17 Jan 2023 11:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: clock: fixed-factor: Add TI AM62 SoC
 OLDI clock
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
References: <20221226095745.19757-1-a-bhatia1@ti.com>
 <20221226095745.19757-2-a-bhatia1@ti.com>
 <8980856c1138571976f00413b94cfeb8.sboyd@kernel.org>
 <1856e963-4514-92f3-5d43-d5b711083193@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <1856e963-4514-92f3-5d43-d5b711083193@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 11:51, Aradhya Bhatia wrote:
> Hi Stephen,
> 
> Thanks for taking a look at the patch.
> 
> On 12-Jan-23 01:14, Stephen Boyd wrote:
>> Quoting Aradhya Bhatia (2022-12-26 01:57:44)
>>> Add "ti,k3-am62-oldi-clk-div" to the fixed factor clock compatible enum
>>> list.
>>>
>>> "ti,k3-am62-oldi-clk-div" is a fixed-factor clock that helps the TI
>>> display subsystem request a pixel clock for itself and a corresponding
>>> serial clock for its OLDI Transmitters. The serial clock is 7 times the
>>> pixel clock. This clock needs the clock set rate request to be
>>> propagated to the parent clock provider.
>>>
>>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>>> ---
>>>   Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml 
>>> b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
>>> index 8f71ab300470..0696237530f7 100644
>>> --- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
>>> @@ -14,6 +14,7 @@ properties:
>>>     compatible:
>>>       enum:
>>>         - fixed-factor-clock
>>> +      - ti,k3-am62-oldi-clk-div
>>
>> I don't see this compatible anywhere in the kernel tree. Is there a
>> patch that adds a node using this? I wonder why the display subsystem
>> can't add this fixed factor clk directly in the driver. Does the OLDI
>> Transmitter send a clk to the display subsystem?
>>
>> I'm asking all these questions because we got rid of vendor compatibles
>> here in hopes of simplifying the logic. Maybe the problem can be
>> approached differently, but I don't know all the details.
> 
> 
> +--------+                       +------------------+
> |        |                       |                  |
> |  PLL   +---+----+------------->| OLDI Transmitter |
> |        |   |    |              |                  |
> +--------+   |    |              +------------------+
>               |    |
>               |    |              +------------------+
>               |    |              |                  |
>               |    +------------->| OLDI Transmitter |
>               |                   |                  |
>               |                   +------------------+
>               |
>               |                   +------------------+
>               |   +----------+    |                  |
>               |   |    /7    |    |      Display     |
>               +-->|   Clock  +--->| Sub-System (DSS) |
>                   |    Div   |    |                  |
>                   +----------+    +------------------+
> 
> This is how the the clock architecture for DSS looks like.
> 
> The clock divider is not a part of DSS, but outside it.
> 
> The clock request flow is initiated by the DSS driver because it has the
> required timing parameter information. It requests a certain pixel
> frequency. But the frequency required by the OLDI TXes is 7 times
> that pixel frequency.
> 
> (Just for clarification, in some cases, the OLDI TX does require only
> 3.5 times the pixel frequency, but in those situations there is another
> divider in-front of OLDI TX that gets activated with a signal and
> divides the incoming frequency by 2, thereby requiring the PLL to still
> generate a 7x frequency.)
> 
> Hence, the idea is that the clock divider is able to propagate the set
> rate request back to PLL, asking for a frequency 7 times more than the
> DSS's asking rate.
> 
> If this is something less than ideal and should not go up, then I can
> implement a new clock device with a separate but similar clock driver.
> 
> Let me know what you think!

As a clarification I would also add to the above that on other TI SoCs 
with DSS, and also for the second video port on AM62, the clock 
framework provides DSS a clock using the pclk frequency.

  Tomi

