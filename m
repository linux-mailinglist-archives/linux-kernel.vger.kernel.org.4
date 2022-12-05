Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B96426CD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiLEKhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiLEKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:37:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C7A14D29;
        Mon,  5 Dec 2022 02:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670236622; x=1701772622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jYfx+B+UAYkydHRZ5isoOVyDSGssXGO6Y1vwW6SpTNk=;
  b=Nn+2nSFPnrJ2h4fyHPtf3i65vm835co49Ec5zMgba88JQODBSTsKZZoI
   qrCfH9OJ/qFgBCUJlxDmb227itwn5Vtj/B2yeD6Jf4n1pyIDcDOy7LSI7
   axBx2EraM7gMcM8WCqhVqyT8AMBN2PDB1y6YfSV20UXAYT0ShAZOHiEuE
   CNypLy/8P1yZh1dY6lW5sSWcvMGqI6A+YdwAGkN4OPds+gLvMcTXEHeUG
   VmCx5XEoJbpo3f72+DAOaqJCwVv5KOrTiCe+N90KY92oWQx3l73W1NgDG
   /AjZBSzfEsqg54iOpNiJ9REVtHeWmJApiJKfAX0awWWazJh3zg920VFv4
   g==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="asc'?scan'208";a="191713849"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Dec 2022 03:37:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Dec 2022 03:37:00 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Dec 2022 03:36:58 -0700
Date:   Mon, 5 Dec 2022 10:36:39 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Icenowy Zheng <uwu@icenowy.me>
CC:     Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/3] dt-bindings: timer: sifive,clint: add compatible for
 OpenC906
Message-ID: <Y43Jt3YOSbFyh954@wendy>
References: <20221121041757.418645-1-uwu@icenowy.me>
 <20221121041757.418645-3-uwu@icenowy.me>
 <98005150-83a7-5439-0db1-d93d459c3809@linaro.org>
 <b924d37d716fa8b1fd93102b1d51fac221f43d59.camel@icenowy.me>
 <d0f3ce4f-5676-f5e1-f04f-dd069679b2d3@linaro.org>
 <81C2234E-C92D-4F78-8295-7C6DD0A9BBC4@icenowy.me>
 <20221130181330.GA2544489-robh@kernel.org>
 <Y4j+Gpptk3NAFBNV@spud>
 <4ad56fa249a30167844abcedac53d198606511d8.camel@icenowy.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CSc7m2POAGcYksfe"
Content-Disposition: inline
In-Reply-To: <4ad56fa249a30167844abcedac53d198606511d8.camel@icenowy.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--CSc7m2POAGcYksfe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2022 at 02:12:54PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2022-12-01=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 19:18 +0000=EF=
=BC=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> > On Wed, Nov 30, 2022 at 12:13:30PM -0600, Rob Herring wrote:
> > > On Tue, Nov 22, 2022 at 03:41:27PM +0800, Icenowy Zheng wrote:
> > > >=20
> > > >=20
> > > > =E4=BA=8E 2022=E5=B9=B411=E6=9C=8822=E6=97=A5 GMT+08:00 =E4=B8=8B=
=E5=8D=883:35:48, Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> =E5=86=99=E5=88=B0:
> > > > > On 22/11/2022 08:18, Icenowy Zheng wrote:
> > > > > > =E5=9C=A8 2022-11-21=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 11:06 =
+0100=EF=BC=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > On 21/11/2022 05:17, Icenowy Zheng wrote:
> > > > > > > > T-Head OpenC906 is a open-source-licensed fixed-
> > > > > > > > configuration of
> > > > > > > > C906,
> > > > > > > > which is now public and able to be integrated.
> > > > > > > >=20
> > > > > > > > Add a compatible for the CLINT shipped as part of
> > > > > > > > OpenC906, which
> > > > > > > > should
> > > > > > > > just be ordinary C9xx CLINT.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > > > > > ---
> > > > > > > > =C2=A0Documentation/devicetree/bindings/timer/sifive,clint.=
yam
> > > > > > > > l | 1 +
> > > > > > > > =C2=A01 file changed, 1 insertion(+)
> > > > > > > >=20
> > > > > > > > diff --git
> > > > > > > > a/Documentation/devicetree/bindings/timer/sifive,clint.ya
> > > > > > > > ml
> > > > > > > > b/Documentation/devicetree/bindings/timer/sifive,clint.ya
> > > > > > > > ml
> > > > > > > > index aada6957216c..86703e995e31 100644
> > > > > > > > ---
> > > > > > > > a/Documentation/devicetree/bindings/timer/sifive,clint.ya
> > > > > > > > ml
> > > > > > > > +++
> > > > > > > > b/Documentation/devicetree/bindings/timer/sifive,clint.ya
> > > > > > > > ml
> > > > > > > > @@ -35,6 +35,7 @@ properties:
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - const: sifive,clint0
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - enum:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 - thead,openc906-clint
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun20i-d1-clint
> > > > > > >=20
> > > > > > > Add entries sorted alphabetically. This should be squashed
> > > > > > > with
> > > > > > > previous
> > > > > > > patch.
> > > > > >=20
> > > > > > I make it a seperated patch because I think it's a
> > > > > > questionable
> > > > > > approach.
> > > > > >=20
> > > > > > If you think it's okay, I will just squash it and put it as
> > > > > > the second
> > > > > > patch in the next iteration, with adding openc906-plic as the
> > > > > > first
> > > > > > one.
> > > > >=20
> > > > > What is a questionable approach? Why commit msg is not saying
> > > > > this?
> > > >=20
> > > > Ah I mentioned it in the cover letter. The problem is just I
> > > > doubt whether
> > > > binding strings for single SoCs are necessary.
> > >=20
> > > They are.
> > >=20
> > > Unless all the quirks/bugs/features are somehow guaranteed to be
> > > exactly=20
> > > the same as other SoCs sharing the same compatible string, or there
> > > is=20
> > > another mechanism to identify the exact version (e.g. a version=20
> > > register).
> >=20
> > Icenowy,
> >=20
> > Having thought about this a little - are we not *more* likely to see
> > bug/quirk disparity between implementations of the OpenC906 stuff by
> > the very nature of being an open-source IP?
>=20
> It's an open-source edition of a specific version of the commercial IP,
> a fixed configuration.
>=20
> In addition, maybe we can just retrieve the version infomation via a T-
> Head custom CPU configuration register, mcpuid. Despite the
> implementation of this register is weird -- it contains 7 different
> read-only values, with the most significant nibble behaving as an
> index.

You lot all know the situation here a lot more than I do...
I don't think "letting" people use the bare "thead,c900-foo" makes much
sense as it gives us no chance to deal with quirks down the line.
I don't think that using "thead,openc906-clint", "thead,c900-clint"
makes all that much sense either, in case someone does something wacky
with the open-source version of the core.

That leaves us with either:
"vendor,soc-clint", "thead,openc906-clint", "thead,c900-clint"
or:
"vendor,soc-clint", "thead,c900-clint"
right?

The first one seems like possibly the better option as you'd kinda
expect that, in a perfect word, all of the open-source IP
implementations would share quirks etc?

Thanks,
Conor.


--CSc7m2POAGcYksfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY43JtwAKCRB4tDGHoIJi
0toiAP0Wp6WtOkNedxf/lHQRpp41vBitePX07cxy201boMcEOAD/Wp9iYknpe+Ir
SYzdybJGmgh0saRrntCdz76LUhf4vAw=
=Nmh2
-----END PGP SIGNATURE-----

--CSc7m2POAGcYksfe--
