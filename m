Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4862B646223
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiLGUL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGULY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:11:24 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E569E7B4CB;
        Wed,  7 Dec 2022 12:11:23 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B43861C09FB; Wed,  7 Dec 2022 21:11:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670443882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dd+u9GBEhwth9IdJehI7pkeDuWqZhizkkD6ytA/2Y50=;
        b=TlDeh2oGpD68AganNyRb3yCoOlmHE108K9HBTUoc1+pXePTXuuVElutgVEHRPLpVZVlDkT
        UsH8KSln5FOs94LwLB44FWMy2T8tx4gy/2U3c+1jWHNlRgla+XdRP1g8K81QvZ8pGgOX8y
        I7/pzp3z9bRk9PtXPMbewwdxsecy3TA=
Date:   Wed, 7 Dec 2022 21:11:22 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] leds: qcom,pm8058-led: Convert to DT schema
Message-ID: <Y5Dzamz6XRZudQzq@duo.ucw.cz>
References: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
 <20221202000858.GA1737135-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qQW4WT0IXBdoTUsx"
Content-Disposition: inline
In-Reply-To: <20221202000858.GA1737135-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qQW4WT0IXBdoTUsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2022-12-01 18:08:58, Rob Herring wrote:
> On Thu, Dec 01, 2022 at 02:15:05PM +0100, Krzysztof Kozlowski wrote:
> > Convert the Qualcomm PM8058 PMIC LED bindings to DT schema.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../devicetree/bindings/leds/leds-pm8058.txt  | 67 -------------------
> >  .../bindings/leds/qcom,pm8058-led.yaml        | 57 ++++++++++++++++
> >  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  4 ++
> >  3 files changed, 61 insertions(+), 67 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/leds/leds-pm8058.=
txt
> >  create mode 100644 Documentation/devicetree/bindings/leds/qcom,pm8058-=
led.yaml
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> Or should I apply it?

Thanks for ACK, let me take it, I guess.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--qQW4WT0IXBdoTUsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5DzagAKCRAw5/Bqldv6
8op6AJ9yUNYvLisZ0pUlTNdpbv8b7o5iOgCgrATjiUyQRd70IUy+GGODrploK1k=
=VjOA
-----END PGP SIGNATURE-----

--qQW4WT0IXBdoTUsx--
