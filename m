Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7343D73487B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 23:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFRVBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 17:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjFRVBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6A6E50;
        Sun, 18 Jun 2023 14:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC6E5611C8;
        Sun, 18 Jun 2023 21:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB45C433CB;
        Sun, 18 Jun 2023 21:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687122069;
        bh=Hse+n9psD1rH1kydjoFmL354hIuk5keWZXT/XSKjuv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cddKG5oriX68GulMyDRFuVeTO6yZFQVRAZ6FUmOjiQ0/PprKPYeaHt9GzbCgJIJU2
         DbgMuR0QY0ahV4t77jshB8Zmh77Lgi9yzBoelUu7GdnoKC0bS1u2JnYN+VQ6LPmFzl
         TQ4X26NgjfFtbXNfi3AqYwN8xZapcwQ+o2p4q1cAjLJQPtB0ot3sVJYkvJLynhiI/A
         u0Q9ujElYdT10mO1DggVP8Jvwa5PLRu4pyMeNUufUZhjodynydZpiFo9/xkxvqknh3
         D6Rjeo1eZeI6r2eaW8tlLu0zayIkIl7EojRAMVE6ZiGfiT0Sg1/a9MxGuAkhDSgI53
         DF5ktGBwXSOhA==
Date:   Sun, 18 Jun 2023 22:01:03 +0100
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
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, arnd@arndb.de
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <20230618-tameness-crescent-d09ffa8ed4c0@spud>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <20230617-duress-phantom-3da79e33f204@spud>
 <ZI8wEp52bpqaCHAl@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4BQua3J3FibZmDrb"
Content-Disposition: inline
In-Reply-To: <ZI8wEp52bpqaCHAl@xhacker>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4BQua3J3FibZmDrb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 12:25:54AM +0800, Jisheng Zhang wrote:
> On Sat, Jun 17, 2023 at 07:20:43PM +0100, Conor Dooley wrote:

> > Going forward, who is going to pick up the patches and send the PRs to
> > Arnd? I wrote a document that should be in v6.5 about SoC tree
>=20
> Here is what I thought:
> From next development window,=20
>=20
> If we see a heavy development window, IOW, the patches size is big, I
> will take the job of picking up patches and sending out PRs.
>=20
> Once the development calms down, the patches size is trivial, I will
> explictly send request to you by repling the patches to ask your help
> to directly take the patches and send PRs.

The thing with this, is you don't really know in advance if the window
is going to be busy or not - you could end up getting a bunch of trivial
stuff pop up at a later -rc etc. I'd rather patches that ready to be
picked up didn't end up sitting un-applied on the list, until you figure
whether there has been enough to justify a PR or not.
If there is only one or two, you can always send the PR as a series of
patches, rather than creating a tag etc.

> Any comments are appreciated.

Could you please add a git tree to the MAINTAINERS entry & get it added
to linux-next? You should probably add another X: line to the MISC SOC
SUPPORT entry in the same patch.
Also, RISC-V is give-or-take clean for dtbs_check w/ W=3D1, please keep it
that way! I do keep an eye on it in linux-next, so if your tree is added
there, I'll at least see if changes in other parts of the kernel cause
warnings to spring up.

> > submaintainer stuff that is worth reading:
> > https://lore.kernel.org/all/20230606-escapable-stuffed-7ca5033e7741@wen=
dy/
>=20
> The handbook is a wonderful document, thank you!

:)


--4BQua3J3FibZmDrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZI9wjwAKCRB4tDGHoIJi
0to+AQC7PeXMQbpa60L+eHoIhnfjbeoRUu5FuD60MvaJIblEuwD/eulobf1E37MZ
AtxFE4Lte3OJN9CIA8hHrcX2OKG4Rw8=
=wuK+
-----END PGP SIGNATURE-----

--4BQua3J3FibZmDrb--
