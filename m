Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C665FFE5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjAFL77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjAFL7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:59:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2402572880;
        Fri,  6 Jan 2023 03:59:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NpMMZ66Jcz4xND;
        Fri,  6 Jan 2023 22:59:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673006378;
        bh=62EzcP7oMrJBoXVCMaWThdfgjS1fbuB2zSpruIcF7vI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S8/WdBuTWleelJBp56FbJ8gQXj1yzszaVD/FnP5qHRJRxXvVFtshNBpnGiM2kXR5Z
         L6DKgmzmtD9grumX8sZQDy2TJCBLRdj0mZmE6sc7w34IwGAgz8SzNApwAUugs2IJIY
         YfttHIKxvTZpBz3BggGJBE8bZBtgyOkvtd9cZEzGY9CKwSjbE3whOUFrhQ0rpuy0NM
         +xFHmCbZeY1+D9fvvc8NcqDrMvFG4iPViaMkk30mc2ke++fCy01fe6f5AtFIflGUcc
         zBkd87P4OMAkdu4MhUfsnTy/IUz8UPGNteBdeBngbpVcABK1uYdReC6ieCK85y9A+q
         kX/7einF4aKhQ==
Date:   Fri, 6 Jan 2023 22:59:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the backlight tree
Message-ID: <20230106225917.118be096@canb.auug.org.au>
In-Reply-To: <Y7fqdX8FPEZW32sM@google.com>
References: <20230106113509.5c101b53@canb.auug.org.au>
        <Y7fo+tMnkSndJNXV@google.com>
        <Y7fqdX8FPEZW32sM@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7iea9Pf6A1m5k.vh+_e0YrA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7iea9Pf6A1m5k.vh+_e0YrA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Fri, 6 Jan 2023 09:31:33 +0000 Lee Jones <lee@kernel.org> wrote:
>
> On Fri, 06 Jan 2023, Lee Jones wrote:
>=20
> What's the branch name that you're tracking?
>=20
> > Don't think so?
> >=20
> > 88603b6dc4194 (HEAD -> refs/heads/backlight-fixes, tag: \
> >   refs/tags/v6.2-rc2, 					\
> >   refs/remotes/mfd/mfd-fixes, 				\
> >   refs/remotes/leds/for-leds-next, 			\
> >   refs/remotes/backlight/backlight-fixes, 		\ =20
>=20
> Ah, wait!  This is the old naming scheme.
>=20
> I assume, despite the message above, you're tracking
> 'for-backlight-fixes', right?

Correct.

--=20
Cheers,
Stephen Rothwell

--Sig_/7iea9Pf6A1m5k.vh+_e0YrA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO4DRUACgkQAVBC80lX
0GymrAgAmsBVUHU/P+s4H2HAO8+vc/VYHfm2QRb8tED695jeozQf1XKWCImB+X58
ryOb/hlIGSnCca4rPeO/l78mW5VJ9NJhtIkBz6OEmdokmGIzP2FXrvDqzaYfQTYO
0oxuV/W/ZiXdtDmenLQcLM7KvyeIApW0mnQrS6cA0I/tUmCQo8nwcseTuRyL9Gap
8lgtEXw7On6CXanWqfcydDzntDHHuI7zxhI29+NUnqIsBSqfE6XCbjaWqnsVPXR/
2CnF3Zsh1v1qmI6kBm9vZfbRmIrqhQwkoA2HoK7rQOcvFZ97VY57DWPGo+Vx2w34
/LtDfmJ4dT8iBemaPV3ehDbXSDAysA==
=qlAE
-----END PGP SIGNATURE-----

--Sig_/7iea9Pf6A1m5k.vh+_e0YrA--
