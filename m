Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B543730837
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjFNT2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbjFNT2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:28:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D02726;
        Wed, 14 Jun 2023 12:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0185D63DB3;
        Wed, 14 Jun 2023 19:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C2FC433C0;
        Wed, 14 Jun 2023 19:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686770849;
        bh=T2ORHO5yFSlNbPCHm8exnTbQMAiovym6Yw8Agz5UFng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTMCil+hklnlF1wdBdgexpCOuFi7k1H8k1v4rWagRqV3dxUorHBVWLvou82XCQT8/
         jGgNlk8Ejwuimir91p35ihiH6bHZUUrwQqRDeRZgQL1tDYxS/Ig7Y28b2KpoP74PQP
         kjFwt2HNJmkbJL06LaIx9f95tFxmKDQAkPlvRt0PTrDM/HhW3/Bm1lH46mPgZ2kYA3
         AkRZ7zBaMSKFK5ptaSPTUDDg+omBNLLOKpL41HRYpqsUsDS37laN3QtBlcz1E3dMGk
         JXhBGHlC+rn9z6ohcuooizlA1WQTPc5Jc1eq9JeNUTEIu7fvwCZjNQBV1UBO6JP6Ck
         2bTCSnLKgL2KQ==
Date:   Wed, 14 Jun 2023 20:27:23 +0100
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
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v4 07/10] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
Message-ID: <20230614-devotee-repave-37d670dbfb7c@spud>
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-8-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5BjMorMatJMI/kO2"
Content-Disposition: inline
In-Reply-To: <20230613153415.350528-8-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5BjMorMatJMI/kO2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Anup,

Mostly looks good, once minor comment.

On Tue, Jun 13, 2023 at 09:04:12PM +0530, Anup Patel wrote:

> +  riscv,children:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 1024
> +    items:
> +      maxItems: 1
> +    description:
> +      A list of child APLIC domains for the given APLIC domain. Each child
> +      APLIC domain is assigned a child index in increasing order, with the
> +      first child APLIC domain assigned child index 0. The APLIC domain child
> +      index is used by firmware to delegate interrupts from the given APLIC
> +      domain to a particular child APLIC domain.
> +
> +  riscv,delegation:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 1024
> +    items:
> +      items:
> +        - description: child APLIC domain phandle
> +        - description: first interrupt number of the parent APLIC domain (inclusive)
> +        - description: last interrupt number of the parent APLIC domain (inclusive)
> +    description:
> +      A interrupt delegation list where each entry is a triple consisting
> +      of child APLIC domain phandle, first interrupt number of the parent
> +      APLIC domain, and last interrupt number of the parent APLIC domain.
> +      Firmware must configure interrupt delegation registers based on
> +      interrupt delegation list.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - riscv,num-sources
> +
> +anyOf:
> +  - required:
> +      - interrupts-extended
> +  - required:
> +      - msi-parent

Not sure if you missed this from the last version, but I asked if we
needed a
	dependencies:
	  riscv,delegate: [ riscv,children ]

IOW, I don't think it is valid to have a delegation without having
children?

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--5BjMorMatJMI/kO2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIoUmwAKCRB4tDGHoIJi
0s8OAQC9Z5JXorm19qiau/8bfDQbErjoln46aJVOZhOB61Zs4AEAldzBD4e5sVZx
BB4EhiqD4OULcq1ms+OtgVW6TW7zIgE=
=hrI0
-----END PGP SIGNATURE-----

--5BjMorMatJMI/kO2--
