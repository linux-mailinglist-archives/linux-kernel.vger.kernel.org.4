Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B039574DA19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjGJPmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjGJPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B794AD1;
        Mon, 10 Jul 2023 08:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F5EB61093;
        Mon, 10 Jul 2023 15:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38172C433C8;
        Mon, 10 Jul 2023 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689003768;
        bh=MLkm2Efg9j8j0AApJz1dQVqV7X1VG6QWOQOfrXe3kPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rFxOpWlaPaIK0ysrxL/QJL3Cqc/8xF85GhTcg22mRqejW5TCuPF9WZ9NSiD+ZhsdD
         jxP/uNptaTdppw5S2SGXnP+Y550EvEtY5ni7onUZCzgKlO2XiPUoS0hVKKS7wzqTJA
         X6fw61TqMATPuETdMDLFTtjrjNe/12iyqRy7lNws4T9+G2W+vTmGDOFVB91q3II2NQ
         Ir3IWmune9kQPQi4ZBekP+UCEB69dEia2CiNNXsYNrFil7VrUQyW32pjmKuUekbD+D
         rrQZaCsPaDzdlRHEg3X5gUu2M2y8yCYbnmc3EhAFuT5NvL+2muKa6OoBkQE1W1z07Q
         zVjdp0Dj9zcRw==
Date:   Mon, 10 Jul 2023 16:42:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Samuel Ortiz <sameo@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: riscv: Document the 1.0 scalar
 cryptography extensions
Message-ID: <20230710-education-evolution-f12520405842@spud>
References: <20230709115549.2666557-1-sameo@rivosinc.com>
 <20230709115549.2666557-3-sameo@rivosinc.com>
 <20230710151624.GA1987602-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="33PrQJ5t6h82PbWt"
Content-Disposition: inline
In-Reply-To: <20230710151624.GA1987602-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--33PrQJ5t6h82PbWt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 09:16:24AM -0600, Rob Herring wrote:
> On Sun, Jul 09, 2023 at 01:55:44PM +0200, Samuel Ortiz wrote:
> > The RISC-V cryptography extensions define a set of instructions, CSR
> > definitions, architectural interfaces and also extension shorthands for
> > running scalar and vector based cryptography operations on RISC-V
> > systems.
> >=20
> > This documents all the dt-bindings for the scalar cryptography
> > extensions, including the Zk, Zkn and Zks shorthands.
> >=20
> > Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> > ---
> >  .../devicetree/bindings/riscv/extensions.yaml | 82 +++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/=
Documentation/devicetree/bindings/riscv/extensions.yaml
> > index cc1f546fdbdc..361756978da1 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -190,6 +190,24 @@ properties:
> >              instructions as ratified at commit 6d33919 ("Merge pull re=
quest #158
> >              from hirooih/clmul-fix-loop-end-condition") of riscv-bitma=
nip.
> > =20
> > +        - const: zbkb
> > +          description: |
>=20
> Don't need '|' if no formatting to preserve.

The existing binding only adds the `|` where the commit message contains
a #, please drop the `|`s if you end up re-submitting. Otherwise,

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--33PrQJ5t6h82PbWt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKwm8gAKCRB4tDGHoIJi
0lmVAP0dsukr8M+O+PT302/sFjsPmEzuEd8tDVvPqj1YwfVzkAD/SjAtHUhGT5OR
ns6O+iOSrmQmy4IV1qDjUf2BJD/wCgo=
=tIFO
-----END PGP SIGNATURE-----

--33PrQJ5t6h82PbWt--
