Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8050D5B8326
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiINIi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiINIiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:38:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CABA69F44
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:38:20 -0700 (PDT)
X-QQ-mid: bizesmtp63t1663144676tb84i9kg
Received: from localhost.localdomain ( [125.70.163.64])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 14 Sep 2022 16:37:54 +0800 (CST)
X-QQ-SSF: 01000000002000E0G000B00A0000000
X-QQ-FEAT: D2GZf6M6C/hQpRBNyjq9XX0VRZZ9+Zv5wVn9VHrReivnJKeyJCbIygSGYvq/G
        7c2wCJGP2sSE0WagPqVlY95RqedO5cVTgvDSPuUkM7aQQKuJww5ViyeZ6StkoVe1YIG8BT3
        6lxLZykHUkqk79j6v6Y2Ql0KPXgGeZOz5y3gQE1AhPxbsW0i2Oud/TArapcaPYfUZLD11dw
        TS2AEDunCGi3475ztO942ty1WFNo53e74d3Zsp0MRx6SJWvNbd9XqDfSPwg0du4iaT7UXLe
        F0tw9irpE3G3NU6zjGXAiHkFfIDL/ND160yfsnxeRFgpp+HOGXt/2hso+nEolkCthVqq7kU
        D7ZHRoeUxKaUpHfN9VJXbzSsdaHgPd7GOTwk82+9kTc7mzPE9k=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.orgc,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] ARM: pxa: fix repeated words in comments
Date:   Wed, 14 Sep 2022 16:37:46 +0800
Message-Id: <20220914083746.29370-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'in'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arm/mach-pxa/palm27x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 1a8d25eecac3..116183859357 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -160,7 +160,7 @@ void __init palm27x_lcd_init(int power, struct pxafb_mode_info *mode)
 #if	defined(CONFIG_USB_PXA27X) || \
 	defined(CONFIG_USB_PXA27X_MODULE)
 
-/* The actual GPIO offsets get filled in in the palm27x_udc_init() call */
+/* The actual GPIO offsets get filled in the palm27x_udc_init() call */
 static struct gpiod_lookup_table palm27x_udc_gpiod_table = {
 	.dev_id = "gpio-vbus",
 	.table = {
-- 
2.36.1

