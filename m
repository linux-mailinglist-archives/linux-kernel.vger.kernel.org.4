Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092355F4218
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJDLjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJDLjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:39:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8872B636;
        Tue,  4 Oct 2022 04:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73B8D61387;
        Tue,  4 Oct 2022 11:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C64AC433C1;
        Tue,  4 Oct 2022 11:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664883553;
        bh=6YTbs/8Zu9MQF65H38BQP4KwDQe8TVEJ9GyPe92EX8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YT4zutDLadFIhyEgGjoyQeo0e0hiu4KzrfSk4KKzYSXSI+uCMCKaau4/y7HLRjq08
         ciRqb0Gd9t8Lw0oGMfl0Nqntkv+tGFmp87KI8qmiTlek+v2B4u5gWoERoV/hkUJ0f6
         KSv9RrzeaEtbE5m6B+BTg+rWTiPhLU+O88AtnXYsU3j/hM35eddBXA13pcCG5Qo791
         BITZD8m2+ABFOqTWx9Og3W3VlxcUg03Px85UO5kMVYbDUXEGwOEhy8bdfldlsFjaKf
         t4Uu52ana9eKzyT7E7Cikmd0uyLoZAxzZ2zTV9EE9vZhtUNIynFcMwLFsyPMMe4U2h
         hQV5Xts5yTOvA==
Date:   Tue, 4 Oct 2022 12:39:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Airlie <airlied@redhat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>
Subject: Re: linux-next: build failure after merge of the drm tree
Message-ID: <YzwbW4YQwQPsRPYw@sirena.org.uk>
References: <20220930105434.111407-1-broonie@kernel.org>
 <20221004132047.435d42db@canb.auug.org.au>
 <CAMwc25oshRcJBoCT70B+b42bh5sPqgyoHuBx6K6ZLrwBMHnJzw@mail.gmail.com>
 <20221004140558.64f59f2c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wFBH04Nbw8pvZ2fD"
Content-Disposition: inline
In-Reply-To: <20221004140558.64f59f2c@canb.auug.org.au>
X-Cookie: osteopornosis:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wFBH04Nbw8pvZ2fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 04, 2022 at 02:05:58PM +1100, Stephen Rothwell wrote:
> On Tue, 4 Oct 2022 12:24:37 +1000 David Airlie <airlied@redhat.com> wrote:
> > On Tue, Oct 4, 2022 at 12:21 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > I'm not seeing it here, what gcc is this with?

> I am using an x86_64 cross compiler hosted on ppc64le - gcc v11.2.0 (on
> Debian).

I was seeing this with an x86_64 cross compiler hosted on arm64 -
Ubuntu 11.2.0-17ubuntu1 from the looks of it.

--wFBH04Nbw8pvZ2fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM8G1oACgkQJNaLcl1U
h9CTXggAhMyKGinOhPsCxRiu9VsYCxGCEihs/QBu/2zmSBJoLaXCF20hi4tCMdg4
hKC7A8FqcLbFwPEN9FcFmfE3EYU6rLxvAeG7Qx/fb1yUQxrexoLWVCAz0zUttKy3
+L5IIlCh45uqWz05NhyD5WshuforslwDXVeY9Lt1RPSpi4z0jhoVg75lz3uiHhzE
UhQzybiHI/2dwXKjFZjz6PSeq2LFUuvKsE+5O7Hb35WQ3tko7119EoBUjHAP75Fm
ZmvoqDim7gxHDvILoSGc4APeVicYZ5S9VZAZsJxoUqvMDzW1SBy5hGg2Vt7xkUuW
NeI/T/X5gbYOnZPI+PKxpnObPxLkxQ==
=M5vb
-----END PGP SIGNATURE-----

--wFBH04Nbw8pvZ2fD--
