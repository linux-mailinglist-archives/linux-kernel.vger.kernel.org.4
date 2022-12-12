Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D5464A9B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiLLVtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiLLVtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:49:08 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14F419C16;
        Mon, 12 Dec 2022 13:48:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWFd104sXz4xGH;
        Tue, 13 Dec 2022 08:48:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670881733;
        bh=N21RLy9QQq1yj++ku2PB1VcKF4Qd6PIqKZAaLSeuXhY=;
        h=Date:From:To:Cc:Subject:From;
        b=fFxW63bUuh7fKI4+GRbbNxaxKhE/WXigxahyIrKwXupgMvJbxjxgSQH4ivHCWyrUx
         u5lyawbL/PdihjVh7tFFus9yc23wECOgrN2oO3C3tNi9WRi8mzuic4qnL8vayOt7hQ
         eXBiDceodpQwlUl/lLgyxjg2fpwnnjTY8rPKrMfywYaPG+wR+ljicah9G/V44jVnqN
         wf4E2YHedmqCrXrwXpX3rw/3zYi+56iE6obIevIz8vtGIB/OFvQS4batK6QbHhYXf1
         ZiTWDYOwqxVMDZdYGE73z/jCey0dH8E2vyLvdncy4/PzSiIeP/i05kiGaIRBj0Rqc7
         jNolnpavf0/hw==
Date:   Tue, 13 Dec 2022 08:48:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the thermal tree
Message-ID: <20221213084838.33d6678c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W9MaaymC+0LDeNpSFJBs1xh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W9MaaymC+0LDeNpSFJBs1xh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c64c9a768c09 ("Revert "thermal/sysfs: Remove unnecessary check in trip_po=
int_hyst_show()"")

is missing a Signed-off-by from its author and committer.

Reverts are commits (and change the code) and so need Signed-off-by tags.

--=20
Cheers,
Stephen Rothwell

--Sig_/W9MaaymC+0LDeNpSFJBs1xh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOXobYACgkQAVBC80lX
0Gy4UAf/RpgnEUE8aYYqO0yRww+pA0qq8Obg78c7qaAmpTGRF+YWWw4ISD9NyNZk
b0eC6CmWenZPBQW3zHUhuSYmdsPrxwbP+duHILeQ0t1MTLu8fjkqzio2/biU3m6v
W/IEB34dD8PS8PU6Phdo0+9w6uHhJ92SjLwTgxzTzy3P/787pAZ8SzVzT0jktskY
za/ei1Gin7o0nFN/mq0WAHtnfNOKqsD2dtaS1r8ciMOfefcBdAIwvWu+mbxWomMF
iSRBPpbnzayWrMJRdh0WdAAozPX0ApgpPOM78j7v6P3+oBGB/GrmTqqI6GrkB74c
Rn3TpSutCMi5VWDNpVAULDEd444a4A==
=cYh5
-----END PGP SIGNATURE-----

--Sig_/W9MaaymC+0LDeNpSFJBs1xh--
