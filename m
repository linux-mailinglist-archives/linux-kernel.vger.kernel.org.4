Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DDA6B96B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjCNNqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjCNNqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:46:05 -0400
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E33A648F;
        Tue, 14 Mar 2023 06:42:49 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 2995E10238F;
        Tue, 14 Mar 2023 15:44:02 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 25F6C10226F;
        Tue, 14 Mar 2023 15:43:42 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.53.223])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 32EChfKV018729;
        Tue, 14 Mar 2023 15:43:41 +0300
From:   Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH] Input: synaptics - remove unreachable code
Date:   Tue, 14 Mar 2023 15:43:36 +0300
Message-Id: <20230314124336.1494716-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.0.152.ga5737674b6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20230314 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synaptics_resolution() function always returnd 0.
And there is no need to check its result.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e839ffab0289 ("Input: synaptics - add support for Intertouch devices")
Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 drivers/input/mouse/synaptics.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index fa021af8506e..4f1182bf9667 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -444,9 +444,7 @@ static int synaptics_query_hardware(struct psmouse *psmouse,
 	if (error)
 		return error;
 
-	error = synaptics_resolution(psmouse, info);
-	if (error)
-		return error;
+	synaptics_resolution(psmouse, info);
 
 	return 0;
 }
-- 
2.30.2

