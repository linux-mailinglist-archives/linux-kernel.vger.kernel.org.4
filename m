Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FBF63A87D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiK1Mdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiK1Mdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:33:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020211A22E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:33:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C64E61149
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18E5C433C1;
        Mon, 28 Nov 2022 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669638820;
        bh=NDqJR81NdolYtYSvcAlTghvBCmhJmiX+dSFRJUV7Koc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cEsVubJBs/km5SfTz6mVez33b+F4ojjwX+iMt7z/yM+ugiv7KNH3cvFUmt1zbv7t5
         WYQhXdP/vp2TJ7VFyhBnWqM9X9WVQ6wrtpDRYGQ+8PXRnr2+2JSuA1OwWepcXR7Kuo
         k/OmNK/rR8mIUoZR0Q4HI63v3cfDrGqtUn34+r6Z+4Km93JTRv2f5QetSw0lrFUT80
         IvoTHSqxUyK403hYyM0AWmNj/tSPyCZk6pnb7w19fg6CvpKzdvaDLlk6B7G87y0c4N
         kwYkrd1+e3TJfnS4cIo0g2sxyHGzfJKpnZ/v8WliwzvXeWYLkYf+wVqwufny8E5+3T
         P7zORirxCPDcw==
Date:   Mon, 28 Nov 2022 12:33:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: rsnd: Drop obsolete dependency on COMPILE_TEST
Message-ID: <Y4Sqn0xOP4R/fl9P@sirena.org.uk>
References: <20221127193441.0b54484d@endymion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RxD8GampBzRF6XNY"
Content-Disposition: inline
In-Reply-To: <20221127193441.0b54484d@endymion.delvare>
X-Cookie: In the next world, you're on your own.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RxD8GampBzRF6XNY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 27, 2022 at 07:34:41PM +0100, Jean Delvare wrote:

> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.

As ever building without OF does not preclude building with OF.

--RxD8GampBzRF6XNY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOEqp4ACgkQJNaLcl1U
h9CdMwf9HHuzhgWN3mSieKcc66DQ15wlrG8W7njOnW1xw4PkaeeJ2dmjcG8qkfua
RewBXhDfC0EMMlnlM13gCx5CzqriVpoBTW/hvFMKZuFkxzVSfdWCc8NEe+FONONb
5j8X5M3rD8/WD6pMCag4V2S7ROgdwXqjdeYjLtX4k9eWsOLnH1Gp/7NkgtqNEEXv
x2L0dffjSR+EJ2QxSuidRYEfXRIRqOvWPcuSR7NQN4I57ilIzMDOD1/f2jIBbIY4
jRrzSmb9tukajj6JHuNd1NZfPHq6hgayBIaVDom8m5gP8M+mGGwAdM4cuS/5dl8C
wYz1xZDFGu8HroSAFMxwNF7O+iIp0Q==
=LuHF
-----END PGP SIGNATURE-----

--RxD8GampBzRF6XNY--
