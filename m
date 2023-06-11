Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006CD72B150
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 12:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjFKKSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 06:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFKKSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 06:18:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C2C1A4;
        Sun, 11 Jun 2023 03:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B29626068C;
        Sun, 11 Jun 2023 10:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C623BC433D2;
        Sun, 11 Jun 2023 10:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686478721;
        bh=iL8+Wfk6U1lb4E3L5Gwm0eLKEumoATlhkMpwqZDCeb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxymkbMxLeyjfETRfmMatpcBdFvRFF076NYf2uu/zdHiYZ30DdEh8bk07QdPgJdOW
         Am/zuC6Z1T1EiQzl39vqdWDCrenPdoVor0QNY7liDaeVmYGRSZ/HUvRIE1/Z41Tp4T
         z4/hnKeejU+L3jBpq8nEEIQPL/Ku7UGLpjOn6YGfTCGX17vDTx2Amtv3hdN1l29ZCE
         LO/i2pl1DT3gEdlrF1JjR7QaaDC5VOGF9KmQljJ64kNReNCM3W2kRpn6qV9YqHjqFF
         aERZjUWbWVFYTGxWJs0hbGjEZ6jNznEq8LKlLbmgGGo0AuDQMjmSAk3QRMj9AKi+px
         9MLVUCdRMvYPw==
Date:   Sun, 11 Jun 2023 11:18:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 3/3] dt-bindings: thermal: sun8i: Add binding for
 D1/T113s THS controller
Message-ID: <20230611-confront-expectant-aa5da832541c@spud>
References: <20230610141739.999268-1-bigunclemax@gmail.com>
 <20230610141739.999268-4-bigunclemax@gmail.com>
 <20230610-rehire-amid-2517f43504c0@spud>
 <CALHCpMiEmc8L=O86_x7-KkBHFwf2QpuP0M7ugz7dNPr71cpJmQ@mail.gmail.com>
 <20230610-enlarged-agonize-0e9219f9921d@spud>
 <20230610-crumpet-spender-4133090a4728@spud>
 <CALHCpMjFNvJAnd2_3-1n_L3QRz4eNc-Egm-BD6jcS6H694dSyg@mail.gmail.com>
 <20230610-whimsical-unrushed-2f5b30349588@spud>
 <CALHCpMhQ8XxffHr_f=AtO-HoWadBQb1mSvojELctdwMKnF1tbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Tn8RUJUS/1xFx029"
Content-Disposition: inline
In-Reply-To: <CALHCpMhQ8XxffHr_f=AtO-HoWadBQb1mSvojELctdwMKnF1tbw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Tn8RUJUS/1xFx029
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2023 at 10:53:56AM +0300, Maxim Kiselev wrote:
> =D0=B2=D1=81, 11 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 01:14, C=
onor Dooley <conor@kernel.org>:
> >
> > On Sat, Jun 10, 2023 at 11:31:03PM +0300, Maxim Kiselev wrote:
> > > =D1=81=D0=B1, 10 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 21:0=
1, Conor Dooley <conor@kernel.org>:
> > >
> > > ...
> > >
> > > > > > > +  - |
> > > > > > > +    thermal-sensor@2009400 {
> > > > > > > +          compatible =3D "allwinner,sun20i-d1-ths";
> > > > > > > +          reg =3D <0x02009400 0x400>;
> > > > > > > +          interrupts =3D <0 90 0>;
> > > > > > > +          clocks =3D <&ccu 0>;
> > > > > > > +          clock-names =3D "bus";
> > > > > > > +          resets =3D <&ccu 2>;
> > > > > > > +          nvmem-cells =3D <&ths_calibration>;
> > > > > > > +          nvmem-cell-names =3D "calibration";
> > > > > > > +          #thermal-sensor-cells =3D <0>;
> > > > > > >
> > > > > > >> Is this calibration required, or optional, for the d1?
> > > > > >
> > > > > > Calibration data for the D1 is optional as for the H6.
> > > > > > (But without it, the sensor data will be inaccurate).
> > > > >
> > > > > Okay. Modulo the signoff:
> > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > >
> > > > Wait, that's not what I meant to say... Clearly turned my brain off=
 for
> > > > a moment. If it is not going to function correctly without the
> > > > calibration data, why not make the calibration data required for the
> > > > d1's ths?
> > >
> > > I don't really know why, but the calibration data is optional for
> > > other controllers.
> > > So I just did it the same way.
> > > Here is explanation comment about it from the driver:
> > >         /*
> > >          * Even if the external calibration data stored in sid is
> > >          * not accessible, the THS hardware can still work, although
> > >          * the data won't be so accurate.
> > >          *
> > >          * The default value of calibration register is 0x800 for
> > >          * every sensor, and the calibration value is usually 0x7xx
> > >          * or 0x8xx, so they won't be away from the default value
> > >          * for a lot.
> > >          *
> > >          * So here we do not return error if the calibration data is
> > >          * not available, except the probe needs deferring.
> > >          */
> >
> > Wait, so if there is no calibration data then this thing will just defer
> > probing, ad infinitum? Looks like everything other than the a33 has the
> > cells in the dts, and the software seems to expect the cells.
> > What am I missing?
>=20
> Not quite. If we don't have a calibration cell in the dts, then we
> just skip the calibration.
> We will only get EPROBE_DEFER if we have calibration in the dts.

Ah that makes a lot more sense, thanks.

--Tn8RUJUS/1xFx029
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIWfegAKCRB4tDGHoIJi
0qihAP9HKfX8HQ1OLKp48vaSuFjSDi02/6HbWAQPyhr2PgYl3QD/dm6k35G/worO
6PPEW0RXIotdTjgDXDh+Q0dGZZhhXAs=
=9EIT
-----END PGP SIGNATURE-----

--Tn8RUJUS/1xFx029--
