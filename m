Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6D646CBC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLHK37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLHK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:29:56 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BEA30550;
        Thu,  8 Dec 2022 02:29:55 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DFF771C09FA; Thu,  8 Dec 2022 11:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670495392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7w9NZ5zMjCJ6jruselsa9gif4njcjBN9vZovQO3hsCw=;
        b=E/XC91OllcUxx1hBoqvZ/VvLx7jAx91ScHqsv3K0SgZ6d0TJBzV9y9luDkkFuKPrCOKruO
        whhYzx2FKbvPp5nlxiFTM81Nd+CvJXxJ0kXloSQ9W9lrqqwL9X/IqbGDjzUK+tFLSGM0cY
        mkS7KeITmJkynn9zc5vvBPeWH6aypCo=
Date:   Thu, 8 Dec 2022 11:29:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] leds: qcom,pm8058-led: Convert to DT schema
Message-ID: <Y5G8oK+L0ck5Zb9j@duo.ucw.cz>
References: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
 <20221202000858.GA1737135-robh@kernel.org>
 <Y5Dzamz6XRZudQzq@duo.ucw.cz>
 <Y5G30ttrf1RJa+sM@google.com>
 <947e47d3-4235-8f16-d3ef-c3ddd7d51acf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0szrq67hw48wihFy"
Content-Disposition: inline
In-Reply-To: <947e47d3-4235-8f16-d3ef-c3ddd7d51acf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0szrq67hw48wihFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2022-12-08 11:19:47, Krzysztof Kozlowski wrote:
> On 08/12/2022 11:09, Lee Jones wrote:
> > On Wed, 07 Dec 2022, Pavel Machek wrote:
> >=20
> >> On Thu 2022-12-01 18:08:58, Rob Herring wrote:
> >>> On Thu, Dec 01, 2022 at 02:15:05PM +0100, Krzysztof Kozlowski wrote:
> >>>> Convert the Qualcomm PM8058 PMIC LED bindings to DT schema.
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>> ---
> >>>>  .../devicetree/bindings/leds/leds-pm8058.txt  | 67 ----------------=
---
> >>>>  .../bindings/leds/qcom,pm8058-led.yaml        | 57 ++++++++++++++++
> >>>>  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  4 ++
> >>>>  3 files changed, 61 insertions(+), 67 deletions(-)
> >>>>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-pm80=
58.txt
> >>>>  create mode 100644 Documentation/devicetree/bindings/leds/qcom,pm80=
58-led.yaml
> >>>
> >>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>>
> >>> Or should I apply it?
> >>
> >> Thanks for ACK, let me take it, I guess.
> >=20
> > Did you see Krzysztof's replies to this patch?
> >=20
> > Sounded like he was going to re-work it, which is why I left it.
>=20
> The only rework needed was to add "dt-bindings:" prefix in the subject.
> If you could add it while applying/amending commit, that would be great
> and spare me resend. Otherwise, let me know if you dropped this patch
> and expect a resend.

Lets not do anything if the patch is otherwise correct.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--0szrq67hw48wihFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5G8oAAKCRAw5/Bqldv6
8o7nAJ401end/9RufAJqigoyfG5TThos+QCcD4SqympiWjM80RAF50EcMuaM4ds=
=FrpG
-----END PGP SIGNATURE-----

--0szrq67hw48wihFy--
