Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA5570F18F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbjEXI5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbjEXI5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:57:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F15497;
        Wed, 24 May 2023 01:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684918634; x=1716454634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RW0IgkneiN2lA7NI9fVLY7vHeqUJ1Zw8kHLQN32dM/c=;
  b=AaZpR6leentI8i+RiekC2ItOXL7ZmriDjqgz2MYSGhKnRXx1tFrwTYN+
   czRQNjJ8qmAoh18WupQ9F6RR7PmAkEcwuwX/2jE50obe1QKFLRtBPeiEk
   cWn04Nz2pdxXiBDIiyYBPmVcKmrKfCWR7loAVo9DviLGZxvFYDnDWcaVg
   jrZ6ZoZLEeL0jWm2vBR3n9LPLwW7cap4RJ53VxfSCKGdMzLu3mnEyZPfG
   LW4ckiGmnzp15OKXVN8qFLsjGxdBRwkIp0NThDB5b19z2PcAa0rfJP+6J
   HcCnHCVZbyvRWn3vvhIMg8Nk+8RF/tIUEW9hQgYuL3PY4QLu9PhtAXTBM
   A==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="asc'?scan'208";a="153670197"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 01:57:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 01:57:11 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 24 May 2023 01:57:09 -0700
Date:   Wed, 24 May 2023 09:56:47 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>,
        <wanghongliang@loongson.cn>, Liu Peibao <liupeibao@loongson.cn>,
        <loongson-kernel@lists.loongnix.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v11 1/2] dt-bindings: spi: add loongson spi
Message-ID: <20230524-pouncing-variable-c520e85f8db8@wendy>
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <20230522071030.5193-2-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8QaxS1dvQPxlqCKP"
Content-Disposition: inline
In-Reply-To: <20230522071030.5193-2-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8QaxS1dvQPxlqCKP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 03:10:29PM +0800, Yinbo Zhu wrote:
> Add the Loongson platform spi binding with DT schema format using
> json-schema.
>=20
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/spi/loongson,ls2k-spi.yaml       | 41 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls2k-s=
pi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml=
 b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
> new file mode 100644
> index 000000000000..d0be6e5378d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/loongson,ls2k-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson SPI controller
> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls2k-spi

I am sorry to jump in here at such a late stage with a (potentially)
trivial question. "ls2k" is the SoC family rather than a specific model
as far as I understand.
The answer is probably yes, but do all SoCs in the family have an
identical version of the IP?

Cheers,
Conor.

--8QaxS1dvQPxlqCKP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG3RTwAKCRB4tDGHoIJi
0vhaAP4qvlPd/Y5xeahrTrNYAScnzWN9KkGBWYj4dIt7W5ayFgD8Co6Y2PAiWZPW
iIuu6Ay00cydK8AKDf4HG0nafaGKSAc=
=yeZA
-----END PGP SIGNATURE-----

--8QaxS1dvQPxlqCKP--
