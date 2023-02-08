Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BB568F5D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjBHRnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjBHRnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:43:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F67C53E6F;
        Wed,  8 Feb 2023 09:40:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81143B81F1A;
        Wed,  8 Feb 2023 17:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA14C433D2;
        Wed,  8 Feb 2023 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675877964;
        bh=x5D1v44TfkTZciEELrTCn8yNDssP2aPN4STf6+woJyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pv8mKkINDyj/chcSgHIZlUO4ObbGI4WTK246iYw9iK26fsgDNjM8h1maTrcJ9x5Yg
         Lu55Uq5KROrkqnwn8ajpGyFnd3R2svQZ7XQ3bWP0p3CCnV5UHR5RZ8nbr3XP0Sc0ow
         HO5bIdkJwNv+Jn0g8xtMztQ+vwciElnBklLJhESI29/5uO4akyVkJNUPkEDdUdyNcQ
         1izDB6nqrZDiKgbX1bAIKFEvkK+6/2t7UpI65+GoRPyMFBH2mW42Dc/nN/Ajwu+N0J
         0f5/4TmDaQcSOPCnbOKoXpWhvfYqvEdtlixy4IbjEXbTMysDimgu2nmjbJ7b7MxAD1
         AHeEoPdbqn/DA==
Date:   Wed, 8 Feb 2023 17:39:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8994: Convert to dtschema
Message-ID: <Y+PeR4EFfcVDbUfV@sirena.org.uk>
References: <20230208172552.404324-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LbXOcrSJthApyg7e"
Content-Disposition: inline
In-Reply-To: <20230208172552.404324-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Walk softly and carry a megawatt laser.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LbXOcrSJthApyg7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2023 at 06:25:52PM +0100, Krzysztof Kozlowski wrote:
> Convert the Wolfson WM1811/WM8994/WM8958 audio codecs bindings to DT
> schema.

> Changes against original binding:
> 1. Add missing LDO1VDD-supply for WM1811.

Both LDOs are present on all variants.

> 2. Use "gpios" suffix for wlf,ldo1ena and wlf,ldo2ena (Linux kernel's
>    gpiolib already looks for both variants).
> 3. Do not require AVDD1-supply and DCVDD-supply, because at least on
>    Arndale board with Exynos5250 these are grounded.

Are you *sure* they are grounded and not supplied from the LDOs?

--LbXOcrSJthApyg7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPj3kYACgkQJNaLcl1U
h9DxOwf+KNudxKFl1rIurGb3jgncHVqN9TlkDoZh7sfauE0He0PsMCtH07bpt28N
Okf/Wf+7r/oY0OvigxxprrYGaVO4QlVZqTFocS5VSFse97Vl3vXIlFv7ZZ563qmB
FK15zIm/k/I5XjzZMfQnkB4p/2qAVYTld+CA9/KW5zymhuw12sF3uv/N33YlejRD
v10mWtG9k2oRTxCXmb+q3qZPcxNK5v19Tli9cykxjm4H9Da/QoJsSW2C2KFJjies
3MJm9uu0mAheXuHBmftvsaEL0NRuWnvDE53PjNDPfxs1KrdBE0l8sJZYIPoNq+An
5CfKLqo34KKLXEz7IRELHR7nX0OO2A==
=gqSy
-----END PGP SIGNATURE-----

--LbXOcrSJthApyg7e--
