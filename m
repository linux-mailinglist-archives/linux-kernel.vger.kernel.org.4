Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325A9701E96
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbjENRJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjENRJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154CA4C3F;
        Sun, 14 May 2023 10:08:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D31060DC6;
        Sun, 14 May 2023 17:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967D3C433EF;
        Sun, 14 May 2023 17:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684084120;
        bh=Y38ByHJH7UauSxGlzX9LVYgXc2kOZJd7HsQTY6MaJRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9eKUXa4t1eEQkTEKJLjaaHjCuoTExJKNPWr0JGfrhvfYkAQ5Ebanaq7Ppb8ByUpa
         TME4SSfsTheQVELjlsvbnowHJAdeZMbKNuszQi5lM1WfIRqbgUc5Qx1LgjFGR7emLE
         FYl1XqEn6ozNKScBpvAJ6IOVE7qg/QsaI3Y1S4ra0aI/LQASUd+0/ZSI7JcvHqct3+
         aaf+qKYU0H7xlsE960QTx4Y8dGg15dPQPyG3fZmmtsKI8oKrd0JURdIfLY9U6JFemQ
         Xmdo7ZLvvJdYtNjjMGyzxoa6QvxlELNxtSbSVbPoLv0NRQ1pN/ob/MWswoMzsaUPML
         hb20TRqyvDgtA==
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
Subject: [PATCH v3 10/10] riscv: defconfig: enable BOUFFALOLAB SoC
Date:   Mon, 15 May 2023 00:56:51 +0800
Message-Id: <20230514165651.2199-11-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230514165651.2199-1-jszhang@kernel.org>
References: <20230514165651.2199-1-jszhang@kernel.org>
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

Enable BOUFFALOLAB soc config in defconfig to allow the default
upstream kernel to boot on Sipeed M1s Dock board.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index d98d6e90b2b8..e8d77b55ce86 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -26,6 +26,7 @@ CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
 CONFIG_PROFILING=y
 CONFIG_SOC_MICROCHIP_POLARFIRE=y
+CONFIG_ARCH_BOUFFALOLAB=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_STARFIVE=y
-- 
2.40.0

