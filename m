Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A890B6685B4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjALVn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjALVnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:43:22 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE9540848;
        Thu, 12 Jan 2023 13:35:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtHsh2CDdz4wgv;
        Fri, 13 Jan 2023 08:35:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673559352;
        bh=h9+22KpQUgk+fmMmKhLnxTPopyo2uqEp+Z0nNWCidwk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SWsg01nhDQ8N8D4I2td/vOlj6hZyO+XKH4DSzqIm6NCa3HGatecVlydqOPEFTwCdT
         MX3a4C9MB8KAe2BjLOi7ww5ADadl6/wYMgCHiU2Pe/vdeHXFwzHkt1ct88YDFwvXQn
         V3nrTVCzyX8KMoMjaN2iV0fG9ZGzKEkpnTMapcsfPYAcZHJRz/cV8SAC+A6R2xykhr
         EOaUmW3Yc/AMuMjkOXsJVDHXxLLA0iWeW18lbPX4wL9xM0+p5UDfRkeqhcEnNH9eA+
         1CZkqMe+r0v561CfMQcnYkfIAw6u823soKI2M10LbErstjR2S6DRzzadOB7U5Lpoup
         j8vLf0VPv+zrg==
Date:   Fri, 13 Jan 2023 08:35:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the spi-fixes tree
Message-ID: <20230113083551.733844b2@canb.auug.org.au>
In-Reply-To: <20230106093252.333e715c@canb.auug.org.au>
References: <20230106093252.333e715c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PI8Cez87To3cx+gv_TXXb_4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PI8Cez87To3cx+gv_TXXb_4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 6 Jan 2023 09:32:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> The following commit is also in the sound-asoc-fixes tree as a different
> commit (but the same patch):
>=20
>   b24cded8c065 ("spi: mediatek: Enable irq before the spi registration")

That commit is now in Linus' tree, but the same patch also appears as commi=
t=20

  b1e9c223736b ("spi: mediatek: Enable irq before the spi registration")

in the sound-asoc-fixes, sound-asoc and sound-current trees.

--=20
Cheers,
Stephen Rothwell

--Sig_/PI8Cez87To3cx+gv_TXXb_4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPAfTcACgkQAVBC80lX
0GwGMgf/cuiFNYpb2Pw7p/V86BocqwoJ+m+5NYkxSZsKyocfNUuL5WvJ7G9YixZ8
QfUXTZlfhHOcnsWt/OCv7mmd+zrN3S5bcJonQEsSuaggfTLZCuay46eJUXESUGi2
2YEMBqejR6gfOG0uPiS08ydjHajQ//n4m9OswtkNX5jBL/5747BLebjP90/BpND1
mTPEB9y7bf2FFb0QXwhKvlWLkSmy3nexSeAeTFX6AUrZEtuYa1/0iqe63SZ4lNPF
MoOTyvog4MAU9ziD2dDKLCMhGZ+5TumuJlLeWGVC0Poq/j29J0UvPyQiXO7QGuHP
71q+Uz5Q2C1rWBRmQXLdKBWnufXiow==
=4AZ8
-----END PGP SIGNATURE-----

--Sig_/PI8Cez87To3cx+gv_TXXb_4--
