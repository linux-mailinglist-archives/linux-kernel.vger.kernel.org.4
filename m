Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FF47097FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjESNLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjESNLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:11:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6ACB6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C78136576B
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B023AC433EF;
        Fri, 19 May 2023 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684501896;
        bh=v1r0gkCrrTU6g3cAA+Cei5Y3vKCC6lB4xTy+3dGEcEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VKIuJ+Yk/FPlF7dJQZW3Vz73Vv8xyLUPBQariSReOHBLxmTL6jvSvOLPvCv6jSf1c
         oEbjWOqpwobRD1koqPXXWsD/oVdZ0uBl8KxuDX3XNWAD0xWvB48J5l1DakqIRHfEtb
         7CAecvJJPUW78ydUE33P5pJ+04Qotz9OKrPe9aYHVeJ5XpiwMmzwl2zcZJ3gg8RF1c
         zGO28dnJ3k7jgxi1jhCl+N0lta/f8o1dUIo8Y/+9/B7r52IheQrvip6GsdwhdIODDO
         ZNI92z2GNQuUcj2Haa8MIRyp3v7Jwcx8zPPwsNFFAJEv1uKrbuCrCjzfRErjZl0Tcf
         3dNa5pgE7AzYA==
Date:   Fri, 19 May 2023 22:11:33 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 00/12] ASoC: codecs: do not store status in state
 containe
Message-ID: <ZGd1hZSO4zdO8gdD@finisterre.sirena.org.uk>
References: <20230518072753.7361-1-krzysztof.kozlowski@linaro.org>
 <ZGX8v3qjkmfMf+J1@finisterre.sirena.org.uk>
 <cc4109d6-3125-0738-537d-34f9fa2c2fa1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yt+Eq0IulzcknXCj"
Content-Disposition: inline
In-Reply-To: <cc4109d6-3125-0738-537d-34f9fa2c2fa1@linaro.org>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yt+Eq0IulzcknXCj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 18, 2023 at 12:33:17PM +0200, Krzysztof Kozlowski wrote:
> On 18/05/2023 12:23, Mark Brown wrote:

> > Please write proper cover letters, but don't resend for this.  You
> > constantly raise small review errors in other people's submissions...

> Since you asked for a cover letter and you did not apply the patchset (I
> checked in your tree), that seemed like a feedback for something you
> want me to fix.

> If you want to give feedback which person should not immediately fix,
> please state it explicitly or through applying patches.

> If you give imprecise messages, don't be surprised you receive different
> results.

I should not need to explain to you that a cover letter should have some
useful description of the patch series it is a cover letter for, there's
a degree of obviousnes one should expect to be understood especially by
someone who is clearly very aware of kernel processes.

--yt+Eq0IulzcknXCj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRndYQACgkQJNaLcl1U
h9AyMgf/WmqY17FrUpqZnaDAXyTwfGznPp86Z6f5ThcJoY1/vTjabJm7/9ymvIzc
qmVqQ3nwFrAMToRZrA6iurFTB9t8udktqK123v/7fjj4WIfN4sbvizrj/vZPIZJW
Fa7MVT0uh1stw50px5PqenQRkqUrLrM95GPtyowTv6YWDFJVCI0J3LXrwe57j9e8
9ncBcMeGxafKBz0k4VM3k8dnz4hH6mDBhTa0e04iSoxpC3VV9xW67LauJSWbSXMR
56evNWwrD8SeWLUDI+1JtNRjUMkhuRjq9u54zfeZ329BBfOu9/Cb/uitNnzEMspL
aMQhL23uF3uLQi+lGmjIK2xztRY6BQ==
=v8Cm
-----END PGP SIGNATURE-----

--yt+Eq0IulzcknXCj--
