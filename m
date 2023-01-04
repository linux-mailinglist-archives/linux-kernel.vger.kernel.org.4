Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8FB65E0D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjADXWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbjADXVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:21:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F49613FB6;
        Wed,  4 Jan 2023 15:21:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F90D61770;
        Wed,  4 Jan 2023 23:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0A0C433EF;
        Wed,  4 Jan 2023 23:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672874492;
        bh=v2/R96SafxBh5iuY4E7Baw1qoJay2O1nWXxJwVkFLI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vAk3P/lUBhcqU9rBK71+IJcT83ARY+TnNkLVUD3yxWBuX0GaR+zlOFRB7SGATXpHs
         /bC+W+xn9OT8OKfyWRUCA0OFpKwRjgFrACvtv3qWkRqLrYhd95h4RDRArjsPhcr2Gf
         ydNlDDW6Ga/jiHkUdZ1NAb6gZbiha8hUBjPwPnjzntQ1Isi+nIDzWc4/w6d9KELCIj
         Kt1FrAKyDkLCvbzlj9RE+7NxwE3UHqMgY7MixlHhhQ5IxX6grAka8Gjzn0s9HzEP9H
         TcKeqFPG1dGTeHMDw7rpl6w4lAJA+I1wyN4J7qoz9DAB97RFaojPYOafgzgOBK1Ccm
         46VIIibxKfo5Q==
Date:   Wed, 4 Jan 2023 23:21:26 +0000
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
Subject: Re: [PATCH v2 4/9] dt-bindings: interrupt-controller: Add RISC-V
 incoming MSI controller
Message-ID: <Y7YJ9j9a+DQVF/dp@spud>
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-5-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HGsSkcCnl6i5IGAx"
Content-Disposition: inline
In-Reply-To: <20230103141409.772298-5-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HGsSkcCnl6i5IGAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Anup,

On Tue, Jan 03, 2023 at 07:44:04PM +0530, Anup Patel wrote:
> We add DT bindings document for the RISC-V incoming MSI controller
> (IMSIC) defined by the RISC-V advanced interrupt architecture (AIA)
> specification.
>=20
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> +  The IMSIC is a per-CPU (or per-HART) device with separate interrupt fi=
le
> +  for each privilege level (machine or supervisor).

> +  The device tree of a RISC-V platform will have one IMSIC device tree n=
ode
> +  for each privilege level (machine or supervisor) which collectively de=
scribe
> +  IMSIC interrupt files at that privilege level across CPUs (or HARTs).

> +examples:
> +  - |
> +    // Example 1 (Machine-level IMSIC files with just one group):
> +
> +    imsic_mlevel: interrupt-controller@24000000 {
> +      compatible =3D "riscv,qemu-imsics", "riscv,imsics";
> +      interrupts-extended =3D <&cpu1_intc 11>,
> +                            <&cpu2_intc 11>,
> +                            <&cpu3_intc 11>,
> +                            <&cpu4_intc 11>;
> +      reg =3D <0x28000000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells =3D <0>;
> +      msi-controller;
> +      riscv,num-ids =3D <127>;
> +    };
> +
> +  - |
> +    // Example 2 (Supervisor-level IMSIC files with two groups):
> +
> +    imsic_slevel: interrupt-controller@28000000 {
> +      compatible =3D "riscv,qemu-imsics", "riscv,imsics";
> +      interrupts-extended =3D <&cpu1_intc 9>,
> +                            <&cpu2_intc 9>,
> +                            <&cpu3_intc 9>,
> +                            <&cpu4_intc 9>;
> +      reg =3D <0x28000000 0x2000>, /* Group0 IMSICs */
> +            <0x29000000 0x2000>; /* Group1 IMSICs */
> +      interrupt-controller;
> +      #interrupt-cells =3D <0>;
> +      msi-controller;
> +      riscv,num-ids =3D <127>;
> +      riscv,group-index-bits =3D <1>;
> +      riscv,group-index-shift =3D <24>;
> +    };

How is, say linux, meant to know which of the per-level imsic DT nodes
applies to it?
I had a quick look in the driver, but could see no mechanism for it.
Apologies if I missed something obvious!

Thanks,
Conor.


--HGsSkcCnl6i5IGAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7YJ9gAKCRB4tDGHoIJi
0vn2AP9AbpFEPFtXjhX2Xeds9ujqOyZk3T0cfbS1mobVcSsGIQEAhYSYvxGdTD6Y
DuHQBNOoJjvpsXYzq43BM95cTisFTw0=
=QAG0
-----END PGP SIGNATURE-----

--HGsSkcCnl6i5IGAx--
