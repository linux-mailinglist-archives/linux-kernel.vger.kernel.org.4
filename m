Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8F362D7AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiKQKEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiKQKES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:04:18 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392F42716C;
        Thu, 17 Nov 2022 02:04:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NCb9S2D7Xz4xG5;
        Thu, 17 Nov 2022 21:04:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668679452;
        bh=zbEQsY4GDz6tCeC6PjX2xpEcn/0Fz5yZoRQ9jnSnI2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WaBIMub9lWHDkD1692UXFEqoHDejVUPLFrA+XlGBCKIfyCEYyOdXUzBmPngGANbTk
         9PLPyUzJytzoH3z8a83EABFJaOjfLrnl9bow6JozwcDLur4TLJNeMDTJbtA0G39CIG
         wbny3s4UpKhOMhZ+UD8rhEcwMk/c3LSRFUvO9v/8sf1+tEc3qy9UwFXUCZHv0wxXRR
         HEU2SqT2JKHvF86DCTBOnQJKdG1usv6++NYU7MWSkUMtPtgIQ4rjKKzz6Ez6vvpWEF
         6Mahmw1d2cDE2UuExhhed8q7MTuhu18oIfZRgY4q0hF9UJ9A0Qn7KS/tan93ZtjcnW
         V6L8rvGldDNmw==
Date:   Thu, 17 Nov 2022 21:04:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ntfs3 tree
Message-ID: <20221117210400.01049e1a@canb.auug.org.au>
In-Reply-To: <20221117085644.52r6gviioifzysqn@wittgenstein>
References: <20221115101756.5d311f25@canb.auug.org.au>
        <20221117085644.52r6gviioifzysqn@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PugsaI/SNJrRAl=IDVd69Zz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PugsaI/SNJrRAl=IDVd69Zz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, 17 Nov 2022 09:56:44 +0100 Christian Brauner <brauner@kernel.org> w=
rote:
>
> or I'll make a note and will let Linus know during the merge window
> about this issue. In the latter case I'd just copy-paste your patch to
> Linus, Stephen?

Or just include a Lore link to my email in your pull request (along
with a short explanation).

--=20
Cheers,
Stephen Rothwell

--Sig_/PugsaI/SNJrRAl=IDVd69Zz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN2BxAACgkQAVBC80lX
0GyyZAf/fooCKBLf72uBvrhjmpAqstuDTAuVbwtYmFA2A6jGZUVOVUjUiAX6UjMH
U/PV3t246XGO3qkX9nzRvE2pkIEszeyBds7TPSW9PUfctJhqBTT0KuZo+ASr+Pfq
VPooyrdfyU7lwW3r0K9IqR1orQcMI39+n/ETAtwDpigLcIuyKxAVIFhIaPVj5crQ
puT+g/JFgTKgLR+s3XmG/KjISqblPkw9wgR4Y/+WBgbpfKVTSOpB3cz+vLv5kpZI
KlrL8S1xfNs6plpiKRodZADbQQ2lwqWlBE0994MYvCejzbkek4OwZl5QPKi8W7z0
IL2jW7+9hDlOiLXYIkqhIbjgvnifZA==
=1HDd
-----END PGP SIGNATURE-----

--Sig_/PugsaI/SNJrRAl=IDVd69Zz--
