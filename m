Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44F86DAB46
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjDGKLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjDGKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:11:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D458B7ED8;
        Fri,  7 Apr 2023 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680862287; x=1712398287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gAO8SRCumNxD+pCFQwia+WypiPkxM5kfEBEREoMMxqc=;
  b=wL50An3baxroiYEsk6SUdxyVfUtCw0Ou19l/IYJ8+u+ZojWy8F2ey9J8
   THpeFxVRFCAePSwZgghcmY56dL7Q8ohs2ZI7wH749OhEuoh8/dA9vTNq3
   loK9+hOzWgwCBfqsBM3CapquDtPUBUPDxNFF742m466pfSPl/5jZWCLeQ
   VlMLZvlhnLq8WOGwYTKDQUZx9pWdfQrPPlYjyr0b+jCjG6plvpPBDiQOv
   FEX+3COIPrh9xZoI+25cv0iOryUAW92Hoj3E76kiU2ruGYxJv17EkvmhU
   od8uutVZSFtlZw+m+YtbZ7XPAC3DvHimsTu8yes8vXvLJqG575LUEAOMb
   g==;
X-IronPort-AV: E=Sophos;i="5.98,326,1673938800"; 
   d="asc'?scan'208";a="145993498"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2023 03:11:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 7 Apr 2023 03:11:26 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 7 Apr 2023 03:11:24 -0700
Date:   Fri, 7 Apr 2023 11:11:09 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     William Qiu <william.qiu@starfivetech.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH v7 1/2] dt-bindings: soc: starfive: Add StarFive syscon
 doc
Message-ID: <20230407-stand-reversion-1db211c03ff4@wendy>
References: <20230406103308.1280860-1-william.qiu@starfivetech.com>
 <20230406103308.1280860-2-william.qiu@starfivetech.com>
 <833b68a5-263d-d293-4910-2ca50b43e60d@linaro.org>
 <2ce35d68-ae6c-129f-588e-9b292de3a654@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fh2qLU8GMRk0u5gs"
Content-Disposition: inline
In-Reply-To: <2ce35d68-ae6c-129f-588e-9b292de3a654@starfivetech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Fh2qLU8GMRk0u5gs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2023 at 05:30:31PM +0800, William Qiu wrote:
>=20
> This would be $ref: /schemas/clock/starfive,jh7110-pll.yaml#, but this fi=
le is not
> available at present,  so I would like to ask if I should submit the docu=
ments
> instead of Xingyu

Or just send the whole lot as one series, and I'll ack the soc bits for
Stephen to take the whole lot via clk? I think Xingyu owes a respin
anyway cos of the changes to this binding file that Krzysztof requested
there.

Plus, the base clock support is now in clk-next, so their stuff is now
applicable to the clk tree.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4c0b39c44957..0b2170e1e4ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19911,6 +19911,11 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/mmc/starfive*
>  F:	drivers/mmc/host/dw_mmc-starfive.c
> =20
> +STARFIVE JH7110 SYSCON
> +M:	William Qiu <william.qiu@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon=
=2Eyaml

Can you squash this in please (whitespace damaged):
diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..6fbb486f59ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19943,6 +19943,7 @@ STARFIVE SOC DRIVERS
 M:     Conor Dooley <conor@kernel.org>
 S:     Maintained
 T:     git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
+F:     Documentation/devicetree/bindings/soc/starfive/
 F:     drivers/soc/starfive/

Cheers,
Conor.

--Fh2qLU8GMRk0u5gs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZC/sPQAKCRB4tDGHoIJi
0mqrAQD68lH1tU4Wq6HSU+FTpSvVnORJwEnuw/Y48zO6SDo9OAD/fZYy57Fk/I74
EpFkC7hl22U7CmGZuW8tlC/bZfG+1QE=
=K7GJ
-----END PGP SIGNATURE-----

--Fh2qLU8GMRk0u5gs--
