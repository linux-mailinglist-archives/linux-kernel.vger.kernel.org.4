Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A142E6AFCF6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCHChf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCHChc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:37:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF157A80DF;
        Tue,  7 Mar 2023 18:37:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PWc0m47jwz4x7y;
        Wed,  8 Mar 2023 13:37:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678243048;
        bh=vjVQ/NyTD77G/ALlfxWdlQrTw1Yi2rOMtAx7lfxcyWU=;
        h=Date:From:To:Cc:Subject:From;
        b=Jo9vk90wNyUnPuhLIQSVb6O7UU5Bmt1DSxEMYdx3aMdkMxqgOHgFUBqEKY9S+B32W
         c/QIn0uOx767BS5sjDFFneoYl0HMZDJXt+9+ZgMi642YOXA4j2wHAh/ane4BQ6vPyX
         OhoXaT1Ac27tcEi6fgTd1DUN3DWUOmUPill3KyeGpMmBEBr/OuUIvNwXE1K5NDxG3U
         zfrdBiKb6ZtdZqTz8DrxWoH+zQL/KSrgVS60gXTbZTYGf+C//zdFNYW0JrE6c8bsYN
         Q2b2XHWs5oNKrzIiA4CqtR6PvBc0jXtVsP9HWLVPgXel5nUOTE20Ypc65onsKphVjx
         MtdMVwZPBZtLQ==
Date:   Wed, 8 Mar 2023 13:16:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20230308131621.4e554121@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ohosF+G4UNjalaAF7kAra5G";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ohosF+G4UNjalaAF7kAra5G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  e4beed6287ce ("Revert "rcu/kvfree: Eliminate k[v]free_rcu() single argume=
nt macro"")

is missing a Signed-off-by from its author and committer.

Reverts are commits as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/ohosF+G4UNjalaAF7kAra5G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQH7/UACgkQAVBC80lX
0Gyj1gf/UBsP5X5mMuxjP+VuvRp+6/SZtwO8iOogmd3Z7Vpb2Pwf1QZsuXKjytF2
VtjtqZc5HR1OrLH21rtp0NLcYPi9bVwQQw/nIetHwuuDHyWxfX2ejC/SXg4/Q6o8
SC1Haz1wwwZ/MxNrggngEqitCjU6WaFSP/SMRVfkmtDiDEVwt43llS+f6rmVU62O
6hfo/xkX6jYH3++O6rqpzViX18S8r/rW0GnrZRUvnYqMZQYrInbyKNhvGY2Nrd8k
/SvkWCF2HMffU1nFHf32rr73rAYDVJQCkyxsN9a9/I6sxJkKEB1rTdQyET83sNSt
6yEyhKCMlx2/6BffyI1IojS5z58NPQ==
=U9y4
-----END PGP SIGNATURE-----

--Sig_/ohosF+G4UNjalaAF7kAra5G--
