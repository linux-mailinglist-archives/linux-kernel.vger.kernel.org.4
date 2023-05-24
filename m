Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360F770F44F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjEXKgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjEXKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3FC98;
        Wed, 24 May 2023 03:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08D70615B1;
        Wed, 24 May 2023 10:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E84C433EF;
        Wed, 24 May 2023 10:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684924601;
        bh=hi083FkRexhMLoidEEKy5XWziKKRM1PgNlp/EQlYmVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asbJvu+16MZuQTh7gbxpwMrJTcvjfHd4T6JDwAkJJlFE/EAssy5B+lXSI4CsJooAC
         GsqJUEODGl0h+lSkFnrAGaSKtsjZyM9UnsBZ7/5iQuEXWxCu9MtWGvUah3EfzjUKsJ
         QSid30r06xwGLXYnUiyHdLWw1lLxCJGQBPrJUBuXftC2w05fbnD99Gxuhy8RsYgaYn
         vgBek6q58SIUmwO2S1J7KPifsFHaMUVdadB7YXrhUyCpXuJ/gtdnRbnRZQe0mORPuK
         w0owrUkSjXbYqiGRyJCx4+Zzu4ta9kd9l+GgUAXRugyIQcdZVmvgQdKxk43Ra66Cba
         T4ZmRgdhGlZqQ==
Date:   Wed, 24 May 2023 11:36:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Ning <zhuning0077@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@collabora.com
Subject: Re: [PATCH 2/3] ASoC: es8316: Do not set rate constraints for
 unsupported MCLKs
Message-ID: <16e818c0-6917-44d9-8cb6-27bbf41b896c@sirena.org.uk>
References: <20230524074156.147387-1-cristian.ciocaltea@collabora.com>
 <20230524074156.147387-3-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BL18BDqPwAF3M+kF"
Content-Disposition: inline
In-Reply-To: <20230524074156.147387-3-cristian.ciocaltea@collabora.com>
X-Cookie: You will be divorced within a year.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BL18BDqPwAF3M+kF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2023 at 10:41:55AM +0300, Cristian Ciocaltea wrote:

> -	es8316->sysclk_constraints.list = es8316->allowed_rates;
> +	es8316->sysclk_constraints.list = count ? es8316->allowed_rates : NULL;

Please write normal conditional statements to improve legibility.

--BL18BDqPwAF3M+kF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRt6LEACgkQJNaLcl1U
h9AHVwf+KYnUvOtkX0kkKv5bSX8q6lynYNs4cwPyEYa4ElWGkL05TG7EvMqFyl61
NAFr7ZbaXS5F6bk9tM+owkDvWBUl7XF0Wgi3Bgkch5xmKSfeYDCXnP7ptpiS8wxX
2giK/jQ7VoZ2vRo3qAquYD+hBmoLOLdsF/CIpUONtUhzfKldB0zyhPP6MFtK7n9J
8s8a4b2r2qszuEXCWQ1NvyikCLMcWoWIoopwEK8pN3371eXvEBvOyex42sEXweDX
e8dv+hwlxnEV+LDLxHFUPq+bnxgneJgv6LWdXaTHdI2V0LC1s4vkBmI0jGn+4ses
8Cd5IhmPalyR6EYRq0qoQPY3e4ipWg==
=Bx7i
-----END PGP SIGNATURE-----

--BL18BDqPwAF3M+kF--
