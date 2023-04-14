Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F8F6E2313
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjDNMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjDNMWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:22:38 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DF05B80;
        Fri, 14 Apr 2023 05:22:32 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6FF061C0AB2; Fri, 14 Apr 2023 14:22:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681474951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbH1fiCHIX9GQaLMMsFN0fVNAvg45vBDuFl4FfGy5H4=;
        b=HXPXZJ+6uWwdlP3nXXVVI/msbHsyKeVyhpKIGZUSpXv85CkDKfudmr2LxGm5y0a8UXdwY/
        KaqVpINemacBxHQ7N/cI0VaawtnAvETo6AxcswUHE9o+Df9fiBCRx8BGrYxWVGRcL0KLqP
        C08acsjKRnujbVlBX1EMYiT9yXJHPpk=
Date:   Fri, 14 Apr 2023 14:22:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/8] leds: qcom-lpg: Add support for PMI632 LPG
Message-ID: <ZDlFh98ZL4zFBTys@duo.ucw.cz>
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
 <20230414-pmi632-v1-4-fe94dc414832@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZzlhyEOZdHmmR6sf"
Content-Disposition: inline
In-Reply-To: <20230414-pmi632-v1-4-fe94dc414832@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZzlhyEOZdHmmR6sf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2023-04-14 01:17:48, Luca Weiss wrote:
> The PMI632 PMIC contains 5 PWM channels, 3 of which can be used for
> LEDs.
>=20
> For the LED pattern it doesn't have LUT like other PMICs but uses SDAM
> instead. This is not currently implemented in the driver but since LPG
> works fine without it, add support for the PMIC now.
>=20
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ZzlhyEOZdHmmR6sf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDlFhwAKCRAw5/Bqldv6
8inyAJ9MRMJzilfTt6Y8eXfWOCRegKxEWQCeNenFC5ZyulW/ZySZTogXXxCl1mk=
=8H34
-----END PGP SIGNATURE-----

--ZzlhyEOZdHmmR6sf--
