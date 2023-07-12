Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98605750830
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjGLM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjGLM03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:26:29 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7385EA7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=rejZ
        5mTvsZMPfmMa/85aO/gvEZ1HzcesnUzhj7Rtx5M=; b=hWTfY/bTig3TgvUCEspK
        RW7aWSfg9iaLGa+f/Z1sljO0/YBfMZH3g0AZQtJ6Q2si8OdxSHdR/2xBSzAVdjdt
        NOoiukjY8GYFlCwrZzjIgVK8PxXcxXpk7HuZU64eewDRv6l4xH5rMDTiLfMUnHER
        5c4QKpJMBCc1Fx0uQef2lpes6VE0jbWyZPIFSaadw7I09cBXHwrkHYiQ3VueVH9J
        dwQwEzK79ZEAcq1ioFzeIvVq9u4wu/viHWME1QMO2mVXKXj/TwbxHhB7uOs0IIVu
        uddFQIqc+5CD6W+ZEXraP3Au71Ql7LzAGtCIxRojob6W6BYxrd228J7Usf3nkqEn
        0g==
Received: (qmail 1611144 invoked from network); 12 Jul 2023 14:26:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jul 2023 14:26:23 +0200
X-UD-Smtp-Session: l3s3148p1@GuziUkkAnsgujnvL
Date:   Wed, 12 Jul 2023 14:26:23 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] mmc: renesas_sdhi: register irqs before registering
 controller
Message-ID: <ZK6b70cCxM8h47Z8@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
References: <20230710140825.47793-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdXr4CmupM9vadidHdyv0ShOhR2yYCCxeDt70d1rPUXBdg@mail.gmail.com>
 <CAMuHMdWwN9Z2Bui6PR6QxBoLJnvs--BXXep10NR7wRd1cfqKKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bry+Vts5mdcdFKyJ"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWwN9Z2Bui6PR6QxBoLJnvs--BXXep10NR7wRd1cfqKKA@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bry+Vts5mdcdFKyJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> No issues seen after reverting fa700d73494abbd3 and applying your patch
> (plus the fix below) on top of today's renesas-drivers release.

Thanks! I would have fixed it differently but I agree this is probably
the best version when backporting is also considered.


--Bry+Vts5mdcdFKyJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSum+oACgkQFA3kzBSg
KbaW4BAAiK5dSXGHctV7D2x4qneA0M+40+sgLVdmramiNOvkaEEr0jpHyFFCsVdu
7LjzOHxYeZ91jgg+2i9+rs5w9CBGKQv5nrC1NisbTNDHbDMZ920iu7k9tlTXIm0G
LHl20Ggd6QbKxkQ5Inv7imFCrNzL9d25AHQfre+8s1c0i2rsJ1LHikIyfAj2+67g
6dEYZlI6zLDNo+ef6gwrEr6ehXIu/Ii7aQXdIKa2dqjjYjfuE7vI1qXQZasT+vKy
hLxx1AFI6y5FiSanI/fWBvOI615WgqPNGATEW32SNjiD9jkMhySB5Ly5FeEaHXK4
oTQGF42LKaYGHnPYqQyytST/v01Q6gD5zgox00E4PxCNX6kkxFf6UAfT5/yhc1Dc
qtWMw17p+sKkcV1mPMcsdF8wcMtPogJRU9cHiGVWnXBIHo7RaPv/XbU2HeEahglY
bWxWnA9bdCKdzp6XCrtMvo89JzJMH1cRqW573w8zhwYu3w3Njl5oGqgp9+16o+MZ
gwHdqbubW/5TH1Vyyo5S22a14eVaz8b0N//EYG/ueKeJ5FOh1P2CbILuEHqlCThx
lpLYGTOv7jdumbNerhV7dKEL1RlgGb5gbSsuXHsTgAiw17SjXiKR3ySqSTMapXaw
3iwkpJqzexViI/z3uo0Xp5bQ/5FAu/Wk7MaHUgw7aIn7ukUrLrg=
=o8ZM
-----END PGP SIGNATURE-----

--Bry+Vts5mdcdFKyJ--
