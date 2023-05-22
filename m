Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A301D70B5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjEVHKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjEVHKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:10:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2859710C3;
        Mon, 22 May 2023 00:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684739386; x=1716275386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MrJJoLd9Vm8H+TbQSUZkBsj9vMTQ88kC/Vf4zZfIBbE=;
  b=2nqMur+9P0gcuCp73HLSw+9eeye5lF/Wx43jqj5CxXWkNwYgqx3ygumD
   MwYwqNijUlCKcPN6KkQCjzRLCqx5+IoDCghUeixzGzQWyflOF3zW7jSU5
   kvBxYQsiWJjzaiaCpvJjrvbf2k+RWmPCtR34LN9uvwgLLore3PCn9j3hV
   3b5kn/Fc02mTy/EUdZraW8jgKuwqNvMZ4oxXN7prBADZFM5kcwN5xOUlV
   0WRn6bxCBssYRhhsA5P039oNCuvtdKGs0494ZurYZsRY04ZhZtdFwriUk
   agmGa0gJ4qBsgZq2pn8rxGXGJGFPMunZtX4asTtFNdti4CeNpo8yysLdD
   g==;
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="asc'?scan'208";a="216588871"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 00:09:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 00:09:42 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 00:09:39 -0700
Date:   Mon, 22 May 2023 08:09:17 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Guo Ren <guoren@kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH v2 4/9] dt-binding: riscv: add T-HEAD CPU reset
Message-ID: <20230522-motto-seducing-f0fa34f31c18@wendy>
References: <20230518184541.2627-1-jszhang@kernel.org>
 <20230518184541.2627-5-jszhang@kernel.org>
 <20230518-driving-secluding-793b3192776e@spud>
 <CAJF2gTTGgLJ3SNcmhRGpAAw7jhOfYA5j=G9ZibwA8wUmeQN3UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="auhsdGmR45e7vSPO"
Content-Disposition: inline
In-Reply-To: <CAJF2gTTGgLJ3SNcmhRGpAAw7jhOfYA5j=G9ZibwA8wUmeQN3UQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--auhsdGmR45e7vSPO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, May 22, 2023 at 10:16:19AM +0800, Guo Ren wrote:
> On Fri, May 19, 2023 at 3:53=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> > On Fri, May 19, 2023 at 02:45:36AM +0800, Jisheng Zhang wrote:
> > > The secondary CPUs in T-HEAD SMP capable platforms need some special
> > > handling. The first one is to write the warm reset entry to entry
> > > register. The second one is write a SoC specific control value to
> > > a SoC specific control reg. The last one is to clone some CSRs for
> > > secondary CPUs to ensure these CSRs' values are the same as the
> > > main boot CPU. This DT node is mainly used by opensbi firmware.
> > >
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  .../bindings/riscv/thead,cpu-reset.yaml       | 69 +++++++++++++++++=
++
> > >  1 file changed, 69 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/riscv/thead,cpu=
-reset.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/thead,cpu-reset.=
yaml b/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
> > > new file mode 100644
> > > index 000000000000..ba8c87583b6b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
> > > @@ -0,0 +1,69 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/riscv/thead,cpu-reset.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: T-HEAD cpu reset controller
> > > +
> > > +maintainers:
> > > +  - Jisheng Zhang <jszhang@kernel.org>
> > > +
> > > +description: |
> > > +  The secondary CPUs in T-HEAD SMP capable platforms need some speci=
al
> > > +  handling. The first one is to write the warm reset entry to entry
> > > +  register. The second one is write a SoC specific control value to
> > > +  a SoC specific control reg. The last one is to clone some CSRs for
> > > +  secondary CPUs to ensure these CSRs' values are the same as the
> > > +  main boot CPU.

> > > +
> > > +  compatible:
> > > +    oneOf:
> > > +      - description: CPU reset on T-HEAD TH1520 SoC
> > > +        items:
> > > +          - const: thead,reset-th1520
> >
> > You've only got one thing here, you don't need the oneOf.
> > Also, s/reset-th1520/th1520-reset/ please - although I do not know if
> > "reset" is the right word here. Do we know what the IP block is called
> > in the TRM/T-Head docs? Perhaps Guo Ren does if not.
> It's called CPU reset controller; every core has reset_ctrl &
> reset_entry signals; Soc just gathers them into some regs.
> For th1520, we have 4 reset_entries registers and 1 reset_ctrl
> register. Fu Wei would give out more details about it.

Okay, thanks. Sounds like this SoC will have multiple reset controllers
then, since there is likely one for the peripherals too?
thead,th1520-cpu-reset seems like a good idea to me?

> > > +  entry-reg:
> > > +    $ref: /schemas/types.yaml#/definitions/uint64
> > > +    description: |
> > > +      The entry reg address.
> > > +
> > > +  entry-cn
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      The entry reg count.
> > > +
> > > +  control-reg:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> It should be uint64.
>=20
> > > +    description: |
> > > +      The control reg address.
> > > +
> > > +  control-val:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      The value to be set into the control reg.
> > > +
> > > +  csr-copy:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    description: |
> > > +      The CSR registers to be cloned during CPU warm reset.
> >
> > All of these values set on a per-soc basis, right?
> Yes
> > If so, I don't think they should be in here at all since you should be
> > able to figure out the offsets from the base & the values to write based
> > on the compatible string alone, no?
> The driver works with all T-HEAD CPUs, not only for th1520. Some
> vendors may have their own custom CSRs, so the csr-copy feature is
> flexible enough to adjust in dts. As far as I can tell, hardware teams
> typically prefer to focus on the firmware binary rather than setting
> up the software compiling environment.

In this case "firmware" means opensbi, since that's where Jisheng
mentioned in their cover that they intended using this.

> > Putting register values into the DT is always "suspect"!
> It's not register values, it's register offset/ CSR number.

So "control-val" is not a value? "The value to be set into the control
reg" makes it sound oddly like one!!

My point I guess is that this entry could be written like

reset-controller@ffff019050 {
  compatible =3D "thead,th1520-cpu-reset";
  reg =3D <0xff 0xff019050 0xfoo 0xbar>, <0xff 0xff015004 0xfoo 0xbar>;
};

or even:

reset-controller@ffff019050 {
  compatible =3D "thead,th1520-cpu-reset";
  reg =3D <0xff 0xff019050 0xfoo 0xbar>, <0xff 0xff015004 0xfoo 0xbar>;
  reg-names =3D "entry", "control";
};

And csr-copy, entry-cn and control-val can be derived from the
compatible string given you've said they are set on a per-soc basis.

> > > +required:
> > > +  - compatible
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    cpurst: cpurst@ffff019050 {
> >                ^^^^^^^^^^^^^^^^^
> > This is also "suspect" and implies that "entry reg" should just be a
> > normal "reg" property.
> Yes, but we needn't reg, here. It should be:
>=20
> cpurst {

I don't think it should! Firstly, "cpurst" is not a generic node name,
but I also don't agree that "control-reg" and "entry-reg" should not
just be 2 reg entries.

Cheers,
Conor.

--auhsdGmR45e7vSPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGsVGgAKCRB4tDGHoIJi
0q6mAQDAVZJoUwwAGAtGG8hTwg9oX0NehK7eByB3ZQOeueZBOgD+K6nRAFCBVj5T
fvcrb/ObJzX52usOSnrbCxbC/brSmwc=
=MzD5
-----END PGP SIGNATURE-----

--auhsdGmR45e7vSPO--
