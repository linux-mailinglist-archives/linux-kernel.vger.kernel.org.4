Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57A67C981
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbjAZLLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbjAZLLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:11:42 -0500
Received: from smtpweb146.aruba.it (smtpweb146.aruba.it [62.149.158.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3881062242
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:11:06 -0800 (PST)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id KzrppyQ5bn7VrKzrupdlrh; Thu, 26 Jan 2023 11:52:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1674730355; bh=JG0jmrScq7HDhSnDu4lEvoGIvGCbBbbHV1PcVq1TxZM=;
        h=From:To:Subject:Date:MIME-Version;
        b=kVUW6EUfCHGR2k9THRY4IGx8laSdYnhgAMOsNdPMJc+77jsS4fgi4x0qfD0SdTREq
         u0Pnx0ImCysFElN0RYNaMfsoFPCRgK9LqVP6WFTPppUU7MOd9u0+dJOTQXPt1YAOyr
         wllycmZV8/O3MUi8Ox7dibbyC+9ThxS4uOSz0nD8UXaa8dcfDoed69/kX4rLrLvqc7
         wihTsNy+3SLo68v60HpFjesXMu9JkY8TJFoKjuFHkCWbRjjvX7mHQ4iHN28V69CXms
         xmGAKn3NPT0Qxa3xhIv/b7JCgdypLRvPK6guVw+ZLKVPplxFnzIzYLVQVQ2K8SgWrF
         h1E1EZToIupoA==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH 2/3] Input: ads7846 - always set last command to PWRDOWN
Date:   Thu, 26 Jan 2023 11:52:26 +0100
Message-Id: <20230126105227.47648-3-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126105227.47648-1-l.ellero@asem.it>
References: <20230126105227.47648-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOOjddogN4mr6xda53A3MDhDxr3whbrWm+moEL9qcULUCce/+FmI75Eh2hDAEdS09t4zzob0nS0hpTQHSltY4Bjq3PgitV+/BUQQS+r528TFUmNWvttn
 ACCwAAV7Cq+2U1iQ2Wqql5xuRm27CjAniHweL9jDYo17aurxMskO1bf17EPz02sdNwqjHge/PsuqJTi53KaHs8pyRTEDj8cRo6yeYTsw6mCvXykC19qHvazL
 8A5yGwXiw+37bdQmR6F8lIzeLmU0zj0KUqrZJw0OXNZOwudWuuMDXlbF+KuuU0enC1yf8Fw3czmkJNACyfNNP26mqEQupR6F8IWTCJeKGxbistjHnluZQlak
 4fNU1Fnr3cakOaNwtbJuWcn5V5vEXxBskXvKU6cltVVtlmHivhTR2KMAPRHJCKQ77cxZreQ9TffIDozi9q5JioKajhOHMN9I2a5yiJAd4pMxYkMr27kjArv0
 J28qjIor8f5AM+l8n7RnUwkNsaVZr6vzd5AiNb+1JhPZ2zd0YHOAPLW952i6iHWxHwgFBYRReVwL7H7UvyROknrMhWkdbor89GV3AOQrmmLtaYW2YuGN5XjD
 kxetBeDGSgW5qkZHq3Edc8Lk
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controllers that report pressure (e.g. ADS7846) use 5 commands and the
correct sequence is READ_X, READ_Y, READ_Z1, READ_Z2, PWRDOWN.

Controllers that don't report pressure (e.g. ADS7845/ADS7843) use only 3
commands and the correct sequence should be READ_X, READ_Y, PWRDOWN. But
the sequence sent was incorrect: READ_X, READ_Y, READ_Z1.

Fix this by setting the third (and last) command to PWRDOWN.

Fixes: ffa458c1bd9b ("spi: ads7846 driver")
Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
 drivers/input/touchscreen/ads7846.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index f11b444f2138..15da1047a577 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1066,6 +1066,9 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
 		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
 		unsigned int max_count;
 
+		if (cmd_idx == packet->cmds - 1)
+			cmd_idx = ADS7846_PWDOWN;
+
 		if (ads7846_cmd_need_settle(cmd_idx))
 			max_count = packet->count + packet->count_skip;
 		else
@@ -1102,7 +1105,12 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
 
 	for (cmd_idx = 0; cmd_idx < packet->cmds; cmd_idx++) {
 		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
-		u8 cmd = ads7846_get_cmd(cmd_idx, vref);
+		u8 cmd;
+
+		if (cmd_idx == packet->cmds - 1)
+			cmd_idx = ADS7846_PWDOWN;
+
+		cmd = ads7846_get_cmd(cmd_idx, vref);
 
 		for (b = 0; b < l->count; b++)
 			packet->tx[l->offset + b].cmd = cmd;
-- 
2.25.1

