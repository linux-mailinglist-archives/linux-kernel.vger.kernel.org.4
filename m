Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB4C5B416D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiIIV1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiIIV1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A0611E6D8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:27:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70A34620F1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 21:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81DBC433D7;
        Fri,  9 Sep 2022 21:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662758822;
        bh=u0Nh9TSTVTuxdZWi8Dbgj9aIebrzI0l3cSRsCgLMXIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvvJcbkZ/tG3EaIqrWFPvzsk5M34BxgnN+Eh+8UUkwXmfAium6lM9+kCrqCYiikjr
         dK747TwvDbux3CcinsBpx+wF08lzMzQF6oMs2cSxD8PCP9m3wCBoDjyRdFTbfM2emT
         o5jeHMbAjrsM3gcvNBniW2ZAxqoXim2ZKYni9Ge0S5mJ+6PO1sVnDqSQmaxW0shDoJ
         gBdLuHLyCjofEBUnhRY4nWVo2exWF15IDNWz9JywMbrnay1IFnOQV9V5XJjkyiogdW
         HoUMQur0TyUQ1VMKb/xEU84hfpt++PAn7jSPEhgi1RhJDAuHT0gN+JpwRyhS10kocZ
         cjdiY7IU+6mxg==
Date:   Fri, 9 Sep 2022 22:26:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com
Subject: Re: [PATCH] ASoC: mediatek: mt6359: fix platform_get_irq error
 checking
Message-ID: <YxuvoTEXIshOy+C7@sirena.org.uk>
References: <20220909064511.22343-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gGLklRiEh69K2ySa"
Content-Disposition: inline
In-Reply-To: <20220909064511.22343-1-yuzhe@nfschina.com>
X-Cookie: May all your PUSHes be POPped.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gGLklRiEh69K2ySa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 09, 2022 at 02:45:11PM +0800, Yu Zhe wrote:
> The platform_get_irq() function returns negative error codes on error,
> fix the checking.

This doesn't apply against current code, please check and resend.

--gGLklRiEh69K2ySa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMbr6AACgkQJNaLcl1U
h9Bf9AgAhvx/rf91KwlZu2N+8PgTsgM42+GZFA6dK9i2ML+gdMa5aYMUlrsQ1phE
fDgTHlDCuRzu4v93hZldk3WCpHvYYs4yoA6Tbx6d6VbQ6xnsyR/gT5FNlcuyRPN2
Nydc7LMN7uPP22r+8IlzVK0LaPj5x7rSW7G6csoFgHw3C/2VgPUjOBE2N97xs6kw
RdLU5tCIrKRvhSlVgCaVrMe/mCNAHqoXY7BTCv6nowNfdQ1gfCwrzcJAh6bfrYH1
FWI60cRcGnYyCyZNeG2bn7ZEG2/zv6nMXxAIqhJXnNnJNd5K6dzaBS7Q3M/3sFsz
kKKEzwz9vszxXeeI9vzy0QbT9dv18A==
=s1Us
-----END PGP SIGNATURE-----

--gGLklRiEh69K2ySa--
