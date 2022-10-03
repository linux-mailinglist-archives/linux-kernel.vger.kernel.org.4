Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D969E5F36E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJCUQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJCUQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:16:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8277A3C150;
        Mon,  3 Oct 2022 13:16:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhBtd1YLDz4x1D;
        Tue,  4 Oct 2022 07:16:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664828185;
        bh=XGZezBEsGeO0qEljl3mPYZF/cbEIazo0+6rZbuzZR1M=;
        h=Date:From:To:Cc:Subject:From;
        b=InrOHaNq6+1bULL2lDmK+URvZpHPycR0vYy7TJiuCSeqwnW7VOGcQupa3PUyQE1II
         im8vUSfBE1Cxa47vow84e7ImmPVuDJ8CxZAchiLGWptnw159iNHpU2nCqQ/GLBnG/D
         znudoHZF8ofNAnQpZoZTaJZldeJmvK5S+xsN6iTXwHMYkheK/2TCpbINdSpKqQZ34f
         NlnICApSfo9bohZhDO+eUGvcfX/eOc3Nq8VtHAVkteoakI5ZzRbFpWoH6GbNoYyIqA
         sJnQl7UU45uJziJcXZ8Spt263w1m9V85nQgL7e1TgyyX5nCL6qXe2ju6eZlYuScBpW
         5ijHIiVfOg+kA==
Date:   Tue, 4 Oct 2022 07:16:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andrew Perepechko <anserper@ya.ru>,
        Alexey Lyashkov <alexey.lyashkov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ext4 tree
Message-ID: <20221004071623.571389b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SpkRt_09Ps8fxyxBb2YVb4.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SpkRt_09Ps8fxyxBb2YVb4.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  34fc8768ec60 ("jbd2: wake up journal waiters in FIFO order, not LIFO")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/SpkRt_09Ps8fxyxBb2YVb4.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7QxcACgkQAVBC80lX
0Gy9TggAkQjBaaSJCOQaSRMabmwz/acKdr9Hxl9fmRQ5wH9CI1K23TSjcwWkddZt
4cC7qXWlEcL8kpq8ACGQFrwLD+UYVxG/z6Jti4rUoiSdtSGsI1f9c696uw14VNH7
MqffP/eBSdwQ4RlVL4/Xl59Mr3ZVY6Zl7CaMMzU4t2p5ALOUXnCc+aTGBBNu3Gyw
1SVd/pkz1LIloilsP5jZVEEyN7rgMyhNb+A04L5gl2GqxZEV+a7JS3ImzBb9xZIO
Kkdmvn5Sy1tYwy/gQAhVJyh9dzMj9Tq43JKb8c8obZcBEp2IocKSVOjZOrbbFXu/
voH9B+GU7fS2ZLSb1wHo2p9CjKxccw==
=ga2y
-----END PGP SIGNATURE-----

--Sig_/SpkRt_09Ps8fxyxBb2YVb4.--
