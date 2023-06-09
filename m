Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC9E728EC5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbjFIECo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbjFIECR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:02:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB89135B5;
        Thu,  8 Jun 2023 21:02:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QcnTV3H8Sz4x3k;
        Fri,  9 Jun 2023 14:02:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686283327;
        bh=diX6SfjP269khVsruatAUVTVjprO6aCGR+YnLNNnENg=;
        h=Date:From:To:Cc:Subject:From;
        b=AKe4NQWXsqheU02RBdQOrnZ4VsCr6dSqw3fze26DexYQ9l1Rub9Q3DONH1733sTxK
         zXL2DqcUfT/I8Ui4CIYeKUml781r4R5mq/BA+R2vbNBki8NB6pruAP0rhl5SVVTWsD
         34zxbs56SUG4y3DzLvIguYuNBo2lwbjavgL7INiub+SHcukjoJlI6nvZGvSasB/bAD
         dDHLpORbefdxfAODf8GIoxF6ITwYjIZ1fXcpduja/m8iL4Wgn4QaSutX5rSeyPIGFp
         8PWtgCEg3msKwO7kzrnjkeBYj2LlxTh5hoRPYPRbpw7o17hMLZCEP5ULmB0yWsgbb/
         4l2jTzsPU7m6w==
Date:   Fri, 9 Jun 2023 14:02:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20230609140204.79af860f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xnYH6qSVQ2wyx8+F8+tGP/M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xnYH6qSVQ2wyx8+F8+tGP/M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/drm_connector.c:2215: warning: Function parameter or member=
 'supported_colorspaces' not described in 'drm_mode_create_hdmi_colorspace_=
property'
drivers/gpu/drm/drm_connector.c:2239: warning: Function parameter or member=
 'supported_colorspaces' not described in 'drm_mode_create_dp_colorspace_pr=
operty'

Introduced by commit

  4d1be821b795 ("drm/connector: Allow drivers to pass list of supported col=
orspaces")

--=20
Cheers,
Stephen Rothwell

--Sig_/xnYH6qSVQ2wyx8+F8+tGP/M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSCpDwACgkQAVBC80lX
0Gw/PQf9GdI/8l42AmurWdFjfkjnYDLRl78BKS0D+MF8KCzdqEAskDHdznevFQNb
18KCVxxFFNSBapTvViEWDX19tcSyODMdnqB3lq4++ikB/9rdxsStjJqWcbdlxK2z
BESDANoMs58G3qLrgKQtwHqxMukJ6LHNTRnBRiLM4BPvQ4gLFCODu0RyqFoPkeAe
j04uFf2SR73MXbTLIwiWNMhTXpbnlAvXV5GUBI+QdVkM/mIJmsOSJGlBd1Jtgftc
FtueSOjbjhZIYwUcx5vs7mOaou+KGIX6n1vO8SE0VarC/8grn9AqS/5/s9R9Us6N
q7yc2T7Nsk0bmBjYrEYnMTyIi5llvQ==
=aKfS
-----END PGP SIGNATURE-----

--Sig_/xnYH6qSVQ2wyx8+F8+tGP/M--
