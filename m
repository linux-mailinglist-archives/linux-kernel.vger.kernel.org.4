Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC376AC23B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCFOFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCFOFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:05:51 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9475630EA4;
        Mon,  6 Mar 2023 06:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678111529; x=1709647529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j460tnFBqbOnjRtbkvJml91BluSKepD3j5MyrI06lZY=;
  b=wlp8q+PTjHcJvXg8e3OY7V78B4xtupl3eJ55XsXMIdpSvEeNUekLFW69
   CM+HH+5+fV7TiRnPwP7uHNiQDHqVhIbFBjET1DonQk91jqjLizg3MHEQZ
   w7wuhMa5W10nifPjHarHte5d6zjaOon+MXapAiwbf4Rlu3d5aHTt7EpGV
   iQPfheJn2D7ETGGd3LHK5RJykcbiO3MaTUbS5smE8kO2B6CXG3XpMlmGJ
   laqvQNNDINHu/og1WA4x6UkxPaKRbkk96e6eWnR8hBsGAYmrg1hm9SrWW
   WcWlr3aBYJAu9u+i3vqN8Yh9n3fGwqvaj5XxDpr5ujWZJkubmAigGv1ls
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,238,1673938800"; 
   d="asc'?scan'208";a="200138216"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 07:05:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 07:05:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 6 Mar 2023 07:05:25 -0700
Date:   Mon, 6 Mar 2023 14:04:57 +0000
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
Message-ID: <ZAXzCfs7wkxaUWN7@wendy>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
 <41bcc545-6eda-6c30-c600-d97ef009abf2@linaro.org>
 <Y+4Fbrz8EYIGyjVj@wendy>
 <8388695b-98f9-223b-1e15-86aaefec2d6f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wJtNSCpBxG2n/Eo9"
Content-Disposition: inline
In-Reply-To: <8388695b-98f9-223b-1e15-86aaefec2d6f@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--wJtNSCpBxG2n/Eo9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey William,

On Thu, Feb 16, 2023 at 11:31:45AM +0100, Krzysztof Kozlowski wrote:
> On 16/02/2023 11:29, Conor Dooley wrote:
> > On Thu, Feb 16, 2023 at 11:23:00AM +0100, Krzysztof Kozlowski wrote:
> >> On 15/02/2023 12:32, William Qiu wrote:
> >>> Add documentation to describe StarFive System Controller Registers.
> >>>
> >>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >>> ---
> >>
> >> Thank you for your patch. There is something to discuss/improve.

Could you please submit a v5 of this, with the bits below fixed,
whenever Hal sends their next version of the base dts series?
There's no maintainers coverage for a soc/starfive subdirectory of
dt-bindings yet, so please CC conor@kernel.org &
linux-riscv@lists.infradead.com on the patch.

Thanks,
Conor.

> >>
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:
> >>> +          - starfive,jh7110-stg-syscon
> >>> +          - starfive,jh7110-sys-syscon
> >>> +          - starfive,jh7110-aon-syscon
> >>
> >> Maybe keep them ordered alphabetically?
> >>
> >>> +      - const: syscon
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    syscon@10240000 {
> >>> +        compatible =3D "starfive,jh7110-stg-syscon", "syscon";
> >>> +        reg =3D <0x10240000 0x1000>;
> >>> +    };
> >>
> >> Keep only one example. All others are the same.
> >=20
> > With these fixed:
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > @Krzysztof, I assume the location of the binding is okay with you since
> > you didn't object to it & I suppose this one is up to me to apply if so.
>=20
> Yeah, generic sysreg devices go to soc. If their primary functions were
> different (e.g. clock controller which also is syscon), then they should
> go to respective directories, but it's not the case here, I think.
>=20
> Best regards,
> Krzysztof
>=20
>=20

--wJtNSCpBxG2n/Eo9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAXzCQAKCRB4tDGHoIJi
0vj0APsEG0BpMkkdDazmeJqsM4kXPSsQBhKaSl/nXRDAbqD8GwD+O0NncG358/h5
GJTAkWmJAdokfjZhfNFmBhbBeRylkgU=
=Y/Ml
-----END PGP SIGNATURE-----

--wJtNSCpBxG2n/Eo9--
