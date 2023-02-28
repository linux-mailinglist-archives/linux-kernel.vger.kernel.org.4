Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D496A5F87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjB1TTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjB1TTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:19:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EDE12F11;
        Tue, 28 Feb 2023 11:19:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F342061180;
        Tue, 28 Feb 2023 19:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FAEC433EF;
        Tue, 28 Feb 2023 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677611977;
        bh=fo0jm9LIFRTBLWMyXrRtWlqKUsGki35LZNiy0Ybfk6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/vEXAL6MEcX2zrFrn1ooCXm/U/Qvczx09vMgM+M51u/u6WOmi+A6bhT5b7D6inYF
         MBn9Q68VHUvJxbUZ2QtxMtTgY+YgZ4FD4t2PUQPUp5H++zCRuimzwcbwqNpNbOI0pC
         dU4uIFCCYgCLTGD3JNY2dhgTaXmrDWUMS552KY74nI5wggf8xgHOGLAjcp4FuKcAG2
         gvdmjM4V95xI9eGgfu3ppqxpJwMXPVR4Qh3o/Lc3UdBSfRka0I8hO880mm33eesT5i
         c7z6fAT9VzZ5h61c1E12YjEiUKKC1kvjvv83RjfmrsTIdgAhR8NdAjt5JPX9dApvP0
         n5zbALL3o+Afw==
Date:   Tue, 28 Feb 2023 19:19:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 12/20] clk: microchip: mpfs: remove MODULE_LICENSE in
 non-modules
Message-ID: <Y/5TxBLcTDIdv2eM@spud>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
 <20230228130215.289081-13-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J9YrWK5U4Nxh9aHS"
Content-Disposition: inline
In-Reply-To: <20230228130215.289081-13-nick.alcock@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J9YrWK5U4Nxh9aHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 01:02:07PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>=20
> So remove it in the files in this commit, none of which can be built as
> modules.
>=20
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Conor Dooley <conor.dooley@microchip.com>
> Cc: Daire McNamara <daire.mcnamara@microchip.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-clk@vger.kernel.org
> ---
>  drivers/clk/microchip/clk-mpfs.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk=
-mpfs.c
> index 4f0a19db7ed74..d85b345f4c08d 100644
> --- a/drivers/clk/microchip/clk-mpfs.c
> +++ b/drivers/clk/microchip/clk-mpfs.c
> @@ -513,4 +513,3 @@ MODULE_DESCRIPTION("Microchip PolarFire SoC Clock Dri=
ver");
>  MODULE_AUTHOR("Padmarao Begari <padmarao.begari@microchip.com>");
>  MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
>  MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
> -MODULE_LICENSE("GPL");

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I'll take this via the microchip/at91 clock tree after v6.3-rc1 has been
released.

Thanks,
Conor.


--J9YrWK5U4Nxh9aHS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/5TxAAKCRB4tDGHoIJi
0qRYAP4hAGmSiUtr+YIBtvnpss72NXfOb3W3G/mOzk1iYpD5WwEAqOGVxkikgTDE
dmyRBIRrLaGFnutuZJDaqnQBnAUB6QQ=
=p4yC
-----END PGP SIGNATURE-----

--J9YrWK5U4Nxh9aHS--
