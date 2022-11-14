Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF86C62750A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiKNDkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiKNDkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:40:41 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC36559;
        Sun, 13 Nov 2022 19:40:40 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N9ZpG44z7zjn8;
        Mon, 14 Nov 2022 11:40:38 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4N9ZpB72rKz4xD31;
        Mon, 14 Nov 2022 11:40:34 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4N9Zp74zSvz9tyD6;
        Mon, 14 Nov 2022 11:40:31 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N9Zp42p3gz4xVnD;
        Mon, 14 Nov 2022 11:40:28 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N9Zp20fR1z4y0tt;
        Mon, 14 Nov 2022 11:40:26 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl1.zte.com.cn with SMTP id 2AE3eC1t022476;
        Mon, 14 Nov 2022 11:40:12 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 14 Nov 2022 11:40:13 +0800 (CST)
Date:   Mon, 14 Nov 2022 11:40:13 +0800 (CST)
X-Zmail-TransId: 2b066371b89d59d038a6
X-Mailer: Zmail v1.0
Message-ID: <202211141140133437292@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <martin.petersen@oracle.com>
Cc:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNjc2k6IHRhcmdldDogVXNlIHN5c2ZzX3N0cmVxKCkgaW5zdGVhZCBvZiBzdHJuY21wKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AE3eC1t022476
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 6371B8B5.000 by FangMail milter!
X-FangMail-Envelope: 1668397238/4N9ZpG44z7zjn8/6371B8B5.000/10.35.20.165/[10.35.20.165]/mxde.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6371B8B5.000/4N9ZpG44z7zjn8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

There is a ready-to-use method to compare a retrieved from a sysfs node
string with another string. It treats both NUL and newline-then-NUL as
equivalent string terminations. So use it instead of manually truncating
the line length in the strncmp() method.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/target/target_core_configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index b8a5c8d6cfde..119711c2bc08 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -208,7 +208,7 @@ static struct config_group *target_core_register_fabric(
 		 * mkdir(2) system calls with known TCM fabric modules.
 		 */

-		if (!strncmp(name, "iscsi", 5)) {
+		if (!sysfs_streq(name, "iscsi")) {
 			/*
 			 * Automatically load the LIO Target fabric module when the
 			 * following is called:
@@ -221,7 +221,7 @@ static struct config_group *target_core_register_fabric(
 				         " iscsi_target_mod.ko: %d\n", ret);
 				return ERR_PTR(-EINVAL);
 			}
-		} else if (!strncmp(name, "loopback", 8)) {
+		} else if (!sysfs_streq(name, "loopback")) {
 			/*
 			 * Automatically load the tcm_loop fabric module when the
 			 * following is called:
-- 
2.15.2
