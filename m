Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AEB737CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjFUICS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjFUICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:02:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84C0170C;
        Wed, 21 Jun 2023 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687334535; x=1718870535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2TQu/oPINqyAhXMvFfjq4krM1J8lJ1HeueobGZSxnsg=;
  b=FhX3suz9bUq5bBwE/MKa8VdHP2yJylwzReGCNz8mskDvU0xAsF9wflcH
   J3/LX5dAenwqacB8yai7TsB0VT+8F2F7o75m4K+o9TZBXJQOWySPZVyoa
   RHtk/5zIrzbrjpdzcL5RQCfCfBXlE6iuvguBu2THAH3tnRMJUp6tCBnfJ
   Q1D72d8AeMii3ll3hOkQunWXq/mE4Di3hSSuZ771ixVs+942TL8ScJFkJ
   hshM+1R3hksb3UKqLH8PToRGae3n2JpGZMNEnf6fa/GnTmb0j3oGi049s
   f+RWzrvcbzNLRcrUMkj7IBir7b1nOPp512j00jsC4AH5pOadDH25jl3H+
   A==;
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="asc'?scan'208";a="219662347"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2023 01:02:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 21 Jun 2023 01:02:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 21 Jun 2023 01:02:06 -0700
Date:   Wed, 21 Jun 2023 09:01:39 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Lucas Tanure <tanure@linux.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yixun Lan <dlan@gentoo.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: meson-t7-a311d2-khadas-vim4: add
 initial device-tree
Message-ID: <20230621-barber-enjoyably-04806271daea@wendy>
References: <20230620134857.238941-1-tanure@linux.com>
 <20230620134857.238941-3-tanure@linux.com>
 <ZJIjtphyKdC48JrN@ofant>
 <76a7f819-f3d2-d39d-1bc9-f1e7f837fd22@linaro.org>
 <CAJX_Q+3im20qphOXzn-=58Kx4--ajbaF4P8BVvRcDcPXn1Qheg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5aSeY0QXlyq92qaE"
Content-Disposition: inline
In-Reply-To: <CAJX_Q+3im20qphOXzn-=58Kx4--ajbaF4P8BVvRcDcPXn1Qheg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--5aSeY0QXlyq92qaE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 08:37:02AM +0100, Lucas Tanure wrote:
> On Wed, Jun 21, 2023 at 7:02=E2=80=AFAM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 21/06/2023 00:09, Yixun Lan wrote:
> > >> +            apb4: bus@fe000000 {
> > >> +                    compatible =3D "simple-bus";
> > >> +                    reg =3D <0x0 0xfe000000 0x0 0x480000>;
> > >> +                    #address-cells =3D <2>;
> > >> +                    #size-cells =3D <2>;
> > >> +                    ranges =3D <0x0 0x0 0x0 0xfe000000 0x0 0x480000=
>;
> > >> +
> > >> +                    uart_A: serial@78000 {
> > >> +                            compatible =3D "amlogic,meson-t7-uart",
> > >                                               ~~~~~~~~~~~~~~~~~
> > > if you introduce new compatible string, then at least you need to doc=
ument it
> > > so Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml n=
eed to be updated
> > >
> > > but my qeustion here, why bother introducing new compatible string if=
 nothing
> > > changed with the compatible data? given the uart is same IP with g12a=
, can't we just
> > > use "amlogic,meson-g12-uart" for this? no only it will reduce the str=
ucture length of
> > > meson_uart_dt_match[], but also relieve maintainer's review burden?
> >
> > https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetr=
ee/bindings/writing-bindings.rst#L42
> >
> > Best regards,
> > Krzysztof
> >
> Hi, I did not understand the recommendation here.
> Can I add "amlogic,meson-t7-uart" without Documentation changes?

No, you can't.

> I think Yes, as I can see a few compatible strings in dts that don't
> exist anywhere else.

Aye, but we do not want to propagate that. New stuff should not be
adding undocumented compatibles, and those that are undocumented should
be documented.

> My idea here is to add "amlogic,meson-t7-uart" for future use if ever
> created, like if we find a bug in the future that is only relevant to
> T7 soc.
> But for now, fallback to s4 uart, as it seems to be the same controller.
>=20
> >From Krzysztof said in the writing-bindings.rst, I am following the rule=
s.
>=20
> So, what's the path forward here?

You are following the rules from the dts point of view, you just need a
3rd patch in which you document the pattern you have added here in
amlogic,meson-uart.yaml. It is probably something like:
+      - items:
+          - const: amlogic,meson-t7-uart
+          - const: amlogic,meson-s4-uart
But I have not tested that, I just wrote that in my mail client.

Cheers,
Conor.

--5aSeY0QXlyq92qaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJKuWAAKCRB4tDGHoIJi
0sz1AQDTbSImMPfj3eXZkkbJgedEV9mFN5eDBAD9G8HavB9hSwEAiOLWCw7Qt7yU
nkxVT6Dtv3r2MiNA45lN8/HWxgTfZwk=
=Xw6R
-----END PGP SIGNATURE-----

--5aSeY0QXlyq92qaE--
