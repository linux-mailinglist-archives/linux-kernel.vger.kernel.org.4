Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7807448B9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 13:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGAL0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 07:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGALZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 07:25:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419E33C07;
        Sat,  1 Jul 2023 04:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B024860B50;
        Sat,  1 Jul 2023 11:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544AAC433C7;
        Sat,  1 Jul 2023 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688210757;
        bh=+x6m0cvYRRqSFpoP4GprjYx6gT0lhtmBKoDo81qBycI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FBK724BgCd2zXxc/AehUnet8tsxSUevHDljuSP6RqlyOah1mwVAsBIgpd4gl9LohU
         V/FgZq6n7w8DqXsKF+gY/tw3kIOVJvas5IlP8luOeBh5FkgoydwsQZdeZZcrT8PqJX
         qE4NOatGq0h9Mz5AixVFslEWhf/mOeM4Nda+UQs4V+8PPVq9bmDZwhrmz04k/XQNTA
         FtBnebK7EKccBOEbw0/JkkqhYQcJwpopOdJlRKRXuF1mAz3qHIN8S6Yblssf1Aamdl
         QiVOCVwE0bNK3E9ePX/vwKS0IPA88ZU3hshWQaNQljdYzkjakCKWmy7pgKY4/EzqIf
         NK88rPFtI+kQA==
Date:   Sat, 1 Jul 2023 12:25:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     palmer@dabbelt.com, Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        Oleksii <oleksii.kurochko@gmail.com>,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230701-pencil-predefine-3f8a2bc2b889@spud>
References: <20230630-very-greedless-16522d7b7830@spud>
 <20230701-b348653e432924f090c513db@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+9VGfXQGZ6FfDNJx"
Content-Disposition: inline
In-Reply-To: <20230701-b348653e432924f090c513db@orel>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+9VGfXQGZ6FfDNJx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 01, 2023 at 01:01:40PM +0200, Andrew Jones wrote:
> On Fri, Jun 30, 2023 at 07:04:04PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> ...
> > +oneOf:
> > +  - required:
> > +      - riscv,isa
> > +  - required:
> > +      - riscv,isa-base
> > +
>=20
> I guess this means a DT must have either isa or isa-base, but not both.
> What should QEMU and other platforms which want to provide DTs that work
> for older kernels, but also start using the new schema do? I'd guess
> they'd like to provide both, where they'd expect isa-base to be used by
> newer kernels and isa by the old.

Sure, is just s/oneOf/anyOf/.

--+9VGfXQGZ6FfDNJx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKANPgAKCRB4tDGHoIJi
0kSxAP0c3x3Cd0SVAM/6s3YkdDjlEZuy4M3AWjQUW+T9v+oGOQD/ZF2BeCgQo9tN
OlycxibdtZ5wGfZzEsJ7zuE42+qwNAE=
=iqnd
-----END PGP SIGNATURE-----

--+9VGfXQGZ6FfDNJx--
