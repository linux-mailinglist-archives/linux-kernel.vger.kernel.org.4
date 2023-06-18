Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33830734912
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 00:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFRWOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 18:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRWOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 18:14:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CA0EE;
        Sun, 18 Jun 2023 15:14:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QknJ25xX6z4wgn;
        Mon, 19 Jun 2023 08:14:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687126483;
        bh=HYS2ObGbRGho14vWeiobxjIAxkVftGcUQIJCA8dU4bo=;
        h=Date:From:To:Cc:Subject:From;
        b=o8xFKBzsZEGzTvTDY+CiM/5R4KHGtIXfWXkx+PALMLNsydnhwG1KpEycvgOr4qt2i
         Qv6CESHUvbs+az8KRue1u2xfcOrIbp24PeAkzCh9JrBZ2oHtnmEScFLm+DoGklr9ge
         eqyfMRbLrfoc91RelXC7+2sZjqxY1Hz2vZX/L2JcmN0+/0lNy1KBJH2g16Aq1K9m72
         CvLRYn0fu9PhtBaqewSVu4RBJ2gvDYcWywNDaVuynSJ4xJVtx43ucwU1CbDJ8haTQr
         jqzaLyyMyfhhbNv7RXhiIht/BLjG2sO6oFY7/E7A568PAg9k/eryWBpxqELSUe98Wz
         z2Vy821ido1QA==
Date:   Mon, 19 Jun 2023 08:14:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the overlayfs tree
Message-ID: <20230619081440.429ba4a0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iUfn_fUVvhmfMtXjcwkvp5s";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iUfn_fUVvhmfMtXjcwkvp5s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  bc0b6f381053 ("ovl: fix null pointer dereference in ovl_get_acl_rcu()")
  0b130bb10bfa ("ovl: fix null pointer dereference in ovl_permission()")
  7413a6762f2e ("ovl: let helper ovl_i_path_real() return the realinode")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/iUfn_fUVvhmfMtXjcwkvp5s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSPgdAACgkQAVBC80lX
0GxMPgf/diRcQII8gi/qaHY8+8XpnzD51IA3dczSjvP2A0xwnNAiPf8iiZ9blPso
5UVLnU6YAiRicCJnD6l8vbLIDRcQoH9zqsFcXg96y7Lv7RbZkdV3RItyrt2zJUtb
OfYvt6HvQI8lirqKNCBeKvZc89EKPa/Gt3VH3YELcClqseOz1SV9HvUD5XLoj3L3
YH5VO16lcZfKoaurWVImJ8qt0buD58scyGTdYSyn6HUa7czEaJ2Zl2r9Q3DBPhbG
Wk8fAAzvhYwBU2Dm/sY4Yton5uNDjBUeo0gZmOahwWyiKUg7l2ZvM7RES1XX7xiO
1cSgYn63m5IBxbCYBb8T3NSeuxQMGg==
=+7V3
-----END PGP SIGNATURE-----

--Sig_/iUfn_fUVvhmfMtXjcwkvp5s--
