Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B5734B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjFSEnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjFSEnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:43:06 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BCB1B8;
        Sun, 18 Jun 2023 21:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687149771; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rAFzMqOIjUMwUOxvEdxda/6JlKhnuX3m4bmFHco8dWZ5VutApgp+eGbyc14YLl0J9K
    WEFHjXgomL/iugopOKXC0EIQTLtORvjKenwNvJ4qHJiHKiFVnnUFY7UltRfgjr2wSrms
    7RQa7s51VIesK9DIkbJppLiRsFU7VycZYcCSC3fx6n91pUJ4NDzsH24BJaACo3JE3I6f
    ufBkqc53xTHLdg0a9rWJHatOThb8K7kKSvjr0EJhvSorEzbnjH/oBSlMkMK9qbQjPciZ
    cL3IEZbWkbbQ923ESIYPp5D3Tpv22Qp18ix85p7yJJR2u7heTJyc46egPO2WY0J+3ezV
    cTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687149771;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Mdck7Fur16Xgvhc0gVxr6hne89YRw586RNysMK1GlZI=;
    b=EuFAqdQqBt2oV+OFudpA/6SMXw597iSGJw950Vf/SFxyFEE3BxU72g29Uw9ItZI8ZG
    iR7msc3+A8HjWb4v0tcjxgS+SOn8cDAt+jxXvbP1gyHz6Z35kFdyPsxGZME+PiyWId/c
    fHMhrH4oaeBpNNg29qmbVJTlv8Qc0kWJFSpP9aJHDhF6D3yqHMW3/a2TAm5ZXce2olbu
    G0JxGf3jYYEDOk/wkAjnG5WEVbewp7RRWVfsm7KhUrAoAx2keWacu0xGGS17ZACqTKfF
    XgBhzvh8BH5dn/N/ZUC3SJRKJTiTayNqXD96bCRI7TBuJvOkxr03RSY9pB4gV03vBjBJ
    gPDw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687149771;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Mdck7Fur16Xgvhc0gVxr6hne89YRw586RNysMK1GlZI=;
    b=rF15MINuEOCIYgSAtwCWzsiaDS8OFvjU3OTXdzKkYh+HvtJI5mkcxlY4ooJHhykpTb
    jFR3EU5BlzHwRyeISSI9gbG10OpixBlma4h1C/BLFC97n+RnuoryhTsGgsW16VeYyxIX
    I5xRP1vucPhTh+0bqVf1SuzcGTHc7Et4ic5WqYz8SQQ/mpRUCSB25CdzoAaLRaxybHzu
    fHQI6hoJ7i4860GILIfwMr2KG1Y8l+byp3BZSkwOOLqP7ZbA4yVvAUe+43yPHILgNOz9
    v8lP8Fkh7OFV5cle6nrc4VPY0XHPTtsNHqXyYy1uW+SHoEkt0pABU2oZf7vQ4VDcL1yz
    9sBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687149771;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Mdck7Fur16Xgvhc0gVxr6hne89YRw586RNysMK1GlZI=;
    b=tqWfycPMHro6c9pln2gb0rsIZ2pZW+SUb2YgjjFQxdTmoXBV5V8/ds7eB2eo+LEojc
    lwfgZHAR6uG+j/KSY3CQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGfpWU="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5J4gpD2u
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 19 Jun 2023 06:42:51 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 0/9] MIPS: CI20: Add WiFi / Bluetooth support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <5511fba10119cdc08a18ea2cca98fed343f9cd33.camel@crapouillou.net>
Date:   Mon, 19 Jun 2023 06:42:50 +0200
Cc:     list@opendingux.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Boddie <paul@boddie.org.uk>,
        Paul Burton <paulburton@kernel.org>,
        Christophe Branchereau <cbranchereau@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <2A9DA240-CEEC-48D3-9B3F-48AB3AF8302A@goldelico.com>
References: <20230615084006.79194526F801@goldelico.com>
 <C1924536-FA97-4E75-9D22-99E5AF24EE5B@goldelico.com>
 <A8EBCBA4-D9BA-4C2F-9C91-38128D06EDBA@goldelico.com>
 <AA802E24-A97B-42B6-90A4-5ECB1E4D9294@goldelico.com>
 <5EF6B0D2-2B84-4C98-B799-88062E035EC1@goldelico.com>
 <43DCEEA5-C013-44BE-85C7-D61A980B0EA5@goldelico.com>
 <ebf776a8fb8dee045e7661daaca4564fe39917a6.camel@crapouillou.net>
 <5511fba10119cdc08a18ea2cca98fed343f9cd33.camel@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Am 18.06.2023 um 15:58 schrieb Paul Cercueil <paul@crapouillou.net>:
> 
> Hi All,
> 
> [...]
> 
>> Looking at the JZ4780_DS.PDF file, the SoC actually wants 1.1V so the
>> DT is not wrong - in theory. But in practice it does not work, as you
>> experienced yourself. However, if the ACT8600 defaults to 1.2V, or if
>> the bootloader configures it to 1.2V, I would think that this is
>> actually a voltage that the SoC can handle - otherwise the SoC would
>> be
>> overvolted until the kernel starts, and the board design would be
>> flawed.
>> 
>> I measured that the old 3.x kernel keeps the SoC voltage at 1.2V, so
>> it
>> sounds like a better default. Therefore the fix here would be to
>> raise
>> the DCDC1 regulator to 1.2V.
>> 
>> I'll send a patch later today.
> 
> After a talk with Christophe (Cc'd), I changed my mind.
> 
> A +100 mV overvolt is a *huge* step up, and although the SoC doesn't
> burst into flames, it could very well reduce its life span.

Well, 1.2V is still within the recommended and absolute limits. See my
previous mail. And it appears that my board simply did run at 1.2V
since I bought it many years ago...

So it should neither burn nor burst into flames since it is no change
at least for my board :)

Anyways running at the lowest possible voltage would be good.
The question is if the driver should enforce this more than e.g. U-Boot.

> 
> I used to have huge stability issues (kernel not booting to userspace
> half the times, or just plain reboots after a few minutes of uptime)

That is exactly what I see with the new 1.10V.

> and I now realize it's because I was running the core at 1.1V, because
> these issues disappeared the moment I switched to 1.2V.

For me as well (and I had 1.2V over the past years).

> 
> However, I am now running at 1.125 volts, which is just 25mV above the
> nominal voltage - and it's been extremely stable so far.

Well, what also could be is that the transient of changing the voltage
from the default 1.20V (it either gets from U-Boot or a preprogrammed
chip setting) to the new 1.1V voltage gives an undershoot.

I remember that I studied the OMAP OPP and dynamic voltage scaling control
some years ago and there it was very critical that voltages and clock
frequencies are changed in a specific sequence and with some delays.

And for the OMAP5 we did find a band within the permitted range where
everything was fine and spurious kernel issues (sudden illegal instructions
or segfaults) outside. The result was that there was a minimum voltage
for low frequencies higher than the maximum voltage for higher frequencies.
So there was not even a single core voltage that could support all
clock frequencies.

> 
> Nikolaus: could you test at 1.125 volts? If it's stable for you as
> well, I'd suggest to use this as the new default.

Yes, this is a good idea!

Especially as there are wires between the regulator output inside
the act chip and the core. There may be a small voltage drop so
that setting 1.10V may be too low and 1.25V may end up in real
1.1V.

> 
> Paul (Burton): As you wrote most of the drivers (and uboot?) for the
> board, do you know why VDDCORE was set to 1.2V?
> 
> Cheers,
> -Paul

Best regards,
Nikolaus


