Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3FA74663B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGCXqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCXqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:46:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A8913D;
        Mon,  3 Jul 2023 16:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688427987;
        bh=5sQIAEXPS8uxXRdTJEiocGEep0W77KyvKm6PBZhZACw=;
        h=Date:From:To:Cc:Subject:From;
        b=MIsNdSqVTxutDrhZQAc1RPjDxI3zoQIerqsK7HPOeSzcTrC+Bn9BW+CjPkaUvhjpI
         tepfNV4PCzyrn/Yh5vkqKbQ5t6BXZUqEvxpQ/NOfaZe4crQKEukfgnbquRmUvwAtBE
         9xA3hGjIrw3FZwZTyzYcxAwk/TCvaOAjbh18jtEym9P0FIkHImk559o58los2xiEoA
         +gumG6RpU7o6jHEprm0dG99D9n03hDuVpkcfHoN3e96SQNpo37YBDRmfW/3eVdo0QN
         VKTlrwUb/YuNQ6gd/V5BYzJgG25qSePJMdBUXCtbJkcp4GcPv3Mhu5YW26/VSXIYSK
         zOh3Ha3iyddxQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qw2cy1pHTz4wqX;
        Tue,  4 Jul 2023 09:46:25 +1000 (AEST)
Date:   Tue, 4 Jul 2023 09:46:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Olaf Hering <olaf@aepfle.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the jc_docs tree
Message-ID: <20230704094623.161dfdbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zhr3wAdm5+U5tnVM1sg4.F=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zhr3wAdm5+U5tnVM1sg4.F=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c029b8a0c5d0 ("Fix documentation of panic_on_warn")

Fixes tag

  Fixes: 9e3961a0978 ("kernel: add panic_on_warn")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 9e3961a09798 ("kernel: add panic_on_warn")

--=20
Cheers,
Stephen Rothwell

--Sig_/zhr3wAdm5+U5tnVM1sg4.F=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSjXc8ACgkQAVBC80lX
0GwpAgf+OMoUKHhP4zrI2sS0APtkWuUhSMeXmPbViIwyTse/75SeYrlKkQ5zRtIp
c+ULhOzKctxznroEGtCzbrI6oFsUYflT6PTWK9VcJMkxMO9ORjLKxOTMbpFDgAc/
H3839F4AorMqU2OdRNBSVOUczC5EbveZgS34CbNQTpprWaA7/yMmynrDuK5rTv3K
GpfYPEWgHtqaQA6zS1swmWctNNyDV3XXsc06a1Iu6Jwgj+yZhAPaa9Jk+U/ftQX5
6eU+HForLXsT4OuhhkFtln3kHUbtwihzAuKDf9OljsE6WDLdIrfENCoAJ86kyDdd
mZIUuamMI6PHz1LW2oVQqT92JiVnhg==
=fUSx
-----END PGP SIGNATURE-----

--Sig_/zhr3wAdm5+U5tnVM1sg4.F=--
