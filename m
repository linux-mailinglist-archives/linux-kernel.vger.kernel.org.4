Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12D705851
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjEPUGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjEPUF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E4E76BE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8508618C9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261F9C433EF;
        Tue, 16 May 2023 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684267551;
        bh=qyz4rw56+HC6dOFHzFvmq/eJldRmlY0llGb59kScA4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbZrs0abiBjSfYoc4+XApzegdn7g4TvGzFoj2IdvLYklyJIxK2B4DSfLtA0cOQO76
         m959uQI/ndPgbQRg5SGtF3Gq/DjFZ3D4159hs+oi5gIgYxzLbYJowbqTrEZ2LYG0no
         ipZX7jiTlVvE+Xwe81xRUKgSEh3C2gtqTZlBGjU7TUySbB478q7LHa/ieq4PpWEzOn
         y7XnN01V49l5GngGq8WI2VCqqoEdJOXyRuZhlhDmdTFR4JdCxv6pjfVZkv6ehBIV8o
         8xjEE5AfKytxDiHpj601yxGmmfXbYblf9qE37/FOZFOWAyiQjKX9mPzeItbIwylvOh
         l5DY1GdpB0I0Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] irqchip: mxs: include linux/irqchip/mxs.h
Date:   Tue, 16 May 2023 22:05:07 +0200
Message-Id: <20230516200516.554663-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516200516.554663-1-arnd@kernel.org>
References: <20230516200516.554663-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

This header contains the definition for icoll_handle_irq(), which
is used in arch/arm/mach-mxs/mach-mxs.c, without this we get a warning
about a missing prototype when building with W=1.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-mxs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index 55cb6b5a686e..b3b1fba871c1 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/mxs.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/of.h>
-- 
2.39.2

