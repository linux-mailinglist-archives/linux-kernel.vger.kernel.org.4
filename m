Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E494F72E2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbjFMM25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242438AbjFMM2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:28:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E39B1BDB;
        Tue, 13 Jun 2023 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686659321; x=1718195321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M+YsxAsrMOdQXi3EjTzJQEXiDd2GLlwy4TAIkoE71E8=;
  b=sIXKRKxS4RucNF1ZzaKlD+m8Nqc/G80K+rfIS2Jvqu+n8ZS7101RkS0X
   D/bh93q99QYNQwtoSBOSnNc4hBF7aP55lay1GBXOne7kHH4b0Bsgn0/0x
   ISiavBLjHlQfp/PstOcQyHfR0tanI5KwYz4HWGaqqv1EvqtU3NKxr9Dg6
   UzZsA+k1Vz7LECBsSLsz+ud4JvaXSA4vBtaCiVxrSJs2z96hriMhQlZrH
   +njJbViWmlcZOePPuRsGWo4iPrVC4NvY1lTVacrazbX1TGH8piSWOMq9w
   pCJMX20jrnCgAhhRVJjoel1NL1vcOcl8RoVw+4MwauFXCWu5ny4aWUbBI
   g==;
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="asc'?scan'208";a="156745543"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 05:28:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 05:28:38 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 13 Jun 2023 05:28:36 -0700
Date:   Tue, 13 Jun 2023 13:28:11 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yingkun Meng <mengyingkun@loongson.cn>
CC:     Conor Dooley <conor@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <loongarch@lists.linux.dev>,
        <loongson-kernel@lists.loongnix.cn>
Subject: Re: [ PATCH v2 3/3] ASoC: dt-bindings: Add support for Loongson
 audio card
Message-ID: <20230613-zoologist-panorama-a87858bba075@wendy>
References: <20230612085614.3039498-1-mengyingkun@loongson.cn>
 <20230612-booted-french-186dd95e78a9@spud>
 <bda7c25f-65cf-d45f-3ac0-f2471e3aacf8@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b/Hqn05Zp1cdyDvp"
Content-Disposition: inline
In-Reply-To: <bda7c25f-65cf-d45f-3ac0-f2471e3aacf8@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--b/Hqn05Zp1cdyDvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 08:23:58PM +0800, Yingkun Meng wrote:
>=20
> On 2023/6/13 01:24, Conor Dooley wrote:
> > Hey!
> >=20
> > On Mon, Jun 12, 2023 at 04:56:14PM +0800, YingKun Meng wrote:
> > > From: Yingkun Meng <mengyingkun@loongson.cn>
> > >=20
> > > The audio card uses loongson I2S controller present in
> > > 7axxx/2kxxx chips to transfer audio data.
> > >=20
> > > On loongson platform, the chip has only one I2S controller.
> > >=20
> > > Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
> > I got 2 copies of this patch, but none of the rest of the series appears
> > to be threaded with it.
> >=20
> > >   .../sound/loongson,ls-audio-card.yaml         | 70 ++++++++++++++++=
+++
> > >   1 file changed, 70 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/sound/loongson=
,ls-audio-card.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/sound/loongson,ls-audi=
o-card.yaml b/Documentation/devicetree/bindings/sound/loongson,ls-audio-car=
d.yaml
> > > new file mode 100644
> > > index 000000000000..61e8babed402
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.=
yaml
> > > @@ -0,0 +1,70 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/sound/loongson,ls-audio-card.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Loongson 7axxx/2kxxx ASoC audio sound card driver
> > > +
> > > +maintainers:
> > > +  - Yingkun Meng <mengyingkun@loongson.cn>
> > > +
> > > +description:
> > > +  The binding describes the sound card present in loongson
> > > +  7axxx/2kxxx platform. The sound card is an ASoC component
> > > +  which uses Loongson I2S controller to transfer the audio data.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: loongson,ls-audio-card
> > Reviewing sound stuff is beyond my pay grade, so forgive me if I am off
> > the rails here, but this (and the "x"s in the description) look a bit
> > odd. Recently, we've noticed quite a few loongson dt-bindings attempting
> > to use a single compatible for many different chips.
> > Usually you have individual compatibles for the various SoCs with this
> > core, which can fall back to a generic one, rather than just adding a
> > generic compatible for all devices.
> > As far as I know, there's several SoCs fitting 2kxxx, and the format
> > being used elsewhere is "loongson,ls2k1000" etc.
>=20
>=20
> Currently, Loongson has 2K0500/2K1000LA/2K1500/2K2000 chips.
>=20
> Here, its' possible to use a single compatible for different chips,
>=20
> as the audio device is a logical device, not dependent on chip model.

What, may I ask, is a "logical device"?

--b/Hqn05Zp1cdyDvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIhg2wAKCRB4tDGHoIJi
0u4VAQCigbmTSbs6qKpLCthlel+v9B2o217oImTKlmwzgWRYqQEArSFE2JivD5nX
5x8XGvhmbqoQ+5dKs74EhWk1XyGz6Qs=
=K/HX
-----END PGP SIGNATURE-----

--b/Hqn05Zp1cdyDvp--
