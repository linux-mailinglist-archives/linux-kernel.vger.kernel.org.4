Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471A7660668
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjAFSek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjAFSeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:34:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A757681E;
        Fri,  6 Jan 2023 10:34:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD1C8B81D2C;
        Fri,  6 Jan 2023 18:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DDDC433EF;
        Fri,  6 Jan 2023 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673030074;
        bh=xUK6wFT5FrlRcYni9bL/QHrma1cq3ZCJnoLrZkFOSEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HOlC/44C5Wfsj9Ch/Lfipm3DaGgzoLjVjlOXApkWBpHFtdNdzO5eJ7TG/SI5pyOa+
         lZhvZVXZ6gBiuMGZ4hMMJJ1pqUp1wl7PBeeKahDiFkCuHObn7TZSc9Qts1MAfbKdsl
         mzjPJ0LwRNaZIYhZgnPlKfkGaC0OyJWzQGbd00eMrwET6Dx8uKvVX5pFh7T+5j/4YX
         67CP+QIymgJkVLlTUbLHHhQqyEmMQPSVgH4EBcMeEgD/IgH7PbiEHjEnLk0FfI0nxU
         HnVbf3LPMOPZhPgb0OGbqKR4iJAg9FDMuIoJprZRwABSCIkMudJ+6adPBgpO5Rx/7/
         1uvmZRJ0SJtgg==
Date:   Fri, 6 Jan 2023 18:34:29 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>, jrtc27@jrtc27.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, heiko@sntech.de, ajones@ventanamicro.com,
        guoren@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] riscv,isa fixups
Message-ID: <Y7hptVmrXBFvJhpU@spud>
References: <20221205174459.60195-1-conor@kernel.org>
 <mhng-e3f1a8a9-2d89-4331-bb8a-b798af0cb277@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HpGX6SdyBnCEs+UY"
Content-Disposition: inline
In-Reply-To: <mhng-e3f1a8a9-2d89-4331-bb8a-b798af0cb277@palmer-ri-x1c9>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HpGX6SdyBnCEs+UY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2023 at 10:27:48AM -0800, Palmer Dabbelt wrote:
> On Mon, 05 Dec 2022 09:44:58 PST (-0800), Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > I noticed ~today~ while looking at the isa manual that I had not
> > accounted for another couple of edge cases with my regex. As before, I
> > think attempting to validate the canonical order for multiletter stuff
> > makes no sense - but we should totally try to avoid false-positives for
> > combinations that are known to be valid.
> >=20
> > All I've changed for v2 was collecting tags & adding in the missing
> > commit reference that Heiko pointed out.
> >=20
> > v3 fixes an issue Jess spotted - it's *any* multi-letter extension that
> > can come immediately after the single-letter ones, not just ones
> > starting with Z.
> >=20
> > @Palmer, either you can take this once the DT folks have ACKed it if you
> > like, or I will take onto some v6.2-rcN fixes branch. I don't think that
> > there is any urgency :)
>=20
> Sorry I missed these.
>=20
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> We can just do a shared tag if you have stuff that depends on them?  That=
'll
> let me keep fixes clean, as I'm running the DT stuff too now.  Though may=
be
> it doesn't matter so much because I'm not really taking any DT stuff.

Nah, shared tag is not needed.
Noone's got a DT with multiletter stuff that needs to be merged yet.
Feel free to take on on fixes or for-next.

Thanks,
Conor.


--HpGX6SdyBnCEs+UY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7hptQAKCRB4tDGHoIJi
0lFIAP4lpEDhJ5iqVhHMmhiuWGm87Fbm0XcS70lDrNpJaRzFRAD/apKxgkNHopV+
VQm2J89Mck/lUSzvelR/XOc0N1B5sg0=
=ewER
-----END PGP SIGNATURE-----

--HpGX6SdyBnCEs+UY--
