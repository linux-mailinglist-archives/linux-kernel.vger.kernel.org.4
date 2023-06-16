Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF8732507
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbjFPCIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFPCIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:08:36 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A75D42962
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 19:08:33 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(18367:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Fri, 16 Jun 2023 10:08:20 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 16 Jun
 2023 10:08:19 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Fri, 16 Jun 2023 10:08:19 +0800
From:   <cy_huang@richtek.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH] regulator: helper: Document ramp_delay parameter of regulator_set_ramp_delay_regmap()
Date:   Fri, 16 Jun 2023 10:08:18 +0800
Message-ID: <1686881298-28333-1-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

With W=1:

    drivers/regulator/helpers.c:947: warning: Function parameter or member 'ramp_delay' not described in 'regulator_set_ramp_delay_regmap'

Fix it by documenting the parameter.

Fixes: fb8fee9efdcf ("regulator: Add regmap helper for ramp-delay setting")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index ad2237a95572..d2183c11d51d 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -938,6 +938,7 @@ static int find_closest_bigger(unsigned int target, const unsigned int *table,
  * regulator_set_ramp_delay_regmap - set_ramp_delay() helper
  *
  * @rdev: regulator to operate on
+ * @ramp_delay: ramp-rate value given in units V/S (uV/uS)
  *
  * Regulators that use regmap for their register I/O can set the ramp_reg
  * and ramp_mask fields in their descriptor and then use this as their
-- 
2.40.1

