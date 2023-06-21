Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A107384BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjFUNSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFUNSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D410C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ACB7614D7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBDDC433C8;
        Wed, 21 Jun 2023 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687353518;
        bh=fNzgBv3S6Z9XVyqQGOlHUKzzBC7T0ZKsC6puwES5pQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UzLCHXo4e0aRFNPwG0rKmRZ9TVR7a7NN1lkXVYfd9yPfJU1E6Lg07Ar/4It34XzUV
         g1835P2QVlAfUwL/EBQCqVeHkbXhGjyBlNGwelfSACYHzwFy7Lm3FcRlI4LPZHbVw/
         E4aNvkzIJw9G3i9pY7BeuvjkXaqbqeJ6d1sfQR2qae8hDac/kQ4ZFDvTvaQg0vGn95
         VTI/6/hHSiSDkYDP1YsdFRlzRboP3tpT06MS7rsrYtruEacD4hMjGcSJdwTxOVrQ0c
         cFyvNY2pMQYoYxp7zeKAFsm13UEUxM3+4dwcBkSvvtm62vhXe2q8hYCrE6ECimHnei
         a+dbmUfZ74W0Q==
Date:   Wed, 21 Jun 2023 14:18:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: codecs: max98090: Allow dsp_a mode
Message-ID: <b763d08e-f751-480c-96b6-339a53856768@sirena.org.uk>
References: <20230621115328.156457-1-fido_max@inbox.ru>
 <3805dc65-113f-453a-90a9-2ae6204004ba@sirena.org.uk>
 <e6be75f6-054f-6c3b-00b4-a5e112bcefc3@inbox.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7uVBzkQ09VJrlG8A"
Content-Disposition: inline
In-Reply-To: <e6be75f6-054f-6c3b-00b4-a5e112bcefc3@inbox.ru>
X-Cookie: When among apes, one must play the ape.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7uVBzkQ09VJrlG8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2023 at 04:02:34PM +0300, Maxim Kochetkov wrote:
> On 21.06.2023 15:26, Mark Brown wrote:

> > This is configuring DSP A identically to left justified mode, it looks
> > like the format configuration needs at least some interlock with the TDM
> > configuration.

> According to datasheet MAX98090 supports only DSP_A (L data MSB after FRM
> LRC) TDM mode. Allowing this mode will let us proper configure CPU audio
> node via DT. Actual TDM mode activation is performed in
> max98090_set_tdm_slot() via M98090_REG_TDM_FORMAT/M98090_REG_TDM_CONTROL
> registers.

I'm saying there should be some interlock between these two settings, if
nothing else setting DSP A mode should force TDM mode with automatically
configured slot sizes.

--7uVBzkQ09VJrlG8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSS+KgACgkQJNaLcl1U
h9BaHgf+PmazZFiaoqkNhCaUKsZylWCGAFPo+cgvXRDHq5Knkow2MpiNkogFgGJf
I/9l7+LvZ8II/1BIxBVK4slt5eygq94wMkzA3q4UOVq0z0npBQZNfM3osCGXGOKW
P3h77NAS5OSyNhe4GcKMSmRyiG4cPc1QYp6/KDJSuUWXHUaQMXQG9nWNv718Fsxj
gtD96exbO3v2B5a/y8D0tGXhFCNU5xw9ZOlkXQULZtD/FD6oYL2loZ26os0Js7o5
qhmuoxz7ymH+ZLeLZZZxXNixaj8CcksYNiCWlWIj8VPxfEAmegLac3GzFWu7f8GW
VH52b6Q6SFn9Gu5bjcJZGj8M6ClZfw==
=1W9y
-----END PGP SIGNATURE-----

--7uVBzkQ09VJrlG8A--
