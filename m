Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D375F98B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJJG4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiJJG4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:56:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D4C402F2;
        Sun,  9 Oct 2022 23:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E809AB80E28;
        Mon, 10 Oct 2022 06:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34325C433D6;
        Mon, 10 Oct 2022 06:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665384978;
        bh=VdleptVGuv3PW/ghHSzmcLYdC8vBkvJlLRU0XfCTzGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZAOPs4KnoCG6ZCPx5drtWFkKt0AHJrxtjhGvX4Vj0MPeePUk+6a7WlVr97Blvyrj
         FNFrMbO8eRY2e0BkMn2vvgspxVhc23Z1z9pxitwpa5PZZGXA8DYvu9PE18zDzqDyxL
         gOuRylL2A9zSdZxdQsYTsMUjkvzYaeS9JQfDF/hWDvWPX666oFBKVDtFZU/FFfvSM7
         HJ1AoI7y8/cLtqf0YzCKBj+qIePuvl/WB0nlEIhzA798Hada2I7Sqxe89FpQxjHyWN
         t72w7cDAmK2SwMjAvnXyBd5txm2bK15faT+pLqt61Cm6J48g7tEoPZb38mW2uFY42Q
         toApLbM52n8uA==
Date:   Mon, 10 Oct 2022 08:56:15 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] clk: renesas: r9a07g043: Drop WDT2 clock and reset entry
Message-ID: <Y0PCD3/nTTZ15m6V@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221009231253.15592-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qD3/D4ZOaXrpcOIe"
Content-Disposition: inline
In-Reply-To: <20221009231253.15592-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qD3/D4ZOaXrpcOIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2022 at 12:12:53AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> WDT2 clock and reset entries.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--qD3/D4ZOaXrpcOIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNDwg8ACgkQFA3kzBSg
KbYgIBAAsfQ+dz9htNx5HMXKuHQQsSO7MnjWuGgIt45LbiUsN6XKQbvw0hsSRx/Y
cbT/0aKKg3qGZOSLkEeKbIV3MywPDefK3cHJXtsqFxAxcgIWIlN8v3JK7WxgRMS7
Ue+rE2sIIE2JpPiE2MMk2oSHqy5n+C4VAhsomrQBWW3UiMf+DqTp+T7V+zCiuwwS
g2wTOXkjd08ssl8n+WR7BLfvF93POieNa6zjgHFaILkTmF9A7D9/37JukD57c5wK
UloBpwSygklbCfJE318vkTO7xDY7ixLqWhvnmRfY0+3+eG4QAcM2R4a9w05dCCyB
VV0uPLpFAyKCbvL9+u3gwZG6XDQxzKD/m2Kdh+6dDbH6qsWyiA4j+5ee12/OG1ZG
iMSAgsdqsTkyrIOzVXcXNdH4B5T2ntPfc9UkDedr46IC+wU1OW0Q8S4jLhMRAr+t
7QBzX1xbV9ZRTVCH4Vl8GSPesEfxjW2QIxSE52eLTB6ihyYixBoOoeZk2WQbunsy
wtwwjVsqPpb+wEyZYeI2XvP03SzfT1bOg4C5Up5SJOQ6vMz4cVJOxJ/6wbbM9FFI
vUGEp/tEKQ7Sx1KiboxW0EegXwscI7HgxjKSIk/xTwODexbFZ1T5gL1Zt4N3i+4I
x20u4LH4NsCxelRs/eINELBjtEwwS323NuWYaeIyABWqs8xHnv8=
=ICiQ
-----END PGP SIGNATURE-----

--qD3/D4ZOaXrpcOIe--
