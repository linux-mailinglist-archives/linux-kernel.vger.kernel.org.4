Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A305E639A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiIVNas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiIVNap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:30:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C7DD07B2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:30:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E1A462FAD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C57C433C1;
        Thu, 22 Sep 2022 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663853443;
        bh=wInR8uefJjXvT2SZqgMSw3Aeupzu3gpSe4DZ3KoW3tA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkSovZfJMK4g4EsJz614MUvw/hkrQWiiVQk+5TwUDSbpCcOEtOV06QcIzUkTwPj5t
         TbgvWkU9yWEcMYNbeLPhT7WXNNsUFhDePSI4GKqAsA0MxsQ05qiKMRX7+ajfpyiR7S
         HUxijEuj/aJa0B/Rvnasr8LDu/b0egqirjTslGPY2ztudcRIAw+/uYWaM+meuVU0JZ
         N98OcZouXmZRU7fGYFPGRRVUHDAcHlweJ/puRpGQ3cssM/wOk2iIXn3oPQKvXwqiJm
         b2Fl7XWcFA6JGbHQLUl4AXvqEjkBlQKHBWGghmh1xMD3KANa6xjgTz6G9ZCy+E7SmX
         vx2okfCTzm1MA==
Date:   Thu, 22 Sep 2022 14:30:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, lgirdwood@gmail.com,
        linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: mt8195-mt6359: Use snd_soc_pm_ops
 instead of custom ops
Message-ID: <YyxjZ9nCBdVovkVs@sirena.org.uk>
References: <20220922103502.49981-1-angelogioacchino.delregno@collabora.com>
 <YyxGXXSp2JD9a6ah@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aiBfMVsZx4xOWY8C"
Content-Disposition: inline
In-Reply-To: <YyxGXXSp2JD9a6ah@google.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aiBfMVsZx4xOWY8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 22, 2022 at 07:26:21PM +0800, Tzung-Bi Shih wrote:

> snd_soc_pm_ops[1] sets some more fields.  I'm not quite sure whether
> it would introduce any side effect or not.  Perhaps Trevor could
> provide some suggestions.

If it does it should be to fix isues rather than introduce new
problems - I suspect the other operations just don't work
currently.

--aiBfMVsZx4xOWY8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMsY2cACgkQJNaLcl1U
h9DpzQf+KMnb+RybmIF1Eut4fCQs9n6503YHXYF9TAwZ78CkI2/5PP9Gc1buqBVz
aPhF11fLUOU6OSXLW+r3Cid7wz+1+zerw13xELulJFJXUYYyFdgHjtvaphjtsVWA
jKON681p0xOVi9K0fScb7wOi21LiClD0c5hSqZuNzJb9Vvsk9+Dxo/o3neWoAJL/
8apxKqDgxkgKSzRowDasy3Ika9NFuPG+3oO20r/MX2D1yo4z410g+xPudcE4Zrzt
IzzY/IzjFkzmeEceJN1Eu63nTxXoxfUPqD3kuBVZUj88SOSK8VSxMHnWY4grR41P
b1DIq2VUpjWPB64v2Zsi+OyPQkT+aA==
=04KX
-----END PGP SIGNATURE-----

--aiBfMVsZx4xOWY8C--
