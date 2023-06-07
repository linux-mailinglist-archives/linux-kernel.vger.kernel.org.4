Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3627272C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjFGXPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjFGXPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:15:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC201BD4;
        Wed,  7 Jun 2023 16:15:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qc39G0nPXz4x3k;
        Thu,  8 Jun 2023 09:15:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686179730;
        bh=izv5C9BQgG7CTycSPmVGdXp6Vo3R4K0y2FGdTw4ZhcA=;
        h=Date:From:To:Cc:Subject:From;
        b=f0/JZQj/CRa5wES3xa8VaT3bBKL04ZqOhp8PorCg1h654lFt/R4mZ+tRPZH4fRVjX
         SH4nQnBiAb/5UhJ8Al7/Ki7oGs7aKvZKbEB2+3aVpVOrB2tknNRMxh5R8GqIWhLMai
         bXE+sNUkX1FZvMlHnin/XApL4udXMnETGvR8MxZutZgbhlihQ2ftzzn7Lc8vRH2M2K
         gE0w1niQt1qKsruklD973BXIDDRY6jUX8wLB1xyV780Gl++kMtIpVlmVabJ0WnllFY
         /alctqclkqlUcx1aEvGtO3CgSup/0DTPegIw7cK+m5tEYBFXpOATxUMUF1PTkkZWNG
         pJR882RthX70A==
Date:   Thu, 8 Jun 2023 09:15:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
Message-ID: <20230608091527.3b26a533@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Mc2_WsLXQ3tsXSry=FPiWbe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Mc2_WsLXQ3tsXSry=FPiWbe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  15f8e38c6c1e ("platform/x86: int3472: Evaluate device's _DSM method to co=
ntrol imaging clock")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Mc2_WsLXQ3tsXSry=FPiWbe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSBD48ACgkQAVBC80lX
0Gz/xwf/cxuS/x7i22kRU8LNaLV8fr7/VlwWYkyWUajnWtC/pnRP3Tm3iut6ANd5
+whPOZYH5ohRRGwq9sFcme7j5lhe+2hiSAyGMBKmd81ert5HD+AwV2CvqFriSD3P
QGsXhXeX4xKpDr2J1ybnqKiUXJvMCkh0SHCoGifHVswmS2Tqj9CKocICyitKXuAb
Au9S8oq5eFB7r87NNhezC7kC5H7OHR6tVIRVXd1o+tVZeyFt/NZn08DcGrig/MRO
CcxCuwxNfREnM+NDN1MEZB9b3IpkoIUu8oxlB0a+k9FrQ55uycifpKIMt6l3n9f1
OaP3mxibQdtL32ygWlr1CI/JCiRBIQ==
=GkcU
-----END PGP SIGNATURE-----

--Sig_/Mc2_WsLXQ3tsXSry=FPiWbe--
