Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB83965A844
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiLaXjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbiLaXjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:39:10 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BDE65CB;
        Sat, 31 Dec 2022 15:39:08 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3C6A95C00BC;
        Sat, 31 Dec 2022 18:39:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 31 Dec 2022 18:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672529948; x=1672616348; bh=Mz
        sHJZB9Zb9u/lShX7yOG5pgpyKuKVfap1nW1MWg8Js=; b=i8U/be36lSrUA3U6eq
        mLCtVEXcOY/T/ms8O7WnNiGkz+MUZIU/81hAWT6sELeBYxq3w/Qfr0PNooQZhP3p
        i/B95durYgeyMQ8y7PvTLpL5Vv+4G2R5QPJeBya/ilkPXDwGE5dTMlCqO6pIaj+7
        shg1+gk4f0gerPudzxc7M6sB/6kz33x2UmTU0C+kfBMpE8OEFXbkWeEZCrEuUFbi
        wSU8KP7XZ3mjhOoobbN+ssJHOrzQoJE+D+8iy9yEu4EeD6pRDwEXJXCp4nelxUHN
        AWh36v7iIhO4oDO4Ecx4RrauXabFpY8OA/Kl1/Mi8gckulatd5Fc8xGExfYeR37z
        hLxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672529948; x=1672616348; bh=MzsHJZB9Zb9u/
        lShX7yOG5pgpyKuKVfap1nW1MWg8Js=; b=wzCtQBDifQdcAvBlrFLAD/40LJmak
        DltrXi+Ki9KmdkDhUZlusVEO9IeMhb9UNX7MM7hILHQn4jUXv/5NxxKXYiDmqZKi
        33U/CIUyvGSmTqx9+dmo6AGDLF3opMQ426LYsptZKehsuLN61fpykLit9FoQUwjn
        jA56OCRznJZ7ScbIj5VEw8bnAxBeor1zF+oXIArvo0m83WbzSIyK5pguS2FSuOxp
        fq2pomV1fcEJ+ttuClRP04eqVDnlF5Of6cy3BxJn5aE/+tpg9dS9/0KA4t7TJbEa
        ZkKrjQx4vHqNT6aTccBs5D2rgyfmacQMjOqkEPtfMTSwTfqU/aF/c03qg==
X-ME-Sender: <xms:HMiwY3fHgNI6NcJB1UBmh1QpQN8ODbNdiL4IAVc5kA-nCBNEmbh33g>
    <xme:HMiwY9Pzs68iyhuODFGADln5Zmh-l6lGqyuwi4wlX2B-x15xEZkoYzFEM385lR5YM
    q_2DDpB2ixWUqxRdQ>
X-ME-Received: <xmr:HMiwYwi7kjSyoi87zM44NO5OFAKkeeHx9XJ7O0TtI5KdULDJrWRhL6d5qUuQfO3iaKf4R56cicDumMJH-KfYfYnlXe2otP2n1EC_biSPrRWGpBiYe40kQ5LNUPJp6B7-HMUgAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:HMiwY48-xtZMXF97I6X5xAYU5s1MnkFfXDlJBQ5_UrcZV16h5sWfWQ>
    <xmx:HMiwYzvhtHjCT7IJQzYb4JIDHQGav5KI23nvVC4sbktLvOASatE-CQ>
    <xmx:HMiwY3GEqTTAlHf2NnNQFD1wMcJPXPUV-mfvV_P8cHzGtFj3GQ2_KQ>
    <xmx:HMiwY88BUAn2_bbsujHBfzv3yGijQ9vdwMHzu2X-VV5pnYRgmv6dyg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:39:07 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v4 11/12] riscv: Add the Allwinner SoC family Kconfig option
Date:   Sat, 31 Dec 2022 17:38:50 -0600
Message-Id: <20221231233851.24923-12-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231233851.24923-1-samuel@sholland.org>
References: <20221231233851.24923-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner manufactures the sunxi family of application processors. This
includes the "sun8i" series of ARMv7 SoCs, the "sun50i" series of ARMv8
SoCs, and now the "sun20i" series of 64-bit RISC-V SoCs.

The first SoC in the sun20i series is D1, containing a single T-HEAD
C906 core. D1s is a low-pin-count variant of D1 with co-packaged DRAM.

Most peripherals are shared across the entire chip family. In fact, the
ARMv7 T113 SoC is pin-compatible and almost entirely register-compatible
with the D1s.

This means many existing device drivers can be reused. To facilitate
this reuse, name the symbol ARCH_SUNXI, since that is what the existing
drivers have as their dependency.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v4:
 - Drop the now-redundant 'select SIFIVE_PLIC'
 - Rebase on v6.2-rc1 + soc2arch-immutable

Changes in v3:
 - ARCH_SUNXI depends on MMU && !XIP_KERNEL

Changes in v2:
 - Sort Kconfig as if we had done s/SOC_/ARCH_/ for future-proofing

 arch/riscv/Kconfig.socs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 34a54e5310a1..4b91367604ea 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -32,6 +32,15 @@ config SOC_STARFIVE
 	help
 	  This enables support for StarFive SoC platform hardware.
 
+config ARCH_SUNXI
+	bool "Allwinner sun20i SoCs"
+	depends on MMU && !XIP_KERNEL
+	select ERRATA_THEAD
+	select SUN4I_TIMER
+	help
+	  This enables support for Allwinner sun20i platform hardware,
+	  including boards based on the D1 and D1s SoCs.
+
 config ARCH_VIRT
 	def_bool SOC_VIRT
 	
-- 
2.37.4

