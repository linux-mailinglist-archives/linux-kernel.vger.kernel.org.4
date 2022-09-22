Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4C05E6F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiIVWT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIVWT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:19:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3032BB38
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:19:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYV815Q9pz4xD1;
        Fri, 23 Sep 2022 08:19:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663885185;
        bh=u29mhIvpahCVfLIeUUJ+Q5zVnoirDkHZjYdUJFVs5oQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HdHw5oYkasNYjRn5gszsBXTII8c/u2/5Utd2mwHx7xY7I1qsB9Czqe9dCWLweKvuH
         K+VNnMh4UTIrmsD4N/KIFdojWmy/r6QSGhaSo9JBhEeR5VTcs8mzdjxBpHvernFA9I
         xlk6/9eK69JtHSjWH5DW0Cj27NznwQVBKEVekFdo8QHTblo6HOV6yK6z9H7dNIVs0F
         I+oXihVkBjrl0t9a7dhE1mrTycct7iMxJN/VSjRD27KBryOsesc6Qp7cJFngXtUP4w
         HL1OP4oQNUQl97dYb7f6DPMu6tWhqsc5AyM/iw8pNnR7U3V5pK4u93RiHkum4Gq9Km
         y/8MF0gmNb+TQ==
Date:   Fri, 23 Sep 2022 08:19:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hector Martin <marcan@marcan.st>
Cc:     Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please add asahi-soc to linux-next
Message-ID: <20220923081928.6172c4fa@canb.auug.org.au>
In-Reply-To: <2159b672-4db7-5add-8046-ed5354dd5343@marcan.st>
References: <2159b672-4db7-5add-8046-ed5354dd5343@marcan.st>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YQ7ShGKyHkj//oJBnDgl6P9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YQ7ShGKyHkj//oJBnDgl6P9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Hector,

On Thu, 22 Sep 2022 23:29:29 +0900 Hector Martin <marcan@marcan.st> wrote:
>
> Could you add the asahi-soc trees to linux-next? We are downstream from
> SoC and would benefit from testing in linux-next before I send out PRs.
>=20
> URLs:
> https://github.com/AsahiLinux/linux.git asahi-soc/fixes
> https://github.com/AsahiLinux/linux.git asahi-soc/for-next
>=20
> (Right now we have no fixes, and some DT changes in for-next)

Added from today.  I have just you listed as the contact at the moment,
please let me know if you want any others listed.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/YQ7ShGKyHkj//oJBnDgl6P9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMs33AACgkQAVBC80lX
0GzwtwgAj44qDB1qKHk382gLm8Oyl9RT/nNE3AlJJRQAMTnwMQBqKHznjQGm8P5L
6n413A7xXoRGNeHsyTiVY6j8wxktNvqWvStMYgEGl9njC28og/z3lTivmule2/to
FUWkzvnmZIQ3mVrMTBKwrEa/e42g8LvgOKvVOV+Ou2FsFoSvoyLHC/be4C1Y1Q5Z
BPGUXWmjbUtvlf5rZarALm/YX9lEYhPMwUNVuQ81q1sMb2D2Vb75phRkPiUqGX+O
7RX4WpHFBckbKL0xAVi6wM17fxufJciedcRz313lbSLrENCrFkmRu2yQCf6WyHsJ
ZhJDdnNWCU2HlND22XnidNpUt27w1g==
=ymJI
-----END PGP SIGNATURE-----

--Sig_/YQ7ShGKyHkj//oJBnDgl6P9--
