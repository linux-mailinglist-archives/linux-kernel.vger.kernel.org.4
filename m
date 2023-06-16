Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E1733ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjFPUVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245204AbjFPUVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:21:14 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F42930DD;
        Fri, 16 Jun 2023 13:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686946867; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RDhlvKviJcIJZZ+e8/63pZ7BoQH6Ms2if5eOoegECQ3OvW7ONUbbLvR8rwtoVW0bkG
    hv9ZySLIw4FIbWi9ijdr5pCPg+eqGcKNhrmOOZxdZ5btbUZCgySCgaCxwsbEzfEy52v3
    g7jDCQyQDGuq903qLmW4Y706q+D9UB4SYNgK5cMBXdTLq+4Rpn2GOPdJaUz6MehCeyxY
    UAqptKx6VcMw+8ERoDHNXpMvJsAnYtFvtHQfA+arpLfx6ls2i5WxYR9JAa4gksfdaRTK
    z6btof5BfE2vA653w9jEgqScWDgZg3nQpE4mDJHCyBpqmNaFyV+xfKe6a7m8lGSI9+YM
    d1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686946867;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=CvIsHqQnmjr0eGXnWhVaV9/eTMH/5xXtMixI9v/UBwU=;
    b=Hc32MS90aJbqtDKHt0BHyT+8qWPrnld52SGf3KJNzI0AEUfNQplMdTHhnm6A1NmLHe
    hoAjxqbh8FNUwbFp7NnGK2VquGpmOKqa6Av105lyDfAeVoCatcuLCj4iWR3S0GZWC8Pg
    Q41Ej2fL2zpOpbOhc+efvHQ181mKZbJsJp4syoDbIbv1Au/OKowZzROPerE9Q0yWIpUQ
    l5VHn2PfJdYbHLfuzbqIWc2GfZdR8cdnwl7h4ZbeXInchSMuxboHMjv/KrPGcqcIGLmq
    HkcZ75jta09dE59xdwU/ylL4oZHnWC5e/hFF9XP1z7qde8EF0SnHm2h8rNlSBz8T3CQc
    EN3Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686946867;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=CvIsHqQnmjr0eGXnWhVaV9/eTMH/5xXtMixI9v/UBwU=;
    b=lHFH0t4sD0RMKNjQzdIYilqY0G8/Z2lBDtNry+33zFAZQhMI5OXYw5XW0CKAhyCgfX
    /5a57sDtdMCrONMiOgt3A0ayBRnFA2KuHqs8kiyTRo8gou32lTJUygtQZSl0AafPPcHx
    L7ixFBCtCx1OPw+d2ty66cy+g62vWHRmByO7/PUhPphX60qDYvbSgVf0/+dujUVnOeHI
    bLH+GDf5kCn5zFBNv2QD8arUhG4nU0qg0XLqcoHL49RlAsb0o0zk0xrTl6Z2IWQoihrS
    lShbZUuAEvcSNyqS1RHPKs6BSAampnGNRFRB3AhoejIocf++d5EsCbOgSFpKGZ4xzKiE
    wn3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686946867;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=CvIsHqQnmjr0eGXnWhVaV9/eTMH/5xXtMixI9v/UBwU=;
    b=5Q9Pj2P8L8MPgaoGeK+2pgSxK1bbbgd7AqV5o+W/PNE25TZ9YXyKsy4ITRFGtGoEpU
    FxoBKh/cEMMbzf6mjWDQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGYkv8="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5GKL7A5f
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Fri, 16 Jun 2023 22:21:07 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 0/9] MIPS: CI20: Add WiFi / Bluetooth support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <AA802E24-A97B-42B6-90A4-5ECB1E4D9294@goldelico.com>
Date:   Fri, 16 Jun 2023 22:21:06 +0200
Cc:     list@opendingux.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5EF6B0D2-2B84-4C98-B799-88062E035EC1@goldelico.com>
References: <20230615084006.79194526F801@goldelico.com>
 <C1924536-FA97-4E75-9D22-99E5AF24EE5B@goldelico.com>
 <A8EBCBA4-D9BA-4C2F-9C91-38128D06EDBA@goldelico.com>
 <AA802E24-A97B-42B6-90A4-5ECB1E4D9294@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

>=20
>>>> Since this patch will actually make the various ACT8600 regulators =
work at their specified voltage, maybe the voltage on one of the updated =
regulators is wrong?
>>>>=20
>>>> Maybe change the regulators one by one back to their old name, =
until you find the one that is problematic? That may give us more info.
>>>=20
>>> That is what I also have thought about but have not yet done.
>>> Will try as soon as I find a time slot.
>>=20
>> I have reverted the whole patch (had only a conflict in wifi_io / =
LDO6) and now I can boot.
>>=20
>> But do not see a WiFi or Bluetooth interface.
>>=20
>> So it looks as if the CI20 variants are indeed different. Which would =
also explain why we
>> originally came up with two different solutions to add WiFi.
>>=20
>> Next I will try to bisect the individual changes...
>=20
> It is this and not the regulator names:
>=20
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts =
b/arch/mips/boot/dts/ingenic/ci20.dts
> index e2221d44e4269..391be48e6427a 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -295,7 +295,6 @@ &i2c0 {
>        act8600: act8600@5a {
>                compatible =3D "active-semi,act8600";
>                reg =3D <0x5a>;
> -               status =3D "okay";
>=20
>                regulators {
>                        vddcore: SUDCDC1 {
>=20
>=20
> Now I wonder how it works without status =3D "okay" for you but not =
for me.

I have not found a reason for this and it was difficult to repeat. =
Potentially a bisect
with failed boot and wrong setup of some voltages may have damaged the =
file system on my
SD card (see below). At least I had to fsck -f after running the bisect, =
but I did not
do it for every bisect step. Sometimes bisecting is difficult if =
hardware effects are
involved...

So I started with the series + a revert of the offending patch, added =
some more logging
to the kernel and printk() in the driver.

Results:

- driver is always loaded, so the status =3D "okay" was spurious and not =
the problem.

- Adding/Removing the regulator names also does not make a difference.

- But renaming the DT nodes (e.g. SUDCDC1 -> DCDC1) (with or without =
regulator_name) makes
boot hang with strange errors which indicate that the processor power =
supply is not stable.
Once a while it did even automatically reboot. In most cases there are =
some EXT4 errors
afterwards.

Example:

[    3.003096] EXT4-fs error (device mmcblk0p1): =
ext4_mb_generate_buddy:1100: group 81, block bitmap and bg descriptor =
inconsistent: 30994 vs 31229 free clusters
/sbin/init: error while loading shared libraries: /lib/mipsel-li
[    3.291901] Kernel panic - not syncing: Attempted to kill init! =
exitcode=3D0x00007f00
[    3.305122] Rebooting in 10 seconds..

I have not found a reason but it appears that if the DT nodes do match =
the
struct regulator_desc list, it is different from having them not match.

At least the result of regulator_of_get_init_data() is NULL if there is =
no
match and then some other code path is followed in regulator_register().

So at the moment I think that matching DT node names with the =
act8600_regulators[] list
changes something in the chip initialization which has influence =
depending on hardware
variation. Maybe your board is simply more robust than mine to that.

Deeper analysis will reveal the issue and indicate a solution...

BR,
Nikolaus

