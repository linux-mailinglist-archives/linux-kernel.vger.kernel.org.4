Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28D8675537
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjATNEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjATNEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:04:08 -0500
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 471DBC3803
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:04:07 -0800 (PST)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IqmFpgGfF6DTZIqmQpKxDO; Fri, 20 Jan 2023 13:46:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1674218763; bh=DFxo0lMWx1LamJoO8gw7DU+04h/F4i+eiapIx8PP5jQ=;
        h=From:To:Subject:Date:MIME-Version;
        b=cuNGE9Ijj4X1QMZV1GMEqCwDZpf5uR0kueMLuyN/hdxEYhzqliHQ4Op8PsbyTvx3r
         IFPA4dK7hHBJGQmyyAT8W847rmK/1dKsPBvN56YSD8efUKEiKq0AZWv+CXDDDY/8Ui
         X2RS3p51xEtPoEgaWtQVIXTiuyjRBHTZFuzeXSMjenb320Vt9Ssq94FQQQnzmfu7Tn
         +0mEfM5mILmahesZ0iU3d8MJ9HUTwZBgbAtbNXU+fbmRFKDXwGYK8h2m55gAFeb3X+
         FMKfF35pbqZDuGrWoeBcKCiHtZZmnDqftpBYBLVxpdj0VCw92b/EQMosDiJppkDXXB
         m0bwPItMgzJBA==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH 2/3] Input: ads7846 - always set last command to PWRDOWN
Date:   Fri, 20 Jan 2023 13:45:43 +0100
Message-Id: <20230120124544.5993-3-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120124544.5993-1-l.ellero@asem.it>
References: <20230120124544.5993-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfL0QDsHFOS64LRHL6Al7UbqGJaiezOl1+OOvf8A67u1hfdUyoKem/h3PepIkXrctWfEhnNHmhDiEs1n6+mT8MqhCYkYGllEJjaUHDXnqOhpwQ36VNez2
 P7ghc6w47ez1XPKv7AuB4kVgGuc9jKxijDNqiAyyqqJKM7R4Ks5XDMhWgMQUsS0shTtZfXtEBDAZcj//azuy3f0sK6TW/0IFk6FPFpXORjGME7bEMGSwtVY2
 0K9GFEh9/WPR31UN5lbRdtk00da6J/nFX8i1Pwf8c30w2zha5kLQ3yjPnW7EG+MsuBjagelBuiS1JPqKgTKd0Q50H/uC4Mp0vgfkzVedX4KXsgN/q4y1gfci
 +rOzNEEHbNgv2KPRarQWVkrUrPAwjp55VV5kCfit4Egs0FGxHZa2GyhBK0lrq0JWOzGXjeHGs+oWwX8T6Dv99DcGl7NqCBPuHUC2thKpWXSXhfPiFjYprRfE
 5Co6umRFAmGCl24KJ/dfENdF36hlb4SA0WHek6xlv4Rh1BhT3kdgyszoQ+liBoX7zFrKIHzjIY5jVeURSN5FKB+Ds7lcdUiY6W8RmNa+nXvNk8vZ6fIxKrDL
 8SP6+kKI6HsPVV/Qa7QakBYL
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
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

