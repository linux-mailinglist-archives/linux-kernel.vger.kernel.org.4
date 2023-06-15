Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA717318FA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbjFOM2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbjFOM2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:28:32 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3112B95;
        Thu, 15 Jun 2023 05:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686832106; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bzCtMGP56z3zFeCKjQcyLs2fpXa7sj/XW35Qim9C3jGTjjrk7DoaPugChvVuMFINNO
    lRcFLo31zP6cpp34D/IkcKtaCq2HVREOTiUiUYuegPCtW0271TU5/YKNuph/PwfNsnXF
    rJIkHE8XRlJaoLVdCgtDFslxN9zcVpU8UEmjTI4OezYzFBpHeYBDQQJ6iy/siFIByIyQ
    XShaNrekjuDXJhHQP7AsvlaK2ikRTpzK8o74pLL6X5ztYQM6eattq2lOfAv9dw3e2C+k
    bcnqD6vqV2UFI/PPU3W4Uqz/Mj5SMvL4MGaGFemE6h4z/nsdKReGb+AqFZ2Tpvjs8sKX
    dBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686832106;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=L8zahWCOH6BtOyqV84y/NXgx3tYFcQ4H5CS9K/3b9bI=;
    b=IzTndO3C42btSk6DYAnFUPkGhtRl9Dk/f3UqLvfawMb2Q+aJLEks9TAHBV1uwXZXVq
    ALZJuf22c7StD0TOLMDofu/kiFYflRsZHN23e/UDTaeDWC67fV8XyqAHQVCWKyEujYlp
    sdYs97g56BYQePB/Me0406UMwfILjcw3Bi+gIxzmrUt8RR2uJ0K+IUB8aFZTEfhUt3KK
    anM1ZjUfwNHkAOGlLX18EyCHm3n4ez1BbYG19PyLWS2RMKE/eVxkvHjkWpOHjRtaxG2c
    AsDrRIAh6KGwaqiMMrgEZ9bmWr5yhR0xhJ0tcIMq8XofmtcnsvgcgRfEsSoMsVI6rMrU
    X96Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686832106;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=L8zahWCOH6BtOyqV84y/NXgx3tYFcQ4H5CS9K/3b9bI=;
    b=XOPfZi8xXC47E74buZVemU7KGyTfOl2mLhJ+47wAx6DudVfnS5JTCeQABhiJKfzqFs
    DoONMhgza/+NcAVQwUEPSaem2ioSu/3K/cqV/F0F9PPMdcPbhHb08xKb/FM5ptP/3JJs
    sK9XuA7FDn/WckfDsxKm34/JXu8MlatLAQV6btrVee/C0JmXPoQY+WLQR/sbb1qqPD3/
    h56aENrfObLB51J0A8pFO2T2NVaqm7nfplXk4bUGcUZ5kpLNoDp+bETEmDFw3Gmb+CXb
    JlYV71Gj01n2uiNChzrCuZwBnC7PDVu8iXTkzkdsN6m9Bn71fv7dMgIMq3iLwnkOX+S+
    1Xcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686832106;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=L8zahWCOH6BtOyqV84y/NXgx3tYFcQ4H5CS9K/3b9bI=;
    b=CnIpYnbgeAWTik1SNBQOK0z3JrYxmQtCodlGuSFIufni8kYbys6BaYEYz0RVKaa9c3
    +MIR6vSron+RYt6TrdDQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeonQ="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5FCSP40V
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 14:28:25 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 0/9] MIPS: CI20: Add WiFi / Bluetooth support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <A8EBCBA4-D9BA-4C2F-9C91-38128D06EDBA@goldelico.com>
Date:   Thu, 15 Jun 2023 14:28:25 +0200
Cc:     list@opendingux.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA802E24-A97B-42B6-90A4-5ECB1E4D9294@goldelico.com>
References: <20230615084006.79194526F801@goldelico.com>
 <C1924536-FA97-4E75-9D22-99E5AF24EE5B@goldelico.com>
 <A8EBCBA4-D9BA-4C2F-9C91-38128D06EDBA@goldelico.com>
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

>>>=20
>>> Since this patch will actually make the various ACT8600 regulators =
work at their specified voltage, maybe the voltage on one of the updated =
regulators is wrong?
>>>=20
>>> Maybe change the regulators one by one back to their old name, until =
you find the one that is problematic? That may give us more info.
>>=20
>> That is what I also have though about but have not yet done.
>> Will try as soon as I find a time slot.
>=20
> I have reverted the whole patch (had only a conflict in wifi_io / =
LDO6) and now I can boot.
>=20
> But do not see a WiFi or Bluetooth interface.
>=20
> So it looks as if the CI20 variants are indeed different. Which would =
also explain why we
> originally came up with two different solutions to add WiFi.
>=20
> Next I will try to bisect the individual changes...

It is this and not the regulator names:

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts =
b/arch/mips/boot/dts/ingenic/ci20.dts
index e2221d44e4269..391be48e6427a 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -295,7 +295,6 @@ &i2c0 {
        act8600: act8600@5a {
                compatible =3D "active-semi,act8600";
                reg =3D <0x5a>;
-               status =3D "okay";
=20
                regulators {
                        vddcore: SUDCDC1 {


Now I wonder how it works without status =3D "okay" for you but not for =
me.

Does your test branch have additional patches which add this back?

Or does your board variant have better or different burnt in defaults =
than
my act8600 so that it runs without any driver?

The chip reads as:

ACTIVE
8601QJ
MD361

BR,
Nikolaus

