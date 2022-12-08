Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A0646BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiLHJM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiLHJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:11:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB3661511;
        Thu,  8 Dec 2022 01:11:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36D1561E05;
        Thu,  8 Dec 2022 09:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFDDC433C1;
        Thu,  8 Dec 2022 09:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670490691;
        bh=eB4ZBzqRKY2P+/+kH7tim6V7TrIqU7mlpztlV40cPFU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=PHwu2bk4WOCZYFh8XO3jtWg/Pqk7EEQQjg33qH6C+4xAIGzOCLb9mTyZPJNKenFKo
         22Tz49fpit01wAbYhQoch29pUGvrdFyc56IqREzb/3ZFkO6Ew1hUfM7eljfGv/VKr3
         BPmKjO/WI8WMSz7locQd3+fD8Xq6Vov/4VvXJGhgjJdEjC/3QZXno3fpgw10qpapE0
         B+KWpPk2e9BtlSulZzHDCwkokUFo24XuJji5J0V3o9ExtUjINHnyL6X8+PsogYCzZO
         gHndsRDdhhWB8CMm7/VHXWcENBVU4I36xOXK1Ssifwc1kiHf+B6IOw4jZnJRSk/aCA
         ua3TxYplb88XA==
Date:   Thu, 08 Dec 2022 10:10:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
CC:     Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_11/12=5D_riscv=3A_Add_the?= =?US-ASCII?Q?_Allwinner_SoC_family_Kconfig_option?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221208090237.20572-12-samuel@sholland.org>
References: <20221208090237.20572-1-samuel@sholland.org> <20221208090237.20572-12-samuel@sholland.org>
Message-ID: <3480FA50-B88E-4BD9-8E9F-27F231C2BAC6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Conor Dooley <conor=2Edooley@microchip=2Ecom>

On 8 December 2022 10:02:36 GMT+01:00, Samuel Holland <samuel@sholland=2Eo=
rg> wrote:
>Allwinner manufactures the sunxi family of application processors=2E This
>includes the "sun8i" series of ARMv7 SoCs, the "sun50i" series of ARMv8
>SoCs, and now the "sun20i" series of 64-bit RISC-V SoCs=2E
>
>The first SoC in the sun20i series is D1, containing a single T-HEAD
>C906 core=2E D1s is a low-pin-count variant of D1 with co-packaged DRAM=
=2E
>
>Most peripherals are shared across the entire chip family=2E In fact, the
>ARMv7 T113 SoC is pin-compatible and almost entirely register-compatible
>with the D1s=2E
>
>This means many existing device drivers can be reused=2E To facilitate
>this reuse, name the symbol ARCH_SUNXI, since that is what the existing
>drivers have as their dependency=2E
>
>Acked-by: Palmer Dabbelt <palmer@rivosinc=2Ecom>
>Reviewed-by: Guo Ren <guoren@kernel=2Eorg>
>Reviewed-by: Heiko Stuebner <heiko@sntech=2Ede>
>Tested-by: Heiko Stuebner <heiko@sntech=2Ede>
>Signed-off-by: Samuel Holland <samuel@sholland=2Eorg>
>---
>
>Changes in v3:
> - ARCH_SUNXI depends on MMU && !XIP_KERNEL
>
>Changes in v2:
> - Sort Kconfig as if we had done s/SOC_/ARCH_/ for future-proofing
>
> arch/riscv/Kconfig=2Esocs | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/arch/riscv/Kconfig=2Esocs b/arch/riscv/Kconfig=2Esocs
>index 69774bb362d6=2E=2Ef655dea86d69 100644
>--- a/arch/riscv/Kconfig=2Esocs
>+++ b/arch/riscv/Kconfig=2Esocs
>@@ -26,6 +26,16 @@ config SOC_STARFIVE
> 	help
> 	  This enables support for StarFive SoC platform hardware=2E
>=20
>+config ARCH_SUNXI
>+	bool "Allwinner sun20i SoCs"
>+	depends on MMU && !XIP_KERNEL
>+	select ERRATA_THEAD
>+	select SIFIVE_PLIC
>+	select SUN4I_TIMER
>+	help
>+	  This enables support for Allwinner sun20i platform hardware,
>+	  including boards based on the D1 and D1s SoCs=2E
>+
> config SOC_VIRT
> 	bool "QEMU Virt Machine"
> 	select CLINT_TIMER if RISCV_M_MODE
