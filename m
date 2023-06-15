Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9B7731297
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245347AbjFOIrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244598AbjFOIq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:46:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD07297F;
        Thu, 15 Jun 2023 01:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686818735; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=F+XAGKtmcxaW8cC7OPstgEhgK0E9xzd5esV/63evVetA1voYWK1P6Lnjz5rogjwKx5
    P8IFuMFBx5OLpxC7aV78YPqvTWABUHsq42hPD9Pc/0n6RS6d1PaxNt/l3/yDhOCb7zd8
    mzTvi/dByRadddhimo2YjDTlCnS6SPq0u80bp4fomX8Fnt9P+kNl/hgb3ijbQhl3ZmmN
    6gcriTRwXfA6ifdOZgkAEKV30KnKI9x3+jjVl2BypbQ0xZFkTbXHZEDPQ/IG49sKPNUg
    d1b8vrLCInZtKljPi4cn+N9A0g6WWYzFJpKb2lqmonIqNsL7HozFoHZlbEmDTqJb4duG
    9gsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686818735;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=r9yoRyTCv75wwFXzzcG+dHR3NLOvYX2zRmFLfs7WaEE=;
    b=hI8shaWvAoddTpEsvASmBLHJiTaPfxsLnO6gwwG1DaOwU8CALXooIeZCCrtvGtV1m/
    1Y7B/p5p90j0VXZTmI8V968lT2/tJG+Ymaz83PLZR8QrMURffD4y/rlv21LpQpakt2uc
    703YYLzA3Wvlp9bqjC/cUImEt/dEA1XyvUXDtx7LPhhBh/bDK/SbnKld1psTpZwMTIBV
    iHNMn1IVA/WJgAbHm8dI59b4t3LpclrgUZNHjlJJVltAGWO2JLMYHPO5FHCKMZpIDz8c
    0nKlK7hwdnayjvJjYRNTYRCc0rJyUQlHMW9k5bNwfn3utQtyl1ou2DuzJO0ESpDD3+8t
    ECRA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686818735;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=r9yoRyTCv75wwFXzzcG+dHR3NLOvYX2zRmFLfs7WaEE=;
    b=YJFJ8zVkXrlehkkl/0/ovSvcN2ADIWFW+j3OqO84pSOJ3D4rli57DEdqK5HOPeiYh4
    ZzHrcPbpiAqoQ3EAJRBxSrckhL/p0oLTFbeoDkHDr3eAkP7BbKP6N6VGwTw8WEQbnStv
    9eSrNgeniNOvYIR2Z6sLugZwSk6u13DKxAJbEAL+voAAi5rEr0VEdLPDlSxi2Q0mvbEO
    15CCo069BvZkbID+OL23pIHnUYViOjOmGwkvENZef66UHKdvlTRPEGtX6WDSNw6+bMkb
    W0KIkkuyTz9uhhQq4InbFTaCSGk5hT5JIMnQ8Ai8W2e8UKJ2/vPpWE4bQvWCvsjZ42mV
    gZTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686818735;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=r9yoRyTCv75wwFXzzcG+dHR3NLOvYX2zRmFLfs7WaEE=;
    b=7h7MQm/blWPwp6wjdBECY0iiSo5T/v7KlupaLkhc0JijjOOSeNjri1nXdtysH0wJEi
    /P1NjqYZ4Y8531+pTcCA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeonQ="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5F8jZ2fK
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 10:45:35 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 0/9] MIPS: CI20: Add WiFi / Bluetooth support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230615084006.79194526F801@goldelico.com>
Date:   Thu, 15 Jun 2023 10:45:34 +0200
Cc:     list@opendingux.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1924536-FA97-4E75-9D22-99E5AF24EE5B@goldelico.com>
References: <20230615084006.79194526F801@goldelico.com>
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

> Am 15.06.2023 um 10:39 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> Le 15 juin 2023 09:00, "H. Nikolaus Schaller" <hns@goldelico.com> a =
=C3=A9crit :
>>=20
>> Hi Paul,=20
>> I was in holidays and could not review this series earlier.=20
>>=20
>>=20
>>> Am 04.06.2023 um 16:56 schrieb Paul Cercueil <paul@crapouillou.net>:=20=

>>>=20
>>> Hi,=20
>>>=20
>>> Here's a set of patches to add support for the WiFi / Bluetooth chip =
on=20
>>> the CI20.=20
>>>=20
>>> WiFi works pretty well, provided it is used with the latest firmware=20=

>>> provided by linux-firmware. Bluetooth does not work very well here, =
as=20
>>> I cannot get my wireless keyboard to pair; but it does detect it, =
and it=20
>>> does see they key presses when I type the pairing code.=20
>>>=20
>>> I only tested with a somewhat recent (~2022) Buildroot-based =
userspace.=20
>>> I enabled WEXT compatibility because the CI20 is typically used with =
a=20
>>> very old userspace, but I did not try to use it with old tools like=20=

>>> ifconfig/iwconfig.=20
>>=20
>> ^^^ great since not everyone is using memory hungry latest user-space =
and=20
>> ifconfig/iwconfig is also available on some other OS so users like me=20=

>> can share scripts.=20
>>=20
>>=20
>> But I had quite some issues with this series.=20
>>=20
>> 1. I could not boot my CI20 V2a board after applying the full series =
to v6.4-rc6=20
>> 2. bisecting failed because vcc_33v is used in a patch preceding its =
definition=20
>>    leading to DTC compile abort=20
>> 3. after fixing I could bisect that "MIPS: DTS: CI20: Fix ACT8600 =
regulator node names"=20
>>    is the first bad commit - although I don't see immediately why=20
>>=20
>> So this series seems to be severely broken and I could not even come =
to=20
>> a test of WiFi and/or Bluetooth which the series claims to support.=20=

>=20
> Well, that's strange. I can assure you it boots and works here.
>=20
> Maybe it is a board difference; I have a non-square green board - so =
the earlier version.

Ok, my V2a is the bordeaux one. That may indeed make a difference.

>=20
> Since this patch will actually make the various ACT8600 regulators =
work at their specified voltage, maybe the voltage on one of the updated =
regulators is wrong?
>=20
> Maybe change the regulators one by one back to their old name, until =
you find the one that is problematic? That may give us more info.

That is what I also have though about but have not yet done.
Will try as soon as I find a time slot.

>=20
>> Comments to some individual patches follow.=20
>=20
> Sorry about the vcc_33v. Honest mistake.
>=20
> Thomas: are you able to drop this series from mips-next, or should =
I/we send fixup patches instead?

Well, mistakes happen.

Best regards,
Nikolaus

>=20
> Cheers,
> -Paul
>=20
>> Best regards and looking forward to a v2 for testing,=20
>> Nikolaus=20
>>=20
>>=20
>>>=20
>>> Cheers,=20
>>> -Paul=20
>>>=20
>>> Paul Cercueil (9):=20
>>>   MIPS: DTS: CI20: Fix regulators=20
>>>   MIPS: DTS: CI20: Fix ACT8600 regulator node names=20
>>>   MIPS: DTS: CI20: Add parent supplies to ACT8600 regulators=20
>>=20
>> ^^^ should IMHO be a separate series since it is not directly related =
to WiFi / Bluetooth=20
>>=20
>>>   MIPS: DTS: CI20: Do not force-enable CIM and WiFi regulators=20
>>>   MIPS: DTS: CI20: Misc. cleanups=20
>>=20
>> ^^^ these two do not compile=20
>> The Misc. cleanups do not belong to this topic.=20
>>=20
>>>   MIPS: DTS: CI20: Parent MSCMUX clock to MPLL=20
>>=20
>> ^^^ this is only loosely related to Wifi / Bluetooth=20
>>=20
>>>   MIPS: DTS: CI20: Enable support for WiFi / Bluetooth=20
>>>   MIPS: configs: CI20: Regenerate defconfig=20
>>>   MIPS: configs: CI20: Enable WiFi / Bluetooth=20
>>>=20
>>> arch/mips/boot/dts/ingenic/ci20.dts | 148 =
+++++++++++++++++++---------=20
>>> arch/mips/configs/ci20_defconfig    |  47 ++++++---=20
>>> 2 files changed, 133 insertions(+), 62 deletions(-)=20
>>>=20
>>> --=20
>>> 2.39.2=20
>>>=20
>>=20

