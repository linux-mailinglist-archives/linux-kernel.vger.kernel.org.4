Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F5A699132
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjBPK3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjBPK3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:29:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B791F518FC;
        Thu, 16 Feb 2023 02:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676543371; x=1708079371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9gLgZeRie+5X0NWOfUFylDfDXdQvE8EQTmZGjjxlp8A=;
  b=dFA5G8vLnYaohUXoIsVj5vQ+zYG3CWH5I9Pnwe+qOqxohlEcqr9143I6
   RYkas1iuHvE63/tQV+LUpRq3wQ2u7OVvHfVdWolwlze7tiNO3TgjMrENG
   pyfkHjEC12olJY8566+V1II9s4IN+tskYaVyLnU/0v/1fqX9oVi3cMkpT
   r0okAbbNPvOf+c4T2PQz8WTKqEYLw4Gpc6fkJ9EnIGGJYUtzko+vIV7Vp
   ykRNeZ22ZVxyFYR1yDJ04yJpTVQwHZZXOh0Px4xP/FOyLc64XfLzlEuwT
   O1xCqWpxSoqF+yqw0GxkenKQReoGHirSgEaDIf2fpfP82Da+ZoP/AuYdF
   A==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669100400"; 
   d="asc'?scan'208";a="201233189"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 03:29:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 03:29:29 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 16 Feb 2023 03:29:28 -0700
Date:   Thu, 16 Feb 2023 10:29:02 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     William Qiu <william.qiu@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
Message-ID: <Y+4Fbrz8EYIGyjVj@wendy>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
 <41bcc545-6eda-6c30-c600-d97ef009abf2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ra2G7SmeZgRSrojk"
Content-Disposition: inline
In-Reply-To: <41bcc545-6eda-6c30-c600-d97ef009abf2@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ra2G7SmeZgRSrojk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 11:23:00AM +0100, Krzysztof Kozlowski wrote:
> On 15/02/2023 12:32, William Qiu wrote:
> > Add documentation to describe StarFive System Controller Registers.
> >=20
> > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> > ---
>=20
> Thank you for your patch. There is something to discuss/improve.
>=20
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - starfive,jh7110-stg-syscon
> > +          - starfive,jh7110-sys-syscon
> > +          - starfive,jh7110-aon-syscon
>=20
> Maybe keep them ordered alphabetically?
>=20
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    syscon@10240000 {
> > +        compatible =3D "starfive,jh7110-stg-syscon", "syscon";
> > +        reg =3D <0x10240000 0x1000>;
> > +    };
>=20
> Keep only one example. All others are the same.

With these fixed:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

@Krzysztof, I assume the location of the binding is okay with you since
you didn't object to it & I suppose this one is up to me to apply if so.

Cheers,
Conor.


--ra2G7SmeZgRSrojk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+4FbgAKCRB4tDGHoIJi
0jqYAP40NbZNtujRwbP0JCaq9jdkbggGcHng7GimVi2bqkmsdQD/UXYjPT9A/qo3
5aV3tPPs1rRe2G1HjpgQ07Ubn/Ck6gs=
=PPhL
-----END PGP SIGNATURE-----

--ra2G7SmeZgRSrojk--
