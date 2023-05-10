Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E376FE1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbjEJPla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237642AbjEJPlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:41:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035471BE4;
        Wed, 10 May 2023 08:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94D366349F;
        Wed, 10 May 2023 15:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D28C433EF;
        Wed, 10 May 2023 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683733273;
        bh=mLYM0wIwUokBuFVTYEtUbVK+lQG9aMCuvxc8EfSHdcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eK0d7TEMKg4b6LHMswgnbxnb6cnYkkYk17LlIMbRc+GkO5gyOkVRNWamgdCr4HycV
         4g4b6O1ANLxYp+KuwpQdHwJIeVe4Gr53VpYO++95vcz9QbaGENyPbt9HdWMQnZjziB
         bNJ+RmWp6iIzIJxeTUEenNo5aYNzJ263bJvsfHh/dA9QT+kUmuBWiCvrF0I7b2qr3i
         MjbCgnMYjvOhg6hkzVn68doBDO43KrsLEXcLNkE4iRPlh1JRVeUkU/uQ/Ubr69c65d
         zm08WbepM4L8eL6XSJJ5I0IrofMfRnSzkHu11W1E2vUrAUpbfkIe9wKVPSwI0Jn+ZP
         U9wxW+VOKj94A==
Date:   Wed, 10 May 2023 16:41:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 08/11] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
Message-ID: <20230510-retry-paced-644f5a95ba3f@spud>
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-9-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="arKlgyJ7DEAnFfLA"
Content-Disposition: inline
In-Reply-To: <20230508142842.854564-9-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--arKlgyJ7DEAnFfLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Anup,

On Mon, May 08, 2023 at 07:58:39PM +0530, Anup Patel wrote:
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 16384
> +    description:
> +      Given APLIC domain directly injects external interrupts to a set of
> +      RISC-V HARTS (or CPUs). Each node pointed to should be a riscv,cpu=
-intc
> +      node, which has a riscv node (i.e. RISC-V HART) as parent.

Same nit here, s/riscv node/cpu node/?

> +
> +  msi-parent:
> +    description:
> +      Given APLIC domain forwards wired interrupts as MSIs to a AIA inco=
ming
> +      message signaled interrupt controller (IMSIC). If both "msi-parent=
" and
> +      "interrupts-extended" properties are present then it means the APL=
IC
> +      domain supports both MSI mode and Direct mode in HW. In this case,=
 the
> +      APLIC driver has to choose between MSI mode or Direct mode.
> +
> +  riscv,num-sources:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 1023
> +    description:
> +      Specifies the number of wired interrupt sources supported by this
> +      APLIC domain.

Rob asked:
| We don't normally need to how many interrupts, why here?

But I do not see an answer to that on lore.

> +
> +  riscv,children:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 1024
> +    items:
> +      maxItems: 1
> +    description:
> +      A list of child APLIC domains for the given APLIC domain. Each chi=
ld
> +      APLIC domain is assigned a child index in increasing order, with t=
he
> +      first child APLIC domain assigned child index 0. The APLIC domain =
child
> +      index is used by firmware to delegate interrupts from the given AP=
LIC
> +      domain to a particular child APLIC domain.
> +
> +  riscv,delegate:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 1024
> +    items:
> +      items:
> +        - description: child APLIC domain phandle
> +        - description: first interrupt number of this APLIC domain (incl=
usive)
> +        - description: last interrupt number of this APLIC domain (inclu=
sive)
> +    description:
> +      A interrupt delegation list where each entry is a triple consistin=
g of
> +      child APLIC domain phandle, first interrupt number of this APLIC d=
omain,
> +      and last interrupt number of this APLIC domain. Firmware must conf=
igure
> +      interrupt delegation registers based on interrupt delegation list.

I read back Rob's comments on this from last time. He said:
| The node's domain it delegating its interrupts to the child domain or=20
| the other way around? The interrupt numbers here are this domain's or=20
| the child's?

IMO it's ambiguous from the binding description whether the numbers
refer to the "first interrupt in the parent domain that is delegated
to the child" or to numbering of the interrupts within the child domain.
"This" can be quite an ambiguous word, and it's not totally obvious
whether the "this" refers to the "child domain" earlier in the sentence.

I also do not not think you have answered his question about the
directionality of the delegation either (it should just be a copy-paste
=66rom riscv,children, no?).

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - riscv,num-sources

btw, do we need something like:

anyOf:
  - required:
      - interrupts-extended
  - required:
      - msi-parent

& hopefully I didn't previously ask this one:
dependencies:
  riscv,delegate: [ riscv,children ]

As an aside, I still think "riscv,delegate" looks strange here alongside
"riscv,children" since "delegate" is singular and "children" is plural.
The plural would be "delegates", but "delegation" would also fit better
than "delegate".

Cheers,
Conor.

--arKlgyJ7DEAnFfLA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFu7AAAKCRB4tDGHoIJi
0tnOAP9pwFDMTlq1KF4BYCaP3qih5oJM8rDl1dp5STbKVq4h0wEAqdbTKSM8oJyH
uAf5lS+38Rja1VZ9QjLSfcPuhtfKJA0=
=qGwt
-----END PGP SIGNATURE-----

--arKlgyJ7DEAnFfLA--
