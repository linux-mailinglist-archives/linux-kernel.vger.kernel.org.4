Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A579611767
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJ1QUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJ1QUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:20:03 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA842558F1;
        Fri, 28 Oct 2022 09:20:00 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B8E9B100003;
        Fri, 28 Oct 2022 16:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666973999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aJh1duVqfrTZOVl5OU502038SgZk4GABxwyxLjkmh54=;
        b=h97V6tVlYT7n7gv2po/gXaRJbtRgw+JXw2QIbdhKDu3DD4cNHQm0TnPeRkDMZvQ/YvNoJP
        S17toEHjZwS4bdiuGQaL1DaOqGyAWMJt/84Alh+LTSUMv828qLLu6WDWus8BoN4cT/I+pL
        nm6HwTG0/IjEYL35mDv3iM9lmrfHFH3PVBDU9Sp9u3sFohtl2znQEWvhjq8HtzMZzubn0u
        NflkQDE545L53hQ9124VTW5UJqodeiwUb8PWLUwo+BjdOsCYuXh9zs/r7F0AZo+Z8Pq2tX
        MfHD6J5CRI2qWk+Xt4xHaVZ09GVEgtMki+eFVNMPwpFF2hIlGIsQidKFu+ICig==
Date:   Fri, 28 Oct 2022 18:19:57 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/1] dt-bindings: rtc: convert hym8563 bindings to
 json-schema
Message-ID: <Y1wBLZL7GeUMu8nr@mail.local>
References: <20221021170605.85163-1-sebastian.reichel@collabora.com>
 <a5db8a34-acd0-e262-36f0-0b904468bd1f@linaro.org>
 <20221024185049.GA2034297-robh@kernel.org>
 <20221024220559.dddihmq4xg55h26w@mercury.elektranox.org>
 <1a9e1bfb-0437-fcd9-8d41-a1e07aced0e3@gmail.com>
 <20221027162648.mowz2lefcajv3s2q@mercury.elektranox.org>
 <d36d91cd-7c54-a558-72eb-d73e9d935668@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d36d91cd-7c54-a558-72eb-d73e9d935668@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 18:29:51+0200, Johan Jonker wrote:
> 
> 
> On 10/27/22 18:26, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Thu, Oct 27, 2022 at 06:11:19PM +0200, Johan Jonker wrote:
> >> On 10/25/22 00:05, Sebastian Reichel wrote:
> >>> On Mon, Oct 24, 2022 at 01:50:49PM -0500, Rob Herring wrote:
> >>>> On Fri, Oct 21, 2022 at 07:59:26PM -0400, Krzysztof Kozlowski wrote:
> >>>>> On 21/10/2022 13:06, Sebastian Reichel wrote:
> >>>>>> Convert RTC binding for Haoyu Microelectronics HYM8563 to Device Tree
> >>>>>> Schema format.
> >>>>>>
> >>>>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >>>>>> ---
> >>>>>>  .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
> >>>>>>  .../bindings/rtc/haoyu,hym8563.yaml           | 55 +++++++++++++++++++
> >>>>>>  2 files changed, 55 insertions(+), 30 deletions(-)
> >>>>>>  delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> >>>>>>  create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> >>>>>> deleted file mode 100644
> >>>>>> index a8934fe2ab4c..000000000000
> >>>>>> --- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> >>>>>> +++ /dev/null
> >>>>>> @@ -1,30 +0,0 @@
> >>>>>> -Haoyu Microelectronics HYM8563 Real Time Clock
> >>>>>> -
> >>>>>> -The HYM8563 provides basic rtc and alarm functionality
> >>>>>> -as well as a clock output of up to 32kHz.
> >>>>>> -
> >>>>>> -Required properties:
> >>>>>> -- compatible: should be: "haoyu,hym8563"
> >>>>>> -- reg: i2c address
> >>>>>> -- #clock-cells: the value should be 0
> >>>>>> -
> >>>>>> -Optional properties:
> >>>>>> -- clock-output-names: From common clock binding
> >>>>>> -- interrupts: rtc alarm/event interrupt
> >>>>>> -
> >>>>>> -Example:
> >>>>>> -
> >>>>>> -hym8563: hym8563@51 {
> >>>>>> -	compatible = "haoyu,hym8563";
> >>>>>> -	reg = <0x51>;
> >>>>>> -
> >>>>>> -	interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> >>>>>> -
> >>>>>> -	#clock-cells = <0>;
> >>>>>> -};
> >>>>>> -
> >>>>>> -device {
> >>>>>> -...
> >>>>>> -	clocks = <&hym8563>;
> >>>>>> -...
> >>>>>> -};
> >>>>>> diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..b0b6126b12dd
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> >>>>>> @@ -0,0 +1,55 @@
> >>>>>> +# SPDX-License-Identifier: GPL-2.0
> >>>>>
> >>>>> Dual license please. I don't think you copied any content from original
> >>>>> bindings... unless the example?
> >>>>>
> >>>>>> +%YAML 1.2
> >>>>>> +---
> >>>>>> +$id: http://devicetree.org/schemas/rtc/haoyu,hym8563.yaml#
> >>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>>> +
> >>>>>> +title: Haoyu Microelectronics HYM8563 RTC
> >>>>>> +
> >>>>>> +maintainers:
> >>>>>> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> >>>>>> +
> >>>>>> +properties:
> >>>>>> +  compatible:
> >>>>>> +    const: haoyu,hym8563
> >>>>>> +
> >>>>>> +  reg:
> >>>>>> +    maxItems: 1
> >>>>>> +
> >>>>>> +  interrupts:
> >>>>>> +    maxItems: 1
> >>>>>> +
> >>>>>> +  "#clock-cells":
> >>>>>> +    const: 0
> >>>>>> +
> >>>>>> +  clock-output-names:
> >>>>>> +    description: From common clock binding to override the default output clock name.
> >>>>>
> >>>>> You need maxItems for this.
> >>>>>
> >>>>>> +
> >>>>>> +  wakeup-source:
> >>>>>> +    description: Enables wake up of host system on alarm.
> >>>>>> +
> >>>>>> +allOf:
> >>>>>> +  - $ref: rtc.yaml
> >>>>>> +
> >>>>>> +unevaluatedProperties: false
> >>>>>> +
> >>>>>
> >>
> >>>>> Would be great if you could also correct DTS using these bindings (see
> >>>>> warning from Rob).
> >>>>
> >>>> It looked to me like 'clock-frequency' should be added to the schema.
> >>>
> >>> I've sent PATCHv2, which removes clock-frequency from all hym8563
> >>> users. My reasoning is, that the old txt binding does not describe
> >>> it and the current Linux driver does not handle it as far as I can
> >>> see.
> >>
> >> Didn't note you were doing a conversion as well...
> >> From my abandonment patch serie
> >>
> >>   clock-frequency:
> >>     enum: [1, 32, 1024, 32768]
> >>
> >> The data sheet shows that it can generate 4 different frequencies.
> >> Rockchip mostly uses 32768, but that doesn't mean someone else is
> >> not alowed to set what he/she prefers.
> > 
> > As far as I can tell 32768 has been cargo copied by everyone, but
> > the driver is not parsing this at all and I would expect the clock
> > API to be used for requesting a specific frequency.
> 
> DT and Linux driver support are 2 different things.
> What Linux currently doesn't support might be needed elsewhere.
> 

Yes but being a clock provider is enough for any OS.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
