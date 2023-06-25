Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666B773CF4A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjFYIYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 04:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjFYIY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:24:29 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CFAE6F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:24:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VlrlpwT_1687681454;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VlrlpwT_1687681454)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 16:24:23 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     bskeggs@redhat.com
Cc:     kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/nouveau: Remove the unused variable entry
Date:   Sun, 25 Jun 2023 16:24:13 +0800
Message-Id: <20230625082413.111375-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable entry is not effectively used, so delete it.

drivers/gpu/drm/nouveau/nouveau_connector.c:1298:7: warning: variable 'entry' set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5596
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index f75c6f09dd2a..3a267b793afa 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1295,11 +1295,8 @@ nouveau_connector_create(struct drm_device *dev,
 	/* attempt to parse vbios connector type and hotplug gpio */
 	nv_connector->dcb = olddcb_conn(dev, index);
 	if (nv_connector->dcb) {
-		u32 entry = ROM16(nv_connector->dcb[0]);
-		if (olddcb_conntab(dev)[3] >= 4)
-			entry |= (u32)ROM16(nv_connector->dcb[2]) << 16;
-
 		nv_connector->type = nv_connector->dcb[0];
+
 		if (drm_conntype_from_dcb(nv_connector->type) ==
 					  DRM_MODE_CONNECTOR_Unknown) {
 			NV_WARN(drm, "unknown connector type %02x\n",
-- 
2.20.1.7.g153144c

