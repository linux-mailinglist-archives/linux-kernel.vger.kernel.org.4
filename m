Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B396AB5C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCFEuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCFEtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:49:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34D2A271;
        Sun,  5 Mar 2023 20:49:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVR2R1R68z4x5Z;
        Mon,  6 Mar 2023 15:49:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678078191;
        bh=Wno7o4SgCco+mqcKNBl1R2wVVIHFVoDgtEwAbvPv2Ts=;
        h=Date:From:To:Cc:Subject:From;
        b=n66m4lWVd+AqCpuEAnfYAyvKAGC+PZhQZtHxYUWklwk/Tg/onfDaYad3y9f194t6L
         Xb42v+EPMGwVWE1X4Gp98mJNmpw1Fs4XNH3BS5KhLASfUjA2cTiKulGvkomzMROqUO
         lCX/5AoUyp/0WwErkFNtSrgtX/9ceEWVX/Qr4dkPhxpK/BRwWl7nEqKsWX3rzB5EKx
         XCsMjsZ2Rok6HrWoZnXmBstaR5EHNyQvis5tfRnzwbvPv64yRkTiEwzktHveYr0FaJ
         hyeWFxIBuIQtggiSrVbTSkyHNrldSfgV79ty1J8K1PdjdMigRfnm5G78rcA/y8qBGr
         U1wJnIXT4I+fw==
Date:   Mon, 6 Mar 2023 15:49:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the sparc tree
Message-ID: <20230306154949.2c93fe25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=0K0zsl67sC=jkANfueP+fP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=0K0zsl67sC=jkANfueP+fP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but a similar patch):

  2d2b17d08bfc ("sparc: Unbreak the build")

This is commit

  17006e86a764 ("sparc: Unbreak the build")

in Linus' tree (since v6.1-rc1).

The latter seems to be a superset of the former, so maybe the former
can be removed from the sparc tree, now.

--=20
Cheers,
Stephen Rothwell

--Sig_/=0K0zsl67sC=jkANfueP+fP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQFcO0ACgkQAVBC80lX
0GzayAgAkN9VP6VJk9Zc6Wou4dcR33jHFhv9d4tIfdU76ktvjs4opsSYAx1oJv7W
wZvQi80WgXex3WQWsPsgKSZAoENh9TysVs4nge/Q4JP+xj+oDQymm6OPnAuNVeiF
eYV3tZa8eegq5OSXNFCz2Jeq96L/5P0fiaLXGtIT6efRwySQN9oDG2nrvoNUpQ0k
JbUyTi+cMr/HBq6CUZdZtfhC5TBUtK9fPYFvoU14p9M0l7kzDtii/35epkHffnGD
zX3Q8BaDnRHnRVS3kJnLvfQOsACwsh6IAA6CbJ+U5U9TLK57KLkCinxa0x/WJwSn
4UD5xpR/WuT3b/azSE1Hhy6aPQULpQ==
=koGU
-----END PGP SIGNATURE-----

--Sig_/=0K0zsl67sC=jkANfueP+fP--
