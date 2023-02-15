Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE53698530
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBOUGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBOUGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:06:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C3B3D93A;
        Wed, 15 Feb 2023 12:06:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PH8GV4H1zz4x4r;
        Thu, 16 Feb 2023 07:06:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676491571;
        bh=nMAwoYxXPHrxlor3Q73lbTOHTIyT9RRacht71KH3FQw=;
        h=Date:From:To:Cc:Subject:From;
        b=GRAxPO0NEmrPLltFk4jntBZy/p81DcwBEeMNciAcxh3QJrPf8pgTsXFeqJ3iyFwGV
         mRpQ4/62xi04Ac2wWkAwUCJ3TRZGuTvW1yBfGkIBrWCH1ynlp2uQMGIs8sxDdbuHMe
         Wa5PXBe9Ry6MXJYvtvZegBE0nxB2ohwb8s1gR5uMzgJS/o8K0Svy9Ub8Z2yqq5CfLk
         QenhunQn10FTtFZjw4Mav/9lzzcdAeZ7m51PhXsa8UzdH0YFgGmpWe+WBdGsW0AFtW
         P+f8nyKpeicFIkkiIvqpXWNrZ+9q2aX0jWPmqnseHKvWIau7m6Ved+yRl6BEnkZGv0
         V+kn4mP9WOeCQ==
Date:   Thu, 16 Feb 2023 07:06:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the ntfs3 tree
Message-ID: <20230216070609.7045e2e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FVYs7IC=Q4aIYvcF/e3Hd9O";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FVYs7IC=Q4aIYvcF/e3Hd9O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  fca02f0f400b ("fs/ntfs3: Don't hold ni_lock when calling truncate_setsize=
()")

This is commit

  0226635c304c ("fs/ntfs3: don't hold ni_lock when calling truncate_setsize=
()")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/FVYs7IC=Q4aIYvcF/e3Hd9O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPtOzEACgkQAVBC80lX
0GymNQf7BDoEuM/yXa7ZS0Yv/5d2mFSl2sRSuY4I0sF2+ilZiz9RhuoUrezTQ2T/
fPR/EXE/Jk2mv5eFW5MNnquf+pthkMe3kCpcJgOxnaWXKKmkZaA+VsZ8ctiHpR+d
VjyXq9Knu9TeWx+zjBEcv4McyHXTJr+wmJL4UidknjWhp1U9ZsLwu3cK8I/Pr6+T
PcMjINsqvNI62/4aUIjAzTSMlhOM2hlU+LybfOn/ybLxkMa43yp3L1IkRYVG3v4Q
KUodrtaYN/spR9/HXa7xD705mij2+nDkyTslGYUNk23h9vlluqii+KVVgiprYXQA
sWLVgiyHKrlfA8rcwwHHH+glKF4bVQ==
=B2+d
-----END PGP SIGNATURE-----

--Sig_/FVYs7IC=Q4aIYvcF/e3Hd9O--
