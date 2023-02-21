Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17F469E9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBUWKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBUWKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:10:35 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0420E28211;
        Tue, 21 Feb 2023 14:10:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLtl66YCxz4x7W;
        Wed, 22 Feb 2023 09:10:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677017429;
        bh=rbzUezoKL+O5ze/PyNqriucJP5pW3zPZvxSRxz8p7PI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pnC4G4iOsM1nd5pnpkDeNHmIR91OBiMx/YJeZO3Q2Qvoe82DRhG0yKeNvtOwcf4yq
         vRXQEBITSAfU61zUd52DLEte/3uIRivzfwjzCzCyoztQUE9cxk/btuymzFnd5Aok3P
         iAFiT6BfC7whzMTeck2buNr6Je02ManqvVo6aU6kbsbZHqPvXBSDuSMeoE1cbPbuW7
         VbeXq9+ZJGqPiVuGnX4O/f9gHp06jspqd9vEkF/Zb+pEYu+rI308pq1RIP443S3Xds
         EJtmNwfGf7pLUt2Obp8hOyalvBqvAOV5A1gA4/e6zGNt9l1LrqCzcL0xCSgd2vQM3c
         WTJGOzJP2AyXA==
Date:   Wed, 22 Feb 2023 09:10:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the input tree with the arm-soc
 tree
Message-ID: <20230222091026.4b440e8e@canb.auug.org.au>
In-Reply-To: <20230112103928.25976ad3@canb.auug.org.au>
References: <20230112103928.25976ad3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M58CvMjFft_fklt4xY0ziuB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M58CvMjFft_fklt4xY0ziuB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 12 Jan 2023 10:39:28 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the input tree got a conflict in:
>=20
>   drivers/input/touchscreen/ucb1400_ts.c
>=20
> between commit:
>=20
>   481ac55a74c9 ("mfd: remove ucb1400 support")
>=20
> from the arm-soc tree and commit:
>=20
>   2cfa7c9c55d8 ("Input: ucb1400_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS()=
 and pm_sleep_ptr()")
>=20
> from the input tree.
>=20
> I fixed it up (I removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the input-current tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/M58CvMjFft_fklt4xY0ziuB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP1QVIACgkQAVBC80lX
0Gz5vAf/e65oHJz4k5s00bev2fjK3D1Jrh7UlxxW1NP7W5R8YU8ToVLg6srWm2Cj
7dtgFlqeyBJIIyTpuO41TOKz4SL2x71KA/l9NzpDxNoBDe72hF5zMdI28Twa18PQ
tWyEYZLOBtxnM5+a3V0lTv/3z4VVtx9Gyrq23n07RwBEXfjXYKr2OkOc483e6dOa
297PMXFq3fkeZAF+5N+rKHgD0hbjvRkKDcMrUoafqFcKljQTnwvFCOxL4v5/qriS
HCnHmwuJShInb979Ed0AsNfdWpwLY9pj/oFfGaHIAT1k2doAyVajXoczW+HUQ9pX
/dKm+VdQ2rZKNFKzbf3TufdVdkFPxw==
=LHxu
-----END PGP SIGNATURE-----

--Sig_/M58CvMjFft_fklt4xY0ziuB--
