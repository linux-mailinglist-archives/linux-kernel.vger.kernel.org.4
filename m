Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC745B8336
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiINIn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiINIni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:43:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F2F1091;
        Wed, 14 Sep 2022 01:43:36 -0700 (PDT)
X-QQ-mid: bizesmtp79t1663145002t9q1ohmd
Received: from localhost.localdomain ( [125.70.163.64])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 14 Sep 2022 16:43:20 +0800 (CST)
X-QQ-SSF: 01000000002000E0G000B00A0000000
X-QQ-FEAT: RFp2QSjOiS4lyMvRhzy066XqcWoc4c4T2YPtMR49gMfuCrBujKXRx9Mh5KpH9
        AytrNYeF9QZbqHnbU+CIVYvLuLJf4zE3n7czPCGfZrkAwytzHeJvuF519ju1KQIYCJSVt12
        WXCkIfcirc/Was1sPyQSIdpGsaNSBguQarPVT3LK6UWl+yBF/CBaE3fJEjovr6sBeVDZyEN
        DKtUo51K3doALtzEl/C/4ASNlHifzTZCnKC16VsuySbIUb00YXmAAaTlXtrbhZEvprtIG+b
        YYMirDd9yLedqHhqxU28yjg6bM417zkpDDio5M4KpdfDZYu0HWYs95Ple+XvBY/g7bDRHM2
        GFS8u8SLWi/mx6bZ3HYPX1Yit+3/xol4ukK9gdJ6OHla1XqgpSZkJBig8ovmBno+m3bQVqV
        v/vwsh/VMLztNlyFM+ld+A==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     tony@atomide.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] ARM: OMAP2+: fix repeated words in comments
Date:   Wed, 14 Sep 2022 16:43:15 +0800
Message-Id: <20220914084315.40165-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'from'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arm/mach-omap2/cm33xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index d61fa06117b4..c824d4e3db63 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2011-2012 Texas Instruments Incorporated - https://www.ti.com/
  * Vaibhav Hiremath <hvaibhav@ti.com>
  *
- * Reference taken from from OMAP4 cminst44xx.c
+ * Reference taken from OMAP4 cminst44xx.c
  */
 
 #include <linux/kernel.h>
-- 
2.36.1

