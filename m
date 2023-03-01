Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C3D6A75D9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCAVIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCAVIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:08:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756A89744;
        Wed,  1 Mar 2023 13:08:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB7DC61492;
        Wed,  1 Mar 2023 21:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B4AC433D2;
        Wed,  1 Mar 2023 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677704894;
        bh=p6qGjDoDT+44oV4iOiUYUowNT/TFjvtfCr2WQQ5zZJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AacK8/b8OP2n3hOU48sDUVulKN3hqjiXm4CFUgRhyaHzqPyYqqf5AnhgWwoynJut/
         TG1cQmkoTnHh3X9wClTdPwPRf+dS3dYLf0UEJYUv7Shf8s0iS6QJWoU8D0uN2h9s6/
         rWCD6nut18wMtty4Qc9D7Ye67zF1RNGPueNE94PR+234L2cKwcOEKNwnXrya+l/HVB
         fp6hWNmgamv4F0/VzytypfzvM6fUus4qzfE+E0JKPlMgUHo9twOOVMLTBcp/jmUZTo
         mMR/iLAUpQx3AZTwp8xXfdwIKQ1yl5Uwl9u7KUARhTuznXZs5+WjAXfkuTzH5F8xq2
         3AnJnsgogRA+A==
Date:   Wed, 1 Mar 2023 21:08:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: wlf,wm8524: Convert to
 json-schema
Message-ID: <Y/++uAN53uxRf93i@sirena.org.uk>
References: <20230227091938.1671416-1-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="72yOwOM5yKv3D7VK"
Content-Disposition: inline
In-Reply-To: <20230227091938.1671416-1-chancel.liu@nxp.com>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--72yOwOM5yKv3D7VK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2023 at 05:19:37PM +0800, Chancel Liu wrote:
> Convert the Wolfson WM8524 24-bit 192KHz Stereo DAC device tree
> binding documentation to json-schema.

I've queued this, no need to resend.

--72yOwOM5yKv3D7VK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP/vrgACgkQJNaLcl1U
h9Duywf/VGO9Z1UIpM9orCVmcjeFQkaNL2qivXVVAaH5fpnvmcT76lulq4YD9kXc
29dBThZA64N0IAWauaalgUs0Mng4w8bKmDjkv3tsUNi+luChrgf+8Lap3ImOh6HL
COYTQvw1qK9mP6PbeRtho5NWvCtNsOfbdouws0ti0hYEVaX0tzz25Rkp+X3h/A8v
yCTJlkO9YN8X7Ghsy5gRvwnFsmrxFoD0p//VA8zqA3waweb2DEnmcwqDsxfdUKUm
5WUvi/hUwj1BkN9I6ppzVbUN2CQs6T7TRScTgQtbvrwb/mWL7nyOuhJyDx8CLV9w
Iswoxkkyzk+yJyW2sDR8jhRtqy9K1g==
=1kFC
-----END PGP SIGNATURE-----

--72yOwOM5yKv3D7VK--
