Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2956601A92
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiJQUto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJQUtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:49:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E4FE06;
        Mon, 17 Oct 2022 13:49:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MrpyQ6GLMz4x1G;
        Tue, 18 Oct 2022 07:49:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666039775;
        bh=WKfIe8F86V7bEvTKF1deR/cHmAsFSTvnfYYDLb/VP2k=;
        h=Date:From:To:Cc:Subject:From;
        b=up7zhqiKMnPilUf3OjSFFeuVqy3y0dorWYLfJzPYbRBnUJOIFjWml8blDP/5TgGSD
         ZyaiaflU/teCWgaSWDzw5eLbwHnDAGPm1PxD7V9voIbTPC++dfQrsx1I2pm9U6HrGO
         FK6EQ/oLCRo6ZANcg55ctXhdhqFVwszhUDPwKiLMAsQJBRsZ9FpuXNd8s09HTWkWxn
         1QlITwVU0psmuOmeomqevIIalAloGkaYso/nnABDV4r7Vcy1iF+PxiHewYTQ0jSVL1
         huo2aux9Ry4fe2HBPZ9wMTONcXx/V5TgKZnMQUz9CGBaF+umz5ZALtYNUxYLiFOvNp
         IQndVPo43RF8w==
Date:   Tue, 18 Oct 2022 07:49:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the thermal tree
Message-ID: <20221018074933.0685f571@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ttVvd_pDN94me6VgdUB.hJA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ttVvd_pDN94me6VgdUB.hJA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  68c0c5a5d991 ("thermal/drivers/exynos: Fix NULL pointer dereference when =
getting the critical temp")

Fixes tag

  Fixes: 13bea86623b ("thermal/of: Remove of_thermal_get_crit_temp(")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/ttVvd_pDN94me6VgdUB.hJA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNNv90ACgkQAVBC80lX
0GwnFQf/TX+TxcCAj20xttWY6cdGw9SosJDOBP0vvseT8Dhwh+TzsiBy6YjgLxtw
0y2YkAOFXIpR2xpoJ2zJngCaUldpBdGvFKlqKkhT0Mu7luvTVeDte2lMASirry3+
hva2f8yaBKNXvjMhVlnEOlYym5rsYKAyQ4qTI707HdRahIv30Bh9+fGeouZlfkM0
Y2MM77rEiMJ+Tu/uyl/xVg1W2hoIxKuWfCKDPATmsx4QAT6WnCL4znF0U47vJcMq
pjc+/pRhTBAiDcZgxyxl4gJK/NXb5CQmL1by701yko8XNlWVR/KFYN6XTn8U1tb8
NmDrv+G+cURzCOvSRr1P0jplEcZ3Uw==
=medh
-----END PGP SIGNATURE-----

--Sig_/ttVvd_pDN94me6VgdUB.hJA--
