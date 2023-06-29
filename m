Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE177422D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjF2JBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjF2JBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:01:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38C410D5;
        Thu, 29 Jun 2023 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688029301; x=1719565301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w3S5KyMzhn3eCt7uu2HW5CUsu9QGVcQK3sBOL7pJmvU=;
  b=nk9GZ6VKSMhHfYwnXaznXAPf9OSBK473WD/tVB+bHCjEljkGgSUUHpT6
   /w4pQu9cOMvLneXnVb2Zf0iILzqYlvcNlfiGTHluU7ET7ar9fmh5zMbkW
   auR2liX6OU+RGJXLQbxq8BI8v0SkE0Bwuq5KLET/P8lSxS209utq0QWFM
   s4EiPUpk/DoCfIExwnDpusbqW6GVbmK9tRqcti44ILzRFO8id7krJUERx
   HEZfHE/fgBZnX5wOP7uaA5LpoQ4Xqd5e2vWW+keDOposw4Owg3P6qV8Df
   qbSdOr1uwk1hT9QEk60IzteP0fnMhDPGhVA/rseIpas0l4Y819ew9ry70
   g==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="asc'?scan'208";a="218159678"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2023 02:01:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 02:01:39 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 29 Jun 2023 02:01:36 -0700
Date:   Thu, 29 Jun 2023 10:01:07 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Message-ID: <20230629-throng-creation-a33bbd191c1a@wendy>
References: <20230613125852.211636-1-xingyu.wu@starfivetech.com>
 <20230613125852.211636-3-xingyu.wu@starfivetech.com>
 <7e2d6bfe-5687-97c5-778b-c02e9c0894af@linaro.org>
 <a83c98ae-2f6c-00c4-5d05-fc304718e05a@starfivetech.com>
 <20230628-affix-maverick-84a08905f05b@spud>
 <2270fd7f-1751-066a-0da5-e35cdd59fd2f@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dyYLTwA1dVYqX1L9"
Content-Disposition: inline
In-Reply-To: <2270fd7f-1751-066a-0da5-e35cdd59fd2f@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dyYLTwA1dVYqX1L9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 02:42:39PM +0800, Xingyu Wu wrote:
> On 2023/6/29 1:34, Conor Dooley wrote:
> > On Wed, Jun 28, 2023 at 02:44:10PM +0800, Xingyu Wu wrote:
> >> On 2023/6/14 2:31, Krzysztof Kozlowski wrote:
> >> > On 13/06/2023 14:58, Xingyu Wu wrote:
> >> >> From: William Qiu <william.qiu@starfivetech.com>

> >> >> +allOf:
> >> >> +  - if:
> >> >> +      properties:
> >> >> +        compatible:
> >> >> +          contains:
> >> >> +            const: starfive,jh7110-aon-syscon
> >> >> +    then:
> >> >> +      required:
> >> >> +        - "#power-domain-cells"
> >> >=20
> >> > Where did you implement the results of the discussion that only some
> >> > devices can have power and clock controller?
> >> >=20
> >> > According to your code all of above - sys, aon and stg - have clock =
and
> >> > power controllers. If not, then the code is not correct, so please do
> >> > not respond with what is where (like you did last time) but actually
> >> > implement what you say.

> Yeah, following your advice, I modified the codes and there are two optio=
ns:
>=20
> --- a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-sysc=
on.yaml
> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-sysc=
on.yaml
> @@ -41,6 +41,16 @@ required:
>    - reg
> =20
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: starfive,jh7110-sys-syscon
> +    then:
> +      required:
> +        - clock-controller
> +      properties:
> +        "#power-domain-cells": false
>    - if:
>        properties:
>          compatible:
>            contains:
>              const: starfive,jh7110-aon-syscon
>      then:
>        required:
>          - "#power-domain-cells"
> +      properties:
> +        clock-controller: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: starfive,jh7110-stg-syscon
> +    then:
> +      properties:
> +        clock-controller: false
> +        "#power-domain-cells": false
> =20
>  additionalProperties: false
>=20
> Or :
>=20
> --- a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-sysc=
on.yaml
> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-sysc=
on.yaml
> @@ -41,6 +41,17 @@ required:
>    - reg
> =20
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: starfive,jh7110-sys-syscon
> +    then:
> +      required:
> +        - clock-controller
> +    else:
> +      properties:
> +        clock-controller: false
>    - if:
>        properties:
>          compatible:
>            contains:
>              const: starfive,jh7110-aon-syscon
>      then:
>        required:
>          - "#power-domain-cells"
> +    else:
> +      properties:
> +        "#power-domain-cells": false
> =20
>  additionalProperties: false
>=20
> Which one is better? Thanks.

This second one looks better to me, as it achieves the same thing in a
simpler way.

Cheers,
Conor.

--dyYLTwA1dVYqX1L9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ1IUwAKCRB4tDGHoIJi
0p+VAP0VjZDVhCo7waX9fMh6nsZdgK3duJg4TOoQ68hNJoD8xgEAvalmj5FLOA7Y
XHTX3ksOnF8f5wfr2yjAkNY6DmfAng0=
=bcF5
-----END PGP SIGNATURE-----

--dyYLTwA1dVYqX1L9--
