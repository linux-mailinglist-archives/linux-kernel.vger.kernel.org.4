Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3DF68B536
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 06:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBFFfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 00:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFFfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 00:35:13 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5DC1350F;
        Sun,  5 Feb 2023 21:35:11 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3165Z0hQ022404;
        Sun, 5 Feb 2023 23:35:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1675661700;
        bh=Y+l9iygICZNXALZiwdEq5SU+mZIFPX05uw2Y5eIQHdM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=fb2+QeeHrzJmcesnbVuOCRiwZc3cKkbz9EWB75Yi2xlQyzWZGD4qvHcGnQ63Mf9Z4
         r2O3etY2EwfODZZJKGhVZHzfGJ+S0P2aOo3mOOOU5+Q5b5qcUsS/KN6W3uiAJ5qV18
         mLjFgHo/RA5SWpj9QakDMJSQWTfVqLs6AmlkX2js=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3165Z0S4040280
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 5 Feb 2023 23:35:00 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 5
 Feb 2023 23:34:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 5 Feb 2023 23:34:59 -0600
Received: from [172.24.222.47] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3165YrXU086264;
        Sun, 5 Feb 2023 23:34:54 -0600
Message-ID: <2cfd99ac-a3fe-5014-1a51-19a0ee95eaa1@ti.com>
Date:   Mon, 6 Feb 2023 11:04:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: clock: fixed-factor: Add TI AM62 SoC
 OLDI clock
To:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     Samuel Holland <samuel@sholland.org>,
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
 <367fba29-bc08-1f27-249c-09e406adfbbb@ideasonboard.com>
 <f324c845f0d291d041a13046a349ae95.sboyd@kernel.org>
Content-Language: en-US
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <f324c845f0d291d041a13046a349ae95.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 26-Jan-23 05:36, Stephen Boyd wrote:
> Quoting Tomi Valkeinen (2023-01-17 01:40:24)
>> On 16/01/2023 11:51, Aradhya Bhatia wrote:
>>> Hi Stephen,
>>>
>>> Thanks for taking a look at the patch.
>>>
>>> On 12-Jan-23 01:14, Stephen Boyd wrote:
>>>> Quoting Aradhya Bhatia (2022-12-26 01:57:44)
>>>>> Add "ti,k3-am62-oldi-clk-div" to the fixed factor clock compatible enum
>>>>> list.
>>>>>
>>>>> "ti,k3-am62-oldi-clk-div" is a fixed-factor clock that helps the TI
>>>>> display subsystem request a pixel clock for itself and a corresponding
>>>>> serial clock for its OLDI Transmitters. The serial clock is 7 times the
>>>>> pixel clock. This clock needs the clock set rate request to be
>>>>> propagated to the parent clock provider.
>>>>>
>>>>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>>>>> ---
>>>>>   Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git 
>>>>> a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml 
>>>>> b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
>>>>> index 8f71ab300470..0696237530f7 100644
>>>>> --- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
>>>>> +++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
>>>>> @@ -14,6 +14,7 @@ properties:
>>>>>     compatible:
>>>>>       enum:
>>>>>         - fixed-factor-clock
>>>>> +      - ti,k3-am62-oldi-clk-div
>>>>
>>>> I don't see this compatible anywhere in the kernel tree. Is there a
>>>> patch that adds a node using this? I wonder why the display subsystem
>>>> can't add this fixed factor clk directly in the driver. Does the OLDI
>>>> Transmitter send a clk to the display subsystem?
>>>>
>>>> I'm asking all these questions because we got rid of vendor compatibles
>>>> here in hopes of simplifying the logic. Maybe the problem can be
>>>> approached differently, but I don't know all the details.
>>>
>>>
>>> +--------+                       +------------------+
>>> |        |                       |                  |
>>> |  PLL   +---+----+------------->| OLDI Transmitter |
>>> |        |   |    |              |                  |
>>> +--------+   |    |              +------------------+
>>>               |    |
>>>               |    |              +------------------+
>>>               |    |              |                  |
>>>               |    +------------->| OLDI Transmitter |
>>>               |                   |                  |
>>>               |                   +------------------+
>>>               |
>>>               |                   +------------------+
>>>               |   +----------+    |                  |
>>>               |   |    /7    |    |      Display     |
>>>               +-->|   Clock  +--->| Sub-System (DSS) |
>>>                   |    Div   |    |                  |
>>>                   +----------+    +------------------+
>>>
>>> This is how the the clock architecture for DSS looks like.
>>>
>>> The clock divider is not a part of DSS, but outside it.
> 
> The divider is fixed as well? And presumably inside the SoC?
Yes, and yes!

> 
>>>
>>> The clock request flow is initiated by the DSS driver because it has the
>>> required timing parameter information. It requests a certain pixel
>>> frequency. But the frequency required by the OLDI TXes is 7 times
>>> that pixel frequency.
>>>
>>> (Just for clarification, in some cases, the OLDI TX does require only
>>> 3.5 times the pixel frequency, but in those situations there is another
>>> divider in-front of OLDI TX that gets activated with a signal and
>>> divides the incoming frequency by 2, thereby requiring the PLL to still
>>> generate a 7x frequency.)
>>>
>>> Hence, the idea is that the clock divider is able to propagate the set
>>> rate request back to PLL, asking for a frequency 7 times more than the
>>> DSS's asking rate.
> 
> Got it. Can the PLL driver provide a pll_div_7 clk that is used for the
> DSS pixel clk?
> 
The PLL driver can not map the clock divider and hence can't provide the
pll_div_7 clock directly to DSS.

>>>
>>> If this is something less than ideal and should not go up, then I can
>>> implement a new clock device with a separate but similar clock driver.
>>>
>>> Let me know what you think!
>>
>> As a clarification I would also add to the above that on other TI SoCs 
>> with DSS, and also for the second video port on AM62, the clock 
>> framework provides DSS a clock using the pclk frequency.
>>
> 
> Are you saying that adding a fixed div-7 clk in the DSS driver is wrong?
Yes. All variants of DSS accept a pixel clock and it would be wrong to
implement a fixed div-7 in the DSS driver.

All that said, I now understand that the new compatible shouldn't go
there. I will implement a new driver and post it. =)


Regards
Aradhya
