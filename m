Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37E35F5D3C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJEXaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJEXaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:30:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DFC1E3F3;
        Wed,  5 Oct 2022 16:30:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MjW5G6B6Cz4wgr;
        Thu,  6 Oct 2022 10:30:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665012611;
        bh=Ay0T0Tx20yVNUfLNefILtCXTS32TYJJWEuMJ5kdlIuI=;
        h=Date:From:To:Cc:Subject:From;
        b=sYp62zPMLCSkDCeOhJLL0NLJGBxjhporQbTE4z2RXnfTj8DIScf9rjw5VGMfhVA//
         3NnKPkbSRqvrJBC6QeJIMI6dqAUo/z38PBCZXQciAIxI+ZNWQ/px9KknV0A518fRdH
         y/cl/WoLGGjuxv8hHutvuQBSGKX0jsqXPnpCSOH7XHsvAy0ERGv1+6RRHLGo2K964l
         +KS4AbuF8lfrNNIDjvOQ4AmETtLqaroohV5Fu2SWjSMTt35n32JYuBggQ450UFuwlg
         9MhgECMjswwUC8WXYmIdx/RNr7RculVEnPU6eF6tkHVoX5uYxtR/w2DzXkBvRgZfwJ
         sxzmM3nduqzOA==
Date:   Thu, 6 Oct 2022 10:30:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Paulo Alcantara <pc@cjr.nz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the cifs tree
Message-ID: <20221006103009.35fca676@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=C4nS_7ieDqa=xSRJrhl_HL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=C4nS_7ieDqa=xSRJrhl_HL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  395381a6c0f7 ("cifs: fix uninitialised var in smb2_compound_op()")

Fixes tag

  Fixes: 5079f2691f73 ("cifs: improve symlink handling for smb2+")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: d689449ef101 ("cifs: improve symlink handling for smb2+")

--=20
Cheers,
Stephen Rothwell

--Sig_/=C4nS_7ieDqa=xSRJrhl_HL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM+E4EACgkQAVBC80lX
0GzgvQf9EpIazNc/Y7366uEQcZmSsMXh9uoIzcFm99bL6HadElbpaFkwS4n8JWNm
RHbVfmwwZyVTzapWM4FOjYafJejUR+oeCfGlzZNEpMd/09PA4db/j457ZjmMtARL
aDI21FpLgnoicoHqkNEcxJHaa4B8RIJVyb9SyURBor0tZqFC0Qtuerh3phkVIVw0
ENYl+sZMkzpUpvOjnytpE28fxK1TiPf5fEd/kdl0JyrqJzDFmcDPx2CHVfEvkg5J
TbHtJnzK9BvdS3XT2tSyNbgkq5qJfwHK82BKxzIWyItGt0h8NsMUvdSgjmm0zbx1
6WBQrY+hEj8MfhzrkClUV40rS38PEg==
=o4OJ
-----END PGP SIGNATURE-----

--Sig_/=C4nS_7ieDqa=xSRJrhl_HL--
