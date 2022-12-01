Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA2063EFBD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiLALnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiLALmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:42:47 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66FFB48D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:42:42 -0800 (PST)
Date:   Thu, 01 Dec 2022 11:42:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1669894957; x=1670154157;
        bh=1DpeR0fOlb5PAMGmnpXX+od9r16gR+9q1pKLo2N9KRI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=yDI7s0HlJ4McXxo+2ufuGpE4pXDth5CZgcjcV3rSuMzzH6q3wJU2Tk8xl6O17cNkC
         HGXaHumIUcAtIEKBNwYce9+vZ6SE7uaW92ikgpJXsWAVzP2llfPOvr8KTm04XlizD+
         qqmrGlCY6Vr+H0QkM3W/9jf6/hOxA26eKCS8YCl+DJk0go0urf5JB+gwEDYNDa+OO5
         1T8hQYX7JoMQ/eCuypvX3exrqCVOMjP+g6FcbGegvHOS8NPTUhCiVXC8ifRf/Od0W+
         SNowSPaq79Rn4U19KPuffPal7gPFjk3PQGZv2gIZTRDFaB0Mv+3fBjN1Wz7ItilgIJ
         mhsl3c7GMLCkg==
To:     Rob Herring <robh@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Pull pinctrl node changes from MT6795 document
Message-ID: <OlpG9EaFtnZPPSHGKPeAj0wrG-hceDitxke8L1MrF58nBbOf4Q8bsw1FC8O12qj_3GFxNpM4p_LeKwbCzchvZGaD0a_S56_uKhg7YWszZ9A=@protonmail.com>
In-Reply-To: <20221130152041.GA2183918-robh@kernel.org>
References: <20221118113028.145348-1-y.oudjana@protonmail.com> <20221118113028.145348-2-y.oudjana@protonmail.com> <20221130152041.GA2183918-robh@kernel.org>
Feedback-ID: 6882736:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 30th, 2022 at 6:20 PM, Rob Herring <robh@kernel.org>=
 wrote:

> On Fri, Nov 18, 2022 at 02:30:22PM +0300, Yassine Oudjana wrote:
>=20
> > From: Yassine Oudjana y.oudjana@protonmail.com
> >=20
> > mediatek,pinctrl-mt6795.yaml has different node name patterns which mat=
ch
> > bindings of other MediaTek pin controllers, ref for pinmux-node.yaml wh=
ich
> > has a description of the pinmux property, as well as some additional
> > descriptions for some pin configuration properties. Pull those changes
> > into mediatek,mt6779-pinctrl.yaml and adjust the example DTS to match i=
n
> > preparation to combine the MT6795 document into it.
> >=20
> > Signed-off-by: Yassine Oudjana y.oudjana@protonmail.com
> > ---
> > .../pinctrl/mediatek,mt6779-pinctrl.yaml | 38 ++++++++++++++-----
> > 1 file changed, 28 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-=
pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pi=
nctrl.yaml
> > index a2141eb0854e..d6231d11e949 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl=
.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl=
.yaml
> > @@ -111,19 +111,21 @@ allOf:
> > - "#interrupt-cells"
> >=20
> > patternProperties:
> > - '-[0-9]*$':
> > + '-pins$':
> > type: object
> > additionalProperties: false
> >=20
> > patternProperties:
> > - '-pins*$':
> > + '^pins':
> > type: object
> > description: |
> > A pinctrl node should contain at least one subnodes representing the
> > pinctrl groups available on the machine. Each subnode will list the
> > pins it needs, and how they should be configured, with regard to muxer
> > configuration, pullups, drive strength, input enable/disable and input =
schmitt.
> > - $ref: "/schemas/pinctrl/pincfg-node.yaml"
> > + allOf:
> > + - $ref: pinmux-node.yaml
> > + - $ref: pincfg-node.yaml
> >=20
> > properties:
> > pinmux:
> > @@ -134,9 +136,25 @@ patternProperties:
> >=20
> > bias-disable: true
> >=20
> > - bias-pull-up: true
> > -
> > - bias-pull-down: true
> > + bias-pull-up:
> > + oneOf:
> > + - type: boolean
> > + - enum: [100, 101, 102, 103]
> > + description: Pull up PUPD/R0/R1 type define value.
> > + description: |
> > + For normal pull up type, it is not necessary to specify R1R0
> > + values; When pull up type is PUPD/R0/R1, adding R1R0 defines
> > + will set different resistance values.
> > +
> > + bias-pull-down:
> > + oneOf:
> > + - type: boolean
> > + - enum: [100, 101, 102, 103]
>=20
>=20
> 'bias-pull-down' is defined to be in Ohms. This doesn't look like it's
> Ohms.

That's right, these numbers appear to correspond to MTK_PUPD_SET_R1R0_*
values defined in include/dt-bindings/pinctrl/mt65xx.h, and work similar
to mediatek,pull-down-adv as defined in mediatek,mt8183-pinctrl.yaml.

Now I think the easiest thing to do in order to sort this out would be
be to stop supporting bias-pull-[up/down] properties and replace them
with mediatek,pull-[up/down]-adv, but I guess that would break old DT.
Changing the supported values to represent ohms and modifying drivers
to accommodate for that would be quite tedious since every pin group
on every SoC has different supported pull resistances, and it would
still break compatibility with old DT anyway.

Does anyone have a better idea on this? Or perhaps we could leave fixing
this for another time since issues with these bindings seem to never end
and this patch series just keeps growing.

