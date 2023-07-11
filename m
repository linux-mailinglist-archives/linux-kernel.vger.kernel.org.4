Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEB874F808
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjGKS3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjGKS3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:29:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C7EE74;
        Tue, 11 Jul 2023 11:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD4DD614C6;
        Tue, 11 Jul 2023 18:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7316C433C7;
        Tue, 11 Jul 2023 18:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689100150;
        bh=4WHgf4NH3QhoBoMxrjIbPFE8U3So6T1/ORPBCNz8mSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSt8zgsy1qxDAeeFc8lsgbkWcmZPOWoXyP2xM1kV9XdSJXv+O2Lj4a1D4nR9sAPd6
         WBp4EX3vLY2g56P9I+UleRLL66kmymXo2FCwNVoIfjqgW6QE59eg65G6Ci+RlyvT6u
         gvtiQ9O3X2uyTNY/XaF6mSVlWBE0/yWOHcoS3dVC+nxR93UerGkJcXXuF1Cm1mNamp
         1gfZ1loriSzwd88AhVnvnhYOnA0bA4YHWwVnD8hsF3fKxv+vS3nsPQ8JcqCLu28FZ5
         pn1g3COnbfGlFQjjp7NDPidt1iF0BK2G8dcL3Ue/fOSvTSuY/0mmZbIkw2TFr8RMhj
         Z2C0CxKiXuQ7g==
Date:   Tue, 11 Jul 2023 19:29:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Ortiz <sameo@rivosinc.com>
Cc:     Rob Herring <robh@kernel.org>,
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
Message-ID: <20230711-deceiving-pulverize-6d167ba904cd@spud>
References: <20230709115549.2666557-1-sameo@rivosinc.com>
 <20230709115549.2666557-3-sameo@rivosinc.com>
 <20230710151624.GA1987602-robh@kernel.org>
 <20230710-education-evolution-f12520405842@spud>
 <ZK2RN7EKqmW87tyQ@vermeer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YcnOMAWI/8l3k2Bk"
Content-Disposition: inline
In-Reply-To: <ZK2RN7EKqmW87tyQ@vermeer>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YcnOMAWI/8l3k2Bk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 07:28:23PM +0200, Samuel Ortiz wrote:
> On Mon, Jul 10, 2023 at 04:42:42PM +0100, Conor Dooley wrote:
> > On Mon, Jul 10, 2023 at 09:16:24AM -0600, Rob Herring wrote:
> > > On Sun, Jul 09, 2023 at 01:55:44PM +0200, Samuel Ortiz wrote:
> > > > The RISC-V cryptography extensions define a set of instructions, CSR
> > > > definitions, architectural interfaces and also extension shorthands=
 for
> > > > running scalar and vector based cryptography operations on RISC-V
> > > > systems.
> > > >=20
> > > > This documents all the dt-bindings for the scalar cryptography
> > > > extensions, including the Zk, Zkn and Zks shorthands.
> > > >=20
> > > > Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> > > > ---
> > > >  .../devicetree/bindings/riscv/extensions.yaml | 82 +++++++++++++++=
++++
> > > >  1 file changed, 82 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yam=
l b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > index cc1f546fdbdc..361756978da1 100644
> > > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > @@ -190,6 +190,24 @@ properties:
> > > >              instructions as ratified at commit 6d33919 ("Merge pul=
l request #158
> > > >              from hirooih/clmul-fix-loop-end-condition") of riscv-b=
itmanip.
> > > > =20
> > > > +        - const: zbkb
> > > > +          description: |
> > >=20
> > > Don't need '|' if no formatting to preserve.
> >=20
> > The existing binding only adds the `|` where the commit message contains
> > a #, please drop the `|`s if you end up re-submitting. Otherwise,
>=20
> I think the `|` is needed because the messages contains a `:`? This is
> the case as the messages in this patch have a "Zvk:..." string.
> Removing the `|` makes dt_binding_check fail because of that.

Right you are. Please keep them so!

--YcnOMAWI/8l3k2Bk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK2fcAAKCRB4tDGHoIJi
0sA9AP9PT0XjbJmH26JVrXZ4zmZU6HqrgHX70VBPn0ThkaXXMwEAg8UsAr1Jm2ZB
aAgTSGrrXOlUT1di0+5Mgxs4ijOGogI=
=XdIy
-----END PGP SIGNATURE-----

--YcnOMAWI/8l3k2Bk--
