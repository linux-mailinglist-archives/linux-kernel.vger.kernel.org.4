Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133AB6E6516
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjDRM4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjDRM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:56:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F296217CF9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29FEC6347C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A320EC433EF;
        Tue, 18 Apr 2023 12:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681822558;
        bh=HSBVQEr2YenXIsFg84DdNoNf25PlYiz5rIbOySfFikc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpAjkp+2LYPiA300PIvALCfoPj1m+xNP0kLMpqFa012MrW0N7DkaVTPp39UUdtYYK
         CBKVaxgYORLb+2M5dk8LvHc8px0HZJcAgyUQpLT2pNWPR+wF9H2ptbHT58OcEoeYYm
         xaQ1mIPyal6ptLC0VNPc1pFjm0sitRTp4CKW9fJESjT0fRMB+sRnc66B63Ms2RTBeE
         BH6kh6L/P7aEB28c/vkRUWdpkx1l1vcrq5bVVq1rms+7fMYaNk/5KFrXpR4mMOXvcq
         YFCVxHNaabrnEqwMymSAQfG1VPBPT3jhsoYiScrtQ2g9w7nvHUh2GJRZv4T8/SyPah
         kdpifmB5NaFOA==
Date:   Tue, 18 Apr 2023 13:55:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: codecs: wcd9335: Simplify with dev_err_probe
Message-ID: <63a3b1c7-a68a-496c-99fe-9c936f4ebd94@sirena.org.uk>
References: <20230418074630.8681-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aPaN6pUpmk2Njt+z"
Content-Disposition: inline
In-Reply-To: <20230418074630.8681-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Just to have it is enough.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aPaN6pUpmk2Njt+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 18, 2023 at 09:46:27AM +0200, Krzysztof Kozlowski wrote:
> Replace dev_err() in probe() path with dev_err_probe() to:
> 1. Make code a bit simpler and easier to read,
> 2. Do not print messages on deferred probe.

>  	 */
>  	wcd->intr1 = of_irq_get_byname(wcd->dev->of_node, "intr1");
> -	if (wcd->intr1 < 0) {
> -		if (wcd->intr1 != -EPROBE_DEFER)
> -			dev_err(wcd->dev, "Unable to configure IRQ\n");
> -
> -		return wcd->intr1;

This is already not printing a message on deferred probe.

--aPaN6pUpmk2Njt+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ+k1gACgkQJNaLcl1U
h9Argwf9FVUXbPmi43xza/mxro0zXAPflx5weIplmXJzMEUOk6arptqbRYUP08rn
MGe98MgbZI21r4uVM8VSyJmCG/FsyMvXaw39CrV6XeIJ/K8XUkeUQk1Y9oONTbuq
25jaOfawbhBOts5F8bQ5/hAniS+F7Tx/cUIuzVxsEgWP6evL+fqEXayQPUSiBE91
MJ+gcOVlBz8XkmVX+g/60wmmXYkNt9j8J0rKo+bN64MITZV/795m6JNZLzHnApI0
M1IXd5RadXtuFznJz8YPuWHLnBREoi2M06BskwkmIViZjJVykoIzRN0vSA74XGAK
OmRoIgcBQ0SYDhypfFBej5A8B2zx+w==
=P3mp
-----END PGP SIGNATURE-----

--aPaN6pUpmk2Njt+z--
