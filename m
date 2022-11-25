Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B060D63924E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiKYXqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKYXqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:46:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7093A59FF8;
        Fri, 25 Nov 2022 15:46:21 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 710A66602B71;
        Fri, 25 Nov 2022 23:46:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669419979;
        bh=pPnXaAWc/pYV6UYA4PeBonV+NM/csJC4V56rNy+Qgwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNhJVHOqJshUHf629nNgqzzZHiHDkjoMYtawtWJUMB+IvtZ4smZiT5b0Gxqr7nxIu
         eI5+VC06UjVOopxJ95cVzNpbvwbMu/iptE+cQQzAb94Za8AQtAwnld7J/VOuFiRNET
         rLVmMsYlMLQvLx01jmHa/lcmPMgw3Y8x9y+MFNZbmHnSY9Qy4Y8auhqG8x0+3KnbdV
         m/beEYhl+rwBVSJN/I8/GEiWVry4dvvUUqSW2ms6BF7NEn0OInmHDdjmiwNOUJGxsa
         knO77dKuC2An0LQ1qP/zHbfj0uJK1tvPN15avwvaQJP+3HsN5GJu8IaB7xfM5DMO/x
         kY8YkOKeo9AJg==
Received: by mercury (Postfix, from userid 1000)
        id A306D10613A9; Sat, 26 Nov 2022 00:46:16 +0100 (CET)
Date:   Sat, 26 Nov 2022 00:46:16 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 11/13] regulator: rk808: Use dev_err_probe
Message-ID: <20221125234616.3jj2izaa42uznlz7@mercury.elektranox.org>
References: <20221020204251.108565-1-sebastian.reichel@collabora.com>
 <20221020204251.108565-12-sebastian.reichel@collabora.com>
 <Y4EYjNOrS6lDnDZK@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="spwcfqzgs2tjdqot"
Content-Disposition: inline
In-Reply-To: <Y4EYjNOrS6lDnDZK@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--spwcfqzgs2tjdqot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, Nov 25, 2022 at 07:33:32PM +0000, Mark Brown wrote:
> On Thu, Oct 20, 2022 at 10:42:49PM +0200, Sebastian Reichel wrote:
> > Print error message for potential EPROBE_DEFER error using
> > dev_err_probe, which captures the reason in
> > /sys/kernel/debug/devices_deferred and otherwise silences
> > the message.
>=20
> This doesn't apply against current code, please check and resend.

That's expected. Patch 2 changes the dev parameter of dev_err(),
which is being changed to dev_err_probe() in this patch.

I think we are getting too close to the merge window for this
series considering it's touching so many subsystems. But you
can take patch 2 + 11 to the regulators tree as is.

Thanks for the review,

-- Sebastian

--spwcfqzgs2tjdqot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOBU8EACgkQ2O7X88g7
+pobVw//bj0mXmsiqq6WitjYB5ZyfXrg4eSJM+5c2SvVRTZrFC0aCq/A98lA5qEm
Vodq8aNKRGBQbpQL2pGFwsK0Nf7WozUdNxy9cB92H/C/nZ/dzRrtlVY6NLy6xFW5
QhLz4YXRfUypYmTNfYfsA5RxU1tsXSzDMIJpAi/kL80C+Dm+u9cq+9Ap/AEL8vWC
cQY0d4QazWN1KJMufa1m2ZTpvSiGHfv2XFqo6nrZ7LuW3wwf1PbJiGeQv9UPJwU9
qlYie7tSlgk1+m60JfYmsUUAKA7V/jMircUlGBruxoMpAzjyNuCqGMgyMsHvF5tA
S6ecEcyFuQimQksTE6jGW27+BaYfYhnmFUZJlHxcHywwTRBkinL2AieqRhhQdJXx
JA4NUfKunWhBqOGLAbkcEF90lvjeYyei/XRg/9tHCBteu1nBW22f6o1Yie+kTjEz
uSPErA4di+UENJFOt42NuesYWe8rrkQ6w31jld8Nz3B/TeQPJbh3BNL1NmnZUzBn
wiGo6oW5jEh3yECiVHj2Gw9QfzuJ5LMVob7S3VW/a8xZzeEndpi2NvzyPh3OReAx
Q+OHwNzrLswxFIs43AnY/P7miM6DdIvNtg3vnnvYEMmR0VFXQzTAwgx8ew27nsU+
shbVt9QfhudZZgZE0nisqCZCq9QoaqIZyzszGaV2Wt518mAHipY=
=n0B+
-----END PGP SIGNATURE-----

--spwcfqzgs2tjdqot--
