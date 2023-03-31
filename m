Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29086D293E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjCaUQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjCaUP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:15:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C9B2220D;
        Fri, 31 Mar 2023 13:15:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E21C62BB4;
        Fri, 31 Mar 2023 20:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44293C433EF;
        Fri, 31 Mar 2023 20:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680293753;
        bh=16dwsgZWYBPEcC5Mo0pKMFJte2h3ZbqjXpx66wj21YA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tukh8HKpkIKrGnzD7GGfO5MBqpoaQ94utwny7C0Hv4uqcjdYsFR0z6rZPGeDBkhkg
         UwBnGYapRWzEQTpmeQK6vxn6mahEdbz+h0kGVRKpRKCzKtH9izPGLQ8BrIZx9nNy4a
         oa5nxeK7E3RiDg5FtX5u734NQKO0m9EX2XM2RRZbNCbWEGxe6Jkm1A6nHN0fCrCLAt
         Fa3hwloajB0ybTUimh06xCDoXuRDrJU5CJF+nRpsbAZaTQNPmA6SrZot7MALuqW4+6
         eYmxF0KHLzrpRETlghwGq8GNwE+UWox/oX6+nQ3n0XsIaChqIoLVpZSissV2T5s9Ww
         JdnlG/vn8JZlg==
Date:   Fri, 31 Mar 2023 21:15:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        uwu@icenowy.me
Subject: Re: [PATCH v7 0/6] RISC-V non-coherent function pointer based CMO +
 non-coherent DMA support for AX45MP
Message-ID: <0d5590e4-e78b-4197-bf17-9de54466470d@spud>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <b2dcda17-5850-47c1-94bc-4ca87f900581@spud>
 <CA+V-a8s+=OY6CX4XTUwyAE9b=rdJZZfgAaY2nU+6aqnu=X9nxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r7DYywVukqmnzbkh"
Content-Disposition: inline
In-Reply-To: <CA+V-a8s+=OY6CX4XTUwyAE9b=rdJZZfgAaY2nU+6aqnu=X9nxQ@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r7DYywVukqmnzbkh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2023 at 08:09:16PM +0000, Lad, Prabhakar wrote:
> Hi Conor,
>=20
> On Fri, Mar 31, 2023 at 7:05=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Thu, Mar 30, 2023 at 09:42:11PM +0100, Prabhakar wrote:
> >
> > > - This series requires testing on Cores with zicbom and T-Head SoCs
> >
> > I don't actually know if there are Zicbom parts, may need to test that
> > on QEMU.
> > I had to revert unrelated content to boot, but my D1 NFS setup seems to
> > work fine with these changes, so where it is relevant:
> > Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on =
D1
> >
> Thank you for testing this. By any chance did you compare the performance?

No, just tyre kicking. Icenowy had some benchmark for it IIRC, I think
mining some coin or w/e. +CC them.

--r7DYywVukqmnzbkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCc/cgAKCRB4tDGHoIJi
0qcNAQCb/JCLCWAyFRm/yAdbNFnCLXnc2InpcdffRHVHLrmn2QD9HXRaoIyBKy8C
+GZGUxjBua3BKi4ILC22+PF1eF7MvAk=
=W6KH
-----END PGP SIGNATURE-----

--r7DYywVukqmnzbkh--
