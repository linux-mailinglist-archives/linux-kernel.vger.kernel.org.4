Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C92F70881E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjERS55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjERS5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:57:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC17910E9;
        Thu, 18 May 2023 11:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CB4C64FCD;
        Thu, 18 May 2023 18:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1CDC4339B;
        Thu, 18 May 2023 18:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684436240;
        bh=+8gBhUykoZM8TrvHxezwEoqx6vcc9txPAEKaZGcJ4uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZfU52L68DqN1YEclN4xauwvlvDjt1TExLclICt6uv1q20JIejrXEOSecNLjbfZqz7
         JJQ+6OMTx6RM13fMAta6Iuy5IdDry0ywDr6F6d59rPIKbgFmHvXHVvFT1OxXgXEoHX
         nkIDH5iXcHMbI2hhQg9j+8iNBjOpS4tBHXxm66FjoMCKw0liH8kyALT0X62UFJ3wFE
         VWpEA7TfQb79Vae3ejwi0fhTTCiooz2bgyEbWKar20iS3LJu6dvxWvavBUys/djyFi
         8CpqtjNAOU1D1zoTmrNPTCt2hOWang2hhmG/IYk4q8gMfeTpksG/mXoNvxHUrh9qS9
         QZZns6KoH2r9A==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 9/9] riscv: defconfig: enable T-HEAD SoC
Date:   Fri, 19 May 2023 02:45:41 +0800
Message-Id: <20230518184541.2627-10-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518184541.2627-1-jszhang@kernel.org>
References: <20230518184541.2627-1-jszhang@kernel.org>
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

Enable T-HEAD SoC config in defconfig to allow the default
upstream kernel to boot on Sipeed Lichee Pi 4A board.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index d98d6e90b2b8..109e4b5b003c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -27,6 +27,7 @@ CONFIG_EXPERT=y
 CONFIG_PROFILING=y
 CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_ARCH_RENESAS=y
+CONFIG_ARCH_THEAD=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
-- 
2.40.0

