Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA065DFBE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbjADWRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbjADWRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:17:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D741A069;
        Wed,  4 Jan 2023 14:17:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FAD86185F;
        Wed,  4 Jan 2023 22:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9CCC43392;
        Wed,  4 Jan 2023 22:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672870623;
        bh=nTOZE+n1x/HPxCpxyWWYLQviHIqmDTpR/4NccwtHT+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IoJlp+b1uXIaXFHUxj+Ce2apRzAZDrapooHr9EBzBVf9qXgfCSTbbmlb8q/1UPgi1
         DJLeY67pw21s2QLNCimRumKSVcikEtJBKJrIFgOCMF1IxWY4fUDa5R7nrkzr/DRTuL
         yKUtHutzxz0QbWy19JidFkwfHfESoNqco1tRCcKdfHQ0GuvlkS8uslWj/OPvhsJEzn
         1FwkjijYTga8XPpRorWH5Z69r+aQnoVdt6bb6CK0yCS5jXchwcKbcEIjLjOHx4Ub3b
         9/ks/XYDKey4/5wBoO+8YeSIbcNZIz8xCYG9rI4RQ7eEaSnIUXbcrOUZ4MdBcNjc79
         UecqYixuIVYaA==
Date:   Wed, 4 Jan 2023 22:16:58 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/9] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
Message-ID: <Y7X62v5Zp6+thx5A@spud>
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-7-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CM+OG7HiznyhPXQ1"
Content-Disposition: inline
In-Reply-To: <20230103141409.772298-7-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CM+OG7HiznyhPXQ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Anup,

On Tue, Jan 03, 2023 at 07:44:06PM +0530, Anup Patel wrote:
> We add DT bindings document for RISC-V advanced platform level
> interrupt controller (APLIC) defined by the RISC-V advanced
> interrupt architecture (AIA) specification.
>=20
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../interrupt-controller/riscv,aplic.yaml     | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controlle=
r/riscv,aplic.yaml

> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 16384
> +    description:
> +      Given APLIC domain directly injects external interrupts to a set of
> +      RISC-V HARTS (or CPUs). Each node pointed to should be a riscv,cpu=
-intc
> +      node, which has a riscv node (i.e. RISC-V HART) as parent.
> +
> +  msi-parent:
> +    description:
> +      Given APLIC domain forwards wired interrupts as MSIs to a AIA inco=
ming
> +      message signaled interrupt controller (IMSIC). This property shoul=
d be
> +      considered only when the interrupts-extended property is absent.

Considered by what?
On v1 you said:
<quote>
If both "interrupts-extended" and "msi-parent" are present then it means
the APLIC domain supports both MSI mode and Direct mode in HW. In this
case, the APLIC driver has to choose between MSI mode or Direct mode.
<\quote>

The description is still pretty ambiguous IMO. Perhaps incorporate
some of that expanded comment into the property description?
Say, "If both foo and bar are present, the APLIC domain has hardware
support for both MSI and direct mode. Software may then chose either
mode".
Have I misunderstood your comment on v1? It read as if having both
present indicated that both were possible & that "should be considered
only..." was more of a suggestion and a comment about the Linux driver's
behaviour.
Apologies if I have misunderstood, but I suppose if I have then the
binding's description could be improved!!

> +  riscv,children:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 1024
> +    items:
> +      maxItems: 1
> +    description:
> +      A list of child APLIC domains for the given APLIC domain. Each chi=
ld
> +      APLIC domain is assigned child index in increasing order with the

btw, missing article before child (& a comma after order I think).

> +      first child APLIC domain assigned child index 0. The APLIC domain
> +      child index is used by firmware to delegate interrupts from the
> +      given APLIC domain to a particular child APLIC domain.
> +
> +  riscv,delegate:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 1024

Is it valid to have a delegate property without children? If not, the
binding should reflect that dependency IMO.

> +    items:
> +      items:
> +        - description: child APLIC domain phandle
> +        - description: first interrupt number (inclusive)
> +        - description: last interrupt number (inclusive)
> +    description:
> +      A interrupt delegation list where each entry is a triple consisting
> +      of child APLIC domain phandle, first interrupt number, and last
> +      interrupt number. The firmware will configure interrupt delegation

btw, drop the article before firmware here.
Also, "firmware will" or "firmware must"? Semantics perhaps, but they
are different!

Kinda for my own curiosity here, but do you expect these properties to
generally be dynamically filled in by the bootloader or read by the
bootloader to set up the configuration?

> +      registers based on interrupt delegation list.

I'm sorry Anup, but this child versus delegate thing is still not clear
to me binding wise. See below.

> +    aplic0: interrupt-controller@c000000 {
> +      compatible =3D "riscv,qemu-aplic", "riscv,aplic";
> +      interrupts-extended =3D <&cpu1_intc 11>,
> +                            <&cpu2_intc 11>,
> +                            <&cpu3_intc 11>,
> +                            <&cpu4_intc 11>;
> +      reg =3D <0xc000000 0x4080>;
> +      interrupt-controller;
> +      #interrupt-cells =3D <2>;
> +      riscv,num-sources =3D <63>;
> +      riscv,children =3D <&aplic1>, <&aplic2>;
> +      riscv,delegate =3D <&aplic1 1 63>;

Is aplic2 here for demonstrative purposes only, since it has not been
delegated any interrupts?
I suppose it is hardware present on the SoC that is not being used by
the current configuration?

Thanks,
Conor.

> +    };
> +
> +    aplic1: interrupt-controller@d000000 {
> +      compatible =3D "riscv,qemu-aplic", "riscv,aplic";
> +      interrupts-extended =3D <&cpu1_intc 9>,
> +                            <&cpu2_intc 9>;
> +      reg =3D <0xd000000 0x4080>;
> +      interrupt-controller;
> +      #interrupt-cells =3D <2>;
> +      riscv,num-sources =3D <63>;
> +    };
> +
> +    aplic2: interrupt-controller@e000000 {
> +      compatible =3D "riscv,qemu-aplic", "riscv,aplic";
> +      interrupts-extended =3D <&cpu3_intc 9>,
> +                            <&cpu4_intc 9>;
> +      reg =3D <0xe000000 0x4080>;
> +      interrupt-controller;
> +      #interrupt-cells =3D <2>;
> +      riscv,num-sources =3D <63>;
> +    };


--CM+OG7HiznyhPXQ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7X62gAKCRB4tDGHoIJi
0jdPAQDE7jaXqDBSHkYz30DfCDF68e8vHV/nGNfwySX74TqkmAEA8kiQVjEAphNj
VrxoMV535/dnuFew0/H+emA4BYc1swU=
=Whsj
-----END PGP SIGNATURE-----

--CM+OG7HiznyhPXQ1--
