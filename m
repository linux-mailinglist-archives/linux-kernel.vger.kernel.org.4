Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5966F9AF0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 20:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjEGSeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjEGSeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 14:34:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096EA9EE8;
        Sun,  7 May 2023 11:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FAF86119E;
        Sun,  7 May 2023 18:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F993C433D2;
        Sun,  7 May 2023 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683484459;
        bh=Cwi9G0RC9sDhCBbFheRaOVgx+rmiAvtJuPLG5ht1r7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uNMPk3ntZAVS8YwlGv7g0/1DxLS+CXoeUiidi4/241Adf5EX2uPx2Ky9DwASPEh9P
         tlnzGdYjzsgWdMnSbcVsFbQBkNwMNDiI4ceLzELguWR78J0trAbI/463xvg2mGEKSz
         bUdNrvv8fgJ7YTZYWyWPg5bPNCyr7rMZyvkSM4VEzTtEX2/1HjNb7bq8J4HL9Hl83z
         SEaXt+7YLPVlPuSIBZ6vLJEZFk75f2J/oqpDKppyCOxKVxYoOd9z/H5zbisZ0NmT2P
         5XW600//wLg/3j+ctQVwLf0s7QvgsztjxL+oa3vs58PktKJBcGCOY6YdVjk/GD7Hl8
         pdupIoJGBLpbQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: [PATCH 2/5] riscv: Add the T-HEAD SoC family Kconfig option
Date:   Mon,  8 May 2023 02:23:01 +0800
Message-Id: <20230507182304.2934-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230507182304.2934-1-jszhang@kernel.org>
References: <20230507182304.2934-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first SoC in the T-HEAD series is light(a.k.a th1520), containing
quad T-HEAD C910 cores.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig.socs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 1cf69f958f10..ce10a38dff37 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -41,6 +41,12 @@ config ARCH_SUNXI
 	  This enables support for Allwinner sun20i platform hardware,
 	  including boards based on the D1 and D1s SoCs.
 
+config ARCH_THEAD
+	bool "T-HEAD RISC-V SoCs"
+	select ERRATA_THEAD
+	help
+	  This enables support for the RISC-V based T-HEAD SoCs.
+
 config ARCH_VIRT
 	def_bool SOC_VIRT
 
-- 
2.40.0

