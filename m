Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8912560BF70
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJYAVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJYAVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:21:21 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D42495F;
        Mon, 24 Oct 2022 15:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666623276; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=OuC5UuswYeJwvDBhbj5/UnDO5N1jT5QmGcDoTqLjmM+WB2SyFIMZK1U9Iakm2oM1Pg5egIcUhvJBEt2o0rThSEN8L5e/AQaz6ddjwD0W6eEXfxscplmQGhRhxi//XtO8neaYjes1G6VzYplBythR3bwn+ryak1tfHqpUt112Qsg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666623276; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=KtFnxpe3/zLGu3zMT8VZpJKVy8JzlMwgd9rxKAODgBc=; 
        b=OhlF9/Ppa7U2cWGLMO+SpNRfzDiQj5sDmuroumxzRZZuTSO7pyfgJGiMQK6YSafQb9FmG08oC4EaB9AtRRjVcuqTBg3Hm5aby24aBd6ozCt/8VHqR8n1mdXbz2/9CjYUsCp6N1vWz6Vid9GJkkZOjvWzNx5kvqHtQ8F1im6KQzA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666623276;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=KtFnxpe3/zLGu3zMT8VZpJKVy8JzlMwgd9rxKAODgBc=;
        b=HjmrGs8cF4SHI5gvT0qasK+xbp3ZRTpFLth0wBnuvei9m5umaJ8AIrP7sfc9w/nl
        XtwQuoLdjJxrD6z59KNz9Oou9mJHp7rOdrAzVyn8kRd5jE4TzcKbyjNwozA4IwXSLlC
        6NZ9NJQQs4I4JzJJwAp7qvTa+aVbRIQdpnst2ZF8=
Received: from edelgard.fodlan.icenowy.me (112.94.102.105 [112.94.102.105]) by mx.zohomail.com
        with SMTPS id 166662327277432.6796919089179; Mon, 24 Oct 2022 07:54:32 -0700 (PDT)
Message-ID: <6eac76260f5d47542ac88143082a2b4393deb3bf.camel@icenowy.me>
Subject: Re: [PATCH v2 09/10] dt-binding: arm: sunxi: add compatible strings
 for PopStick v1.1
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Date:   Mon, 24 Oct 2022 22:54:25 +0800
In-Reply-To: <20221024151714.59968916@donnerap.cambridge.arm.com>
References: <20221012055602.1544944-1-uwu@icenowy.me>
         <20221012055602.1544944-10-uwu@icenowy.me>
         <20221024151714.59968916@donnerap.cambridge.arm.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-10-24=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 15:17 +0100=EF=BC=
=8CAndre Przywara=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, 12 Oct 2022 13:56:01 +0800
> Icenowy Zheng <uwu@icenowy.me> wrote:
>=20
> Hi Icenowy,
>=20
> > SourceParts PopStick is a F1C200s-based stick-shaped SBC.
> >=20
> > Add a compatible string list for its v1.1 version (the first public
> > one).
>=20
> If v1.0 (or anything prior) never made it to the outside world, I
> don't
> think we need to mention that in the public bindings.
> In general Linux seems to discourage support for unreleased hardware,
> so I
> think you can just drop the "sourceparts,popstick-v1.1" name.

There's going to be v2.0, which is quite different to v1.1.

>=20
> Cheers,
> Andre
>=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > New patch introduced in v2.
> >=20
> > =C2=A0Documentation/devicetree/bindings/arm/sunxi.yaml | 7 +++++++
> > =C2=A01 file changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > index 3ad1cd50e3fe..c6e0ad7f461d 100644
> > --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > @@ -807,6 +807,13 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: s=
inlinx,sina33
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: a=
llwinner,sun8i-a33
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: SourceParts PopStick v1.=
1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: source=
parts,popstick-v1.1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: source=
parts,popstick
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: allwin=
ner,suniv-f1c200s
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: allwin=
ner,suniv-f1c100s
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: SL631 Action Camera=
 with IMX179
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: a=
llwinner,sl631-imx179
>=20

