Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD91B70BEB0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjEVMsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjEVMsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:48:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E30AA;
        Mon, 22 May 2023 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684759684; x=1716295684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yxKglgoCICqxCp/YUO9N6SBOqlY2w1KxWsoJyA/AVRs=;
  b=euuvFxzxlC2BYJDjvt/ixzQH3txQF5bjN4zvABJLU5mzlUD6J8bi9BR2
   hVAFNVvp8psHmXKAEfYHpcvdbsc/5eeUyuKXLr2YvdQ+UoSW3OFpyBgvr
   aushmZe8KUyXU+sY5EkAGd003i4X1s8Cr7i2tv8tjMGMWLvWNo86av15H
   nfL1TmFZJQwN2XIlFh3R6oYE9yJHoPMdlEls02XRa6HWa/I3PfCS0YaOi
   5jZUsCINhxH2o1skq6yWcgSdcAm8QumsDxR8cC7Nt+oGkqFZtYYRowNOn
   g5RIrmUGD31MkO2YXN7b76e20F2cwFmhfK6e9NQNoI+JIvJVw5vTzb4gi
   g==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="asc'?scan'208";a="214906449"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 05:48:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 05:48:02 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 05:47:59 -0700
Date:   Mon, 22 May 2023 13:47:37 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Baoqi Zhang <zhangbaoqi@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, Yun Liu <liuyun@loongson.cn>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        <wanghongliang@loongson.cn>, Liu Peibao <liupeibao@loongson.cn>,
        <loongson-kernel@lists.loongnix.cn>
Subject: Re: [PATCH v2 2/3] dt-bindings: soc: add loongson-2 pm
Message-ID: <20230522-kooky-outbid-82662b45d305@wendy>
References: <20230522093156.7108-1-zhuyinbo@loongson.cn>
 <20230522093156.7108-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKHvUwRJNqoRSsho"
Content-Disposition: inline
In-Reply-To: <20230522093156.7108-3-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--gKHvUwRJNqoRSsho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey!

On Mon, May 22, 2023 at 05:31:55PM +0800, Yinbo Zhu wrote:
> Add the Loongson-2 SoC Power Management Controller binding with DT
> schema format using json-schema.

Grabbing thread from lore.kernel.org/all/20230522093156.7108-3-zhuyinbo%40l=
oongson.cn/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 3 messages in the thread
Checking attestation on all messages, may take a moment...
---
  [PATCH v2 1/3] loongarch: export loongarch pm interface
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  [PATCH v2 2/3] dt-bindings: soc: add loongson-2 pm
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  ERROR: missing [3/3]!
---
Total patches: 2
---
WARNING: Thread incomplete!
Applying: loongarch: export loongarch pm interface
Applying: dt-bindings: soc: add loongson-2 pm

Looks like the user for these bindings got lost somewhere along the way?
Please make sure to keep a series threaded.

>=20
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../soc/loongson/loongson,ls2k-pmc.yaml       | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/loongson/loongs=
on,ls2k-pmc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k=
-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pm=
c.yaml
> new file mode 100644
> index 000000000000..ddad62889c60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.ya=
ml
> @@ -0,0 +1,51 @@
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
> +    items:
> +      - enum:
> +          - loongson,ls2k-pmc
> +      - const: syscon
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

I (still) think this property is rather odd, maybe I am just not really
understanding the property as it seems to be described partly in terms
of operating system behaviour rather than its actual function. "was
jumped from kernel" I don't get.

The whole setup here seems a bit odd, but that's for the loongson arch
folks reviewing the actual code to comment on!

Thanks,
Conor.

--gKHvUwRJNqoRSsho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGtkaQAKCRB4tDGHoIJi
0lI/AP9QXb2RsmKR29etNH1JpHYidwCCU9a2ysUEbVebSFyQYwD6AytJGE2GQLfa
2xQLm5VNuuHYmHeEFacgzuPyui/L4gg=
=xr43
-----END PGP SIGNATURE-----

--gKHvUwRJNqoRSsho--
