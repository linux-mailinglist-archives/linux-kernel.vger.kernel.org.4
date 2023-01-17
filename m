Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F506670B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjAQWOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjAQWNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:13:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D8949943;
        Tue, 17 Jan 2023 12:42:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84F26B818EE;
        Tue, 17 Jan 2023 20:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4F7C433D2;
        Tue, 17 Jan 2023 20:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673988128;
        bh=bN1rNc513vQmrecLRhCXnFkD9PGMHmyMJzDfwS8nfT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsTWxiHa3biQSfAqhmIIf1A5AYQV4HeVTuhO6QauJFJMyT2CsaswdOxuFQK8+HxXd
         sl+lum2g1RuJlFIWm7vdNvlmrhEx90XxhsY862oaTX7BsaBKMaFcphJurL0oup7SsV
         hQzzxKRChvB1nm9uY91DTr7SAmcfaedaOr4Eq/iYkNWt48xgfOrtzpbetrEoBISVQZ
         WzjKIvzlPpd0GSS/egu/HNENkD2DmCw0VOBvNJmCBDP/oT8W4JtUYK1sNt5MLiGUGN
         9OUIITCOJMYj378/XhBKy4OT3hDSz8HdmczZSQDi7a9p53LCuzD5hl2zDi1e5ZOYFH
         UHs6BxcdPtm8g==
Date:   Tue, 17 Jan 2023 20:42:03 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/9] RISC-V: Add AIA related CSR defines
Message-ID: <Y8cIG6gKSlkTh5AF@spud>
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-2-apatel@ventanamicro.com>
 <Y7YGp/7ufyRPhkwg@spud>
 <CAAhSdy2YKJfuxhBmsx9v-OMyxKQjys+J-z_ZqoPJF7q=YrE4Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k2uHQ/1oXnALNsqN"
Content-Disposition: inline
In-Reply-To: <CAAhSdy2YKJfuxhBmsx9v-OMyxKQjys+J-z_ZqoPJF7q=YrE4Zw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k2uHQ/1oXnALNsqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Anup,

I thought I had already replied here but clearly not, sorry!

On Mon, Jan 09, 2023 at 10:39:08AM +0530, Anup Patel wrote:
> On Thu, Jan 5, 2023 at 4:37 AM Conor Dooley <conor@kernel.org> wrote:
> > On Tue, Jan 03, 2023 at 07:44:01PM +0530, Anup Patel wrote:

> > > +/* AIA CSR bits */
> > > +#define TOPI_IID_SHIFT               16
> > > +#define TOPI_IID_MASK                0xfff

While I think of it, it'd be worth noting that these are generic across
all of topi, mtopi etc. Initially I thought that this mask was wrong as
the topi section says:
	bits 25:16 Interrupt identity (source number)
	bits 7:0 Interrupt priority

> > > +#define TOPI_IPRIO_MASK              0xff
> > > +#define TOPI_IPRIO_BITS              8
> > > +
> > > +#define TOPEI_ID_SHIFT               16
> > > +#define TOPEI_ID_MASK                0x7ff
> > > +#define TOPEI_PRIO_MASK              0x7ff
> > > +
> > > +#define ISELECT_IPRIO0               0x30
> > > +#define ISELECT_IPRIO15              0x3f
> > > +#define ISELECT_MASK         0x1ff
> > > +
> > > +#define HVICTL_VTI           0x40000000
> > > +#define HVICTL_IID           0x0fff0000
> > > +#define HVICTL_IID_SHIFT     16
> > > +#define HVICTL_IPRIOM                0x00000100
> > > +#define HVICTL_IPRIO         0x000000ff
> >
> > Why not name these as masks, like you did for the other masks?
> > Also, the mask/shift defines appear inconsistent. TOPI_IID_MASK is
> > intended to be used post-shift AFAICT, but HVICTL_IID_SHIFT is intended
> > to be used *pre*-shift.
> > Some consistency in naming and function would be great.
>=20
> The following convention is being followed in asm/csr.h for defining
> MASK of any XYZ field in ABC CSR:
> 1. ABC_XYZ : This name is used for MASK which is intended
>    to be used before SHIFT
> 2. ABC_XYZ_MASK: This name is used for MASK which is
>    intended to be used after SHIFT

Which makes sense in theory.

> The existing defines for [M|S]STATUS, HSTATUS, SATP, and xENVCFG
> follows the above convention. The only outlier is HGATPx_VMID_MASK
> define which I will fix in my next KVM RISC-V series.

Yup, it is liable to end up like that.

> I don't see how any of the AIA CSR defines are violating the above
> convention.

What I was advocating for was picking one style and sticking to it.
These copy-paste from docs things are tedious and error prone to review,
and I don't think having multiple styles is helpful.

Tedious as it was, I did check all the numbers though, so in that
respect:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--k2uHQ/1oXnALNsqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8cIAQAKCRB4tDGHoIJi
0qosAQDNLMBZwn0pOgFxNRZ2gQ4mAB4/IDrKT4lV7uJ6FsZKTgD/d5T4U/puI+fm
TEmdCdjhH8752eP4Q65/dDTea9aeXgk=
=HSHv
-----END PGP SIGNATURE-----

--k2uHQ/1oXnALNsqN--
