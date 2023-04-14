Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305306E1E57
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjDNIbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjDNIay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:30:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D77D59E5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:30:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnEp5-0004l4-Vm; Fri, 14 Apr 2023 10:30:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnEp2-00B9ki-OF; Fri, 14 Apr 2023 10:30:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnEp1-00D6uj-Ur; Fri, 14 Apr 2023 10:30:19 +0200
Date:   Fri, 14 Apr 2023 10:30:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        chunkuang.hu@kernel.org, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        houlong.wei@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 01/27] dt-bindings: pwm: Add compatible for MediaTek
 MT6795
Message-ID: <20230414083019.cpomx37tax4ibe5u@pengutronix.de>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
 <aaeeb18d-f8e8-d6c1-1272-e5b797554b9e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="meuxombxxc4zwoxv"
Content-Disposition: inline
In-Reply-To: <aaeeb18d-f8e8-d6c1-1272-e5b797554b9e@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--meuxombxxc4zwoxv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 10:21:05AM +0200, Krzysztof Kozlowski wrote:
> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> > Add a compatible string for MediaTek Helio X10 MT6795's display PWM
> > block: this is the same as MT8173.
> >=20
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.ya=
ml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> > index 0088bc8e7c54..153e146df7d4 100644
> > --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> > @@ -22,7 +22,9 @@ properties:
> >            - mediatek,mt8173-disp-pwm
> >            - mediatek,mt8183-disp-pwm
> >        - items:
> > -          - const: mediatek,mt8167-disp-pwm
> > +          - enum:
> > +              - mediatek,mt6795-disp-pwm
> > +              - mediatek,mt8167-disp-pwm
>=20
> This does not look correct. You do not add compatible, you replace
> breaking all mt8167-disp-pwm. At least it looks like this from context.

I thought the old semantic to be:

	"mediatek,mt8167-disp-pwm"

and the new

	"mediatek,mt6795-disp-pwm" or "mediatek,mt8167-disp-pwm"

=2E What am I missing?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--meuxombxxc4zwoxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ5DxoACgkQj4D7WH0S
/k4b0gf/XGg5FqG1Mgkx3HAKSgi3PZuY2KSNIop4uRKh9jD6sSxX8ZOB5wNtwFbz
OwOpF/4bmEy9R4vW++134sQENrXwVv2QR8aMaolP298zl6s+qqTm1/8USwc3TVep
kTXMWWKuKFTBbj2viZrKSJUBT7C7I+VPcblxqtQnYe9AUZYJRCtLalvkECL+FgiZ
EbKGM99/7nbD7NPk33LTt0uEiaBrWoe7p4ehasD9uVW/7dhZAs44xQLFOR+XiT4U
Upy4cMJQtRqfISF44KBNw0Bm2Rm+Tqw3NoKTtPOQ1C36xzTHBnC+hp8ZoPFR/dYo
T9uMy4x52AKlzE9EAH2T/lOj/Rs5uQ==
=6UO4
-----END PGP SIGNATURE-----

--meuxombxxc4zwoxv--
