Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F506DD985
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDKLjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDKLjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:39:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830A235B1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E7D361E24
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CC8C433D2;
        Tue, 11 Apr 2023 11:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681213159;
        bh=/QdHGYeIbfo/3518TeLMyhUA4GGa9EF5z1qxX6n5wKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syfVKP2uEXRCX27AOe2rirvMFFUzgy4SdwRhayQSMkW+S4Qk0CaOT9/xWZpd5C0Vo
         0V0C/Vr4jD1gVXTUXtsLnVbZftk5vhYQGmSvvlOTaGxFGO2QO2S/zedAp4JyCihmT1
         rtGE1GuCEU9OcNr6K5bwqN5/P6qFvzO1evlshXJpskNu8qyrMQvLrjq6wRws/rDpZ/
         RO65lv0q+JIX7fu2szt/GuKMwCu3kMa6II08YC40vLCkEz+tp8ynLEoZY3t4CR3kgn
         I3hjoYfpHELSP0gTTWxh2krFhwe9dVe0wt8hk3bSe07Lp3A24XxwhgHr7U/wlbLGwp
         HmHfnzNSQyLwg==
Date:   Tue, 11 Apr 2023 12:39:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     alsa-devel@alsa-project.org,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        David Rhodes <david.rhodes@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 1/3] ASoC: ep93xx: i2s: move enable call to startup
 callback
Message-ID: <110982c6-c3ad-4d47-b6c9-6531a644712d@sirena.org.uk>
References: <20230410223902.2321834-1-alexander.sverdlin@gmail.com>
 <20230410223902.2321834-2-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kOvKSPZAebBkIE2J"
Content-Disposition: inline
In-Reply-To: <20230410223902.2321834-2-alexander.sverdlin@gmail.com>
X-Cookie: Sauron is alive in Argentina!
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kOvKSPZAebBkIE2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 11, 2023 at 12:39:00AM +0200, Alexander Sverdlin wrote:
> Make startup/shutdown callbacks symmetric to avoid clock subsystem warnings
> (reproduced with "aplay --dump-hw-params" + ctrl-c):

This doesn't apply against current code, please check and resend.

--kOvKSPZAebBkIE2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ1RuAACgkQJNaLcl1U
h9DvZgf/b+Wm8jvRpiAIE66Nc6EchfS6cCr/ywxMOKkFIl5zx1/31LBBW4+FfxHb
NrDSqDFths+0HnYp0Sz7d3XNZn6P60MnwUH4EGGMQ4KbY2j7X7/V59UXxowFD9R2
K/Vd7BqSLDfqEBl8iZXhXuaawPcUiTSOKNiEiOMxpKk2N9V8hgpj5cSX8B0fyZox
i/oUzXQiIZNN/fI4QJC6NFb+bGY6Ll7JoPudMa9aihTa+/Jl/AYP5v3OC1AsMbMV
s+DWu6IfzBvziVw74R/fMJianSdlOxpbv8vQXtLTEFXay0QcbZA2U2ZQvgkvSCoL
d3WchgdhuXdnBMqYqvkn9f+SZyNjHQ==
=oVJq
-----END PGP SIGNATURE-----

--kOvKSPZAebBkIE2J--
