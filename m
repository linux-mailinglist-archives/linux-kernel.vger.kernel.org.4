Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A50716F87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjE3VQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjE3VQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:16:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FC1107;
        Tue, 30 May 2023 14:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D55B560F71;
        Tue, 30 May 2023 21:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F88C433D2;
        Tue, 30 May 2023 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685481365;
        bh=L8Q39KcjX9asWMuLDLCMaq8IoG34g1EVquhTGcwvXMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/8HIU2MppMHomLQbzgZScvfxbtr/K8NRALIWFP0ArkgmrWWAbkfjF9NmawBJC/OL
         UesvctGmB22SZeJWyVSFbWhR/vx+ZxS8DCt0xYucoUosbzuq1HM17mr1nXrhSreFg3
         43t6DQHywadA5kJLLJwQLGT8vJeQ+YUExop/7H1sQGCqeCC5VEoFfhXAjvq8LaHxVi
         gZdXmJzhNK1X7TQXiAkGPFlGpH46WWc9xvTP3e2PFXu7Ylrx1TX+3JTO3TdRkVfK1g
         cK96dDQXjwT6wblQ5dwGEhU8spTP4y2o8oAW67x0WScI2IXJE2VR1n4rsbZpI4YGJD
         g16QBewjjQ2Hw==
Date:   Tue, 30 May 2023 22:16:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Osama Muhammad <osmtendev@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] spi-dw-core.c: Fix error checking for
 debugfs_create_dir
Message-ID: <30bcf77a-3e7c-4f13-94ab-f4efc52193dc@sirena.org.uk>
References: <20230520224025.14928-1-osmtendev@gmail.com>
 <168546845148.691057.9965315836245052581.b4-ty@kernel.org>
 <20230530211446.foqpcfha6hjruhow@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cDAaynX61SC8vgCB"
Content-Disposition: inline
In-Reply-To: <20230530211446.foqpcfha6hjruhow@mobilestation>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cDAaynX61SC8vgCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 31, 2023 at 12:14:46AM +0300, Serge Semin wrote:

> Oh, thanks. I've absolutely missed the respinned version of the patch
> (it should have been marked as v2 though). Anyway the change looks
> good except it introduces a redundant empty line at the tail of the
> dw_spi_debugfs_init() function. Is it possible to rebase the branch
> and drop the line it? If it's not I'll send an incremental cleanup
> patch then.

I'd rather just take the incremental patch here.

--cDAaynX61SC8vgCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR2Z48ACgkQJNaLcl1U
h9AaCAf/fR+F6c1cm8RkIndWTi2+HtG4GKXe+YL4jJH4nj0Yhha4dDMCOFNEYLRu
VFfatNHD3nXeGc7JRWOeC0mMik5sMHC3GnKoKDWehBg10DxF1vXPHdC98+ARxncA
Nr9yfNkfYeAKBENjzqUApzdeSQsbNmUQGHKuNRe/mGf20ZOJc8WyTO0A+ahvOgxP
LoZ7JYnSeK06BPia6yta82KKxbl6nCIqHFla1QIZ/UpM0QK/TIpGsAqf+c412uXR
547sXmW9fyka7NCyqYp81ZpNlPtRkJFOxZP+NNFCrfmZcJ8e5707PJR0Ls/FN+ak
XYFyUyk3PeKp4kmfmRUdttxZqQIqkw==
=UMeQ
-----END PGP SIGNATURE-----

--cDAaynX61SC8vgCB--
