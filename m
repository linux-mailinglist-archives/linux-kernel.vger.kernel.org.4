Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774BB6C7450
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCXADr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCXADo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:03:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFC02C67A;
        Thu, 23 Mar 2023 17:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF36628FB;
        Fri, 24 Mar 2023 00:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E68C433D2;
        Fri, 24 Mar 2023 00:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679616223;
        bh=XUAQX7WLfPzAunVs66lGMtCyPb+vveo57jrK8ZTvSfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rtel7lrEL0i9v7PLBlT4+t+EzDejq77npMxgGV9XvuXioojGieXhZ0XVTf4kMPYyM
         1CPybuqC5B1X5XsAqOo1j8pyBcIS0NKbBq3yPCwcrDl4fQrZ8BiYkx9SiluFiRg39x
         LEk1DdjrNojzkJYOnhv9W1jsDR2nMgDLyS443cpXobYuv2LZNcsRbZcWgGWhsEJPTF
         8qdYh0yXHjeJfjbLv0woEt+Lv/9HxHFe7lVBT1Q1ibCYRgWbH8AurM9lWUNjo/2F+O
         ZjR1nvwhRwUl7rM7y0AErIblD4VWy69HLjeQ80RiwCimBXnWUWJu00iDh32ScGZ/eB
         LgkIso8S/zIBQ==
Date:   Fri, 24 Mar 2023 00:03:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saalim Quadri <danascape@gmail.com>
Cc:     alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH v2] ASoC: dt-bindings: alc5632: Convert to dtschema
Message-ID: <13480aac-019d-40cc-b785-00ec5614e284@sirena.org.uk>
References: <4a553ab8-4cd3-4ce4-8225-20f43b70a5be@sirena.org.uk>
 <20230323193709.5176-1-danascape@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p7P/9WEWSNzZV5B+"
Content-Disposition: inline
In-Reply-To: <20230323193709.5176-1-danascape@gmail.com>
X-Cookie: A lie in time saves nine.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p7P/9WEWSNzZV5B+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 24, 2023 at 01:07:09AM +0530, Saalim Quadri wrote:

> +maintainers:
> +  - Leon Romanovsky <leon@leon.nu>
> +  - Mark Brown <broonie@kernel.org>

I know nothing specific about this device so shouldn't be listed.  CCing
Leon for him to confirm.

--p7P/9WEWSNzZV5B+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQc6NgACgkQJNaLcl1U
h9A61Af+NpVYj2Eus5eln0oJJ2sFYS7Mhz/F06ddXU1O2kQP+pqzInt2TSjWuQra
8jK8DFTpEroGGBhX4NnqHAISeWXzz9g9zu7LuipuMYmhlYtQdLmLzRCEm2tqFTC2
sl1ZH7JpN8kwD/0jEVu6fzRoHv2+wgqKz+M4HHndXBJBIwOkSDZDEiny0ogEXrsY
XIHFZULrLnF5RQTH61GU8raCPF2p3ixhtOxPh+ju2eoLwoz/aX9mUPk+4lpwP/0f
DaRZIrcwHpOh1TNgZlLwNWwJQOAY/atQCncRANcOEERV96PLJMAhPvKcScadebgU
4JT7biBiQbQp8Jyl1qF2MJklQ7OIlg==
=UK0B
-----END PGP SIGNATURE-----

--p7P/9WEWSNzZV5B+--
