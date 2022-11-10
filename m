Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E91D624CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKJVZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJVZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:25:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD34314;
        Thu, 10 Nov 2022 13:25:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N7Zcb30ggz4xTg;
        Fri, 11 Nov 2022 08:25:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668115519;
        bh=1lrZIjDS0eQbvvLZjDGoZN8tvyhs4pnf2ZvQt0EF2y0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QRRhKg0jsJxdpOMeQjzCgockGM13Qjw/FKkEqAicYqS8cWgjIJyFzQ2v0L60Bbz7+
         BBO4eomFVqsr2pbazfpmMStDpKj0J22jeYFpBi55VAOI9BfH40So5YrXqqNCveVjLh
         gmraS0FJcI+0IuJsasxJiBYsTGd4feeDyPuU6JJegoYMznRzcdf9P+cr84pZ7vH5Yx
         3ZxjtT9hUr+aiC/4O5z1I3ReC1DmMVXAjyV3dBO5h4qlzDE8ezveeYgeXTXsCEDkzS
         hC2Q7jQk5A3OXypsGmJQ05lC9BAipS0pkHtRSHYOBxJFPBWpHyUlTE3tYlIrZJtVou
         /+9qcuUiLn4Gg==
Date:   Fri, 11 Nov 2022 08:24:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Boris Burkov <boris@bur.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the btrfs tree
Message-ID: <20221111082455.6319fa88@canb.auug.org.au>
In-Reply-To: <20221107080225.358cc0ee@canb.auug.org.au>
References: <20221107080225.358cc0ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dBqVbvZHIcqe0/lB4yFaMqY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dBqVbvZHIcqe0/lB4yFaMqY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 7 Nov 2022 08:02:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> In commit
>=20
>   5a2644cf1841 ("btrfs: fix improper error handling in btrfs_unlink")

This is now commit c330cff765cc.

> Fixes tag
>=20
>   Fixes: 6a1d44efb9d0 ("btrfs: setup qstr from dentrys using fscrypt help=
er")
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Maybe you meant
>=20
> Fixes: c0916fbc08be ("btrfs: setup qstr from dentrys using fscrypt helper=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/dBqVbvZHIcqe0/lB4yFaMqY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNtbCcACgkQAVBC80lX
0Gyt6Qf/RDLy2KctETSt5T/zRz0Wlqacq1ie3FD+g1l7Z9nOnkfBDfP3oqlbIlAC
LoLzjo6B5sKQeK/SfwB15s4nFpdSZ23qokBs4OZ45O0O/J6lLv1zjIu1MnxaG+7+
RjsxeCkn4UaG/u5HvJ0Yiq/uz31iF7AAdEEP/V9JvSa8py4QoKOQ5J7QyZlAogGo
HvbwyQEzJF/w0aoUIwWEg7f/uyv8+4oSKGBqiHUSw54LQgkD7Fmsol5pyKgSs4gL
Y6qe56/RoJXKuta6PKzuexvb88HqOYwPhQMIgK6YRKe04PoqlCBJ+gOpyN8Mst5J
rQ+ehkrQZQhpTuvSj1XL0ahCYOFNSw==
=VplA
-----END PGP SIGNATURE-----

--Sig_/dBqVbvZHIcqe0/lB4yFaMqY--
