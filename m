Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D53669D78F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 01:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjBUAiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 19:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBUAiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 19:38:06 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4882B1A66E;
        Mon, 20 Feb 2023 16:38:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLL3p1wXTz4x5Y;
        Tue, 21 Feb 2023 11:37:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676939879;
        bh=QX95mNs6AN6MzzcgAlZPFNwlBk/BZogsodbivydXhwg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gFRbkvEVGCfIxG+xZKH+ZB/9B0jac4WBC25J1mXvJSPNIDFf9FPrSn8dCao/8DKYz
         9UaC5gOqS8hxCiKMQR6y19xZjBXA2ZAKKIha5xXWgB+DA/5mxMpB/aY7QYnNQK2opw
         kEOvbsb30tLlhlIWJi0u6nDbKh29em3sX5/xiOxJTE2hynh+OlHTbvLIrc5LN3d7Iv
         TF5BWMeg/BQitVv27HuhyTM1jgmgbl5a5UI4GpzmrQRLUeUhtFusLoVa1WkbJu4R4M
         d8Bj8AYWoKDi/CWan6iUojCJEJr74XAz9e5uU9j8M1sL2ros+iwtqqEBFqnjPjywym
         /gJ4HhZygdZsw==
Date:   Tue, 21 Feb 2023 11:37:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, CIFS <linux-cifs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: Re: linux-next: manual merge of the block tree with the cifs tree
Message-ID: <20230221113756.70d8359d@canb.auug.org.au>
In-Reply-To: <20230220114201.11659a37@canb.auug.org.au>
References: <20230220114201.11659a37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fy8D4pPgIXHBnSsyX8crdzs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fy8D4pPgIXHBnSsyX8crdzs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Feb 2023 11:42:01 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the block tree got conflicts in:
>=20
>   fs/cifs/fscache.c
>=20
> between commit:
>=20
>   8378eea2e41f ("cifs: Change the I/O paths to use an iterator rather tha=
n a page list")
>=20
> from the cifs tree and commit:
>=20
>   220ae4a5c2ba ("cifs: use bvec_set_page to initialize bvecs")
>=20
> from the block tree.
>=20
> I fixed it up (the former removed the code updated by the latter in
> fscache_fallback_write_pages(), so I did that) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the cifs tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/fy8D4pPgIXHBnSsyX8crdzs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0EmQACgkQAVBC80lX
0GyDIwf/Xip1mEeAqVAFcrWPbjbhQxvVghW75hVROTzI8y8SUrKizoMN4IyXjfrQ
lPwPWBLVoGoUEe4ISp9IYl6rfIHqH5cQ6YBfu5J1KKcBiJv5UM0zkX8Hgd3ldk0j
Ha/TLs32vJGxE38cQGVeXZvie+T50oPusG53znSkyxZihU+PRVRBXJp8aoHFFH4a
OC8rP1m6GWz866NKcfEwe1eDr5bKqwA5yS6FHTEsrZj2gNfXjU77oYk5v9OecNMW
EGDP8MekHndwG1f1LAz4O7mZ8OF6uWokVwbArkbmpnDvkOfjlWGSueL0LjpUxEPL
9zhzSR83kXudi+PMO/ortXRQ9MA+rA==
=PZKe
-----END PGP SIGNATURE-----

--Sig_/fy8D4pPgIXHBnSsyX8crdzs--
