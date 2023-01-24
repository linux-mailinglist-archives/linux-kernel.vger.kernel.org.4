Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2681867A41C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjAXUnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjAXUnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:43:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398F04F363;
        Tue, 24 Jan 2023 12:42:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1f755Yh7z4y0R;
        Wed, 25 Jan 2023 07:42:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674592977;
        bh=K+yXxJb5mllRAH64AfTRbxdv3ds5BCOlSlaEhsc0+Co=;
        h=Date:From:To:Cc:Subject:From;
        b=VlSSytjJrawZsJqoD/YvYE0HAt6r/o9vj4oi/tIQnMnAVBLTWCe2eyIHLRHRdPkXx
         Z0WQf/xXAX1GeLIlWdVVHLLgeusRELlQjdE5uke7J2AK+WNlJVtzJYeLLRBN7PDuCk
         DR4OGoIr3GdERaRNpi0H0FgoOHnR44qsdo0yW9uWXUu9Whrt1rPgiecxRbvOR4AtW5
         EfBwJsUJSG826jNQpf33A2nz2XYpw1T8OH00iVYMeCeHL9s1phWMnbxBl98TN/Y3Nc
         PyW8A5F23SLFXU1ZzFynvmqWqPKzHVY/Or/8Dc5Fyr6JKTDOX+Pv6LnoJAqjIanZSI
         9rodF+s8E/xdQ==
Date:   Wed, 25 Jan 2023 07:42:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the pm tree
Message-ID: <20230125074256.7bd06030@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/usYH2NlTnR8O7hiwRpDqtzc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/usYH2NlTnR8O7hiwRpDqtzc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  26c9a5984cba ("thermal: intel: int340x: Fix unitialized variable error")

Fixes tag

  Fixes: d58c653e9e26 ("thermal: intel: int340x: Use generic trip points")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: fecb78002029 ("thermal: intel: int340x: Use generic trip points")

--=20
Cheers,
Stephen Rothwell

--Sig_/usYH2NlTnR8O7hiwRpDqtzc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPQQtAACgkQAVBC80lX
0GxpQAgAjwOraK+INXJ8OMEn0+tRKEbSwx7ECMYOV+vz4qsYJaiVxY0fUrCHbDP5
qsHI8Gty5APKjq9opJYbJqMSeU7WSlAMf8LxS7FkA7Jy5AI12e0nqLKL/Am8Oaz4
E5xs6dDgYxc9AhcuZJjm4SNDmMgHHiLmFFbaYQ0plWCBffOz7cI5nXuQ1wqWWX86
ysy+jNO4oLGPd+eIOZnEFNfAxWuVzJ1r6X8E8Bd0KsqAWV0bja+ydVeKfeJvmp/Q
5HRWu3p/d54sB5BFCroPJu0AJXayXKS+rgq9+ARyRaZ1G+pw5CvHPaqPXJ0jQJL9
/e7NUDm9QgLHXXKHyEcEOtSOrXwVxA==
=sFOI
-----END PGP SIGNATURE-----

--Sig_/usYH2NlTnR8O7hiwRpDqtzc--
