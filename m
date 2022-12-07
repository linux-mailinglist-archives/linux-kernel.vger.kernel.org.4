Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8869D646229
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLGUMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGUMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:12:09 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909157B4D5;
        Wed,  7 Dec 2022 12:12:08 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 64DB11C09FB; Wed,  7 Dec 2022 21:12:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670443927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uu+n3RTNj0g3CTPuRnF+rNRl0NULzFKV15I2ltsPoos=;
        b=Hen5tQKlnCo3f3nYqTCmhJePk3l/NddgJw520HDUXwMlCiwuK+rxmZji5EvGZiQaSR83nn
        krZJxv5U1Q2pGpahbLa0kuV1aTBIoRCM0qA5SCZA9shuOzgMEMM1coRL7rwehI3fuNuiJN
        rrDMcvPf6o7koBoEUCio+5vUIlhQoZw=
Date:   Wed, 7 Dec 2022 21:12:06 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] leds: qcom,pm8058-led: Convert to DT schema
Message-ID: <Y5DzloNlPZpDvdCS@duo.ucw.cz>
References: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="j7NkTX6cf6083q0H"
Content-Disposition: inline
In-Reply-To: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j7NkTX6cf6083q0H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2022-12-01 14:15:05, Krzysztof Kozlowski wrote:
> Convert the Qualcomm PM8058 PMIC LED bindings to DT schema.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank you, applied.

BR,
									Pavel
								=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--j7NkTX6cf6083q0H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5DzlgAKCRAw5/Bqldv6
8tiNAKCoGqIN1SXz5uvy7j/FdAGtAKM+FgCfY38iCAu2VL82o3g1r8o2Pb0oc6c=
=I+lk
-----END PGP SIGNATURE-----

--j7NkTX6cf6083q0H--
