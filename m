Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1836DBB20
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 15:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjDHNYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDHNYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 09:24:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D071D53C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 06:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC95614BE
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 13:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A48C433A1;
        Sat,  8 Apr 2023 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680960248;
        bh=zh3lTgBmnypZA5+Nw411DMxgOKCSc/q0VjQ8IrqzJ2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qir4ccYwjx5pT4lgUGrpeYXWCsLQ0NUmCK3/ppsTQEuSStZwPzdxJSbfxS5nIf22G
         eQy30zudpEHB+aP9VRsq9pySKx5EjCj7Codh/Tx5aBhJ9bLeeL4Up4zAVuWPKZ6HAP
         pq+3xQefgFkOnbBQ0mMh+giXrmZtpMaADqt8241TrZGwEe5nZpOthnQ8eLXUc01p5U
         iqiDfiakaTmP3dRPnMd0yNlC0/bxDaHfqGkEFWLkbRHy9Ak0tKR6zD/a7f410BeSI+
         d+CYpKx2vSOe6NgLMWg5r9yc6trXmnUSfjxIrPrtpHuvgCr67sNs2t2Wl5iy6qt2lT
         AYLumcsVYdR7A==
Received: by pali.im (Postfix)
        id 4240F20C8; Sat,  8 Apr 2023 15:24:06 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] powerpc/fsl_uli1575: Allow to disable FSL_ULI1575 support
Date:   Sat,  8 Apr 2023 15:21:49 +0200
Message-Id: <20230408132151.8902-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408132151.8902-1-pali@kernel.org>
References: <20230408132151.8902-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ULI1575 PCIe south bridge exists only on some Freescale boards. Allow to
disable CONFIG_FSL_ULI1575 symbol when it is not explicitly selected and
only implied.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index d41dad227de8..d4b43dade51e 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -261,7 +261,7 @@ config CPM2
 	  on it (826x, 827x, 8560).
 
 config FSL_ULI1575
-	bool
+	bool "ULI1575 PCIe south bridge support"
 	select GENERIC_ISA_DMA
 	help
 	  Supports for the ULI1575 PCIe south bridge that exists on some
-- 
2.20.1

