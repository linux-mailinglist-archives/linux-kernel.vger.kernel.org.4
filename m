Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A476FB5DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjEHRXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjEHRXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D9B49EA;
        Mon,  8 May 2023 10:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D04361F43;
        Mon,  8 May 2023 17:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBD8C433EF;
        Mon,  8 May 2023 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683566631;
        bh=o/W/upx1oxojt1pe4iM5As9FLK8IM26SwU7IdjNmdic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vavk1aH4LhGTgSh9NkidLrV8NHrkBidhBM6Hidv08ZSmSvHsALg6+qSJIGuAZtCA+
         z2xbjNHytvlsPBf3kP5dh+ytxtT+FL3EA4bCVAa/8R2KrkCOt/Sk5hT9/BSZO0Ggiu
         NsnM7UCw+UMMpvY/6Di2BpgcUy2FGjMxHWaPmK3VxxAkumIzwknPgPrzNPF7xZNwmQ
         CkY07sWgc8xgjrO3e81I2WSgYfUxGHEEcyn6aBFNOIU/fClvvdxLJvagBOr+7PNvL/
         0Mbu7vnY82GaJsettzFO4ybqJ+gRThiIqtAJBuHJQrI/ZMVZZQ3JqUbD53yVgyZecc
         l+9/BknBT/rlw==
Date:   Mon, 8 May 2023 18:23:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 5/5] MAINTAINERS: add entry for T-HEAD RISC-V SoC
Message-ID: <20230508-problem-repulsive-939edfdf7663@spud>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-6-jszhang@kernel.org>
 <20230507-woof-eldercare-f1323b10bde6@spud>
 <ZFkgsHGvEIxGDxXv@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dSqjxm9sPfcjRPhf"
Content-Disposition: inline
In-Reply-To: <ZFkgsHGvEIxGDxXv@xhacker>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dSqjxm9sPfcjRPhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 12:17:52AM +0800, Jisheng Zhang wrote:
> On Sun, May 07, 2023 at 10:21:26PM +0100, Conor Dooley wrote:
> > Hey Jisheng,
>=20
> Hi Conor,
>=20
> >=20
> > On Mon, May 08, 2023 at 02:23:04AM +0800, Jisheng Zhang wrote:
> > > I would like to temporarily maintain the T-HEAD RISC-V SoC support.
> >=20
> > What does "temporarily" mean?
>=20
> I got a Lichee Pi 4A board, and want to mainline its support. Sending
> the new dts patches needs to touch MAINTAINERS entry, so I added it.
> But I expected an experienced people from T-HEAD, with many
> kernel contribuitions in the past, will take the maintainership
> finally, for example, Ren Guo. He knew this SoC better than me.

I see. I don't mind applying the patches for the platform for now, it's
not too much more on top of the other vendors that I am doing as things
are still low enough volume, as long as someone is willing to review
them as they come in.

Cheers,
Conor.

--dSqjxm9sPfcjRPhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFkwIgAKCRB4tDGHoIJi
0tkSAP9xd/XjooRGUlzzIUbh3gmKoz4mYhqIJ9UqthFrEHzv0gEAygtJ+Nsi4GLZ
kgnge/Y+sUV+cRzazxPcssoUADlu7gE=
=L9rr
-----END PGP SIGNATURE-----

--dSqjxm9sPfcjRPhf--
