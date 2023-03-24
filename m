Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208756C7488
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjCXAW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCXAWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:22:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7452E0E0;
        Thu, 23 Mar 2023 17:21:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PjNCg2c6Dz4xFb;
        Fri, 24 Mar 2023 11:20:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679617249;
        bh=Ec7in0wIuy+VDbDVAQ8RuUjdxF9bluD17phAnPQTL/U=;
        h=Date:From:To:Cc:Subject:From;
        b=CbTJ+zys750RlGeuZFVl8ajfThkj/tQ7sLDOmAt1GR1qmEzamSQwrDoxvCoRuRoXl
         1IczlGBFLJL+AdT5u4rWLaxfGMyr9ldhOSjPzl9kWwn9nUD7Y9XsLN/O4qIp4P+iqh
         qpgysup8n7Y1nh0HEM1g+UKsQgeRY5SCCPwZACOn+SpQY36eXPVaU6x7qp06XgFvSW
         K2Aor+DttkGy6WrWj4aNTB/lYZUEh1AsDg2oOHl29dTlXj5a2hcZ+VGNtASLZEXxB3
         O8KGMU7RYKb1vQ7yM3tCKKZ2P7CCcyVUZxS27vz5buq1udmB2m5i+UIMySGKRO7bir
         Pa3jBiAkA9PZQ==
Date:   Fri, 24 Mar 2023 11:20:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the tegra tree
Message-ID: <20230324112046.23e9ef5d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aZpterKTi_NRW/_2GFxCF8m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aZpterKTi_NRW/_2GFxCF8m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  23797dde7588 ("arm64: tegra: Bump CBB ranges property on Tegra194 and Teg=
ra234")

This is commit

  4bb54c2ce48f ("arm64: tegra: Bump CBB ranges property on Tegra194 and Teg=
ra234")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/aZpterKTi_NRW/_2GFxCF8m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQc7N4ACgkQAVBC80lX
0Gz2Sgf+KtFoSi1MBMI/GoIfvDk+ti/P1Zu93YYpkiohNRqTCfofzGZpJYOZqNtQ
a+50vrRX9LKZlQ5TQ5GRcLMntOUFmNCn0rDtFgVXnL7UYcVN2dkUSmODkFwXsibM
2vIlC7gMH2LK/zsEKAQZFX4boTM8zNqHUeMkdS9iDpDaN+fncS6DpRxqHyiLWejz
4ffhtphFgM9kAbKy1EAVVrMn2azI6qqF7wOddYSgjbQc8eI5uODT2LCx4uXqSNAm
3ADqiArl8UO+rSMv0sDikUUz00y3xblmU1J5rPIZYV7B4CoL8G0Qnar/tBoDRGbX
lJ/UvNqMlAswd+niIBikGPwkUzBD8A==
=6q5J
-----END PGP SIGNATURE-----

--Sig_/aZpterKTi_NRW/_2GFxCF8m--
