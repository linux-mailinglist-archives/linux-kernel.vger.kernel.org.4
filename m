Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26BD69B0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjBQQb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjBQQb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:31:26 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD246B33B;
        Fri, 17 Feb 2023 08:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1676651397; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcfRlNQsN6C8F3J5F/n8xfhEJCxaZ52Dwm/+9WCFOLo=;
        b=PG8Id652QOkJdmsoa4D9myrkY7nkv50BCxw8FhhEwNHMAQpVadHQzWqxz1RN1zd1WTvg8P
        0+qA33rYkpuvcxKaQvP8/Q4eMvdIFuHqZouiBW66kl/TIcvbNRcifWjGhWlCScWMJJ2y77
        twMaEj1/L41qoDBNU+cYI55S4JcGURA=
Message-ID: <420c4453e236b9881fcdfdc90a10d12bf0eab323.camel@crapouillou.net>
Subject: Re: [RFC 1/3] MIPS: DTS: jz4780: add #clock-cells to rtc_dev
From:   Paul Cercueil <paul@crapouillou.net>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     riccardo Mottola <riccardo.mottola@libero.it>, paul@boddie.org.uk,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Date:   Fri, 17 Feb 2023 16:29:54 +0000
In-Reply-To: <77bcc96a2b81e42b32d48a041d7fac31e7240e56.1676482318.git.hns@goldelico.com>
References: <cover.1676482318.git.hns@goldelico.com>
         <77bcc96a2b81e42b32d48a041d7fac31e7240e56.1676482318.git.hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 15 f=C3=A9vrier 2023 =C3=A0 18:31 +0100, H. Nikolaus Schaller a
=C3=A9crit=C2=A0:
> This makes the driver present the clk32k signal if requested.
> It is needed to clock the PMU of the BCM4330 WiFi and Bluetooth
> module of the CI20 board.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index c182a656d63bc..18affff85ce38 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -155,6 +155,8 @@ rtc_dev: rtc@10003000 {
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clocks =3D <&cgu JZ4780_CLK_RTCLK>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clock-names =3D "rtc";
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0#clock-cells =3D <0>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl: pin-controller@1=
0010000 {

