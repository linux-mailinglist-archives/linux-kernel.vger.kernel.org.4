Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C713614583
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiKAIPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKAIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:15:12 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7011260E;
        Tue,  1 Nov 2022 01:15:07 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id WLR00100;
        Tue, 01 Nov 2022 16:15:00 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.12; Tue, 1 Nov 2022 16:15:01 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <michael@amarulasolutions.com>,
        <dario.binacchi@amarulasolutions.com>,
        <wsa+renesas@sang-engineering.com>,
        <oliver.graute@kococonnector.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] Input: edt-ft5x06 - replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Tue, 1 Nov 2022 04:14:58 -0400
Message-ID: <20221101081458.8119-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20221101161500c5e451d4bbc87ab63752f659c0e9ec61
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
  drivers/input/touchscreen/edt-ft5x06.c:756:0-23: WARNING:
    debugfs_mode_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 9ac1378610bc..a184425b6985 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -753,7 +753,7 @@ static int edt_ft5x06_debugfs_mode_set(void *data, u64 mode)
 	return retval;
 };
 
-DEFINE_SIMPLE_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
+DEFINE_DEBUGFS_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
 			edt_ft5x06_debugfs_mode_set, "%llu\n");
 
 static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
-- 
2.27.0

