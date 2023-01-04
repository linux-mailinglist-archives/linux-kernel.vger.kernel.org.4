Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACA65DF14
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjADVbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbjADVad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:30:33 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D3EB;
        Wed,  4 Jan 2023 13:29:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnN6P1znzz4y0B;
        Thu,  5 Jan 2023 08:29:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672867789;
        bh=+JmFpXePagpX88IPAsk6wyt07kw2DZLrQIoyAdf5SSc=;
        h=Date:From:To:Cc:Subject:From;
        b=Tr2JUDtE74aXZqpBRLfcFRgHlQqcU9b8KDacmddTQgNWrMDRx5bl+7TxZ87LYCMa1
         LR7j1uMHCKopx1RZE18dnyft+UpgnIaDGHNjrAnX452RxL5f9hXTHhwvzC+pgk4roF
         7C76rt5xt5TRM8WeRP4LxJ9JGpRMHbziv1KmH7HKKwIVGoe28jft8Nbfno+7pK0IFS
         jpMTc1gxpHrm8E7/Db68OhqpYfbVZGefooz7kKCFyKpIGEb6LvRjBKFdNVLnJG/ogo
         lD4hh8KlmCLH41lZFpvdsYwLOG22U/umKkYYuqGEcnyVKT064fGmvekEsJAi2Kx62j
         nxlccHfYNoNrQ==
Date:   Thu, 5 Jan 2023 08:29:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the backlight-fixes tree
Message-ID: <20230105082925.3a0a1c43@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2TLkVyTKAVcTNn84Nsh55K5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2TLkVyTKAVcTNn84Nsh55K5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit already exists in Linus Torvald's tree as a
different commit (but the same patch):

  ac3fbaec13ec ("mfd: palmas: Use device_get_match_data() to simplify the c=
ode")

--=20
Cheers,
Stephen Rothwell

--Sig_/2TLkVyTKAVcTNn84Nsh55K5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO177UACgkQAVBC80lX
0GygXwf+M3AhDmGOgb9DADtFy3JXfhyJU4XNA0f51mpG7R6BHRf2HYOjDy8v+KW2
tfdoaz/j00W4Ce8z7tIyWhVP6IafKYpZ0dZuRpqC06auopqrz2GXkihF9Ge5R1yZ
mEjnfSXpBHsEQvUAef/SsfMinlALArlZCTdLvALOnU6vDkmJPNdk+deOotc/Yjse
CtaiSri5dbs4yGZcAtTQSiKcZUas/Gw6Oy+PhTJgyiz3TgJ8RqSyRjuFWGdxWUm5
ae0lZAIBMQX2NOkCvnU15yokm8+eRUXR5mmxf36Kq09kWPY+HiVTV2mYE2n2GfbM
4dVFVRkXF+U0Y7TnYKQNz8JIzx+fsg==
=ZDbe
-----END PGP SIGNATURE-----

--Sig_/2TLkVyTKAVcTNn84Nsh55K5--
