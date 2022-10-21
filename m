Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E6760824D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJUXz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJUXzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:55:55 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BA618C400
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:55:48 -0700 (PDT)
Received: from localhost.localdomain (95.49.29.134.neoplus.adsl.tpnet.pl [95.49.29.134])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id E35D03F3EF;
        Sat, 22 Oct 2022 01:55:44 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     asahi@lists.linux.dev, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/apple-aic: Mark aic_info structs __initconst
Date:   Sat, 22 Oct 2022 01:55:23 +0200
Message-Id: <20221021235523.76585-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These structs hold information used only at init time that never
gets modified, hence mark them __initconst.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/irqchip/irq-apple-aic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 1c2813ad8bbe..ae3437f03e6c 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -248,14 +248,14 @@ struct aic_info {
 	bool fast_ipi;
 };
 
-static const struct aic_info aic1_info = {
+static const struct aic_info aic1_info __initconst = {
 	.version	= 1,
 
 	.event		= AIC_EVENT,
 	.target_cpu	= AIC_TARGET_CPU,
 };
 
-static const struct aic_info aic1_fipi_info = {
+static const struct aic_info aic1_fipi_info __initconst = {
 	.version	= 1,
 
 	.event		= AIC_EVENT,
@@ -264,7 +264,7 @@ static const struct aic_info aic1_fipi_info = {
 	.fast_ipi	= true,
 };
 
-static const struct aic_info aic2_info = {
+static const struct aic_info aic2_info __initconst = {
 	.version	= 2,
 
 	.irq_cfg	= AIC2_IRQ_CFG,
-- 
2.38.1

