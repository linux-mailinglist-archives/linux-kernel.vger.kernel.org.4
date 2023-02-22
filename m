Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9F369FA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjBVRrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBVRrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:47:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143973D93C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:47:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B9E7614B1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F193C433D2;
        Wed, 22 Feb 2023 17:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677088064;
        bh=m40C9QeJ6/wlTN5ZtUc+UTmZXUkrUn5xfLFQsUdChJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HowCyPqms5/CcljG7F11Mf1oVd4SeVDbyqZgcsk6vHWlyPJSUhzJbiS2i39Q8E4Zv
         GOTpDCI//2q71f8ip8a37EUsYqZ7RgomdYe3zctvtDndbVzdtl3LWic9ZSiLzs85C8
         6L57vJOZwjRQA7lO5nSfNAtKNnBGMNcPWFZPlNLjbHG9F++MYAdxau8frql1RYerE0
         ZR6jtspYQr/6aStURtsTyhO1YQL/VYsj4+az0SmuRtl13CAIVNRfnTACR9sl1K7pX5
         n4wLQDn2sv/L5z8oQAlkD0hMT640BHmxPdKBUaXL4zMYXPatmgD4yUwMPaOsX+eDvl
         jJPgiDFSk2Wrw==
Date:   Wed, 22 Feb 2023 17:47:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 2/4] regulator: core: Add sysfs class backward
 compatibility
Message-ID: <Y/ZVOfaApSo/Dslf@sirena.org.uk>
References: <20230218083252.2044423-1-saravanak@google.com>
 <20230218083252.2044423-3-saravanak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/MITqH4ok7qcVPFa"
Content-Disposition: inline
In-Reply-To: <20230218083252.2044423-3-saravanak@google.com>
X-Cookie: My LESLIE GORE record is BROKEN ...
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/MITqH4ok7qcVPFa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 18, 2023 at 12:32:49AM -0800, Saravana Kannan wrote:
> A regulator device's sysfs directory used to be created under
> /sys/class/regulator when it is added to a class. Since the device is
> now moved to be under a bus, add symlinks from /sys/class/regulator to
> the real device sysfs directory.

Shouldn't this be squashed into the previous patch given that it creates
a bisection issue?

--/MITqH4ok7qcVPFa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP2VTkACgkQJNaLcl1U
h9BjDAf9EO1OIkNrmQQBuy0lDw2uI1NVp+pjGzFNBDHwHUYX6FC/cFnbsLWG7oTR
9WQaCzAprfPbaOimbJXsFvWIBSJXDi5zecuNPJSczEKj0T4jHvxTff2WrinupBe9
mN0BrUS3t02Xnvu+0zJYja7+qfRU6gWYbIbkIiboGFQrCHH1nOG+K5Y5KklF7sfc
lqWaV5Wb8aRtat0nlnWCKowoP+xefkEZsdX1EyzhEMw6wSh2bTcrPpiFDC22EbZ7
EkhOXBxNxWTJHopRvnhjnjmks9kCpH7yTos/XQGiapWgNX5I3rW+3swzAls9A4AY
oByoqg+f64vkl9nRX5axA7fji/+HIA==
=FCLb
-----END PGP SIGNATURE-----

--/MITqH4ok7qcVPFa--
