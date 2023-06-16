Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12E973282F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbjFPG7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242498AbjFPG7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:59:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC5F2D69;
        Thu, 15 Jun 2023 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686898739; x=1718434739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B24fwtB2ICXWiKb2YjOOU9xiIvWffWyp4EDuSS+K2kM=;
  b=HRMaxPE/OZtvLI/8grXIBIbFVJXVTQibEpru4DvOeFxLMWUHDrz5nOf3
   qJCJmpTN0XjAkSPwaYL1h24FOo2j2IFNq3nmW/X6pPmQlrJfrwHTD1pmF
   u3sfljDVKbp1syA+omFj7yt9kwGbJ0oPSZtRnYEZadOaMqhYfJqYnmjtO
   T+QLbUBAvsqZSxkC8gMgDfxEHhmSSPtDen07JXOeDo3jhhIrDhqQJQ6Oz
   9b6Ciar9T+jjpduwqOGLohtu/hhQMJmWAe1j7qPJGNks/hlbu4hbNdbW4
   LQ+cybo7LBOeOTsEsbdV5NZQP1y3MIwCogGWf6p2KMuDkL0Zc10GoaABG
   A==;
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="asc'?scan'208";a="218830239"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 23:58:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 23:58:58 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 15 Jun 2023 23:58:55 -0700
Date:   Fri, 16 Jun 2023 07:58:29 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <loongarch@lists.linux.dev>, Jianmin Lv <lvjianmin@loongson.cn>,
        <wanghongliang@loongson.cn>, Liu Peibao <liupeibao@loongson.cn>,
        <loongson-kernel@lists.loongnix.cn>
Subject: Re: [PATCH v3 2/3] soc: dt-bindings: add loongson-2 pm
Message-ID: <20230616-entangled-cauterize-1cbde7401b91@wendy>
References: <20230615091757.24686-1-zhuyinbo@loongson.cn>
 <20230615091757.24686-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pKwHiKupU1CL+x6/"
Content-Disposition: inline
In-Reply-To: <20230615091757.24686-3-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pKwHiKupU1CL+x6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Rob, could you take a look at this please? On v2 while you were away I
was kinda struggling w/ suspend-address & whether it made sense.

The v2 & v1 are here:
https://lore.kernel.org/all/20230522093156.7108-3-zhuyinbo@loongson.cn/
https://lore.kernel.org/all/20230517073149.31980-3-zhuyinbo@loongson.cn/

On Thu, Jun 15, 2023 at 05:17:56PM +0800, Yinbo Zhu wrote:
> Add the Loongson-2 SoC Power Management Controller binding with DT
> schema format using json-schema.
>=20
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../soc/loongson/loongson,ls2k-pmc.yaml       | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/loongson/loongs=
on,ls2k-pmc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k=
-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pm=
c.yaml
> new file mode 100644
> index 000000000000..32499bd10f8c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.ya=
ml

The filename should ideally match one of the compatibles.

> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/loongson/loongson,ls2k-pmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-2 Power Manager controller
> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - loongson,ls2k1000-pmc
> +              - loongson,ls2k0500-pmc

I notice the driver only supports one of these two. Is there a reason
for that?

> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  suspend-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The "suspend-address" is a deep sleep state (Suspend To RAM)
> +      firmware entry address which was jumped from kernel and it's
> +      value was dependent on specific platform firmware code. In
> +      addition, the PM need according to it to indicate that current
> +      SoC whether support Suspend To RAM.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pmc: pm@1fe27000 {
       ^^^

nit: this label isn't used, so you can drop it.

Cheers,
Conor.

--pKwHiKupU1CL+x6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIwIFQAKCRB4tDGHoIJi
0j0SAP4yEcxiKsuqkTFGnDCYoyr/wDXBuBcURftefENgTTZaRAEA4utfLQgRdtBs
jlzXhgfdNIcQkw/4ENO94EAQ69eyfQs=
=cZGJ
-----END PGP SIGNATURE-----

--pKwHiKupU1CL+x6/--
