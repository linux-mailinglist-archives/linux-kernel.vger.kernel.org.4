Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19B86A11B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBWVLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBWVLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:11:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8990619F;
        Thu, 23 Feb 2023 13:10:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PN5KH32b0z4x1T;
        Fri, 24 Feb 2023 08:10:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677186643;
        bh=0eChOWpGUNS2J+XhqSPEYxziEpsuWjFu1T24LMRwRoQ=;
        h=Date:From:To:Cc:Subject:From;
        b=NncRq+8bvAgbh0Kgf9RqCO03KJrL8+yEfcQwUvRxwPK4mK32zrVJtfD3yUcpsMtqN
         63eJtfL67duNQ5/i9315VoJTuqhg3GbKTX1EiuLLdjue6yFTWRsLL3ehbk5l2IMoPF
         OsG7gcL9AGJ32A+LLg1WlN7HM/IsQHzj0PxhT3ufXWH5IviCVXXIYZYCY7dQYYJbFr
         ulkbXTqSGymsIi/3/TjNUgIarhOVeQKrXTP+v/hk8J06iosayfAQM85rSjKvzb5/gh
         P+yEmkIDeOujpqsv34NQIlh47EmMiewEo6YnLbeeqlXwfr7/+fZGwWG98ezDlxoBIv
         xeJsZfFtFDleg==
Date:   Fri, 24 Feb 2023 08:10:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20230224081042.36fa0f2f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8/0ivESdw8cIBMEI3jpHPwT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8/0ivESdw8cIBMEI3jpHPwT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  23b7e4141de5 ("cifs: reuse cifs_match_ipaddr for comparison of dstaddr to=
o")
  c9334cd0edaf ("cifs: match even the scope id for ipv6 addresses")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/8/0ivESdw8cIBMEI3jpHPwT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP31lIACgkQAVBC80lX
0GwYUQf9FB+IedYCbi7TcZmzULtnhg9k0vtxXiNtcjBzEc64S9QF284HkJLsLEO7
MPSm5gy9ctkMaq2srIVrkw7XwpUzMhhpV0C4AyJDM9B494LjET39UaqSIFT9rmL/
aknzOISrl6bW1XN7k7UvQiwP8N1D6+Kcdif+DHHqYEIBs72aXRZIGY4/we5DxVuC
mbTottf5MXXV9hfm8CEc5liy+M0BadoxNOrLFd5qtq1EzSwfI40wntYbnnxmk5Js
5bqtYSFdWk25F9ie6CsKz+GBArTxd9100IY8nh9FhEtDNIx3RW+XafP8gMz9bRXT
4Z7/BmnfZxkKQVxhAmTJJAt0SpgqcA==
=ezdL
-----END PGP SIGNATURE-----

--Sig_/8/0ivESdw8cIBMEI3jpHPwT--
