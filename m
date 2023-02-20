Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED04F69C91A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjBTK5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjBTK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:57:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C911352F;
        Mon, 20 Feb 2023 02:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676890638; x=1708426638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jDdc34ua3hSMfXFV4jOX80dQxnqYjzwrw24WUIV9lJQ=;
  b=UacEHjN1cZvyzl97yv8HQaxqBZCRYtrycoOwOPHX3QKuwvFJ5aEwN93P
   HxnKcrpWrCeHAYcHC6QeQcHLTvJwm6DUQgMlmJ4K/kYUbMuzgohfBcYie
   lYYAj8lfxRYROgfY5UJkCczfJW2TG/psG4/Y9w96pVuPO7REwE4RDwact
   QPxeShzFmgDEtDvH6RkTjofG+vbpP5VphNfJ5YBnf5kcLzFXb0C1XA3Zg
   ZO5tDGzXSpnmjpH3Vcfr/yCe5NBjTTzaOzBQHJlefDURm19s0vkX7LMZJ
   lSDiLeZBHD5EQmP8LQRaFINYi2kLXCCgAwTiBiuhP15U/UqDjAN/SQ/oz
   A==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669100400"; 
   d="asc'?scan'208";a="197790378"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Feb 2023 03:56:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 03:56:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 20 Feb 2023 03:56:49 -0700
Date:   Mon, 20 Feb 2023 10:56:23 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <apatel@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 6/9] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
Message-ID: <Y/NR18DhIGQrDb7w@wendy>
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-7-apatel@ventanamicro.com>
 <Y7X62v5Zp6+thx5A@spud>
 <CAK9=C2UPa5SATTG1pJdckqaoJxh-8EBz8xsENirZQ-vbaHTgjg@mail.gmail.com>
 <Y/NMWZAW4KAqKXEs@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jSnDV5Ee8m2676wk"
Content-Disposition: inline
In-Reply-To: <Y/NMWZAW4KAqKXEs@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--jSnDV5Ee8m2676wk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2023 at 10:32:57AM +0000, Conor Dooley wrote:
> On Mon, Feb 20, 2023 at 10:06:49AM +0530, Anup Patel wrote:
> > On Thu, Jan 5, 2023 at 3:47 AM Conor Dooley <conor@kernel.org> wrote:
> > > On Tue, Jan 03, 2023 at 07:44:06PM +0530, Anup Patel wrote:
> > > > We add DT bindings document for RISC-V advanced platform level
> > > > interrupt controller (APLIC) defined by the RISC-V advanced
> > > > interrupt architecture (AIA) specification.
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > ---
> > > >  .../interrupt-controller/riscv,aplic.yaml     | 159 ++++++++++++++=
++++
> > > >  1 file changed, 159 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-con=
troller/riscv,aplic.yaml
>=20
> > > I'm sorry Anup, but this child versus delegate thing is still not cle=
ar
> > > to me binding wise. See below.
> >=20
> > There are two different information in-context of APLIC domain:
> >=20
> > 1) HW child domain numbering: If an APLIC domain has N children
> >     then HW will have a fixed child index for each of the N children
> >     in the range 0 to N-1. This HW child index is required at the time
> >     of setting up interrupt delegation in sourcecfgX registers. The
> >     "riscv,children" DT property helps firmware (or bootloader) find
> >     the total number of child APLIC domains and corresponding
> >     HW child index number.
> >=20
> > 2) IRQ delegation to child domains: An APLIC domain can delegate
> >    any IRQ range(s) to a particular APLIC child domain. The
> >    "riscv,delegate" DT property is simply a table where we have
> >    one row for each IRQ range which is delegated to some child
> >    APLIC domain. This property is more of a system setting fixed
> >    by the RISC-V platform vendor.
>=20
> Thanks for the explanations. It's been a while since my brain swapped
> this stuff out, but I think delegate/child makes sense to me now.

> Just don't ask me to write the dt entry as proof...

Having looked at Dramforever's QEMU dtb dump a bit more and your
responses to her, I think that I have "come to terms" with it now
actually.
I suppose when the next version comes around I'll make sure that I
arrive in the same ballpark that QEMU does, based off the descriptions
etc in the binding.

Thanks!

--jSnDV5Ee8m2676wk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/NR1wAKCRB4tDGHoIJi
0u+GAP0XLd9PvC0s3LcqSNtuFDzWCUDZhswGihu85xIq2c3jigEA11nESkIJ+S8H
pDH3YOtFsT1FnHWHSt515DWQhxTwbA0=
=6jax
-----END PGP SIGNATURE-----

--jSnDV5Ee8m2676wk--
