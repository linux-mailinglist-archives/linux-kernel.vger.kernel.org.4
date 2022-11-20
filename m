Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B498063130E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 09:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiKTIbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 03:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKTIbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 03:31:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1059A5F1;
        Sun, 20 Nov 2022 00:31:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ECC4B8094C;
        Sun, 20 Nov 2022 08:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931AEC433B5;
        Sun, 20 Nov 2022 08:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668933076;
        bh=ZIyxtDK+5wX/gBokLdTl5DvntJdJCnlFQwtz1yaZio0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ts4sR6+/pZZaUipGd83QQ/CEzfvA0M1VKs6GeRoST3/w0zSjXFPfA5YVlTCmLuTGE
         wNJmnIcPVnYHzWPbsU5SLxhWGAm3vdNFgXMRye8/mgw+GufcRgqfyMfFPhM5ySRy/I
         gJPzyfCDa2NrqVw7mDCQzAHMclbtJrr+7Tzy3s3h+SvVlmzsaZ+dXJA9NAZ8jz1IsW
         aOzTADAaHzlvBXrjzzpNubDgIjY9Amk9yfJJj0Ejp8zO2KIF3KVB/6br/achcyKhf4
         2JuEzAinCyiiCIvadXVz/Nqdz71X5PQcTAFiuTIgYC3ZKVtSjDBiYDSbPXWaaByZII
         u5sAI/KJfbSNQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 4/7] riscv: add the Bouffalolab SoC family Kconfig option
Date:   Sun, 20 Nov 2022 16:21:11 +0800
Message-Id: <20221120082114.3030-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221120082114.3030-1-jszhang@kernel.org>
References: <20221120082114.3030-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Bouffalolab bl808 SoC contains three riscv CPUs, namely M0, D0 and
LP. The D0 is 64bit RISC-V GC compatible, so can run linux.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig.socs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..90256f44ed4a 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -1,5 +1,11 @@
 menu "SoC selection"
 
+config SOC_BOUFFALOLAB
+	bool "Bouffalolab SoCs"
+	select SIFIVE_PLIC
+	help
+	  This enables support for Bouffalolab SoC platforms.
+
 config SOC_MICROCHIP_POLARFIRE
 	bool "Microchip PolarFire SoCs"
 	select MCHP_CLK_MPFS
-- 
2.37.2

