Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8C5F2809
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 06:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJCEsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 00:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJCEr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 00:47:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F4536082;
        Sun,  2 Oct 2022 21:47:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MgpHB6Zkyz4x1V;
        Mon,  3 Oct 2022 15:47:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664772471;
        bh=5NRFN1KOvggFX86lq7vptRFwp3FcxK89DDwyyN8+0fY=;
        h=Date:From:Cc:Subject:In-Reply-To:References:From;
        b=B51rwhIgFpUYTsdTmDpstDNT88k1RcA/ZspikcpBwrRdSmoG6vYWQbwOOrt1yw4dJ
         +o8b147vrdGggNK+jap+V3x5/kWAIjzXtnZNO8P4HNXlYw1nkJ7bqGnaQdNBVtpd4x
         KyzvsEgL/8BQ8stNRMV8AAsnQPX+hu58IuYfYa0pPom11wqOxdF9swfaQq67rB0EVU
         CFBNh5A1BwGquYLzgQ/mB7RTQsdwJM1D/FhgxAnTP4ox2fZScokZTWhzOQYQu1+z0i
         3MrX4Om/JvlfhBJMTCpB2iTj7Q9m0kALMVHVQcnDeumOH9dzOjC1K41G8Ot6WLUdro
         lMRmKAyaB4mDg==
Date:   Mon, 3 Oct 2022 15:47:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 30
Message-ID: <20221003154746.1cf5cbea@canb.auug.org.au>
In-Reply-To: <20220930154710.548289-1-broonie@kernel.org>
References: <20220930154710.548289-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v1BMVlnixVaUCiWVj_xs21A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v1BMVlnixVaUCiWVj_xs21A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 30 Sep 2022 16:47:10 +0100 broonie@kernel.org wrote:
>
> Stephen should be back on Monday and normal service resumed.

Normal service will resume tomorrow (as today is a public holiday here)
so there will be no linux-next release today.

I would like to publicly thank Mark for taking up the burden of
linux-next again.

--=20
Cheers,
Stephen Rothwell

--Sig_/v1BMVlnixVaUCiWVj_xs21A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM6aXMACgkQAVBC80lX
0GzZDQgAgjS6e+4MHYbndRDX9aHcUeBYcti93jUHPhxjqwc2E2GfIi2Ya/tU2kuf
HhU8QcMZ1PJMs4sjVOJjOv2tVC5jSFejubqCoFYeYP90y1en4tKfWPlzEBI1jja0
rqh8rT7+zaP+Hwb+UzbDMYUzughEGec2feo//XkBB61+vZH9duTgx3tHB1cjUiaO
tg2gJ7E02omahjwQTWZkByUqj4OFgdOHtqF5BGD6aijyGHU0WRfOFZ1NsgrTfNvj
mKONSe57PdG0L2Uf7BUq2LVKnSyBAp1LTZLGlaQfAaq7UvbUXsYGtzGyvy26ZWVx
nUxBfS0hPn6rKuE0p5A/BQV9mRmcUw==
=Pkj3
-----END PGP SIGNATURE-----

--Sig_/v1BMVlnixVaUCiWVj_xs21A--
