Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C017E69D799
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 01:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjBUAju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 19:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjBUAjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 19:39:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FEE1ADDE;
        Mon, 20 Feb 2023 16:39:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLL5q4jGgz4x5Y;
        Tue, 21 Feb 2023 11:39:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676939984;
        bh=a7w2e6KHGnEX0MRAjsRNMueYhsFOVGl0qcjlqUf7nPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l7+YQW6C6+9wWL1f8YNvMhVzvR/MiPL8Rd6GcgjmFIYpdoaUNpWiHjr28fgVfcrYk
         OsT2d1QcQm+HPOpiqxW+vehhNr3ohBI7KtBYpUwXCVL19j6Bzq8DAq47rFUZyFNYI2
         sBcq+kzhHmtwf0IVfimNGs/2sHfZYqaUih8pwiCVYrn+vKyZVqWvIyOzAF2jmaXVRs
         P1H74Zug1u51zppuxpr0YWB/q+TvFDgmxtGR0WDtg7xaM/NmnkJJEEdSB1iPjUifb6
         au+g+bCgJ+PMQMIkoU0YUesHvVvd81kMc6S4TLeA/IekaYbjFewGA9Ym7wfFZTWnxn
         TNfUmIx/TPPXQ==
Date:   Tue, 21 Feb 2023 11:39:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, CIFS <linux-cifs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: Re: linux-next: manual merge of the block tree with the cifs tree
Message-ID: <20230221113942.0d0ca13c@canb.auug.org.au>
In-Reply-To: <20230220115056.22751cf6@canb.auug.org.au>
References: <20230220115056.22751cf6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7GsqgIcHxyht7J.Uk0ahOQ/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7GsqgIcHxyht7J.Uk0ahOQ/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Feb 2023 11:50:56 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the block tree got a conflict in:
>=20
>   fs/cifs/smb2ops.c
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
> I fixed it up (the former removed the code updated by the latter) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

This is now a conflict between the cifs tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/7GsqgIcHxyht7J.Uk0ahOQ/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0Es4ACgkQAVBC80lX
0GzhPwf/Yr3e8y170nPtPoDvXjhBDBnvKFM2VpCdOuYx1kYXAYH5o6FayM2oyheh
gShDCt/+Davsc5wd0Vd9t82lrxZCIvDWnAmEtznnot8h59icP53bgWXA+u/YWxcO
ZOrTkF28/EvxYvskh6OWJHEqFmYLhCg+EagB7tYbkBq4VrFP/gOhSTh+/q//8oAj
vKGJuLvAQxQthjQHBW6pXMpvHMWjg6YYN+RZPCzCrPeCcHP4olbgjkoUtvJffvju
TQjb0arsdRP+UxkR0sydeJxU+Mcm0zBRMB+9TzBmtjMMHvcMpMhJ1PkUUDnh9+Sk
Gmit9AinQTYOprDON7DvQW00bX62Fw==
=mF5X
-----END PGP SIGNATURE-----

--Sig_/7GsqgIcHxyht7J.Uk0ahOQ/--
