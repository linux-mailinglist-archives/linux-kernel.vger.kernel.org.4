Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A57743F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjF3Py0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjF3PyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514883ABE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8A5761792
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C4CC433C8;
        Fri, 30 Jun 2023 15:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688140450;
        bh=7OJfj3mRRwh7boKqkb9v7u3M1MnmPwlc5BEi+eCoD/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkBi1TAgIpC7ZQSW3Zk8aXoNhmgecjUToehHCp6xLMSLcf5FGOMITfg2wjUX9+JwW
         qfgfb7bauqO3q3RwO9M5eK5jSkcIe4v5d0ie1cZSAJRSH2r1YYL7Wb4tYRcKuiW9vr
         6jHGMXcF6ejiovEyzeF+mUC7P0sN50pUHR64dI0rMaZJW5dUO+jGsTubNHD/iaROmG
         modtPW5nZix4xJYtW2K1rVngSC1mBZzIsjvbFO7lrzKQDGQJGqWTKf28Kbl5JpzOV3
         ijBrWxhBCUuljye65qKslQIgHuv2BgyZ/dgoQ1DqZAmIgY11kKmoQ1dMia+EdUH0Bf
         ikQCQe9nBxsew==
Date:   Fri, 30 Jun 2023 16:54:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] ASoC: codecs: wcd938x: fix mbhc impedance loglevel
Message-ID: <4dbc08d4-9e45-40d7-95f5-4c12d3034bf5@sirena.org.uk>
References: <20230630142717.5314-1-johan+linaro@kernel.org>
 <20230630142717.5314-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DCVMfBkLXgljzRQ6"
Content-Disposition: inline
In-Reply-To: <20230630142717.5314-2-johan+linaro@kernel.org>
X-Cookie: Old mail has arrived.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DCVMfBkLXgljzRQ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 30, 2023 at 04:27:13PM +0200, Johan Hovold wrote:

> -	pr_err("%s: d1=%d, c1=%d, x1=0x%x, z_val=%d(milliOhm)\n",
> -		__func__, d1, c1, x1, *zdet);
> +	pr_debug("%s: d1=%d, c1=%d, x1=0x%x, z_val=%d (milliohm)\n",
> +		 __func__, d1, c1, x1, *zdet);

Indeed we should really be able to arrange to make this a dev_dbg().

--DCVMfBkLXgljzRQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSe+psACgkQJNaLcl1U
h9CDJgf+P+jaWniR0//IBmvy7CV+0jDyq6kdWfoTrfeLkWm5xzGHOnkC7rYuf2pz
cqpg7YPaH2ebAOd/MOyA4kuY8JM5bn+rPCjVeQCb2nEsC8srnMTP+Sel8lUQ0otD
3+w/0fAX6xVGQFAjTMVtgkGEkbJBv+NcWVDS3uVUv1KnIH0G0sh2PunuvhN37Fe/
/dXGEKMtqV0PlGpLN+VwbqEH5iK12SaW+5SoK8iFQkdxdWTXUDdu61mJRL5Xrg8O
wYe1hJIM4/Ne/Y6pOZ76TMGSEppI8kH/oKRwa4rSwl8rlIJfdzULzG+XFJH+DPZQ
BTig6ASZoMy9x1TP1/JHM91orIR/Mw==
=h3V6
-----END PGP SIGNATURE-----

--DCVMfBkLXgljzRQ6--
