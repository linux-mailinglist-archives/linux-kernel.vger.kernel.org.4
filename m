Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1034E6BA180
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjCNVhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCNVhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:37:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2E53DA9;
        Tue, 14 Mar 2023 14:37:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pbn1V57RDz4x8y;
        Wed, 15 Mar 2023 08:37:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678829854;
        bh=Nd2x1gG2+NtcTScVqI2c9zvK2kePXYNOFcyym9qGNug=;
        h=Date:From:To:Cc:Subject:From;
        b=ZJWT4IMt6bAm/afFuu6BfF+YU8G0QEdwe8JIPLoZoAlHJDsKNPze/1C9p/dtYxwqB
         L2sRnD7Gx8gOKp3atQ/33hXkhczvttR1rPFx5SHrgnfZOz0YrpASdLfps0ApQBhZWE
         7STvh3RuTqnRoFRfgnqT8JSxtF5xmzK8gueCx+yu2Rg8LYjIAU4fwFapSS9su0CnJS
         H1ThW1WxKdn34Ys1YejvijV9OjG5+C8KLk4e7NttD290aa8VB/o18sHGZqdgqWerGe
         r5xysvG0rdZ8IAmLlp9GTfvOzOGsGvpwS+37/qy4alCHbugu3FXmevC9T5Ah22iLp5
         9hJWOi364FJcQ==
Date:   Wed, 15 Mar 2023 08:37:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Robin Chen <robin.chen@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20230315083733.352cbf84@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2cNvZ49YqAmsSTP6cfBmj=u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2cNvZ49YqAmsSTP6cfBmj=u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  540359b2e8a4 ("drm/amd/display: hpd rx irq not working with eDP interface=
")

Fixes tag

  Fixes: 11ec7d8f2263 ("drm/amd/display: Allow individual control of eDP ho=
tplug support")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: ab144f0b4ad6 ("drm/amd/display: Allow individual control of eDP hotp=
lug support")

--=20
Cheers,
Stephen Rothwell

--Sig_/2cNvZ49YqAmsSTP6cfBmj=u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQQ6R4ACgkQAVBC80lX
0Gx06gf9EwGz8K7axGcsjMWLbz3lMlgCU6NTNV+CyOeW780ix0GBiLfieZrLZEPv
5aVl1P9OeSVrABEw2VQZFaTidSW5cyjDThFMkObQzZkPCpKo7gCq5Bnmb/GxQ/Xb
RlvioKKOZuoXzHmneg0wXRshzBgzbEyrqM1XdCz7+yNP+xVIh0DjV1hSUam7pXiQ
nl2nlgdKv5KzCvpuitKTTxcvSKgnhyxX5t/hVGEJb/c6OX3RDr6s7h5l+Ci+eBZR
QT/+H+4pQTnDNzcxw/sWxLlAuYjhUT5X0fcdud1wfO4H1a7rqjbkRc1QFPkr59/n
/QlyhQHtcyiMbP4XMlrhELXj9ojDzw==
=Nqk4
-----END PGP SIGNATURE-----

--Sig_/2cNvZ49YqAmsSTP6cfBmj=u--
