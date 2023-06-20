Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27EF7374EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjFTTMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjFTTMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:12:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE01710;
        Tue, 20 Jun 2023 12:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A62C461425;
        Tue, 20 Jun 2023 19:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD004C433C0;
        Tue, 20 Jun 2023 19:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687288338;
        bh=p33ijndQSVtv65AQdpZat7WhUOH6QV7DhiNvd7275KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCIOu4Avb+PtU3yJeQdrr/0sBgklzIZflCGJfh/gDvIJznjZwDuGtPcdg7p9hGxsm
         yXWoLRVI5GJNmkDe9eKugxcvd6sm+l25zgVkUiCFUR7Pg1UBIDTKaGk1WZaEhorH4R
         Ds7HK5tBsez7B7KmzyzBCEu9SEIbjWWGEZ9GWiqV1uULP4bmmz+Ei3czntKl4T/wg9
         dqcsB6fV2sXIMHt9hyjZel3DMJyN48bC56BRdVJL8oHBTtx/FAl/b46+dOh2a9frm3
         eEip7tjdISSaW7T3G943fXZApeNVSCJX2dVNYvUMThuQ6VprpTfy5wPfSLzzZ35BgD
         0NXZeyHaeC63A==
Date:   Tue, 20 Jun 2023 20:12:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     heiko@sntech.de, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        heiko.stuebner@vrull.eu
Subject: Re: [PATCH v5 1/4] RISC-V: add Zbc extension detection
Message-ID: <20230620-thorn-trowel-9a4a7c387efd@spud>
References: <20230612-unstable-tilt-1835f84363b1@spud>
 <mhng-919a6ed5-c8b0-4311-9a8f-8c204b81a8e0@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6YNTO7wDjk54mE4/"
Content-Disposition: inline
In-Reply-To: <mhng-919a6ed5-c8b0-4311-9a8f-8c204b81a8e0@palmer-ri-x1c9a>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6YNTO7wDjk54mE4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 12:09:28PM -0700, Palmer Dabbelt wrote:
> On Mon, 12 Jun 2023 14:31:14 PDT (-0700), Conor Dooley wrote:
> > Hey Heiko,
> >=20
> > On Mon, Jun 12, 2023 at 11:04:39PM +0200, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > >=20
> > > Add handling for Zbc extension.
> > >=20
> > > Zbc provides instruction for carry-less multiplication.
> > >=20
> > > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > ---
> > >  arch/riscv/Kconfig             | 22 ++++++++++++++++++++++
> > >  arch/riscv/include/asm/hwcap.h |  1 +
> > >  arch/riscv/kernel/cpu.c        |  1 +
> > >  arch/riscv/kernel/cpufeature.c |  1 +
> > >  4 files changed, 25 insertions(+)
> >=20
> > Plumbing into the hwprobe stuff would be nice, but that's not a
> > requirement for getting stuff merged :)
>=20
> IIRC we talked about this on IRC, but IMO we shouldn't require something =
be
> user visible for it to be merged in the kernel.

Yup, I asked you before replying since I wasn't sure what the "rules"
were about hwprobe since it is so new.

--6YNTO7wDjk54mE4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJH6DQAKCRB4tDGHoIJi
0h0vAQCWQwf3bFexQuFDT5Cl8ZPPJPGLTj247/m2BBGvms994AEAnT5NIlru1zY9
cMEGtgKjm1d/nmRI+L78jlV7Wg0EoQI=
=Mb5h
-----END PGP SIGNATURE-----

--6YNTO7wDjk54mE4/--
