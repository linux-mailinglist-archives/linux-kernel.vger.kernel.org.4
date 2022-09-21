Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9A25BFABF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiIUJWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiIUJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:22:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3702480F77
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5DB7B82EC6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2F7C433D7;
        Wed, 21 Sep 2022 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663752098;
        bh=ghhup3/B33nB7XHNALzYmfqCgWnUt8vhwwrgQftoRt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tYhYyzrm0VHW+MfmapEys3j4BHoD14XINUSa8Uz1hJC/X7I+dpNnIQ0QDDoZarsvz
         BrRj+WN5FWczzkpUmkwycd9k1qHNcXDMPeIRrBW1LCh6uH7pV8AvSYgJxUToUeoIY4
         IcQx47LzutgbbXZDioACXXTRBRoNtWza3EsGQYPrG6iZ4hTt02ieS3Fs4Ft4bnjDe5
         HZhSjEU0+TAR8dXr+EsFv0ZVY9yG7GBUMYnZgvYjyzbPhnzakFp2rR/zhkXAFJqdmU
         USAi0bUnAoZRWddFKbrYfzvoKl05hv86xhdc4LIoLrUIH+INbmzOGjcGDmELrrOvpQ
         EmkNX8bStD9VQ==
Date:   Wed, 21 Sep 2022 10:21:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@axis.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Astrid Rost <astridr@axis.com>
Subject: Re: [PATCH v4 0/3] ASoC: ts3a227e control debounce times
Message-ID: <YyrXiJSrc2hX+Zda@sirena.org.uk>
References: <20220921081834.22009-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nUgNn9n5bNnHT0gi"
Content-Disposition: inline
In-Reply-To: <20220921081834.22009-1-astrid.rost@axis.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nUgNn9n5bNnHT0gi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 21, 2022 at 10:18:31AM +0200, Astrid Rost wrote:

> Astrid Rost (3):
>   dt-bindings: sound: ti,ts3a227e: convert to yaml
>   dt-bindings: sound: ti,ts3a227e: add control of debounce

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--nUgNn9n5bNnHT0gi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMq14cACgkQJNaLcl1U
h9D+nAf/cbWjVFNQ9zdyz4yBV+FoDfeZZT/vG96TkBti0z0I99CMGo7Ew0DDqpSG
xGw8ajcJpP7KE5K4HGBVccMX88JMwkVJUqJ62UElk+7phlw1ERM8yV+Ooo+DQaLV
VUjublu1emWixadN7Mbq5yt/sITKCvP1zruib8clUPvVswuotz+54R2PhONoTJKp
7ETB9I/1RS7Du/hgmDmLJjws6en0St+MsCuNAs50SBJC+w3ejequUabPyZlRq3sd
YMc+dUyGifNaAXRzyjJ3kPFwloBzYNgbMvz9yUP1tGYXSkPD7u7IpNa9aFgNu/EO
Xg0o9p43HQSIidOgLbpcPuOr9YUXbg==
=XH6B
-----END PGP SIGNATURE-----

--nUgNn9n5bNnHT0gi--
