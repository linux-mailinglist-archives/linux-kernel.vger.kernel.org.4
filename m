Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C856C993B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 03:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjC0BDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 21:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjC0BDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 21:03:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04904EDA;
        Sun, 26 Mar 2023 18:03:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PlF1v36yFz4x1d;
        Mon, 27 Mar 2023 12:03:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679879027;
        bh=rjvvSQxNUbkGv/mmqNTjfbTBiQ/JATdCBz2+Fh6CbVI=;
        h=Date:From:To:Cc:Subject:From;
        b=M7+b2b/IljFSKSFai00vlt0dBjDmv5eTFpZgr/XhHL23Y2tkE8WShdffKMsC/p1zA
         0nNn5645+SF+X/mmqzeIooGQAZQayesj4SxSEgnzqGRvVpXY+tY/yaPkSjUq1LWYaV
         yPmrhBw0vgowKVfEgxsw/fkSXN+63Ozg648N67Q+m4+JUNOUgSDqAACZRUAZzrsDsR
         9mW0z4ROY8d+RHm1tzGl6JsmtKTC1u7E2d9X8hbEFelBI0EB+gDaZ/FwbIRClVAeQz
         w/bMfHPWOvQXe4VuzJ1RJyv2DVNqTc6gpKJQsONnghUvrQY1vVhqrpCZBgPt1Ey4qG
         UDNfHhqSsUb4g==
Date:   Mon, 27 Mar 2023 12:03:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the driver-core tree
Message-ID: <20230327120346.0a357f86@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.VFUs96y4N6xJA8ifu8eBoW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.VFUs96y4N6xJA8ifu8eBoW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (htmldocs)
produced this warning:

drivers/base/class.c:237: warning: Excess function parameter 'key' descript=
ion in 'class_create'

Introduced by commit

  dcfbb67e48a2 ("driver core: class: use lock_class_key already present in =
struct subsys_private")

--=20
Cheers,
Stephen Rothwell

--Sig_/.VFUs96y4N6xJA8ifu8eBoW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQg63IACgkQAVBC80lX
0GwJqggAknvZ0fmd34/osEQSn4lju5E4UOiiR6dSoMWXY232D17CnHoYaDVnYQAl
lW0r0el0rEMUlC9nWwMB0nWHiJ2u9y8VDwEnzSmDYaiZHXzqLa5JXq1rF/0uddjQ
o+CMsF0VBTFFLo0zj2yu4j9Q9Su+Lpg9AzOEEwfe6meQ8ueRkjwyueGU4FqA21kB
ztcR9FeFtJ1Q3ElbeTlc2YxdnjsFmxZMxzwd4kWaxa2DblSlo/jgfLoP0kNIoXcA
hKFzFtaBGuHxyut7OyRLeqF5cUtWs3Ir0XSfGQs0MvdAesJm1W7bZt6LVv611deV
f/WqVzwZZ2eueHFWoFWgIxNVQyECTQ==
=SON/
-----END PGP SIGNATURE-----

--Sig_/.VFUs96y4N6xJA8ifu8eBoW--
