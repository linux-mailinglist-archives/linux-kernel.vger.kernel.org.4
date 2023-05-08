Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F206FA261
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjEHIgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEHIgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:36:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AC41BEC;
        Mon,  8 May 2023 01:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683534963; x=1715070963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q5ODJunHXC2mcC++rxUZpJJ+DUhK13R4N+xZYOfCDPU=;
  b=pOEzSwFbIhfUkzwtf80HeQwxd527nDJ9JKvuXVvxIkUAWdhLOLiR+qbG
   bXRC+Cv/eB+KiYvcYuOnvq1p5rLI1yNkp1XvypkUDBlgnPV0EMpPpcUSd
   U0fisEJPCrc+EVvcht0S6vltZT7DjtrwwgBSVSjoCvWz2IlrKEwCn9SAK
   N8o4v1QYp3P3YT+6r8Vw/GXs1MT4E46TnOL4DT+0ZolTwdFFFyS0GnI4/
   G1YeSJif/PubQJOF6pzpZN6qkGoUcx2d24CJl7utoidknJUiZzxI7kTFW
   JyxrshFN4tf7UNkjEHhCgQor4NlU87zFJM3ezcFTARK14GjXg5H1VRn5y
   A==;
X-IronPort-AV: E=Sophos;i="5.99,258,1677567600"; 
   d="asc'?scan'208";a="210122642"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2023 01:36:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 8 May 2023 01:36:00 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 8 May 2023 01:35:58 -0700
Date:   Mon, 8 May 2023 09:35:38 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
CC:     Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 3/5] riscv: dts: add initial T-HEAD light SoC device tree
Message-ID: <20230508-refute-reliable-f50dafa6afbd@wendy>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507-calamari-gentleman-bbe62af06f92@spud>
 <394696a52bf1d767044e3f990cebfbaf69dabe70.camel@icenowy.me>
 <7518428.EvYhyI6sBW@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bEoJ+zKkEnHhY3/3"
Content-Disposition: inline
In-Reply-To: <7518428.EvYhyI6sBW@diego>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--bEoJ+zKkEnHhY3/3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 10:23:02AM +0200, Heiko St=C3=BCbner wrote:
> Am Montag, 8. Mai 2023, 05:32:17 CEST schrieb Icenowy Zheng:
> > =E5=9C=A8 2023-05-07=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 22:35 +0100=EF=
=BC=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> > > Hey Jisheng,
> > >=20
> > > On Mon, May 08, 2023 at 02:23:02AM +0800, Jisheng Zhang wrote:
> > >=20
> > > > +               c910_0: cpu@0 {
> > > > +                       compatible =3D "thead,c910", "riscv";
> > > > +                       device_type =3D "cpu";
> > > > +                       riscv,isa =3D "rv64imafdc";
> > >=20
> > > Does this support more than "rv64imafdc"?
> > > I assume there's some _xtheadfoo extensions that it does support,
> > > although I am not sure how we are proceeding with those - Heiko might
> > > have a more nuanced take.
>=20
> I guess the interesting question still is, are these part of the isa
> string or more of an errata?

Yeah, I dunno. That's possible a policy decision more than anything
else. I don't remember if it was one of your patchsets or elsewhere, but
I do recall a split between xtheadba etc and vector, where xtheadba was
defined as a vendor extension, whereas vector is not. Their extension
spec repo <https://github.com/T-head-Semi/thead-extension-spec> appears
to be aligned with that view, apart from the CMOs that we have already
called an erratum.

> The binding currently says
>       Identifies the specific RISC-V instruction set architecture
>       supported by the hart.  These are documented in the RISC-V
>       User-Level ISA document, available from
>       https://riscv.org/specifications/
>=20
>=20
> I guess if we decide to make them part of the isa-string the binding
> then should get a paragraph mention _xfoo vendor-extensions too.

I have an idea in the works that may allow dealing with this kind of
thing, but it's a bit of a departure from the existing binding.
I will hopefully post an early RFC of it later today.
That said, the binding does currently allow you to put in _xfoo vendor
extensions as-is.

> Personally, making these part of the ISA string definitly sounds like
> the best solution though :-) .

You would say that wouldn't you! In general, I'd rather we filled in as
much information as possible here, even if it is not currently in use,
to avoid having to retrofit as support becomes available.

--bEoJ+zKkEnHhY3/3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFi0WgAKCRB4tDGHoIJi
0mLjAPwIbkf8ND8bETn28FqkNQUw7WZE4pCwsbtCxP4g9Fa/zAEAx7QdvUgGgoki
L2lbouRlgh/MWTdnd6MR7meT9HAKNgY=
=n0NK
-----END PGP SIGNATURE-----

--bEoJ+zKkEnHhY3/3--
