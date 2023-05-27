Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D9B7135C8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjE0Qpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjE0Qp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 12:45:26 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95189E;
        Sat, 27 May 2023 09:45:16 -0700 (PDT)
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FB2020008;
        Sat, 27 May 2023 16:45:14 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 2/3] sh: dma: Drop incorrect SH_DMAC_BASE1 for SH4
Date:   Sat, 27 May 2023 18:44:51 +0200
Message-Id: <20230527164452.64797-3-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230527164452.64797-1-contact@artur-rojek.eu>
References: <20230527164452.64797-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the supported SH4 family SoCs features a second DMAC module. As
this define negatively impacts DMA channel calculation for the above
targets, remove it from the code.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---

v2: new patch

 arch/sh/include/cpu-sh4/cpu/dma.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/dma.h b/arch/sh/include/cpu-sh4/cpu/dma.h
index 38187d06b234..e97fb2c79177 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma.h
@@ -13,6 +13,5 @@
 #define DMAE0_IRQ	evt2irq(0x6c0)
 
 #define SH_DMAC_BASE0	0xffa00000
-#define SH_DMAC_BASE1	0xffa00070
 
 #endif /* __ASM_CPU_SH4_DMA_H */
-- 
2.40.1

