Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676FA72AF67
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 00:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjFJWOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 18:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFJWOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 18:14:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B21F35A9;
        Sat, 10 Jun 2023 15:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9865161343;
        Sat, 10 Jun 2023 22:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E500C433EF;
        Sat, 10 Jun 2023 22:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686435239;
        bh=vsMsWBUiczZVzHiGOeLpckG4GBKjVlgpysa4XpZAf7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KxOTHhTfcUU/rljAc8qZk2jB4hsnkk8Hjkbt+QxRG4SQzRCjizYUh8ar8xJRcDMmW
         03ArKh7Yne7zeZ6yyQIbXuDHJ/dQGEesZL2noyuw+RLe0PxSjGA463Psj9AovwkJL2
         nZjLmIZxArunyPVjQVUpeSPN2PQ6xCuusLMDz9TqUAZAMFrUeN8s0vo0Ydq21cqH05
         1tj63GIs/Xh0RX9666U4zCykkmpqDaWE3ME67m52vIOctHrtQhQO/40WVSMmUXcT3I
         TF5/BBAulzN2vhTWSuwgHubLRMb7q4nQL7pNNXYVHK+Sv9g5cmLLV8Ca7ih16zeBG/
         2eeUyhpP4cr8A==
Date:   Sat, 10 Jun 2023 23:13:52 +0100
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
Message-ID: <20230610-whimsical-unrushed-2f5b30349588@spud>
References: <20230610141739.999268-1-bigunclemax@gmail.com>
 <20230610141739.999268-4-bigunclemax@gmail.com>
 <20230610-rehire-amid-2517f43504c0@spud>
 <CALHCpMiEmc8L=O86_x7-KkBHFwf2QpuP0M7ugz7dNPr71cpJmQ@mail.gmail.com>
 <20230610-enlarged-agonize-0e9219f9921d@spud>
 <20230610-crumpet-spender-4133090a4728@spud>
 <CALHCpMjFNvJAnd2_3-1n_L3QRz4eNc-Egm-BD6jcS6H694dSyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3iXLHNmcMAxY6UVf"
Content-Disposition: inline
In-Reply-To: <CALHCpMjFNvJAnd2_3-1n_L3QRz4eNc-Egm-BD6jcS6H694dSyg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3iXLHNmcMAxY6UVf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 10, 2023 at 11:31:03PM +0300, Maxim Kiselev wrote:
> =D1=81=D0=B1, 10 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 21:01, C=
onor Dooley <conor@kernel.org>:
>=20
> ...
>=20
> > > > > +  - |
> > > > > +    thermal-sensor@2009400 {
> > > > > +          compatible =3D "allwinner,sun20i-d1-ths";
> > > > > +          reg =3D <0x02009400 0x400>;
> > > > > +          interrupts =3D <0 90 0>;
> > > > > +          clocks =3D <&ccu 0>;
> > > > > +          clock-names =3D "bus";
> > > > > +          resets =3D <&ccu 2>;
> > > > > +          nvmem-cells =3D <&ths_calibration>;
> > > > > +          nvmem-cell-names =3D "calibration";
> > > > > +          #thermal-sensor-cells =3D <0>;
> > > > >
> > > > >> Is this calibration required, or optional, for the d1?
> > > >
> > > > Calibration data for the D1 is optional as for the H6.
> > > > (But without it, the sensor data will be inaccurate).
> > >
> > > Okay. Modulo the signoff:
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Wait, that's not what I meant to say... Clearly turned my brain off for
> > a moment. If it is not going to function correctly without the
> > calibration data, why not make the calibration data required for the
> > d1's ths?
>=20
> I don't really know why, but the calibration data is optional for
> other controllers.
> So I just did it the same way.
> Here is explanation comment about it from the driver:
>         /*
>          * Even if the external calibration data stored in sid is
>          * not accessible, the THS hardware can still work, although
>          * the data won't be so accurate.
>          *
>          * The default value of calibration register is 0x800 for
>          * every sensor, and the calibration value is usually 0x7xx
>          * or 0x8xx, so they won't be away from the default value
>          * for a lot.
>          *
>          * So here we do not return error if the calibration data is
>          * not available, except the probe needs deferring.
>          */

Wait, so if there is no calibration data then this thing will just defer
probing, ad infinitum? Looks like everything other than the a33 has the
cells in the dts, and the software seems to expect the cells.
What am I missing?



--3iXLHNmcMAxY6UVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIT1nwAKCRB4tDGHoIJi
0uxwAQDbSA54Fod2Iv1WkrzMW6btFFimBhB2h3grpf16GJVr5gEA72NThqZR28DY
gJomC3CeBsmnzL2M+76ZZxJhsvbFjwk=
=h6lM
-----END PGP SIGNATURE-----

--3iXLHNmcMAxY6UVf--
