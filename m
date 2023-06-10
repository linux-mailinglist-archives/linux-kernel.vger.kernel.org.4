Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B56E72AE07
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 20:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjFJSBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 14:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjFJSBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 14:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CDA2139;
        Sat, 10 Jun 2023 11:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A30B619F9;
        Sat, 10 Jun 2023 18:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D94C433D2;
        Sat, 10 Jun 2023 18:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686420098;
        bh=lklu6izAOiwJ8VmIzzbqh8xtnkfI9N34tzyzoxGqvxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FPUaIb2hwDOg/DAOeQYvD/9TjqUSW0Vlr6Su35DH5dxGtBiqUH/L8tY3BFeiq5SRJ
         610Fc4ELRP0WLrYcNL3eubINLJdiUZaULSZNxu0HxEFTzvdrR0gsrZHAjGp5dfCBCb
         Y0cFQmNPYtSasBbtF8t38jPGEwBPlVR6XtTjzFaNkIbOhu1KmvTpLPHiOTpZxnPo3h
         1u8VZj2b3ltxYEi4VNLmgSSrH/3/GkUb67M4VKGHmZf+53Lmnwjy0S5j9sYK4p7ASv
         u7Af0BBPnHAKg1WCa4O5odTGRRpMfrcl/Kp1IkxTyu244Oa1A1GjTkvfUG3BZ0ZmZU
         0xf4lftXbfFlw==
Date:   Sat, 10 Jun 2023 19:01:31 +0100
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
Message-ID: <20230610-crumpet-spender-4133090a4728@spud>
References: <20230610141739.999268-1-bigunclemax@gmail.com>
 <20230610141739.999268-4-bigunclemax@gmail.com>
 <20230610-rehire-amid-2517f43504c0@spud>
 <CALHCpMiEmc8L=O86_x7-KkBHFwf2QpuP0M7ugz7dNPr71cpJmQ@mail.gmail.com>
 <20230610-enlarged-agonize-0e9219f9921d@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y9leMd3iPIBr4SeW"
Content-Disposition: inline
In-Reply-To: <20230610-enlarged-agonize-0e9219f9921d@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y9leMd3iPIBr4SeW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 10, 2023 at 06:59:29PM +0100, Conor Dooley wrote:
> On Sat, Jun 10, 2023 at 06:30:48PM +0300, Maxim Kiselev wrote:
> > =D1=81=D0=B1, 10 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 17:52,=
 Conor Dooley <conor@kernel.org>:
> >=20
> > ...
> >=20
> > >
> > > Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> > > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > >
> > >> Why do you have 2 sign-offs that are both you w/ different spellings?
> >=20
> > Sorry for that. I accidentally signed it twice.
> >=20
> > ...
> >=20
> > > +  - |
> > > +    thermal-sensor@2009400 {
> > > +          compatible =3D "allwinner,sun20i-d1-ths";
> > > +          reg =3D <0x02009400 0x400>;
> > > +          interrupts =3D <0 90 0>;
> > > +          clocks =3D <&ccu 0>;
> > > +          clock-names =3D "bus";
> > > +          resets =3D <&ccu 2>;
> > > +          nvmem-cells =3D <&ths_calibration>;
> > > +          nvmem-cell-names =3D "calibration";
> > > +          #thermal-sensor-cells =3D <0>;
> > >
> > >> Is this calibration required, or optional, for the d1?
> >=20
> > Calibration data for the D1 is optional as for the H6.
> > (But without it, the sensor data will be inaccurate).
>=20
> Okay. Modulo the signoff:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Wait, that's not what I meant to say... Clearly turned my brain off for
a moment. If it is not going to function correctly without the
calibration data, why not make the calibration data required for the
d1's ths?

Cheers,
Conor.

--Y9leMd3iPIBr4SeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIS6ewAKCRB4tDGHoIJi
0rexAP9jASDb8H99wbQ++SNJJrD6f2j8d4daxWokKAsYNldy5gEAlK+BUZY0DFLe
BHRNoCoB9c0U6VXpkEMipQbMB/UvsgI=
=6tgd
-----END PGP SIGNATURE-----

--Y9leMd3iPIBr4SeW--
