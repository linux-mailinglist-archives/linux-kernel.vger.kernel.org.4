Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB6732D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjFPKL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjFPKL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:11:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E75AC;
        Fri, 16 Jun 2023 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686910315; x=1718446315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8PTgZpEiLPMpSVSdcmzuYsdAeMPqe+xF/Qpo/bvYr4c=;
  b=cgstJHhezPetkHvG92uPdCNw4wkrhY8A6LrehgFQfFZ1pGR5gvij/qnl
   jiLquz+18Mw+NG/FEUMRrpdmN3ib2rNlJO4SyINFOJhXtgpdevPkONhmX
   xSa9SYyvQLmXfyDhB6eJZOM7E3V3g8UGMT4X4ettam+Ykb9jin+TOpBDs
   3anUrMWzKWg4naJIc3xzRKjUmX8UjvCvzF3UNIbtcHzbnOtNkNB8JVia2
   u3s3E2giDETGPSD5A2IgOf1h4+tf75fjf/eISAVLb+2U51vbRNJgszgX4
   V39XYaRp92Skd+vYsEQUeKEVYMRquqJDBkV3ilGzL2Xb8h7nXEJpicQzU
   w==;
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="asc'?scan'208";a="157251664"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2023 03:11:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 16 Jun 2023 03:11:03 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 16 Jun 2023 03:11:00 -0700
Date:   Fri, 16 Jun 2023 11:10:34 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Eric Lin <eric.lin@sifive.com>
CC:     <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <maz@kernel.org>, <chenhuacai@kernel.org>,
        <baolu.lu@linux.intel.com>, <will@kernel.org>,
        <kan.liang@linux.intel.com>, <nnac123@linux.ibm.com>,
        <pierre.gondois@arm.com>, <huangguangbin2@huawei.com>,
        <jgross@suse.com>, <chao.gao@intel.com>, <maobibo@loongson.cn>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dslin1010@gmail.com>,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Message-ID: <20230616-renovate-country-12b9873b4494@wendy>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-4-eric.lin@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ssNWi0cU4z5MFoHT"
Content-Disposition: inline
In-Reply-To: <20230616063210.19063-4-eric.lin@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ssNWi0cU4z5MFoHT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Eric,

On Fri, Jun 16, 2023 at 02:32:10PM +0800, Eric Lin wrote:
> This add YAML DT binding documentation for SiFive Private L2
> cache controller
>=20
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Nick Hu <nick.hu@sifive.com>

Firstly, bindings need to come before the driver using them.

> ---
>  .../bindings/riscv/sifive,pL2Cache0.yaml      | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive,pL2Cac=
he0.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yam=
l b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
> new file mode 100644
> index 000000000000..b5d8d4a39dde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml

Cache bindings have moved to devicetree/bindings/cache.

> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2023 SiFive, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/sifive,pL2Cache0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive Private L2 Cache Controller
> +
> +maintainers:
> +  - Greentime Hu  <greentime.hu@sifive.com>
> +  - Eric Lin      <eric.lin@sifive.com>

Drop the alignment here please.

> +
> +description:
> +  The SiFive Private L2 Cache Controller is per hart and communicates wi=
th both the upstream
> +  L1 caches and downstream L3 cache or memory, enabling a high-performan=
ce cache subsystem.
> +  All the properties in ePAPR/DeviceTree specification applies for this =
platform.

Please wrap before 80 characters.

> +
> +allOf:
> +  - $ref: /schemas/cache-controller.yaml#
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - sifive,pL2Cache0
> +          - sifive,pL2Cache1

Why is this select: required?

> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - sifive,pL2Cache0
> +          - sifive,pL2Cache1

What is the difference between these? (and drop the caps please)

Should this also not fall back to "cache"?

> +
> +  cache-block-size:
> +    const: 64
> +
> +  cache-level:
> +    const: 2
> +
> +  cache-sets:
> +    const: 512
> +
> +  cache-size:
> +    const: 262144
> +
> +  cache-unified: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  next-level-cache: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - cache-block-size
> +  - cache-level
> +  - cache-sets
> +  - cache-size
> +  - cache-unified
> +  - reg
> +
> +examples:
> +  - |
> +    pl2@10104000 {

cache-controller@

Cheers,
Conor.

> +        compatible =3D "sifive,pL2Cache0";
> +        cache-block-size =3D <64>;
> +        cache-level =3D <2>;
> +        cache-sets =3D <512>;
> +        cache-size =3D <262144>;
> +        cache-unified;
> +        reg =3D <0x10104000 0x4000>;
> +        next-level-cache =3D <&L4>;
> +    };
> --=20
> 2.40.1
>=20

--ssNWi0cU4z5MFoHT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIw1GgAKCRB4tDGHoIJi
0gNOAQCIJoftwKLE7w2VWLh+kuM2k8LgVXAVjLDyCKgmSzTT0AD/deRzPJgKXPwV
MMGvlTkxTrxIz9e+3MVzNEw/6+WpHQY=
=Q4Dq
-----END PGP SIGNATURE-----

--ssNWi0cU4z5MFoHT--
