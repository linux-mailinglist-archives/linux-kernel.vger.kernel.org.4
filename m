Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE905E5F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiIVKNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiIVKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:12:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E568ABF20;
        Thu, 22 Sep 2022 03:12:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYB1C1zNcz4xGQ;
        Thu, 22 Sep 2022 20:12:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663841567;
        bh=XLwibGIv5BGINbco3o0NTpDvOVxYtnFFJ1tpHSj24+A=;
        h=Date:From:To:Cc:Subject:From;
        b=svYnTi8DfTg6hR/2uszT3CEzNdS3ZBat2y+zDedrHDw1/EfhlIQiVQDrqaZ1kZIYr
         Mb61Vyz3Mn9rbEX+adGxSQyfwa/brld06CjqJaGgg/KweRs+dq/ekKrvNd/uOt0Ek/
         5egYX3Babzy/GBAMhBt0eYuUIGSNZY+MfLprrSaHdjFa9ldzjIxUHUNWtV84RlVXDi
         ML/JqQuUgrQTJ2ZFfFTTcIaVOIW/M6YFiQH5dxZydR5+wRVxoxugakhJIND6WF/x3W
         XKv7M9s63pZvLbw4pt507NIrV2mh86w/DBlC+aIqRuXEvnoXs0bzWJO4s1zJiVo/qY
         KTcxCuehOjxJg==
Date:   Thu, 22 Sep 2022 20:12:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20220922201222.01e0f2f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//oOtkijRZwFS49YEhzDM_kS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//oOtkijRZwFS49YEhzDM_kS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  a3450c5ce1df ("Revert "rcu: Simplify rcu_init_nohz() cpumask handling"")

is missing a Signed-off-by from its author and committer.

Reverts are commits, too.

--=20
Cheers,
Stephen Rothwell

--Sig_//oOtkijRZwFS49YEhzDM_kS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMsNRMACgkQAVBC80lX
0GxuJAf/QAWaCb/vlI5+WWU29I5Pwn6YcCRkGGMJsnhqMoAaF3/+t5I6q9CT+dAL
knsG8kuZElUU77Z3nIexlgiIKwESko4QyH2QZfom3UoW0ED+AkiMlfkmMim5dsuD
xJAdzdHYEkPWoYGIDf2nudxuELzDCqxGAO2541ZblMvK/ByTrpStbCy+xOX06UqL
OL/aE/1VT68RwveB2/xVFPKqQCXUzZzTdx50LwWuxvEJSg9JsuzAOBwgr5HwfTgj
eDOt/96d0W3RPqOWXMuI+N5XyIrGYv7pMYklA8HSnCUrZkG9FVIBG24jGpET9Rji
Zv2ZHARI2UR/QT87Wo4IqHM2Ny5LwA==
=fPKl
-----END PGP SIGNATURE-----

--Sig_//oOtkijRZwFS49YEhzDM_kS--
