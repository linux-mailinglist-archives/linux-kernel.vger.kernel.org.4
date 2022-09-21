Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444B65BF66A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIUGcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIUGcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:32:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ED18050B;
        Tue, 20 Sep 2022 23:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D301CB82284;
        Wed, 21 Sep 2022 06:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0844C433D6;
        Wed, 21 Sep 2022 06:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663741935;
        bh=rC4E+19FVQlROChcbwNhPnEipKbJ85MCL4IuRpFzwOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DCX08OfxusX2gqMseGQrdErer7hzwsDaE1J5thbETa2jedwzVjozRsXli1yim7cN+
         dHdllCUxRqIKNIkfXYMxdIlpikvRm6ilL5niBuojwX2g9AYkZeplB9dZjXxhJpzE8h
         r7+UxVFryZpe4crXBEUOZ9wuPkhc3KQFA5hhRGBEAhguEJi62O5d1Uho2RutfMesQb
         /Z/bM4ieVSJK2la2jujblVAM3jBWw5yRiD352MBVK0t/WFdT0Mkj994x1q1TFAVbpL
         FG/MduCrQqH/SWuMuGp+57qBaXZnz5BjByOhJiSTI0wOR/ehzIZA7V7XZdLxBj0+W7
         JNmeY3L2aLfIA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oatHK-0003Sf-0R; Wed, 21 Sep 2022 08:32:14 +0200
Date:   Wed, 21 Sep 2022 08:32:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the usb-serial tree
Message-ID: <Yyqv7rwuy3dedbqI@hovoldconsulting.com>
References: <20220921151109.174cad24@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mMFeO+J6G+9SD2f2"
Content-Disposition: inline
In-Reply-To: <20220921151109.174cad24@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mMFeO+J6G+9SD2f2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 03:11:09PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the tty tree got a conflict in:
>=20
>   drivers/usb/serial/ftdi_sio.c
>=20
> between commit:
>=20
>   a8619505a778 ("USB: serial: ftdi_sio: move driver structure")
>=20
> from the usb-serial tree and commit:
>=20
>   f6d47fe5921a ("usb: serial: Make ->set_termios() old ktermios const")
>=20
> from the tty tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good. Thanks for the heads-up.

Johan

--mMFeO+J6G+9SD2f2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCYyqv5gAKCRALxc3C7H1l
CM9QAQDCjz9Hkb6MIXN/oNp9h2S/r7htSlL5C8tiIAyg5MOyvwD/dMaYY/0Yi+na
fPTEgcLoOpv1gOgWJSWItDmzYlYIyQc=
=5KBK
-----END PGP SIGNATURE-----

--mMFeO+J6G+9SD2f2--
