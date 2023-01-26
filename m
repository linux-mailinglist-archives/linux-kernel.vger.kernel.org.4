Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BACE67C41E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 05:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjAZE60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 23:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjAZE55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 23:57:57 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C536CA16;
        Wed, 25 Jan 2023 20:57:51 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BC2AD5C01B6;
        Wed, 25 Jan 2023 23:57:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 25 Jan 2023 23:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674709070; x=1674795470; bh=9b
        LZqpHm9uIsrcMILVXhn1yBXMyhRKonXhCCu2xgjyM=; b=a01NR+ZtTMnIKwmvYI
        HLXmvl9ggXpYf1/hPU7McRXNZYXabG22DUbq0j2/uQQvVNYnVSOC9HkWJsTrwQKr
        9RfmJ+AiLOyBUjnhKO1eTeFRKxvY7/tC8hV8DZoNvInTzJ0oFU1ZsjWPgwi2scdc
        ORawMzntB0yrii8LSQlh01MLOKIg2VXnGgRZG9zuS7V2J4r5IlJSoQyaK9qZynn/
        gcCwnzLrr3V74zQtzr+RiGNNlmxWBijrcqfXIUpEmJ/m7KXS3Ef5+2aRUrqFkBT4
        YoMMRmtOwsYxsc7zq+lms3unW1PfRU0f7VvnxkU5QybkTiPB5lixmlTNU4Unw5E3
        KUDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674709070; x=1674795470; bh=9bLZqpHm9uIsr
        cMILVXhn1yBXMyhRKonXhCCu2xgjyM=; b=bXG5OVxzHuZofpr9vns9hFkpK71se
        dXSOgAhNhY8eYtjZG/0jfUV1KRyUxexOIoXJSVyj5PNLtC4dSpOYlW90nfFqq0z5
        EVD4kALRm3mjrWlFJE6MYoB1b4MNz1+T03X3bByMXLRijPFgioOuN0JP+onat7BR
        IOCOvlsaq4A3QRds3e7k8nyGHGNt3tD8JerK2LuTTdJrXw69e2VMXS+/G3dRCR8o
        KPx7U1OYaLSVuj2oDFXuHG5Wlrx3+EjoRWoYR+zFn4Qd24BrZOyTe4oUeSMPvdP9
        4rENQVmdJQYfyc9fJEumxgIdRam4dj6V6coZbjD3XOMmDdoVjIHjtP35A==
X-ME-Sender: <xms:TgjSYwxyriklLwpk3vPCqDbc8z0lC6-_RsBqVKHKWtzGmGVrNW2_AQ>
    <xme:TgjSY0Rzw0yEdwzvdbawCJcSKEAlUNJ2OItk4WoTk4lLVZVGpOwQd_OM8tXEHUxH5
    Ia_Jz6MHEivOFFdKw>
X-ME-Received: <xmr:TgjSYyWE13pSwK3UWd4VWjgubgtuGaI2262yqaqEEdi_m0CwyYNVLnO85Q-YJoXcv5-ygBvZc6L01DNpGZnlUQL-tpjSz8Kk3PVZhsbVgm1z22d2w0S9gBXetURrs4cUvsLmsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:TgjSY-jtexuQZCjJlNcMi4qa7nCY3Sa9dOF-9cJOolfCmXEDBlwHmg>
    <xmx:TgjSYyCApsm2xmG0JbYwy5Fk_Jdbgs3nu_Bt_6spGt2D4xmtErlCMg>
    <xmx:TgjSY_LpZ9F7r6D2rMaK0FtMYFG05bocoF7ji_ZTTm0xYCc9ZtE6eg>
    <xmx:TgjSY8xax1QVPV0fTjigq7XVSiCfqiHkwA_eB9xsWMwiSG7mgPtBqA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 23:57:49 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     linux-riscv@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v5 10/11] riscv: Add the Allwinner SoC family Kconfig option
Date:   Wed, 25 Jan 2023 22:57:37 -0600
Message-Id: <20230126045738.47903-11-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230126045738.47903-1-samuel@sholland.org>
References: <20230126045738.47903-1-samuel@sholland.org>
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

(no changes since v4)

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
index 659140309157..1cf69f958f10 100644
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

