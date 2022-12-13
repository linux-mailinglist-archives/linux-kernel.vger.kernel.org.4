Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032D764BE71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiLMVbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiLMVbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:31:45 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D24240A5;
        Tue, 13 Dec 2022 13:31:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWsBd31Ryz4xTy;
        Wed, 14 Dec 2022 08:31:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670967097;
        bh=d93HhSuM1bfwkBIxam509QCPSfb40NV1BNqQHTmZMg0=;
        h=Date:From:To:Cc:Subject:From;
        b=bPkZMxFpNxzcLMXgK4A0VtEDnhLSQzhrhdkV5ghFa2KPm4knZQkoDIDoR1Y5f5uz6
         n0z9hNXSugEIA+Fhomm69TcnspQECO3kAHGRIE8AGFl2Lj7ykV2V9wPkV1bVVJQsdf
         /PhC3qtdOLW2XtC1QEN+veCBYxezZov3cWFfhS6myFZlibwVia8fF/ZotpOcV9X/v9
         xNdxF/389J+RAFCwL0BeJq8tYMQJ2y9OrhtVQP6nAoLQQVvze+9YwxPW0bupVXvZ6+
         yIub2Tb4bwE9Mkf7ac8455x1lz/iPFjYTUwucJIDEdLLGFr9yhI8XkDm2i7OfDgMYX
         Vto6Jq3IO5eOA==
Date:   Wed, 14 Dec 2022 08:31:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the perf tree
Message-ID: <20221214083119.248fa4a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ceNn7PW/ZP+gDgomp61Ihrl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ceNn7PW/ZP+gDgomp61Ihrl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4d59952792c4 ("perf test: Update event group check for support of uncore =
event")

Fixes tag

  Fixes: b20d9215a35fb6ed ("perf test: Add event group test for events in m=
ultiple PMUs")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 82e236e28a79 ("perf test: Add event group test for events in multipl=
e PMUs")

--=20
Cheers,
Stephen Rothwell

--Sig_/ceNn7PW/ZP+gDgomp61Ihrl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOY7ycACgkQAVBC80lX
0GwcOQgAivpHLlIwlZ1TGR/oggi9krO8l9nmNSUs5LZQGew3JPCs9pu6VNDzq4NF
GxVJ0k1TOEqDzgHa0SeV9w4+b9fs7oJlwnhdcGqOM9Bj2+GGOOwM+k5lIn04uLWB
i8zwdWpzeFwfy2lIWcQPU3ShGRYTfpTSsIKm7wkaqrXwelJsW6D8G7cpRwAcGYiz
LUPd2s/HPRhhYD4+GsuCrVdEjeoScCB45dtzCtPqKxfIB0mPmHwUu2Ji3vGPW+eS
m3ermvsHzP7FDLs1HlIBmrooTSqR7FgrRqVdBfXUCV4I0l5iRVwnFqQjpRwoDQx0
sY2WtT4Qyl5cgTfEz6zBmElLlxCx+w==
=7AkC
-----END PGP SIGNATURE-----

--Sig_/ceNn7PW/ZP+gDgomp61Ihrl--
