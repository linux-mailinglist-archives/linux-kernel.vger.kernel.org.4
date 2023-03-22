Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16AA6C4B70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCVNO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCVNOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD13B23B;
        Wed, 22 Mar 2023 06:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B83BB620BE;
        Wed, 22 Mar 2023 13:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ED7C433EF;
        Wed, 22 Mar 2023 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679490891;
        bh=u9GikT43rfqNNchHEzB4MC9MRag1S1z9pDfJEAUESrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqdlowXMk3DZJFG71QvOsdJ3Nt3cdYJHXOru5Q51NotqX9F+albV1whddzlSd9Vof
         ShfquJWr2WtURNplk+TdeRhaGnqRVGV6ej0sL4l61cjjfewsHbFG1dlKjKcWlSzfrF
         DpJWWjNpW1rmXGzWmX3xvSE9LWpS+r1M0hgFMpqC5WM3MXSq6e8HaeZJnoNcl2MyFH
         cOhFaD0o2GPbnA10rLOn9XN4pf6STgYxSYlcbFcdRVmDb3XKkUAeDBj/BWf1+eQnL3
         KbIRlc5khLIPwtPGUsAKNxs3OZXNoRgorioDh+e7ixpV1lT9cSRA5Uc1PQCKVx9mYq
         JaSryf9u1o9HQ==
Date:   Wed, 22 Mar 2023 13:15:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: (subset) [PATCH v2 0/8] Fix sound on ASUS Transformers
Message-ID: <ZBr/V8kEJqan38Nw@sirena.org.uk>
References: <20230308073502.5421-1-clamor95@gmail.com>
 <167933710348.198283.16107220354236772396.b4-ty@kernel.org>
 <CAPVz0n2AuCb7fmLkzdimiZvqneQw7gXCfMTRvhp1n1zwRckfaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MsWazqoCnTV+oHgS"
Content-Disposition: inline
In-Reply-To: <CAPVz0n2AuCb7fmLkzdimiZvqneQw7gXCfMTRvhp1n1zwRckfaA@mail.gmail.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MsWazqoCnTV+oHgS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2023 at 12:56:06PM +0200, Svyatoslav Ryhel wrote:

> Thank you, Mark Brown! You have asked me to update commit name for
> codec machine dts schema commits (those, which contain CODEC in the
> subject), should I still update and resend them or you will handle those?

> I still need v3 to update existing device bindings to the currently working
> scheme. Should I exclude commits you have picked?

No need to resend anything that's already been applied, drop any
commits that were applied and don't worry about their changelogs
any more.  If there's fixes needed in the newly added code then
make incremental patches for those.

> I have DMIC fix for wm8903 codec driver required for tf101 and tf300t,
> should I add it into v3 or I have to send it separately?

Just send it as a new series.

--MsWazqoCnTV+oHgS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQa/1YACgkQJNaLcl1U
h9B5+gf/QdroK8bOm9/dNaSen/YbUl4L0XULQYZIRiHx0f8gYEP4ym0OV82dgFxg
3zi64foG8GRXipaY4+F1m8xPrKaetXjKcLu2BlqH6mKISmle4eUtbs5J+CYlrEFn
g2/XRw8UNhK6/U6fWCqIjT273HYOXESDXJodKAhgCKH4w+oT0xJVs/RIWq4wXQXa
vh/C9ewbN+xD1IUWnQ8hdIkHwsttxylFR/RwKXuooGC41hL85IGYMztsLqii/5BZ
ypxgQPO6KIhh8fo6uEfpWKcaW8ktA5S/zSDXNYSLpYj3JKkYvKrzqzaRyPyIYaHv
llA+8HogqAGyDQh6UnsU/2OPXuQHfw==
=YegK
-----END PGP SIGNATURE-----

--MsWazqoCnTV+oHgS--
