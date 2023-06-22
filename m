Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A98739D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjFVJeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjFVJdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:33:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69801BD4;
        Thu, 22 Jun 2023 02:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687426046; x=1718962046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=avbGK7S7LV+7nn+z658JKvXE0ojq/Xd4FY7WvcVFmzg=;
  b=h3P5621KdzQ3CwnSlfIuv2sSp+1NhJDwT9ksVkg+N63LjpJs/fvvcDwj
   yJwTMsHormC0ZZ+iVGpvSYln4t4c1NMYK7mPnHXpWgmzIXsKZQryT1Ocw
   WvMzPYzJ5vtJZrSdpF0d8oreSTtxREGa/AFlzWvEA4ZO3GkR4dTmnDEzs
   aC5M7FzDQAM4qFba0leEs7/vw7amgsMTv4NJAr/X/4V7GT0d+t85/Gvab
   cPzE8/UXE+hivzZXS1P2u/fQIdWBtNBb/v50Y2OMnQRp8vK+aGt/6+y4h
   p7EHXqXk8eZnVVAawFVnLX6NQCRjNgUypmLwyK9oXLLjy43sTCRlumIcy
   A==;
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="asc'?scan'208";a="158093292"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2023 02:27:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 22 Jun 2023 02:26:47 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 22 Jun 2023 02:26:45 -0700
Date:   Thu, 22 Jun 2023 10:26:18 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Lucas Tanure <tanure@linux.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
Message-ID: <20230622-unsent-willing-574906af5e1a@wendy>
References: <20230622084045.519203-1-tanure@linux.com>
 <20230622084045.519203-3-tanure@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ddIyo+hP71qlkpK4"
Content-Disposition: inline
In-Reply-To: <20230622084045.519203-3-tanure@linux.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ddIyo+hP71qlkpK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Lucas,

On Thu, Jun 22, 2023 at 09:40:44AM +0100, Lucas Tanure wrote:
> Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
> There is no need for an extra compatible line in the driver, but
> add T7 compatible line for documentation.
>=20
> Co-developed-by: Conor Dooley <conor@kernel.org>

You can delete this, I don't need a Co-developed-by tag for review
feedback.

> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.=
yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> index 01ec45b3b406..4ca4673169aa 100644
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -46,6 +46,12 @@ properties:
>            - amlogic,meson8b-uart
>            - amlogic,meson-gx-uart
>            - amlogic,meson-s4-uart
> +      - description: Everything-Else power domain UART controller on G12=
A compatible SoCs

s/Everything-Else/Always-on/
Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Perhaps it can be fixed on application, I don't know how the amlogic
maintainers operate.

Cheers,
Conor.

> +        items:
> +          - enum:
> +              - amlogic,meson-t7-uart
> +          - const: amlogic,meson-g12a-uart
> +          - const: amlogic,meson-ao-uart
>        - description: Everything-Else power domain UART controller on G12=
A SoCs
>          items:
>            - const: amlogic,meson-g12a-uart
> --=20
> 2.41.0
>=20

--ddIyo+hP71qlkpK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJQTugAKCRB4tDGHoIJi
0lalAQC26MkvYfk+N8oVCKB3gmbONVI77MG2hQKQm4gPBQBMpAEAmhCQCy5FYk2G
fefLgjHl2z94F9oOu9SJ+Zj8fkWhOgg=
=vwt5
-----END PGP SIGNATURE-----

--ddIyo+hP71qlkpK4--
