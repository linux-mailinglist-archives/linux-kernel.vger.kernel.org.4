Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5359065E0B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjADXHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjADXH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:07:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7151D0CF;
        Wed,  4 Jan 2023 15:07:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AA7CB81916;
        Wed,  4 Jan 2023 23:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E56EC433F0;
        Wed,  4 Jan 2023 23:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672873645;
        bh=SuNnedOBTBfRkngA+uwJbPA6/dPQf71AItesDuB3NQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2H5ihuSQ2Tix3j3i0Qx3h5A1G2BmO25RNvZCbR49C1JYPoGXkElPPjPqlhfo1ZcN
         M9sTV4KprAeRmQXEY+ALI5Fz1wz3TJZmAm6HMxE8N1BTLYxxAZvtuHDp6mMOngkpad
         8s3Ta5qEpOX0nF1+1XWTPNa+8XtOtQqFSZDNJp+0Y9gObhfTzsOcsFux4EJqz3D69o
         VCHS2Padnjk0Bcka/gtsrwMclHgPmdte95W0JNb0cGK1P1F88kv+fvlYuuJMdczvL0
         RQq1hEveF0mwiEDYTPFQWqH/TatDo8I6mc0nD/z9J0E4wiQpVrvLunKV02yWZhJ77q
         V6KvQJZqSUo+Q==
Date:   Wed, 4 Jan 2023 23:07:19 +0000
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
Subject: Re: [PATCH v2 1/9] RISC-V: Add AIA related CSR defines
Message-ID: <Y7YGp/7ufyRPhkwg@spud>
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-2-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jxzId6Yfk8IaDWIM"
Content-Disposition: inline
In-Reply-To: <20230103141409.772298-2-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jxzId6Yfk8IaDWIM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Anup!

On Tue, Jan 03, 2023 at 07:44:01PM +0530, Anup Patel wrote:
> The RISC-V AIA specification improves handling per-HART local interrupts
> in a backward compatible manner. This patch adds defines for new RISC-V
> AIA CSRs.
>=20
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/csr.h | 92 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 0e571f6483d9..4e1356bad7b2 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -73,7 +73,10 @@
>  #define IRQ_S_EXT		9
>  #define IRQ_VS_EXT		10
>  #define IRQ_M_EXT		11
> +#define IRQ_S_GEXT		12
>  #define IRQ_PMU_OVF		13
> +#define IRQ_LOCAL_MAX		(IRQ_PMU_OVF + 1)
> +#define IRQ_LOCAL_MASK		((_AC(1, UL) << IRQ_LOCAL_MAX) - 1)
> =20
>  /* Exception causes */
>  #define EXC_INST_MISALIGNED	0
> @@ -156,6 +159,26 @@
>  				 (_AC(1, UL) << IRQ_S_TIMER) | \
>  				 (_AC(1, UL) << IRQ_S_EXT))
> =20
> +/* AIA CSR bits */
> +#define TOPI_IID_SHIFT		16
> +#define TOPI_IID_MASK		0xfff
> +#define TOPI_IPRIO_MASK		0xff
> +#define TOPI_IPRIO_BITS		8
> +
> +#define TOPEI_ID_SHIFT		16
> +#define TOPEI_ID_MASK		0x7ff
> +#define TOPEI_PRIO_MASK		0x7ff
> +
> +#define ISELECT_IPRIO0		0x30
> +#define ISELECT_IPRIO15		0x3f
> +#define ISELECT_MASK		0x1ff
> +
> +#define HVICTL_VTI		0x40000000
> +#define HVICTL_IID		0x0fff0000
> +#define HVICTL_IID_SHIFT	16
> +#define HVICTL_IPRIOM		0x00000100
> +#define HVICTL_IPRIO		0x000000ff

Why not name these as masks, like you did for the other masks?
Also, the mask/shift defines appear inconsistent. TOPI_IID_MASK is
intended to be used post-shift AFAICT, but HVICTL_IID_SHIFT is intended
to be used *pre*-shift.
Some consistency in naming and function would be great.


> +/* Machine-Level High-Half CSRs (AIA) */
> +#define CSR_MIDELEGH		0x313

I feel like I could find Midelegh in an Irish dictionary lol
Anyways, I went through the CSRs and they do all seem correct.

Thanks,
Conor.



--jxzId6Yfk8IaDWIM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7YGpwAKCRB4tDGHoIJi
0lRTAP4wNZdKZZX9vvp6BuQN+P/gjGLcQs5KY25lQJK75lJ+yQEAgXVYUM3O80Dq
NEcF2/9not7ySdC5sv0F4cG1oEoruAg=
=NNSd
-----END PGP SIGNATURE-----

--jxzId6Yfk8IaDWIM--
