Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5A770F43A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjEXKaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjEXK3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:29:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8769A8F;
        Wed, 24 May 2023 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684924194; x=1716460194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gwuUuZ5cSF78REHUiHPXnq4Vyh/npUSjZrkX4R0VIcE=;
  b=m+ZauJ6fdJoInkRXDDeQyVLiiTTteYK6bUrYs6taxmIqZiWXx7tUQr3q
   HyA43EwMoOVnFV+Cqmixb/n8m1KrKq9Ii3p0G8olUWxeWrvRVUO1bbqlq
   V1Wdqjxi8K/hpahciz/EBhafn7hE0wznSu4Xo/KzGlPFQ2/H0P9Lgp+Qv
   MViocoaA9TNqmsVidjNl4G3V5luNP9JA8mkeIla5rtPn+erJbutAU17Kq
   IW0ruPteuUwPwF2PL6m9ywYD0mYuwtjbSuyPKv0uSvkL5u8EN/3l8I0h/
   eyqq9jtSqWz25LXVMEIjHIsSosDd3FKhkva7l7Q0C3vJt+awlKkhlF1gX
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="asc'?scan'208";a="214671058"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 03:29:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 03:29:52 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 24 May 2023 03:29:50 -0700
Date:   Wed, 24 May 2023 11:29:28 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     zhuyinbo <zhuyinbo@loongson.cn>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>,
        <wanghongliang@loongson.cn>, Liu Peibao <liupeibao@loongson.cn>,
        <loongson-kernel@lists.loongnix.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v11 1/2] dt-bindings: spi: add loongson spi
Message-ID: <20230524-relative-trimmer-046fb26a7764@wendy>
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <20230522071030.5193-2-zhuyinbo@loongson.cn>
 <20230524-pouncing-variable-c520e85f8db8@wendy>
 <b1e3d199-de5a-f8d5-9159-4965e9e1f5ef@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pFaQaHu3/olulfLs"
Content-Disposition: inline
In-Reply-To: <b1e3d199-de5a-f8d5-9159-4965e9e1f5ef@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pFaQaHu3/olulfLs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 05:44:38PM +0800, zhuyinbo wrote:
>=20
>=20
> =E5=9C=A8 2023/5/24 =E4=B8=8B=E5=8D=884:56, Conor Dooley =E5=86=99=E9=81=
=93:
> > On Mon, May 22, 2023 at 03:10:29PM +0800, Yinbo Zhu wrote:
> > > Add the Loongson platform spi binding with DT schema format using
> > > json-schema.
> > >=20
> > > Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >   .../bindings/spi/loongson,ls2k-spi.yaml       | 41 ++++++++++++++++=
+++
> > >   MAINTAINERS                                   |  6 +++
> > >   2 files changed, 47 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/spi/loongson,l=
s2k-spi.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.=
yaml b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
> > > new file mode 100644
> > > index 000000000000..d0be6e5378d7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
> > > @@ -0,0 +1,41 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/spi/loongson,ls2k-spi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Loongson SPI controller
> > > +
> > > +maintainers:
> > > +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/spi/spi-controller.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - loongson,ls2k-spi
> >=20
> > I am sorry to jump in here at such a late stage with a (potentially)
> > trivial question. "ls2k" is the SoC family rather than a specific model
> > as far as I understand.
> > The answer is probably yes, but do all SoCs in the family have an
> > identical version of the IP?
>=20
>=20
> No, but the spi supported by this loongson spi driver are all the same
> identical version, and other type or verion spi will be supported as
> needed in the future.

Does having a catch-all compatible make sense then when not all SoCs in
the ls2k family will actually be able to use this driver?
Or am I misunderstanding and all ls2k SoCs do work with this driver and
you were talking about other, future products?

--pFaQaHu3/olulfLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG3nCAAKCRB4tDGHoIJi
0lR6AQCPA3ic4UvRm1328KZoL51qPlPWTTYRJxmuXZ0y2gB0hQEA7oBZjGgPzFSy
QjkEJA5dPiSEZcAqddQ30sdPQzebbgY=
=O8HN
-----END PGP SIGNATURE-----

--pFaQaHu3/olulfLs--
