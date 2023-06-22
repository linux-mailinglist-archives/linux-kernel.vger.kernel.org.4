Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E9C73A775
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjFVRlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFVRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CC31BE1;
        Thu, 22 Jun 2023 10:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF633618CD;
        Thu, 22 Jun 2023 17:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9155BC433C0;
        Thu, 22 Jun 2023 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687455678;
        bh=YAOh3PltHuv3oiVdQk7pp6PuM5ji7zkTeX46kRr9GsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLLthQNjRf6xNoc1hI5BkPHrZjL1FjjBmrbUNEM7rLK76EaHjMAwPGMaYsnG4NMgH
         XGl317enxqEC0vOWOlZvBoLZsOWU/iRi5WgOywc+9VRbTpGs3AADnq1ioaStdEZULn
         0HAPYCYsBsc9BKf9d6GgyK3cMYVsk880L0Vqq/mBFtHlJj4j77qVUZ7ubZ9nD9jRqt
         QC9TzCb3fGYYmv4/H0GUCLyuQQtuSiS89PSvYT7FG5ZbS1BXGec+ZFc9g3YIBzqiHd
         VgOByMiNMzIjJOht5jGLtLICV6qfbNvt4eVgOOwF1YxZQY77Xp9U3vrZcnz7yWg+s2
         Q5mskb8E5DMfg==
Date:   Thu, 22 Jun 2023 18:41:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v2 2/3] Documentation: riscv: Add early boot document
Message-ID: <20230622-clone-overfed-21ec0886e904@spud>
References: <20230621072234.9900-1-alexghiti@rivosinc.com>
 <20230621072234.9900-2-alexghiti@rivosinc.com>
 <20230621-d6da578719f8af903d6746ef@orel>
 <20230622-4af59422f118ea634836d351@orel>
 <CAHVXubgJQhShbOfaQeOTxM61g_tUnLBxa-0JK+WE+YQRGkYRQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kh9jAV9zzKnGH3pC"
Content-Disposition: inline
In-Reply-To: <CAHVXubgJQhShbOfaQeOTxM61g_tUnLBxa-0JK+WE+YQRGkYRQA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kh9jAV9zzKnGH3pC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 07:32:23PM +0200, Alexandre Ghiti wrote:
> On Thu, Jun 22, 2023 at 7:24=E2=80=AFPM Andrew Jones <ajones@ventanamicro=
=2Ecom> wrote:
> >
> > On Wed, Jun 21, 2023 at 02:19:50PM +0200, Andrew Jones wrote:
> > > On Wed, Jun 21, 2023 at 09:22:33AM +0200, Alexandre Ghiti wrote:
> > ...
> > > > +Hardware description
> > > > +--------------------
> > > > +
> > > > +The firmware can pass either a devicetree or ACPI tables to the RI=
SC-V kernel.
> > > > +
> > > > +The devicetree is either passed directly to the kernel from the pr=
evious stage
> > > > +using the `$a1` register, or when booting with UEFI, it can be pas=
sed using the
> > > > +EFI configuration table.
> > > > +
> > > > +The ACPI tables are passed to the kernel using the EFI configurati=
on table. In
> > > > +this case, a tiny devicetree is still created by the EFI stub. Ple=
ase refer to
> > > > +"EFI stub and devicetree" tree section below for details about thi=
s devicetree.
> > >                              ^ redundant 'tree' here
> > >
> >
> > Can whoever applies this drop this 'tree' I pointed while applying?
>=20
> Yes, sorry: @Conor Dooley give me the overly long lines you wanted me
> to break and I'll send a v3, it won't take much time and I'll fix this
> too!

Look, I said it was pure pedantry on my part, and not something that
helps with understanding. You've been warned!

diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rst
index 019ee818686d..a52793fd9f6c 100644
--- a/Documentation/riscv/boot.rst
+++ b/Documentation/riscv/boot.rst
@@ -143,11 +143,12 @@ be carefully examined.
 Device-tree mapping via fixmap
 ------------------------------
=20
-The RISC-V kernel uses the fixmap region to map the devicetree because the
-devicetree virtual mapping must remain the same between :c:func:`setup_vm`=
 and
-:c:func:`setup_vm_final` calls since the :c:var:`reserved_mem` array is
-initialized with virtual addresses established by :c:func:`setup_vm` and u=
sed
-with the mapping established by :c:func:`setup_vm_final`.
+
+As the :c:var:`reserved_mem` array is initialized with virtual addresses
+established by :c:func:`setup_vm`, and used with the mapping established by
+:c:func:`setup_vm_final`, the RISC-V kernel uses the fixmap region to map =
the
+devicetree. This ensures that the same virtual mapping is used by both
+functions.
=20
 Pre-MMU execution
 -----------------

--kh9jAV9zzKnGH3pC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJSHuQAKCRB4tDGHoIJi
0jsVAQDEXMV48OW7eoZ1+j6mFXAUoK4gEfiDynMorze08Q3uqgEA6tiHd5oOT7Lt
VRIIRuWAwkwl7eEczS4ibrV8mm0sAAo=
=BX7b
-----END PGP SIGNATURE-----

--kh9jAV9zzKnGH3pC--
