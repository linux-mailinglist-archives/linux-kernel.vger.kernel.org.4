Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62EE651040
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiLSQXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiLSQXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:23:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E063A2BF;
        Mon, 19 Dec 2022 08:22:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64EA3B80EDC;
        Mon, 19 Dec 2022 16:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97458C433D2;
        Mon, 19 Dec 2022 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671466976;
        bh=AP7So4vFX8TXSzeR4auXo5dAvhGr1KjNOTVhu/9sCEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oamcbvikShoZe+LabtlC0VsHGm6bzhr/TxE0TnD1Q/7LxL+ZTr/Mump8QwJ+jUjBJ
         Y8v9fBNnh9iwMnqpFkS9MrbHkX+mUyAf/ZZZ/JF3ofToeKbOSGl/XXv75BZ+6t5C1K
         nKCXohA9y+AbLpj+yfSZWax8OlEEG8BbLv2Vna7fZKPEFdYGy3MAq6APYO9pNsf15Y
         Z2f8506iv+qg3QSD+nYbrQQ9MKHhqZ0e6zdYs3tQ3RXfM8Oih4txWTmGpl+7LfcPEh
         f+OdxNtY/fackoBHoj7GEBmmizJDMFJmAZRVGTzYpvBbwc+YaVmaoDCT2xhQLT8ASn
         4scxP6PFMhvDw==
Date:   Mon, 19 Dec 2022 16:22:49 +0000
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 1/6] riscv: asm: alternative-macros: Introduce
 ALTERNATIVE_3() macro
Message-ID: <Y6CP2VhKUPZixQ8r@spud>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y543kM4070CSDtZi@spud>
 <CA+V-a8ss0idLDoc+J8-Undqd+DUGrpeytenzSxV8xMs2N3dh1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kqnHAilnmtzrgK7g"
Content-Disposition: inline
In-Reply-To: <CA+V-a8ss0idLDoc+J8-Undqd+DUGrpeytenzSxV8xMs2N3dh1g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kqnHAilnmtzrgK7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 19, 2022 at 11:15:17AM +0000, Lad, Prabhakar wrote:
> > On Mon, Dec 12, 2022 at 11:55:00AM +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Introduce ALTERNATIVE_3() macro.
> > >
> > > A vendor wants to replace an old_content, but another vendor has used
> > > ALTERNATIVE_2() to patch its customized content at the same location.
> > > In this case, this vendor can use macro ALTERNATIVE_3() and then replace
> > > ALTERNATIVE_2() with ALTERNATIVE_3() to append its customized content.
> > >
> > > While at it update comment above ALTERNATIVE_2() macro and make it generic
> > > so that the comment holds good for any new addition of ALTERNATIVE_X()
> > > macros.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > > + *
> > > + * Usage:
> > > + *   ALTERNATIVE_x(old_content,
> > > + *      new_content1, vendor_id1, errata_id1, CONFIG_k1,
> > > + *      new_content2, vendor_id2, errata_id2, CONFIG_k2,
> > > + *      ...
> > > + *      new_contentx, vendor_idx, errata_idx, CONFIG_kx)
> > >   */
> > >  #define ALTERNATIVE_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,              \
> > >                                  new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)         \
> > >       _ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,    \
> > >                                       new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)
> > >
> > > +#define ALTERNATIVE_3(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,              \
> > > +                                new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2,         \
> > > +                                new_content_3, vendor_id_3, errata_id_3, CONFIG_k_3)         \
> > > +       _ALTERNATIVE_CFG_3(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,  \
> > > +                                       new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2,  \
> > > +                                       new_content_3, vendor_id_3, errata_id_3, CONFIG_k_3)
> >
> > btw, why is this indented with spaces when the line above it is indented
> > with tabs? (At least, that is how it appears in mutt).
> >
> I'll update it with spaces.

The file uses tabs, so it'd be switching the spaces you added with tabs,
right?

--kqnHAilnmtzrgK7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6CP2AAKCRB4tDGHoIJi
0qYJAP9z2qR+D518JddxaVh4saksLN5VBZkCC4Q+XUHzt9P+owEAuU1gIeb1wFlg
6cbJwCN63kPV3dyn8vIDqGfyF7bUvQA=
=z9Dl
-----END PGP SIGNATURE-----

--kqnHAilnmtzrgK7g--
