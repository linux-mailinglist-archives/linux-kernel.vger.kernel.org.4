Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D176EF37C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbjDZLf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbjDZLfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:35:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3D346B9;
        Wed, 26 Apr 2023 04:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D67CF635A9;
        Wed, 26 Apr 2023 11:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3F7C433D2;
        Wed, 26 Apr 2023 11:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682508923;
        bh=lS3OSZHI0E1yy7X2gYhT09bvb43tywfhxdU7NBknisU=;
        h=Date:From:To:Cc:Subject:From;
        b=fFCGuqgNqPuJi9vCZYi6GIZTi0t7Hae27XHpJhs7gRF/1gtQy898IKqdcPJMUWDlA
         blh+01pLNpcpYK1UvWlAiic+jQrXOViHz5kiWi9K0eTglbaFIVNVkwcCoCXiXAlfqp
         mM9UkHF5+SYzg0O8STCwi0orWZtGSUjTTZFguUDwdsmYZfKZqivvAzN18IRh3T2fQB
         x73/VYpKEIJ+HPON/61C/i4apP/b+iqOAgHAKWE+X5b+FJuRqfyaXLJhca2dopXAAk
         ImwN9lOoHUDYYy1rKYXcUD+xNKwTZdH4ZGFt7x5q1Ex/qLyuKDBW3a5ozopiwsPSCb
         A4NKLlRpc8/2w==
Date:   Wed, 26 Apr 2023 12:35:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Missing signoff in the thermal tree
Message-ID: <c7a60bcd-f7f3-49df-a209-7b6e7c3ce753@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S+z+Dp6vUHKasGhp"
Content-Disposition: inline
X-Cookie: Drilling for oil is boring.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S+z+Dp6vUHKasGhp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit

  2912d341800bb ("thermal/drivers/cpuidle_cooling: Delete unmatched comments")

in the thermal treee is missing a Signed-off-by from its author.

--S+z+Dp6vUHKasGhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRJDHMACgkQJNaLcl1U
h9C+lwf8CQRYKXZFc6XMbeTH73W9BluQCJgBK809dme8X8DuBvw/TYpwGhcVaTBr
HgkFb92lv1v4t2J1udVBgx+D9YAd4J+myh7YaH4mPS0FaXKNicXKEymtBBo3lscm
Thzi2z86wGyFWkCCF7rdMSZ1BnVDWLsGRTThGWEkX6Wa6+VW0PmciadngQW6dM6i
sAbFnMuUOpZwYBDwoDMLTmwGEMyAYOi0/KuXRyGMqmc9KM2SGg48b1zQPwLj4ufn
6/2qavLCs8Nx0DsSAQmjtNRM/iHmeywNyJabmDN5y39b6l7enpjMu01jw64oNyh+
MwTOqhboAlg1dPf+VHWb2YQB9GTtcA==
=8JE3
-----END PGP SIGNATURE-----

--S+z+Dp6vUHKasGhp--
