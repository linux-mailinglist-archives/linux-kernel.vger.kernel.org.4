Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C167B701E87
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbjENRIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbjENRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:08:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE973C07;
        Sun, 14 May 2023 10:08:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D2260A48;
        Sun, 14 May 2023 17:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D69C433A0;
        Sun, 14 May 2023 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684084101;
        bh=mtrxumyq0ZRmNVTAnw5KH+BUNijjTRh/kWJxJPGHbDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvXP+Y7I3i3ihYdVkNewCBLQsD/O0zHS0lGhnogvEMO8oiDFPpC6/t+lxpjKhzHPW
         oH70PSK2jM0zLINBqMLjX/u9btWauAIQ7HNe1V37K+2vR7GMdAP5BcvcMiF8LmKhTv
         V4Ar+Z1o6kkaGQWnr9Z1pooXcsYN4aN05qxjGQSDc3jGpRvOG/+xkg2n3uZPFgFaH7
         EcrSkkp4qR6O3IvHVjGiqRYujd5+AaZ4mC9cA8rzmtAAFHyIJnY4flWI1DFZvKy9IH
         YsO0dXae8EjHf3WQmssR5WKI8zcsrnI9ScUQsMRva+IjkHnOoeWcM/Z+byHqX06atA
         e3WEbiCuvbw3Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 05/10] riscv: add the Bouffalolab SoC family Kconfig option
Date:   Mon, 15 May 2023 00:56:46 +0800
Message-Id: <20230514165651.2199-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230514165651.2199-1-jszhang@kernel.org>
References: <20230514165651.2199-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Bouffalolab bl808 SoC contains three riscv CPUs, namely M0, D0 and
LP. The D0 is 64bit RISC-V GC compatible, so can run linux.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/Kconfig.socs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 1cf69f958f10..33220b5144bb 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -1,5 +1,10 @@
 menu "SoC selection"
 
+config ARCH_BOUFFALOLAB
+	bool "Bouffalolab SoCs"
+	help
+	  This enables support for Bouffalolab SoC platforms.
+
 config ARCH_MICROCHIP_POLARFIRE
 	def_bool SOC_MICROCHIP_POLARFIRE
 
-- 
2.40.0

