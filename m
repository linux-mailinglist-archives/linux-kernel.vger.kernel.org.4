Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617E172E56A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242734AbjFMOMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242476AbjFMOMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:12:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6171FC3;
        Tue, 13 Jun 2023 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686665539; x=1718201539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hfxBhUgx7NXJ6JdXeA8drLUkBlBlA9y7CgQi6V3xvlI=;
  b=EfEg4FtnU2mG8JkGKEDWTqrEJM0477zu4izGtRHurccl+bBA05ahCQLN
   k/EF/6GiNV438uLZtTKiFuv2/ZH7LxLPxxpOIPTThcN52FBu0uOkEfqAl
   v2RGiXoWak1sblb3kmWreTUQspSHpaBFonepm075DJLo2EvjfOWeMKq01
   QF/4GGkRAlApWJP/Ia0z9OWhAk/6aqr5rYV4SbENQ6U0EI75cQvgboSoK
   /mUusOnskX3j/GKWaDGuxigEh6+RVZOCb6xIEoyJlFwGhdR/h4nF0EPrN
   vg0Ybic4hluEOGvQhs0DKAWZKPuxN/+gKQz5crXDD8ydIT2aJF9XVtlFL
   g==;
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="asc'?scan'208";a="218264434"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 07:12:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 07:12:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 13 Jun 2023 07:12:13 -0700
Date:   Tue, 13 Jun 2023 15:11:47 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>, <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        <linux-riscv@lists.infradead.org>, <qemu-riscv@nongnu.org>,
        <u-boot@lists.denx.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230613-outbound-exchange-cf48ad61d31c@wendy>
References: <20230518-4050231ca8dbe93c08cf9c9a@orel>
 <CAAhSdy07Mg_JBF+4ucGFiWdBKh-Ass5G_aUWqBqTnDSFp7S=0A@mail.gmail.com>
 <20230518-hammock-doornail-478e8ea8e6a7@wendy>
 <f7c20090-220c-2805-86ba-b174a89f65b3@seco.com>
 <20230518-monkhood-dispersal-6749b1228b0d@spud>
 <20230530-duller-reset-a34ae111f207@wendy>
 <20230608191537.GA3233857-robh@kernel.org>
 <20230608-cobbler-giving-e0fac2185e11@spud>
 <20230612-relic-fetal-1beeae3455aa@spud>
 <CAL_Jsq+CJ-mEcEujd5Sk4SLvgTfUX1A7NRXYcMDqkoViDYxTXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X3sgJjRgCn4CtUIw"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+CJ-mEcEujd5Sk4SLvgTfUX1A7NRXYcMDqkoViDYxTXw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--X3sgJjRgCn4CtUIw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 07:28:34AM -0600, Rob Herring wrote:
> On Mon, Jun 12, 2023 at 3:23=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Thu, Jun 08, 2023 at 08:30:28PM +0100, Conor Dooley wrote:
> > > On Thu, Jun 08, 2023 at 01:15:37PM -0600, Rob Herring wrote:
> > > > On Tue, May 30, 2023 at 03:12:12PM +0100, Conor Dooley wrote:
> > > > > On Thu, May 18, 2023 at 10:42:34PM +0100, Conor Dooley wrote:
> > > > > > On Thu, May 18, 2023 at 02:30:53PM -0400, Sean Anderson wrote:
> > > > >
> > > > > > >
> > > > > > > Why not just have something like
> > > > > > >
> > > > > > > mycpu {
> > > > > > >       ...
> > > > > > >       riscv,isa {
> > > > > > >               i;
> > > > > > >               m;
> > > > > > >               a;
> > > > > > >               zicsr;
> > > > > > >               ...
> > > >
> > > > I prefer property names be globally unique. The tools are geared to=
wards
> > > > that too. That's largely a symptom of having 0 type information in =
the
> > > > DT.
> > > >
> > > > For example if you had an extension called 'reg', it would be a pro=
blem.
> > >
> > > Per the current ISA rules, that'd not be valid. But then again, I do
> > > have trust issues & it's not like "reg" is the only property name in =
DT
> > > land.
> >
> > ...you say "prefer" here. Is that a NAK, or a "you keep the pieces"?
>=20
> Don't do the above node.

Yeah, that's more helpful wording than "prefer" for sure!

If that's a no-go & so are the booleans prefixed with "riscv,whatever-",
since people have size concerns, I guess that leaves your string
suggestion (there is a helper in Linux at least, haven't checked
elsewhere yet).

I guess that means something like:

  riscv,isa-extensions:
    $ref: /schemas/types.yaml#/definitions/string-array
    minItems: 1
    description: Extensions supported by the hart.
    items:
      anyOf:
        - const: i
          description: foo
        - const: m
          description: foo
        - const: a
          description: foo
        - const: f
          description: foo
        - const: d
          description: foo
        - const: c
          description: foo
        - const: zifencei
          description: foo
        - etc

Obviously with "foo" replaced by the existing descriptions in this
patch.


--X3sgJjRgCn4CtUIw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIh5IwAKCRB4tDGHoIJi
0qHeAP4vJ0QRi7YJAoUUY9FMywRtOb4MKioKJLodiR5tQ3sA3gEA/oOKmdPiwKIP
32NtYdVYP78YjeI+omupwDOZZfgQEQw=
=td6r
-----END PGP SIGNATURE-----

--X3sgJjRgCn4CtUIw--
