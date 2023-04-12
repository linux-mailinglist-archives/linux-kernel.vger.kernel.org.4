Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2446DF06F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDLJat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjDLJag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:30:36 -0400
X-Greylist: delayed 953 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Apr 2023 02:30:19 PDT
Received: from ssh249.corpemail.net (ssh249.corpemail.net [210.51.61.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758083E6;
        Wed, 12 Apr 2023 02:30:18 -0700 (PDT)
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id IEJ00104;
        Wed, 12 Apr 2023 16:48:04 +0800
Received: from localhost.localdomain.com (10.73.43.242) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.21; Wed, 12 Apr 2023 16:48:03 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] mmc: vub300: remove unreachable code
Date:   Wed, 12 Apr 2023 04:47:58 -0400
Message-ID: <20230412084758.2673-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.73.43.242]
tUid:   2023412164804bd112bb7f71eefd5a56a73e62553a68c
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

The function sched_partition_show cannot execute return, delete the
invalid code.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/mmc/host/vub300.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 72f65f32abbc..e4c4bfac3763 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1341,8 +1341,6 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 		return;
 	}
 
-	return;
-
 copy_error_message:
 	strncpy(vub300->vub_name, "SDIO pseudocode download failed",
 		sizeof(vub300->vub_name));
-- 
2.27.0

