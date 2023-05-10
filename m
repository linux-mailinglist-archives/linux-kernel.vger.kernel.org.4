Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF1B6FDA54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbjEJJDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbjEJJDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:03:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E230F4;
        Wed, 10 May 2023 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683709417; x=1715245417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VpdYeJ4G6emHuCE/V9JBrB8r3xgWZqaYPxiXW9vSJIQ=;
  b=WVn19sWrS15VbXzpf0+KePogrkvJOr2GICPi22azgUjnXFIAUAelwFWy
   xZetKYzW+g2g8271luC9wI83FHvaKH/irNo517ZjwqW4QL/8S8UQbqwP2
   kMv/wupCW36T/f+bWOaVnTWgwzqaudSiOOkTADJXRw+2VWZdthgVhfkXm
   N0h8Z55xY327eDS2SNZcUFZuT2QLoL9pX91btkPAu5hHTesss48znLtoV
   U2ebux8REAgN5WjCTaiWsiHjlI0eg3Wz6Mo+XjkbizJEHBpG12mHGAwx0
   n6jqoCe27IpHeu3m2wy9zETwNG7ZopsFu0a0+cKS922Zlg4RTXHRNli7A
   w==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677567600"; 
   d="asc'?scan'208";a="214617575"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 02:03:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 02:03:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 10 May 2023 02:03:31 -0700
Date:   Wed, 10 May 2023 10:03:11 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
CC:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <shawnguo@kernel.org>,
        <marex@denx.de>, <frieder.schrempf@kontron.de>,
        <stefan.wahren@i2se.com>, <marcel.ziswiler@toradex.com>,
        <festevam@denx.de>, <Markus.Niebel@tq-group.com>,
        <leoyang.li@nxp.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: dts: Add initial support for Emtop SOM
 IMX8MM
Message-ID: <20230510-grappling-cover-62367950d730@wendy>
References: <20230510083104.3692006-1-himanshu.bhavani@siliconsignals.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OzP8MZ2gRZYgo27s"
Content-Disposition: inline
In-Reply-To: <20230510083104.3692006-1-himanshu.bhavani@siliconsignals.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--OzP8MZ2gRZYgo27s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 02:01:04PM +0530, Himanshu Bhavani wrote:
> Add the initial device tree support for Emtop SOM based om IMX8MM.

In the future, please send this as a threaded patchset. Git's send-email
will do this automatically if you point it at a directory containing the
patches. For example, see "Thread overview" in:
https://lore.kernel.org/all/20230510083346.3692555-1-himanshu.bhavani@silic=
onsignals.io/

You can see that there is only one patch in that thread.

Cheers,
Conor.

>=20
> Change in v2:
> - in patch 1/3:
>         - Update dtb add order in Makefile
>         - Update proper prefix/name in dts
>         - Removed stray blank line
>         - Add pinctrl-names
>=20
> - in patch 2/3:
>         - Update bindings
>=20
> Changes in v3:
> - in patch 1/3:
> 	- Removed dead code
> 	- Fixed style and indentations
>=20
> - in patch 3/3:
> 	- Update vendor prefix
>=20
>=20
> Himanshu Bhavani (3):
>   arm64: dts: Add device tree for the Emtop SOM IMX8MM
>   dt-bindings: arm: fsl: Enumerate Emtop SOM
>   dt-bindings: vendor-prefixes: Add Emtop
>=20
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../arm64/boot/dts/freescale/imx8mm-emtop.dts | 261 ++++++++++++++++++
>  4 files changed, 265 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
>=20
> --=20
> 2.25.1
>=20

--OzP8MZ2gRZYgo27s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFtdzwAKCRB4tDGHoIJi
0g5eAQC92PM9o7VOx2fJQ0cALdDEmHhdy2kkSlzZ71Gw4E3PNAEAoRZuMnToNJ0K
06Tg5lfLtuEvbvOVE9yjYriUR9RF7gw=
=mzDc
-----END PGP SIGNATURE-----

--OzP8MZ2gRZYgo27s--
