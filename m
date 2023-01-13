Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C5D6688F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbjAMBNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjAMBNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:13:15 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D53F5D6BC;
        Thu, 12 Jan 2023 17:13:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtNhP5tDCz4wgq;
        Fri, 13 Jan 2023 12:13:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673572391;
        bh=1sSfbQquQYVOZSzbn1ll1Ailg+vb1yv87aNiDgoy7+o=;
        h=Date:From:To:Cc:Subject:From;
        b=YiFn9NqNcWHxCTywRS7guLhPG5nZYZhMjpZ8nEIazEwIzOY8OqIQ456gilGs9E3UN
         +GAxtxV6Q4I9MDJfRhjj5N28FNp+o5hubTFQQi100eQbfAcWNenqX/aWV8QoOPVMFa
         Zvn9jMgKu58mWp40iark1Jhf7b17EF3Xaj8GRJPupkERpr9wcPkf17hsv1l8J9iTVH
         hl4fp+VCrKmp7KdueXdbceeSSZWzbu94D55+fxyoQSz72+Ox4/fifAqhOBUcVTJRTS
         ng2AAMX5PD/uViAKq8XS6g+kHdYq47JKYggzg4z6oSv0Ar+BHd/9NoPB9CKn10M6l4
         Gc65wIq3+7umg==
Date:   Fri, 13 Jan 2023 12:13:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the sound-asoc tree
Message-ID: <20230113121308.5e86479f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fHB5_u/=swJpA8.e2YwU17l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fHB5_u/=swJpA8.e2YwU17l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  5eab9265759e ("ASoC: PXA: make SND_PXA2XX_SOC_AC97 user-selectable")

(commit 350a6eb412d3 in the arm-soc tree)

--=20
Cheers,
Stephen Rothwell

--Sig_/fHB5_u/=swJpA8.e2YwU17l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPAsCQACgkQAVBC80lX
0GylCwgAk1i1EfBhwr6rga+46p12VqI3iQSh5TePD8GorTQ5JGciP6ix6WqYisZG
PFh50kfMhYFSN+TgtE4j8kighTEgp3DQYeYzjtLwm0gf31izAQsl5qupX94Con64
XtWG5JdGaw3k3sSMvEsj2fCdjj8zgDSd2BlUyDZffhC2UvMUNMLf6EvWhnnHJu6S
7gfGENZ5v7EMJccEiv9vvTbe9HmYfNE7iisCeFMBsttk1mzp4edce64gzj6CD2QB
W91VfU29j8z7GDDsxpNNYWaFhM0YajiEb603qmUAEUqfyR/p7E34PzG+FLqEMJhG
mj8IjKXIciHPAq8kmVED8YR+VhM1+w==
=yHUz
-----END PGP SIGNATURE-----

--Sig_/fHB5_u/=swJpA8.e2YwU17l--
