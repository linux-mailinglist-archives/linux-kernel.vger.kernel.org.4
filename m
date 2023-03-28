Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCD06CBB87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjC1JvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjC1Jur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:50:47 -0400
X-Greylist: delayed 968 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Mar 2023 02:50:27 PDT
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B692683
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=bpgSkZ5zx/R2k7vE5MA+GtuUcZGBjFY+KrjObI3nadY=;
        b=gg+oV7GqDbOQPiwgw3yhmsvareFaRM5ijLAOCT7nfvy/QWU1gCEv4c2O/RQstwOofNJ/YsFcd7fkx
         qoXdH3gyz+2nThgmB6621cv6SfFy3GXT2NVzYR8VxeNhzA1yoPO6pnfkJV79jJmt0QvQv5zAVPaAbj
         dozvLcgK+12V+ffOXKKtj9hfQUVu5yFFwA++R3rsGImJWtaGGkp50fuJqsPxENK3kdSMAk9CQe3ZBO
         l8BfVruogSdQrYurvWDsBUDTgnmswlld4WiDyTEA12IOJU+FIj1HQRMbYC91/6iTs8t/6tGKO2xSsy
         lklPaAuVCzL0uJHlRMhVTuty/txaZXg==
X-MSG-ID: b09f73ec-cd4b-11ed-829c-0050569d2c73
From:   Roan van Dijk <roan@protonic.nl>
To:     linux@armlinux.org.uk
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, Roan van Dijk <roan@protonic.nl>,
        David Jander <david@protonic.nl>
Subject: [PATCH] arm: mach-stm32: board-dt.c: Add support for STM32MP151
Date:   Tue, 28 Mar 2023 11:33:11 +0200
Message-Id: <20230328093311.1258948-1-roan@protonic.nl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds initial support of STM32MP151 microprocessor (MPU)
based on Arm Cortex-A7. New Cortex-A infrastructure (gic, timer,...)
are selected if ARCH_MULTI_V7 is defined.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Roan van Dijk <roan@protonic.nl>

---
 arch/arm/mach-stm32/board-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
index 2ccaa11aaa56..5dcc4ddd1a56 100644
--- a/arch/arm/mach-stm32/board-dt.c
+++ b/arch/arm/mach-stm32/board-dt.c
@@ -21,6 +21,7 @@ static const char *const stm32_compat[] __initconst = {
 	"st,stm32mp131",
 	"st,stm32mp133",
 	"st,stm32mp135",
+	"st,stm32mp151",
 	"st,stm32mp157",
 	NULL
 };
-- 
2.37.2

