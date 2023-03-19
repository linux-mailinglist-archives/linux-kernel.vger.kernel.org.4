Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D02C6C01B0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCSMoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCSMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:44:00 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Mar 2023 05:43:59 PDT
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de [80.67.18.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341C81ACF8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:43:58 -0700 (PDT)
Received: from [92.206.161.29] (helo=note-book.lan)
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1pdsND-0005RF-NT; Sun, 19 Mar 2023 13:42:55 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
To:     Lee Jones <lee@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH] mfd: arizona-i2c: add the missing device table IDs for of
Date:   Sun, 19 Mar 2023 13:41:53 +0100
Message-Id: <20230319124153.35294-1-git@apitzsch.eu>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition
which generates correct modalias for automatic loading
of this driver when it is built as a module.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/mfd/arizona-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index b2301586adbc..43e393c8608d 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -112,6 +112,7 @@ static const struct of_device_id arizona_i2c_of_match[] = {
 	{ .compatible = "wlf,wm1814", .data = (void *)WM1814 },
 	{},
 };
+MODULE_DEVICE_TABLE(of, arizona_i2c_of_match);
 #endif
 
 static struct i2c_driver arizona_i2c_driver = {
-- 
2.40.0

