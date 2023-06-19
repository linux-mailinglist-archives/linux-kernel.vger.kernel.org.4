Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E34734B27
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFSEnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjFSEnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:43:03 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C851B8;
        Sun, 18 Jun 2023 21:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687149767; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VpVgzpR6PCCUn6kx74GhMVJK9aSwq/xS7P/wUQeqgsovFhhsHN3irQIfOgHivkhEzF
    P3pLWbFHTrFwLYPOPV44zVYOa7EzpIyL2DyCnp+Kig4Tb6kx/BM6I+ZkfOXH4nQ5FKQQ
    MHQNi5RTZXorzKcvgn8ifsgiV6qf0Wvk3AZLuUl9rAqSnNwmVQC+VHnSzKpCQYONRh1p
    65TYL+RQpz9OiFZv/C0A554bgR3hGB36Pmfqvax0nQRDs89RlcciCsF3/3W/csy5gUrG
    bY6uP3T7O6j+ckbUDfbnmFkMcF15YbKOUQObM87P6hSy1ADZA1a7CLTNhat+2Q8A9m7O
    JOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687149767;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=JG15ksB+d5M5Is+HF2zvoL07mEewhS2UrKIpTdHlrw4=;
    b=h7Q/hq6HfP+CxuZCOX8bgb+BLtgHDavPBJvBaC8S9EeT+nZ2Spcr8uIgYn6PMciyiq
    9SuYoMZn0K5M1AV2rDv9rwhpOQkE45jjph45P086hS0KYnfzcNLkkmvuJQ7pNP0nhB6Y
    9aj7KC+WVXmdtfZ3ltKQ0SZek3NZcjnfSe+ne6H2vy/t4YbpYv6uhyZuYc0mTumVTulF
    PX2YHYg8CZsFU7vgHNuRoaaijgTAKIgyFG47D5cv/F3GfSe7GYr0h1ROMauRVyXB/HGv
    /hc3XTg04FFe2T3EInUoTAHcStk340wbVFdw+WWLdq2VohbKTec5EUl0j0DS88P5QWAi
    6rCA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687149767;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=JG15ksB+d5M5Is+HF2zvoL07mEewhS2UrKIpTdHlrw4=;
    b=m8Q7JlXg15C3YvlV0FJZCuoDCSEAQK6y+9P/ZgHoDPyh8ld4sWfPiN5Z5kI5Aqf6Dx
    1UDO4vfCndd0KTR95Lp/zYErBP/b35imEbysCCxkGdsg5jw6ub1Iq9NGGnjZTMGLzHc7
    1iPEEA5bR34QmvP0MF/7SAhaZKetjvYgR7EtGyuCZad7cz/rqAOXB4x90EJLYFDp7B6V
    Kc6kTjEROZ6gEz6fFSfztnnLJ2+wLhqCKrNu5P0m/aV1iHhflLxq8dghFbLttOyJnL9F
    M4rBz8pZWci7tIjTou82yXZiyw+jKwi40HgYLTbxCSkPy09jXaMqTIWZliUrxxpMhGtP
    lfBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687149767;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=JG15ksB+d5M5Is+HF2zvoL07mEewhS2UrKIpTdHlrw4=;
    b=NfYgr2rw4BurEfKYRMxSft6uimz3zqFrhOslbXjFv2J6v3BKLDBGscrQFnQ74eeYOo
    pPQq5pw0Y5Fk/w9rf4Dw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGfpWU="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5J4glD2t
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 19 Jun 2023 06:42:47 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 0/9] MIPS: CI20: Add WiFi / Bluetooth support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <ebf776a8fb8dee045e7661daaca4564fe39917a6.camel@crapouillou.net>
Date:   Mon, 19 Jun 2023 06:42:46 +0200
Cc:     list@opendingux.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Boddie <paul@boddie.org.uk>,
        Paul Burton <paulburton@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <92BF3D49-42EB-4153-BB64-20031CF25A11@goldelico.com>
References: <20230615084006.79194526F801@goldelico.com>
 <C1924536-FA97-4E75-9D22-99E5AF24EE5B@goldelico.com>
 <A8EBCBA4-D9BA-4C2F-9C91-38128D06EDBA@goldelico.com>
 <AA802E24-A97B-42B6-90A4-5ECB1E4D9294@goldelico.com>
 <5EF6B0D2-2B84-4C98-B799-88062E035EC1@goldelico.com>
 <43DCEEA5-C013-44BE-85C7-D61A980B0EA5@goldelico.com>
 <ebf776a8fb8dee045e7661daaca4564fe39917a6.camel@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Am 18.06.2023 um 13:51 schrieb Paul Cercueil <paul@crapouillou.net>:

>> And the issue seems to be that without matching the node names the
>> voltages in the device tree may have been ignored completely all the
>> time... Now it sets up voltages, which should happen. But different
>> ones for my board which breaks boot.
>=20
> So the node names fix caused the driver to actually use the info from
> DT, which doesn't allow the board to boot. Nice.

Very good summary :)

As usual the fix is just a one-liner, finding what to do is multi-hours.

>=20
>> Finally I did risk (I have no replacement CI20 board and they are no
>> longer
>> on sale... RS part# was 125-3305 Mouser 456-VL-62851) to run a test
>> with
>> rename to "DCDC1" but changing the voltage to 1200mV. And this
>> version boots.
>=20
> Looking at the JZ4780_DS.PDF file, the SoC actually wants 1.1V so the
> DT is not wrong - in theory. But in practice it does not work, as you
> experienced yourself. However, if the ACT8600 defaults to 1.2V, or if
> the bootloader configures it to 1.2V, I would think that this is
> actually a voltage that the SoC can handle - otherwise the SoC would =
be
> overvolted until the kernel starts, and the board design would be
> flawed.
>=20
> I measured that the old 3.x kernel keeps the SoC voltage at 1.2V, so =
it
> sounds like a better default. Therefore the fix here would be to raise
> the DCDC1 regulator to 1.2V.

I finally found my JZ4780_DS.pdf (Release Date: Nov. 20, 2014).

According to Table 3-1 the absolute maximum for VDDcore is 1.21V.
According to Table 3-2 the recommended range is 0.99V to 1.21V. 1.1V is =
only "typical".
According to 1.3 Characteristic: "the Core should run at 1.1 -0.1/+0.2V"

So 1.1V should be right...

But in practise it may be that the ACT8 seems to come up with 1.2V
as chip-internal default during boot. Or U-Boot is initializing it as =
well.

Maybe I find some time to measure some test point or capacitor while
breaking into U-Boot.

BR,
Nikolaus

