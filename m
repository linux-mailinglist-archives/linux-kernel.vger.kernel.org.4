Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1144666A41B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjAMUah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAMUae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:30:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0CCF580;
        Fri, 13 Jan 2023 12:30:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 014F162323;
        Fri, 13 Jan 2023 20:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE60C433D2;
        Fri, 13 Jan 2023 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673641832;
        bh=ZKBKtD9F64Mm7IQ2EpI4uviTsyGYvqtzNM7Rwk6Om+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHPh3WmTeCuNCbqzo5Qkv9i6xYBjdliGBhu3g56lE3E9rug4UjRZdKOv8dD2RvG74
         7M4C+/Np1NRvxpNyRB05orEyL5oZo7pSdWbIASx3OF+yQcJoBLlvfsUhVjBomFLYJR
         d8Xb1/vpxk/fRFBZec3lqGzwXIoRq9W0etbTvqDECYLbmxgucSVvZCD8PpjcH+U0ff
         RWSp8je68ef2SV2uPz4G6gC4dZo1o6p9QztUNiHmx0tqzXeybEukXQtH7JX36pQsUQ
         dsG1eJ4ndoWUZ/frYYdpNcKkryU6RQBeXlYfJWICBUZP5LmmXPAsQb6jsqgk8rI4sP
         1C+ccoEbLQxwA==
Date:   Fri, 13 Jan 2023 20:30:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: BUG: kernel NULL pointer dereference, address:
 0000000000000008 - RIP: 0010:do_wp_page
Message-ID: <Y8G/Yu22ZfUoQbed@sirena.org.uk>
References: <CA+G9fYt_b04YNCCv-iTZTtwb5fmNEQ0abiO46qW_-SrA1GQX8w@mail.gmail.com>
 <Y8Fkjxsq5EOtGiql@casper.infradead.org>
 <CA+G9fYuahjaNs6ia1UOeF98hUhonAt0Z4YOFGcqOKt3J4tRvTw@mail.gmail.com>
 <Y8F+iKuJWAFsUg2m@casper.infradead.org>
 <Y8G0fu7Kpkd8s7DE@sirena.org.uk>
 <Y8G27N+0Mpr9WmgD@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bxEJuMAsFGomarQ4"
Content-Disposition: inline
In-Reply-To: <Y8G27N+0Mpr9WmgD@casper.infradead.org>
X-Cookie: I know how to do SPECIAL EFFECTS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bxEJuMAsFGomarQ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2023 at 07:54:20PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 13, 2023 at 07:43:58PM +0000, Mark Brown wrote:
> > On Fri, Jan 13, 2023 at 03:53:44PM +0000, Matthew Wilcox wrote:

> > > Uh, are you compiling your kernels without debuginfo?  The results
> > > from syzbot & 0day are much more useful:

> > FWIW here's a decode from arm64 (the boards I sampled all looked very
> > similar):

> We've identified the bad commit now ... this thread is just about
> improving the process for next time ;-)

Ah, OK - I missed that thread.

--bxEJuMAsFGomarQ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPBv2IACgkQJNaLcl1U
h9ByiAf9HOJILf7LMpdFqRf91m/yZLVnOEqBaQrsTKyLAQtzu0cDOZ6ZXi2+eBU1
qbUt+Knn9DGxYnfKjLsQ0XWYRwNV9LeJivIAYMhWVCDDaSi78JCzBWauJb9VMVre
zLRrrMHb3CuBkn/WBLr24/O3wjdNJQmJqqj0pN72Z5fPGh7YdFjKt5WO3XA890TN
xVRtGUda9doWiJ6T61QJ2vDYZE9l9pGO4kgNG5NLq+momwP87HdvGGVobWq3COF7
4/w5KFB0Kf80p3eroSnLPzqORklA3A/rf0eEwSUNx4GdBL5V/LSMwrRg1ZzI7ncN
Xib1OKQErB9UcjlHH/2e/kfLN7bLbA==
=0P7x
-----END PGP SIGNATURE-----

--bxEJuMAsFGomarQ4--
