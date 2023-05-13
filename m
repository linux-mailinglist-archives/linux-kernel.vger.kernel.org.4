Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1DB7019AC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjEMUff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEMUfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:35:34 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4FF2D40;
        Sat, 13 May 2023 13:35:33 -0700 (PDT)
Received: from [213.219.167.32] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1pxvxd-0008Pk-Gz; Sat, 13 May 2023 22:35:25 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1pxvxd-007dgZ-03;
        Sat, 13 May 2023 22:35:25 +0200
Date:   Sat, 13 May 2023 22:35:24 +0200
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH v2 0/2] perf doc improvements to man page reproducibility
Message-ID: <ZF/0jJkAOXxzGAMc@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3NraPDKjMzW1VfwZ"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 213.219.167.32
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3NraPDKjMzW1VfwZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I previously sent a patch in 2016(!) to make the dates in man pages
reproducible, with KBUILD_BUILD_TIMESTAMP specifiying the date.  That
patch partly overlaps with commit d586ac10ce56 "perf docs: Allow man
page date to be specified", which implemented generation of dates
based on commit timestamps.

However, both of those implementations were specific to the original
asciidoc's DocBook backend and had no effect on asciidoctor's direct
man page generation.

This series builds on the current definition of perf_date, adding
support for asciidoctor and the KBUILD_BUILD_TIMESTAMP variable.

Ben.

Ben Hutchings (2):
  perf doc: Define man page date when using asciidoctor
  perf doc: Add support for KBUILD_BUILD_TIMESTAMP

 tools/perf/Documentation/Makefile | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)


--3NraPDKjMzW1VfwZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmRf9IcACgkQ57/I7JWG
EQkXhA/+NC0hKNh65HLxO2pw8jYqTv2z+hnTyqWYDeMX8pcibHJgDJpo0ovkvXvT
D6sa7wlxtFxQogTqmJkpVFOvH3xaUBtFGq1P9kiwr+TVcJE8X5hE8uPBv5F4jShl
uEaSmHG3GVR+7qIwX/+0QVyth5fFdd2vmIjS8SQWpxULvCKxCHeslmwSqMwAoxpx
Ql3Ei2IKh+04NfhR2/OJy62o5VFFOoESBlKcQcLYe0L4jKj2mIXn31j3Iy3cJhf5
yzsgJk3H6uYMCIz14WRqtsX109yTJB6zMcYn1PZnEE6ZjTE7jbLqI/Yj4jPNaDH5
IKMxCgH0XcDzMzIz5wR+dr9/+ZOzNQYLraXhLr/xyJ9JJsJtAg/ozD32mvh893Iy
OjTO4cQdgIDpodwPu1ZqWgc+PjH9rbt6OUBoicIOgIttgw1cRct1NNQIikZK5ThB
PtwkaEV1scUux+1ABI23o/iJOwwMrcFP1ZN5MZ6OhStyTfow04PcF3eOuqQZyfoC
pj0VUPN03efhbmzLTmgMxnhHspVnPjVZJADZ8vuZx23+6dZ02c1inpa4/4Z+KKy/
+UtHdMvv2z/UZwg4Y5vWXe5N+c1mQy29tRptanSsrxum+ttJVuJ58dIa2gYA5u20
wdJ7HZavURfbkmrLK6rRSb7fqTW5lW3R8WxEFOUl8osUPuixTwg=
=vukG
-----END PGP SIGNATURE-----

--3NraPDKjMzW1VfwZ--
