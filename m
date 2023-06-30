Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DEB743BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjF3MMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjF3MMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:12:10 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFD24209;
        Fri, 30 Jun 2023 05:11:12 -0700 (PDT)
Received: from droid10-sz.amlogic.com (10.28.11.69) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 30 Jun 2023
 20:11:09 +0800
From:   zelong dong <zelong.dong@amlogic.com>
To:     <narmstrong@baylibre.com>, <p.zabel@pengutronix.de>,
        <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
        <martin.blumenstingl@googlemail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <jbrunet@baylibre.com>,
        <devicetree@vger.kernel.org>, <kelvin.zhang@amlogic.com>,
        Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH 2/3] reset: reset-meson: add support for the Meson-C3 SoC Reset Controller
Date:   Fri, 30 Jun 2023 20:10:58 +0800
Message-ID: <20230630121059.28748-3-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230630121059.28748-1-zelong.dong@amlogic.com>
References: <20230630121059.28748-1-zelong.dong@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.69]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelong Dong <zelong.dong@amlogic.com>

Add a new compatible string to support for the reset controller
on the C3 SoC. The count and offset for C3 Soc RESET registers are
same as S4 Soc.

Change-Id: I65113f6a90545cd46015abf60b4bcb63fa148267
Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
---
 drivers/reset/reset-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 13878ca2779d..ee1d5caf0ee4 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -109,6 +109,7 @@ static const struct of_device_id meson_reset_dt_ids[] = {
 	 { .compatible = "amlogic,meson-axg-reset",  .data = &meson8b_param},
 	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
 	 { .compatible = "amlogic,meson-s4-reset",   .data = &meson_s4_param},
+	 { .compatible = "amlogic,meson-c3-reset",   .data = &meson_s4_param},
 	 { /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
-- 
2.35.1

