Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559B8735FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 00:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjFSWa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 18:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFSWaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 18:30:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22EF103;
        Mon, 19 Jun 2023 15:30:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QlPbX6kKhz4x0B;
        Tue, 20 Jun 2023 08:30:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687213817;
        bh=aBWwy2x7olbw2nW5TixUQE6rSECSSxfcU1WrXGDwUT0=;
        h=Date:From:To:Cc:Subject:From;
        b=AIktUrZnKzaEV+HrXP8dRJzsUvJ7FK6BbfAXpmL6DU/rJwSTkB8sKWA0x/kb/zSts
         yB3NfgN1NJqABOHHChEnMCoRfsLnJT8VMwgtOv+g+ZtDnRYzEtmQ6Ywa36HGd+dpsp
         x5FIim+kzUUYPnUiGbPiSIDs6vhVZ5ZQ7NlZf6KGFSQ+hBYJh2KWnVGDO9s5MuZnOp
         05Sagrf5BKyGDgG63qtu+lW1aXlPsDB+QrRJY3+SdNCArZ0pEVJavePjqR1f91ULOx
         DE6i6ykqzKzxSLqWuzm+Ewwd9UGVe5u5Kpl/0qoVz8xc+5GjjroCJ43THJCww/vnBX
         O7OC7huwbPUNw==
Date:   Tue, 20 Jun 2023 08:30:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20230620083005.5660d209@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U=+PeBoPrc9uHX4qYBn..O2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U=+PeBoPrc9uHX4qYBn..O2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  a1fc457f016e ("SMB3: Do not send lease break acknowledgment if all file h=
andles have been closed")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/U=+PeBoPrc9uHX4qYBn..O2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSQ1u0ACgkQAVBC80lX
0GyzaAf+Jcd9nnBZv2IPjsdlOYToyrbU/U6Uam7Aq8+635qvgMkmyyL+bgARW3Rl
kkmUTlKUk7vw/v5iCZQyKBB9Wt+UaIsWgq2QdYhRyMonSlGsKWpEBfs5DSAyBrc8
N/1L4QkiHC+RMvAtQLYJt4Xdy6d4/V8R+po9jDtMMi0yx3K7yLTuPuJwPjrqhBPp
Pa7Fra1o/VAqQMul4e5+BVbnh6zu94IxBnzw33O7Ny9n8kKGQ0tfAP2pYCb+P1xm
POdiJJlY3IxvVC3DvjK+Sk1qdHAd/vV93dU2tnaUK5eAyX00U1lUz5EgBFv+1ms5
JcaTKuvSFNZEsVaB/CLuqImgoi4LTA==
=zESE
-----END PGP SIGNATURE-----

--Sig_/U=+PeBoPrc9uHX4qYBn..O2--
