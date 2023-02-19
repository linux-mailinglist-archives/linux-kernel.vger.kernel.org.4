Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6C669C24D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 21:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjBSUeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 15:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjBSUd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 15:33:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6425FDE;
        Sun, 19 Feb 2023 12:33:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKchf18qCz4x4p;
        Mon, 20 Feb 2023 07:33:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676838834;
        bh=cgJoRCw4OhMkVLdN5V23k7xdwfcxqaQvTriz7X9u774=;
        h=Date:From:To:Cc:Subject:From;
        b=WnRlEvXUWY4FfSBtKowHaAHodPSS6tpZPvX8+X0FKCbZ0lUHfmKloaqCi4fNokIjE
         vXeNoVzL8+aImCvtUeyyZ+ST5mBc4K99F2lkPhouT60p5JIiV9CRZIVYvwxoQeNMbD
         +t7PgLPWDYfTCjcLzOWkIt/3v9ng/PLbZ8i/I/aAEAGskHklM+CmlcOMhTg8THPeAg
         KnjFwqZvPcojOcZ/ONuCouXGGYC8bmnYQ5YRzXlN2PIm+4+in1/1ib5gBs0ziXH1VJ
         G7A7n41Ki4iy6QjLLlv4YOYk4lHvbWWZ4Jv1WY54sT4gQUtSfajBDNBK2Twe7wkMty
         DObaH6LNIHr4g==
Date:   Mon, 20 Feb 2023 07:33:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ext4 tree
Message-ID: <20230220073353.37911f79@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/49OV.WInsDgk/Q3fgIhuLcH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/49OV.WInsDgk/Q3fgIhuLcH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  7fc51f923ea6 ("ext4: remove unnecessary variable initialization")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/49OV.WInsDgk/Q3fgIhuLcH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPyh7EACgkQAVBC80lX
0GzPlwf+J0jmWFr9bMPMURTvCnib3CPYNSLBT3CygN55EbtiLrBz9EHsVu7A1Md/
5JnMVJA48DRDOmINtwiIvi1iDJUZT/m6rYm9DfSw09/YD+iyAZtu+NUiSMf/JEdb
ue1etRh8yYvFYIsT25QyJKbo20qJjpTj4kzRGXfonAwUsO3L1EaWWkcfg7JjhV5r
ZGJhFQzHx5W2dPLADBQKoJyekU0Ll3qsdoGHqUv/0VbtaKztGVVDPX9NTopnC0Dw
41hyW8ZgRWApUDYho7+Cg+dQJmA5SYEKdXG/IaTNac5VbOybT1Q4rXQRuUl2Dq2J
ul+Q3EcRcBtW9MFj+JAS6CglIbs1Bg==
=kk4b
-----END PGP SIGNATURE-----

--Sig_/49OV.WInsDgk/Q3fgIhuLcH--
