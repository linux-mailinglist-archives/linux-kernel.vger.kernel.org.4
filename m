Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3774D716E96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjE3UXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjE3UXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:23:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A073F7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 13:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE73962A33
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581A6C433EF;
        Tue, 30 May 2023 20:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685478179;
        bh=4DN+utQWh38lU/aZ6R0seCQUmXbUMKSQnd7XfU2PdBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNT5Aoq3zxhrXOaYVXhGMDLVtwHCvTOzsTW0ypZB6kAVw7iLdTToHxM8bU2jg69+y
         oIegGjzECGgRDYouWDmaa8ILaVM86EJgxsig8N+1y/p48kjte5LUzXfTwoLqreO7cw
         4nv4Fn2LzzAboQN6t1GTPWJZHUoCRp1ySQF9a48qy3Bd7daj5Gn3bMLpF+5lW6nhbs
         txu+OnlJw2v3Sk5XhuEmAjM4IaF31uwmqvpSwayudVkRrmVDTyzYKoi8Wg+WkSsOea
         vNablcbJ4rwzMIl1RWSHlWZYvNs7XXxkXffTzDMKn3ty26puoZqn74fBrK9qgfyUz0
         pzVQCGbEx3UAg==
Date:   Tue, 30 May 2023 21:22:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Message-ID: <20230530-atrocious-control-bcb37de558fc@spud>
References: <20230528-darkness-grandly-6cb9e014391d@spud>
 <cf0d2d2a-c407-7b3d-a5ab-ea5c19e7b890@ghiti.fr>
 <20230528-uneatable-earpiece-3f8673548863@spud>
 <b71dc2f5-fdc0-2a8d-e1f9-696cd9a1529e@ghiti.fr>
 <20230529-skillet-quarters-3fbc3b6edb3a@spud>
 <41e57bb9-ce0c-7772-abeb-5c01d5ec19bb@ghiti.fr>
 <20230530-polka-trifle-7ccd7a093099@wendy>
 <92d4aaa8-a1ed-74e1-3a22-df9be1ca1e4a@ghiti.fr>
 <20230530-hatchery-unifier-64d7a2ffe0d0@spud>
 <CAHVXubgG31moSNOe3fRqFzUSJK9tRWKH1KPP_BO7wRNC4WzxTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Axts1iAZiGz20SHU"
Content-Disposition: inline
In-Reply-To: <CAHVXubgG31moSNOe3fRqFzUSJK9tRWKH1KPP_BO7wRNC4WzxTQ@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Axts1iAZiGz20SHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 08:04:17PM +0200, Alexandre Ghiti wrote:
>=20
> Ahah, I think we found the culprit!
>=20
> With CONFIG_RELOCATABLE, vmlinux is actually stripped from all the
> relocations (so that it can be shipped) and vmlinux.relocs is what you
> should use instead, since it is just a copy of vmlinux before the
> removal of the relocations!

That probably makes us both eejits for not realising sooner...

Tested-by: Conor Dooley <conor.dooley@microchip.com> # booted on nezha & un=
matched

Thanks for your patience here Alex.

--Axts1iAZiGz20SHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHZbHgAKCRB4tDGHoIJi
0jaVAP9PHoU5a5+zRhdA/FBl5TFJ8x8d2o/6P5u3gk9yQsxuzAD/dLh6VZFvWFlO
ETHZVpo1mS3y+rIvKBc3kHQ3cOpwGwY=
=uZdZ
-----END PGP SIGNATURE-----

--Axts1iAZiGz20SHU--
