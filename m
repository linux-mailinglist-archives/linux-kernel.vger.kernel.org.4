Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88046950ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjBMToE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjBMToC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:44:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0438C9752
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:43:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6EE96129A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0AAC433EF;
        Mon, 13 Feb 2023 19:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676317357;
        bh=guXZkW5cd9rxMRD0z8ewEgH9k03dg98yNz1cKBNWipY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dMZmMbhe+Fiha3PJmP+rBKyZPRXcwK9eSq71zoLh6/W/rYZlByKZqPyLjHR0niVpn
         B1wWfNO6kx9sHBmgnARW97QbEikoFBo/04wl4ZqTVB/g+FZ3jhRdwvHlVdnj5CqkkG
         GAMvEIGsORCb8szwjcv5VUzKzI143Y7oh+xXGFDQN28HpgqfXKxyV1kcVPRFBn+4NJ
         cKscnBMvf8gQhC00Vg2eBK/g1RJk68cAMrfSOR5lIHqL9plS4kPF9r07WwrK8nv2pC
         jMrWZIKekzd6/i3cPvRgt8hevNqSwrx3/I7YBbOwW0ZDJTmq2LTH1bkcw5TJyfiMz0
         GzexHuoksiTDQ==
Date:   Mon, 13 Feb 2023 19:42:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/3] clk: k210: remove an implicit 64-bit division
Message-ID: <Y+qSqHDhcFZNqOMg@spud>
References: <20230212205506.1992714-1-Mr.Bossman075@gmail.com>
 <20230212205506.1992714-2-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ydD/mnLxnoLWogXe"
Content-Disposition: inline
In-Reply-To: <20230212205506.1992714-2-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ydD/mnLxnoLWogXe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2023 at 03:55:04PM -0500, Jesse Taube wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> The K210 clock driver depends on SOC_CANAAN, which is only selectable
> when !MMU on RISC-V. !MMU is not possible on 32-bit yet, but patches
> have been sent for its enabling. The kernel test robot reported this
> implicit 64-bit division there.
>=20
> Replace the implicit division with an explicit one.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-riscv/202301201538.zNlqgE4L-lkp@intel=
=2Ecom/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

btw, you'll need to run get_maintainer.pl on this patch so that the k210
and clock maintainers are CCed.

It's also worth adding Damien Le Moal <damien.lemoal@wdc.com>

> ---
>  drivers/clk/clk-k210.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
> index 67a7cb3503c3..4eed667eddaf 100644
> --- a/drivers/clk/clk-k210.c
> +++ b/drivers/clk/clk-k210.c
> @@ -495,7 +495,7 @@ static unsigned long k210_pll_get_rate(struct clk_hw =
*hw,
>  	f =3D FIELD_GET(K210_PLL_CLKF, reg) + 1;
>  	od =3D FIELD_GET(K210_PLL_CLKOD, reg) + 1;
> =20
> -	return (u64)parent_rate * f / (r * od);
> +	return div_u64((u64)parent_rate * f, r * od);
>  }
> =20
>  static const struct clk_ops k210_pll_ops =3D {
> --=20
> 2.39.0
>=20

--ydD/mnLxnoLWogXe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+qSqAAKCRB4tDGHoIJi
0rTyAQC5cOGbbN+5i2RQw624EEXHxdskW6y+HKXlZl7Fs/EqigEAgv0xBo1B/SIy
xsSbgqfgyutZNCHM9/+mcAF8KQpn2Aw=
=sh6D
-----END PGP SIGNATURE-----

--ydD/mnLxnoLWogXe--
