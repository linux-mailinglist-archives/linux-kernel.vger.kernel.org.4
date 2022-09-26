Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AC65E97D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 03:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiIZBwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 21:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIZBwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 21:52:17 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D2E2B1A1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 18:52:15 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id UAA00010;
        Mon, 26 Sep 2022 09:52:10 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.12; Mon, 26 Sep 2022 09:52:11 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <ogabbay@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] habanalabs: Use simplified API for p2p dist calc
Date:   Sun, 25 Sep 2022 21:52:08 -0400
Message-ID: <20220926015208.3794-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022926095210313cce5187fcc4c8f93a89f569eab40d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the simplified API that calculates distance between two devices.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/misc/habanalabs/common/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index ef28f3b37b93..99b1d6ce26ae 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1689,7 +1689,7 @@ static int hl_dmabuf_attach(struct dma_buf *dmabuf,
 	hl_dmabuf = dmabuf->priv;
 	hdev = hl_dmabuf->ctx->hdev;
 
-	rc = pci_p2pdma_distance_many(hdev->pdev, &attachment->dev, 1, true);
+	rc = pci_p2pdma_distance(hdev->pdev, attachment->dev, true);
 
 	if (rc < 0)
 		attachment->peer2peer = false;
-- 
2.27.0

