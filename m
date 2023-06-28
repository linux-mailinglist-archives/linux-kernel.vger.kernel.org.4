Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5554C741766
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjF1RnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjF1RnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:43:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24802123;
        Wed, 28 Jun 2023 10:43:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 471A261374;
        Wed, 28 Jun 2023 17:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EEFC433C0;
        Wed, 28 Jun 2023 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687974200;
        bh=DigUiMepEKZdpHMPnpx95fJpEWDaT/7V9w+BxtVC7MY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VU27FEMGNX7uLNDp3McHl6GNJMB5ErsahJsW4e9nUmvJxj0MpsU25chnCjvQ1uL0K
         4GpFU2m7sSJO+j1nW2wWRD7jXl4G50U5jcGM4AW0e1kiKdQxl4TnLpjaJfVljtaKJN
         bspgesvLD/sPcVRNqAc/ujhS342ec46lPfoHu0OB0DmCnia/xQCQ8wjuDZgpSoCgu7
         1dE0bCEezgL54Vn/yltVu9Aoe9w1DbZhKuMwfw9YcIo3jJGjMTlTKR56gSGbP1c39f
         7RvYs+Dt6s9ZK9vJszZlui9OrDVZkFb+excIzKhfJ1bKnhCnNkMV9rsqJ50malblT6
         QwaXTZrA7hV6w==
Date:   Wed, 28 Jun 2023 18:43:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/9] RISC-V: add single letter extensions to
 riscv_isa_ext
Message-ID: <20230628-gizzard-trading-a5f9785128b5@spud>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-sensuous-clothing-124f7ae0aedf@wendy>
 <CALs-HstDV3PjBk_8WDecwuvVK9rno1CKFzT1+8ohoUXE7X0GwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IEb0IsuCCuZUv+Ab"
Content-Disposition: inline
In-Reply-To: <CALs-HstDV3PjBk_8WDecwuvVK9rno1CKFzT1+8ohoUXE7X0GwA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IEb0IsuCCuZUv+Ab
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 10:33:20AM -0700, Evan Green wrote:
> On Mon, Jun 26, 2023 at 4:21=E2=80=AFAM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > So that riscv_fill_hwcap() can use riscv_isa_ext to probe for single
> > letter extensions, add them to it. riscv_isa_ext_data grows a new
> > member, signifying whether an extension is multi-letter & thus requiring
> > special handling.
> > As a result, what gets spat out in /proc/cpuinfo will become borked, as
> > single letter extensions will be printed as part of the base extensions
> > and while printing from riscv_isa_arr. Take the opportunity to unify the
> > printing of the isa string, using the new member of riscv_isa_ext_data
> > in the process.
> >
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h |  1 +
> >  arch/riscv/kernel/cpu.c        | 36 ++++++----------------
> >  arch/riscv/kernel/cpufeature.c | 56 +++++++++++++++++++++-------------
> >  3 files changed, 46 insertions(+), 47 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index a35bee219dd7..6ad896dc4342 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -77,6 +77,7 @@ unsigned long riscv_get_elf_hwcap(void);
> >  struct riscv_isa_ext_data {
> >         const unsigned int id;
> >         const char *name;
> > +       const bool multi_letter;
>=20
> Instead of defining a new member, could we just infer this by making a
> macro like #define MULTI_LETTER(name) (name[0] && name[1])?

Or don't even try to be clever like this and just call strnlen on the
name & check if it is 1? It's only used in 2 places.

--IEb0IsuCCuZUv+Ab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJxxMwAKCRB4tDGHoIJi
0hp+AP91DhkjewdtfZP1vKzJeISjYAdB7Bdm2bRrgqMPsu3f1AD/VqublU31lGDa
NFdXAaLNImqjgRoRJ3JGTBfpN5735AM=
=udNR
-----END PGP SIGNATURE-----

--IEb0IsuCCuZUv+Ab--
