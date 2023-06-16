Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE28D7329AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245160AbjFPIXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjFPIXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:23:22 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1C2212B;
        Fri, 16 Jun 2023 01:23:21 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B394F1C0E6E; Fri, 16 Jun 2023 10:23:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1686903799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uwqz7xaKAqzIwowJQBfMPTshEu7P5aPh8FrMKIEdGvM=;
        b=sEmhATV/S6WM4B8Ta+dZo2CGYgFmBq01wuDJpjgmdWQs/K8Il8SAF4gGU3UX6GfYUZ/c0Q
        1+57GmJmxCELS3Sdc/eQ1Kmp50Vl+VgJD3AJUX4zUo3f6f4wrFsuiH05MeaSMSCKACCGsY
        MEtjVRfS16moMkaloaT1UIuY7jZKN7M=
Date:   Fri, 16 Jun 2023 10:23:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        sre@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.3 01/37] power: supply: ab8500: Fix
 external_power_changed race
Message-ID: <ZIwb98ptaEb01MC4@duo.ucw.cz>
References: <20230615113654.648702-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="b+zKUwoCEUgmSd1B"
Content-Disposition: inline
In-Reply-To: <20230615113654.648702-1-sashal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b+zKUwoCEUgmSd1B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I do not see complete series in my inbox (only see patches 1-6).

But then I see another thread which seems to be complete.

Date: Wed, 31 May 2023 09:39:43 -0400
Subject: [PATCH AUTOSEL 6.3 01/37] power: supply: ab8500: Fix external_powe=
r_changed race

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--b+zKUwoCEUgmSd1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIwb9wAKCRAw5/Bqldv6
8uh+AJsElO3pROJOHxyIrhQQLDNZKJimtgCghG4XlUIrXuqEWAjN+fwC+/m3tCE=
=+NFY
-----END PGP SIGNATURE-----

--b+zKUwoCEUgmSd1B--
