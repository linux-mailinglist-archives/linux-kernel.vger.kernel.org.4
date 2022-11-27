Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86864639E41
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiK0XmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK0XmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:42:07 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299BABCA4;
        Sun, 27 Nov 2022 15:42:04 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 10D24240003;
        Sun, 27 Nov 2022 23:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669592523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vr+0RXVT0QhN4P9EN7mtZrpAeJNmfR3sW3a2tBYH+zY=;
        b=VJ8yTG47eVHgrCKk0a0PLYmFtgDwmiO66UH27wdkk6Pa6HQMWkpiETpjIPZbb/xpJrSSDT
        95r+xqZHOHXqvHWEz8V2FE/d6TtsIjlNvtQY7tjOetcdgsP2heQZ041+rJD4U7Qw8gHtFl
        +5LAOzGY/D45zyIRRb/IlCorsTF6uqdZrMLNFMfFAKf4AmtRkakdBpfm3jOXPmFPHmPegF
        jsY267+Exm06COkQ3afJxRm44zIQoCtX1xoJUxpS07cNidzwBzaeMtUnxjJWAYZEL+r/a7
        DaCjO18yF/tWdSH0xQU89Ne3SLlcVIesSdnCcaCZQ51zdnlZHfKsMeKLw+AJQQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: armada-xp: add interrupts for watchdog
In-Reply-To: <0308a842-efcb-d4a0-f17c-2b0bf12c9dfb@alliedtelesis.co.nz>
References: <20220211003257.2037332-1-chris.packham@alliedtelesis.co.nz>
 <20220211003257.2037332-2-chris.packham@alliedtelesis.co.nz>
 <87o839jw4p.fsf@BL-laptop>
 <0308a842-efcb-d4a0-f17c-2b0bf12c9dfb@alliedtelesis.co.nz>
Date:   Mon, 28 Nov 2022 00:42:01 +0100
Message-ID: <87fse49d86.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:

> Hi Gregory,
>
> On 15/02/22 04:39, Gregory CLEMENT wrote:
>> Hello Chris,
>>
>>> The first interrupt is for the regular watchdog timeout. Normally the
>>> RSTOUT line will trigger a reset before this interrupt fires but on
>>> systems with a non-standard reset it may still trigger.
>>>
>>> The second interrupt is for a timer1 which is used as a pre-timeout for
>>> the watchdog.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>>
>> To keep bisectability this patch should be merged after the driver
>> patch.
>>
>> Thanks,
>>
>> Gregory
>
> The driver changes were merged a while back. Looks like your intention 
> was for this to go in via the watchdog tree but that never happened. 
> Could you take it through your tree now? Probably won't be until 6.2 now 
> but that's fine.


Applied on mvebu/dt64

Thanks and sorry for having missing the fact that it was not applied.

Gregory


>
>>
>>> ---
>>>   arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 1 +
>>>   arch/arm/boot/dts/armada-xp.dtsi          | 1 +
>>>   2 files changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
>>> index 38a052a0312d..0e561dfc0ca9 100644
>>> --- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
>>> +++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
>>> @@ -286,6 +286,7 @@ &watchdog {
>>>   	compatible = "marvell,armada-xp-wdt";
>>>   	clocks = <&coreclk 2>, <&refclk>;
>>>   	clock-names = "nbclk", "fixed";
>>> +	interrupts = <93>, <38>;
>>>   };
>>>   
>>>   &cpurst {
>>> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
>>> index 6c19984d668e..4297482da62f 100644
>>> --- a/arch/arm/boot/dts/armada-xp.dtsi
>>> +++ b/arch/arm/boot/dts/armada-xp.dtsi
>>> @@ -260,6 +260,7 @@ &watchdog {
>>>   	compatible = "marvell,armada-xp-wdt";
>>>   	clocks = <&coreclk 2>, <&refclk>;
>>>   	clock-names = "nbclk", "fixed";
>>> +	interrupts = <93>, <38>;
>>>   };
>>>   
>>>   &cpurst {
>>> -- 
>>> 2.35.1
>>>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
