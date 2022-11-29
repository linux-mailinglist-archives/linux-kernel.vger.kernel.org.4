Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7163B6FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbiK2BSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiK2BSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:18:37 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0183F06F;
        Mon, 28 Nov 2022 17:18:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NLkxK27pgz4x1H;
        Tue, 29 Nov 2022 12:18:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1669684711;
        bh=um0BfxoDtr4r9+x8I9nQygrNqAmT0G+nGZvRVjUq5tk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KH+heAmmoOdxpzPu3mTU51IOwN/JQSxYTo+zcKi2kekvq/JTY9/RhSDzngCDRJJTc
         vR/G13kqiZGns5ydjYiGt3YkEZM2fE4e6IYT5ieOqNy/y9PofdpPJy7MtQy2wje3b4
         mmp/bQ2fnGviHA6QB5gxDkOOytytT6eMaYnwOygEkLw6EhWeCZS2lCtz6HQZA+ngJt
         yxTiJip6qOR7CBdRueeAehMl12w8KsXdHJu6v0GEwtt1r81DkbvbakQhUKN+YvIEID
         OnF44VweMD1mmLN5UFq4/w34y/RKcWjzUTL2B7N2YBgtDzNDdjtGHdRoEPd+EaYf/O
         fJNDWAUH9Vo3w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Josef Schlehofer <josef.schlehofer@nic.cz>
Subject: Re: [PATCH] powerpc: dts: turris1x.dts: Add channel labels for
 temperature sensor
In-Reply-To: <20221101224348.xkpzucskunn46i5z@pali>
References: <20220930123901.10251-1-pali@kernel.org>
 <20220930124618.kyaansrl7ls5kn3i@pali>
 <20221009120506.itwa4n25nljn2tll@pali>
 <20221101224348.xkpzucskunn46i5z@pali>
Date:   Tue, 29 Nov 2022 12:18:28 +1100
Message-ID: <87k03eblsr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:
> Michael, could you take this patch?

Yep.

With these dts patches it always helps if you tell me that it passes the
DT schema checks, so that I don't get yelled at by the DT people :)

cheers

> On Sunday 09 October 2022 14:05:06 Pali Roh=C3=A1r wrote:
>> On Friday 30 September 2022 14:46:18 Pali Roh=C3=A1r wrote:
>> > + CC hwmon ML
>> >=20
>> > On Friday 30 September 2022 14:39:01 Pali Roh=C3=A1r wrote:
>> > > Channel 0 of SA56004ED chip refers to internal SA56004ED chip sensor=
 (chip
>> > > itself is located on the board) and channel 1 of SA56004ED chip refe=
rs to
>> > > external sensor which is connected to temperature diode of the P2020=
 CPU.
>> > >=20
>> > > Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1=
.x routers")
>> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>> > > ---
>> > > With this change userspace 'sensors' applications prints labels:
>> > >=20
>> > >     $ sensors
>> > >     sa56004-i2c-0-4c
>> > >     Adapter: MPC adapter (i2c@3000)
>> > >     board:        +34.2=C2=B0C  (low  =3D  +0.0=C2=B0C, high =3D +70=
.0=C2=B0C)
>> > >                            (crit =3D +85.0=C2=B0C, hyst =3D +75.0=C2=
=B0C)
>> > >     cpu:          +58.9=C2=B0C  (low  =3D  +0.0=C2=B0C, high =3D +70=
.0=C2=B0C)
>> > >                            (crit =3D +85.0=C2=B0C, hyst =3D +75.0=C2=
=B0C)
>> > >=20
>> > > And without this change it prints just generic tempX names:
>> > >=20
>> > >     $ sensors
>> > >     sa56004-i2c-0-4c
>> > >     Adapter: MPC adapter (i2c@3000)
>> > >     temp1:        +43.0=C2=B0C  (low  =3D  +0.0=C2=B0C, high =3D +70=
.0=C2=B0C)
>> > >                            (crit =3D +85.0=C2=B0C, hyst =3D +75.0=C2=
=B0C)
>> > >     temp2:        +63.4=C2=B0C  (low  =3D  +0.0=C2=B0C, high =3D +70=
.0=C2=B0C)
>> > >                            (crit =3D +85.0=C2=B0C, hyst =3D +75.0=C2=
=B0C)
>> > > ---
>> > >  arch/powerpc/boot/dts/turris1x.dts | 14 ++++++++++++++
>> > >  1 file changed, 14 insertions(+)
>> > >=20
>> > > diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/=
dts/turris1x.dts
>> > > index 4033c554b06a..5b5278c32e43 100644
>> > > --- a/arch/powerpc/boot/dts/turris1x.dts
>> > > +++ b/arch/powerpc/boot/dts/turris1x.dts
>> > > @@ -69,6 +69,20 @@
>> > >  				interrupt-parent =3D <&gpio>;
>> > >  				interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>, /* GPIO12 - ALERT pin */
>> > >  					     <13 IRQ_TYPE_LEVEL_LOW>; /* GPIO13 - CRIT pin */
>> > > +				#address-cells =3D <1>;
>> > > +				#size-cells =3D <0>;
>> > > +
>> > > +				/* Local temperature sensor (SA56004ED internal) */
>> > > +				channel@0 {
>> > > +					reg =3D <0>;
>> > > +					label =3D "board";
>> > > +				};
>> > > +
>> > > +				/* Remote temperature sensor (D+/D- connected to P2020 CPU Temp=
erature Diode) */
>> > > +				channel@1 {
>> > > +					reg =3D <1>;
>> > > +					label =3D "cpu";
>> > > +				};
>> >=20
>> > I'm not sure if you want UPPERCASE, lowercase, PascalCase, kebab-case
>> > or snake_case format of labels. Or if you want also "temp" or
>> > "temperature" keyword in the label. So please adjust label to the
>> > preferred one, if proposed format is not the correct.
>>=20
>> Ok, if nobody complains then please take this patch as is.
>>=20
>> > >  			};
>> > >=20=20
>> > >  			/* DDR3 SPD/EEPROM */
>> > > --=20
>> > > 2.20.1
>> > >=20
