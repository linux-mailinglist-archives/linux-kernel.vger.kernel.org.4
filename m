Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1094D6F9BBF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjEGVSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEGVSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:18:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D11989;
        Sun,  7 May 2023 14:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CA8961208;
        Sun,  7 May 2023 21:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63D0C433D2;
        Sun,  7 May 2023 21:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683494286;
        bh=1NZQml9zDBqx7taKKzTrx2YDBLgFsAyXf+f6+N6GDoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dn3AWSGljGjMD2p0S8VMI0fOVlM0XNeTp7X8O+57Q5f57bCPuI3kjTT5eGjdjGIiG
         VtPPFA7lcF7r3ROfl8bk3/G/VurgGG6NGupj051IyDTLqlVJAwyO7eGtV18MkObjAc
         1feGuiYDzcacZ26mAkR8i3uw3sWdTFg/3BaO8fQDKTV2xA04xyNRFC4w0lPc//6amA
         Qj7iudIdOqDtbDaR7gu9OUceS0TgHVhFahhezUI2g0YfvOyI95qCjtiLby1qNRRDtB
         9/z/W60nOVJkv8fCJoTVt2LJZEzqxwQSA2Xd+v3EqaMN+U4sfuEbMXYyD49OKg3g7c
         UiYhnzB8USLrw==
Date:   Sun, 7 May 2023 22:18:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 1/5] irqchip/sifive-plic: Support T-HEAD's C910 PLIC
Message-ID: <20230507-spiny-purify-bd1a0bc395ee@spud>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BFuuXvLmezuA9yIP"
Content-Disposition: inline
In-Reply-To: <20230507182304.2934-2-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BFuuXvLmezuA9yIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jisheng,

On Mon, May 08, 2023 at 02:23:00AM +0800, Jisheng Zhang wrote:
> The T-HEAD's C910 PLIC still needs the delegation bit settingto allow
> access from S-mode, but it doesn't need the edge quirk.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 4 ++++
>  drivers/irqchip/irq-sifive-plic.c                             | 1 +

dt-bindings changes need to be in their own patch.

>  2 files changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index f75736a061af..64b43a3c3748 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -62,6 +62,10 @@ properties:
>                - starfive,jh7110-plic
>                - canaan,k210-plic
>            - const: sifive,plic-1.0.0
> +      - items:
> +          - enum:
> +              - thead,light-plic

If "light" is a code name, but "TH1520" is what this is known as to the
wider world, I think we should use thead,th1520-plic here.

Thanks,
Conor.

> +          - const: thead,c910-plic
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-plic
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index e1484905b7bd..71afa2a584d9 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -569,6 +569,7 @@ static int __init plic_init(struct device_node *node,
>  }
> =20
>  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> +IRQCHIP_DECLARE(thead_c910_plic, "thead,c910-plic", plic_init);
>  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy sy=
stems */
> =20
>  static int __init plic_edge_init(struct device_node *node,
> --=20
> 2.40.0
>=20

--BFuuXvLmezuA9yIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFgViQAKCRB4tDGHoIJi
0ip+AP4np3bd4vMrd0RXgyATUrdb76pBpi/32O/A4+EtjoCCqAEAhjBHhz7U+tAv
V4QSEXP0R6ThmABGVDXyj6/5ver+GAk=
=zm2X
-----END PGP SIGNATURE-----

--BFuuXvLmezuA9yIP--
