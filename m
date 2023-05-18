Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4467708660
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjERRGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjERRGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9AE121;
        Thu, 18 May 2023 10:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AAFA64557;
        Thu, 18 May 2023 17:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2548DC433D2;
        Thu, 18 May 2023 17:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684429590;
        bh=XL8Q8LxpeG+xUSW+d2Fhz16+YABT67r3plx3O+Y35ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYDwNwjeRfNEkfoyIRyJq3Fohsc3ZIt3WbvX+OQ++ceTWjibgZ24NbiSU4vfGEufv
         E7/MG8tjVbYn8mfTzAqH4bsSYhCAPy4wioXysSz9c9jyKzRIwkWR4YFCfxF+QkoWHa
         SjilsAYEF5gzcKD+jg9x90stMTD6SLJsxPxhPjJZW0StGE3IfSLuaGFwHOy8eBK4OM
         i59muo8WKsAEN4/0QTZOrGqA5Hx1JqDnrSJpknH+axhqo4xWAcFso0ezUz0FDXuSnL
         xP1/Z3FypEnI8MGE/wgMHsOmzfJ6SUoZ43dLzibDtQNclaBobAMq0a6Jey31YekcNb
         7Uu1mISU27XeQ==
Date:   Thu, 18 May 2023 18:06:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, anup@brainfault.org,
        ajones@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        apatel@ventanamicro.com, atishp@atishpatra.org, jrtc27@jrtc27.com,
        rick@andestech.com, ycliang@andestech.com,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230518-elective-mossy-1bf147f5e9b8@spud>
References: <20230518-hammock-doornail-478e8ea8e6a7@wendy>
 <mhng-95b99ff5-9024-4672-bb84-7599f7a05129@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TKxZvzqyNscVPD5H"
Content-Disposition: inline
In-Reply-To: <mhng-95b99ff5-9024-4672-bb84-7599f7a05129@palmer-ri-x1c9>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TKxZvzqyNscVPD5H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 07:41:17AM -0700, Palmer Dabbelt wrote:
> On Thu, 18 May 2023 07:06:17 PDT (-0700), Conor Dooley wrote:
> > On Thu, May 18, 2023 at 07:13:15PM +0530, Anup Patel wrote:
> > > On Thu, May 18, 2023 at 4:02=E2=80=AFPM Andrew Jones <ajones@ventanam=
icro.com> wrote:
> > > > On Thu, May 18, 2023 at 09:58:30AM +0100, Conor Dooley wrote:

> > > One downside of this new approach is it will increase the size of DTB.
> > > Imaging 50 such DT properties in 46 CPU DT nodes.
> >=20
> > I should do a comparison between 50 extensions in riscv,isa and doing
> > this 50 times and see what the sizes are.
>=20
> I'm not sure how sensitive people are to DT size (presumably it'd be DTB
> size)?
>=20
> It's also not clear what we can do about it: RISC-V has lots of extension=
s,
> that's going to take encoding space.  Sticking with an ambiguous encoding
> because it's smaller seems like a way to get burned in the long run.

I did actually go an look at this. I cheated a little and renamed the
properties to "riscv,isa-ext-foo", which is about as communicative IMO
as the longer name I currently have, but may seem more agreeable to the
size conscious.
I added 30 cpu nodes to mpfs.dtsi, each with 100 extensions of 6 chars
long. With just the string, containing "rv64imafdc_zabcde_...", it was
unreadable, but "only" took up 46k.
I then removed the multiletter extensions from riscv,isa & switched to
riscv,isa-base & 100 booleans. IMO it was more readable (although still
quite bad!), but took up 62k.
Removing all of the boolean properties, leaving me with 30 addtional harts
with "rv64imafdc" only, was 26k.

I think the generic limit for dtb files is 2 MiB? To me the size
increase doesn't sound like a bit problem.

--TKxZvzqyNscVPD5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGZbEAAKCRB4tDGHoIJi
0s2UAQC3dbtneTDqOvEpuMHz7vzTT/qCO/nEAhYVxRjH0MasoQD+IWeuh0pZj7Y/
NPtfbaq3ryBkiGdWFoAC2ls1S9xcNAo=
=0mwD
-----END PGP SIGNATURE-----

--TKxZvzqyNscVPD5H--
