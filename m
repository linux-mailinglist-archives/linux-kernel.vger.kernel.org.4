Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616CA6EFB43
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbjDZTnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbjDZTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:43:13 -0400
X-Greylist: delayed 589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Apr 2023 12:43:07 PDT
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E25ED2D74
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:43:07 -0700 (PDT)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id DC625DF00B2; Wed, 26 Apr 2023 21:33:14 +0200 (CEST)
From:   Philippe De Muyter <Philippe.DeMuyter@macq.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Philippe De Muyter <phdm@macqel.be>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] Documentation: regulator/consumer.rst: fix 'regulator_enable' typo.
Date:   Wed, 26 Apr 2023 21:33:02 +0200
Message-Id: <1682537582-2314-1-git-send-email-Philippe.DeMuyter@macq.eu>
X-Mailer: git-send-email 1.7.10.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe De Muyter <phdm@macqel.be>

Removing an erroneous 'd' at the end of 'regulator_enable'.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 Documentation/power/regulator/consumer.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/regulator/consumer.rst b/Documentation/power/regulator/consumer.rst
index 0cd8cc1..85c2bf5 100644
--- a/Documentation/power/regulator/consumer.rst
+++ b/Documentation/power/regulator/consumer.rst
@@ -41,7 +41,7 @@ A consumer can enable its power supply by calling::
 	int regulator_enable(regulator);
 
 NOTE:
-  The supply may already be enabled before regulator_enabled() is called.
+  The supply may already be enabled before regulator_enable() is called.
   This may happen if the consumer shares the regulator or the regulator has been
   previously enabled by bootloader or kernel board initialization code.
 
-- 
1.8.4

