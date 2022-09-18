Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECA15BBB25
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 04:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIRCPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 22:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIRCPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 22:15:07 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E47F513E89
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 19:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KKOLo
        e6jV7OhaYjuOkL4ZW2LfigbDK6OZGAttUk20qc=; b=Iku22FjUN8loVd424B6MY
        WhBkPyVqMOY5duTuruDoGrSBohOQXRmV8fxDK2xKmOTMbkB8i3yd0rBSdOtMIf2L
        Mn1kggtF8UXiMXSrwSZVM1OiaBeu4gGLMPFCVcki/2Bk1Aql2hebiVrCE2l68Fgc
        vQzHuiZY1TpxZiRMD+rVZw=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp8 (Coremail) with SMTP id DMCowAB3v6f3fiZjpmgXbg--.42780S4;
        Sun, 18 Sep 2022 10:14:38 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] firmware: arm_scmi: remove unnecessary 'NULL' values from pointer
Date:   Sun, 18 Sep 2022 10:14:10 +0800
Message-Id: <20220918021410.17369-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAB3v6f3fiZjpmgXbg--.42780S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrur4fKF1xJF13tF48GFWkCrg_yoW3ArcE9F
        yrXw4UKw1IkrWqqr13Ga43Arnaya18W3WfXrn2va13tr17Aw4Du3WkCwn7XwnrXrsFyFn7
        urZ0gFs5Zr4vkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREoUD5UUUUU==
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbCoA+AF1zmWP61HwAAsO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to initialize the assignment.

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/firmware/arm_scmi/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index ecf5c4de851b..a8654d3d5ff9 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -723,7 +723,7 @@ static void *scmi_perf_fill_custom_report(const struct scmi_protocol_handle *ph,
 					  const void *payld, size_t payld_sz,
 					  void *report, u32 *src_id)
 {
-	void *rep = NULL;
+	void *rep;
 
 	switch (evt_id) {
 	case SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED:

base-commit: d5538ab91d3a9a237805be6f8c6c272af2987995
-- 
2.34.1

