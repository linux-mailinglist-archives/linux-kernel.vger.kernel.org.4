Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DCD5F98B4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJJG4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJJG4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:56:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FE631EFE;
        Sun,  9 Oct 2022 23:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB8B8B80E4A;
        Mon, 10 Oct 2022 06:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0C6C433C1;
        Mon, 10 Oct 2022 06:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665384966;
        bh=WNtvqkW4/8yEfg7rBtuWxdx0EP/TSxOJxN2UJno+J3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KDeRvW+zxXs7FdtnZ730nm98lWyasDiqfDHtBXEK8VHiHmJxCnugxAHCkCrNb0efx
         +NE9XuYs3Wv3CZnOEVbh05gtfJQWPRXu6ec5rtPTm3RR644F06SvUX7s1koTE7LRwE
         //H70izUNhOtanTNvyA658XvHX8dJP3TmL2+cxXa+D8YZU0wXcnewmosNRy3r+BbML
         OvmtwE4wH/xzkVzlFjZgKmzjBq7EIRYfNzsfzPkO6nQfAJ6EmyudlUA5+NPInsbe+x
         e2ekLR5+bxXbyU7wNzIaa48aTQtNrvHl/tkphrKMRlAKEyQXdgyNZM0lKfG2B701DX
         L8Diy3r9CYCGg==
Date:   Mon, 10 Oct 2022 08:56:03 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] clk: renesas: r9a07g044: Drop WDT2 clock and reset entry
Message-ID: <Y0PCAycTLsGuPmFF@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221009231013.14791-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lE1zZbkiwZu2Rchj"
Content-Disposition: inline
In-Reply-To: <20221009231013.14791-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lE1zZbkiwZu2Rchj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2022 at 12:10:13AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> WDT2 clock and reset entries.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--lE1zZbkiwZu2Rchj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNDwgIACgkQFA3kzBSg
KbZC5w//Qgn3NDSQ2sF5vIel+hJz+8H8tl+zWkGe88NCjssNkyCNJEVuroKcgcD7
Tz5c9aYfLU4rWXM6kx4RUNXD7ShH6nsIjCrZ5wZ5uk9+KzQX43/vWzsEVainhtNY
FKX25jM2tHKBbJz9Y9L75amx/RhuXOl+Znzh4A+tso+K7P/ByJQ6nPqWIpHg5x2k
r0K4XbqNPp4leaYV7xyRYn4Ib61eyd7PWDXeCnTnB0/TGHFa3zpY2J9iBiwQNgru
wR0rOg69DIiV9G/aZ9Uwg9/2OWlafThPI8H3Gi6J7gbCxoY3/9keKGcvU/5jCV71
54PDP+dzMvXVxEk9JiC15KXnUOoCVquFNIU8O2Hh8tA+HtLgBh9q50+4haCQ2Xue
d4AJcqJkK2cOSH/egEn7IS1ip4gpS23ID/e7ZJQl5Ts0m8AAIWyvYJfUM1pm0wNp
xQEmERN5aLMCzQtFOMRab+NrcOdYFsUWPp09Ta+HEjNv5sZmHSxJk9fKk9qd8KgV
WwOwMG1+qqBUiEAB0ixZbVxgwahsbXkF/LPdlZpFj3JAB5j1wrjpy5dTCic7cnIQ
zMogVw5DIs6/X8G3ajBbDn6Ol7UBc0gCgs+6Z+K7AjtczqHSkScAzjBhRNXw/MfX
q3vNLP/NnNncI/8E96RIZ4Q0BNOe3WX/vMESXX2CHb805TuzZ84=
=iHAn
-----END PGP SIGNATURE-----

--lE1zZbkiwZu2Rchj--
