Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF63A66D5CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 07:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbjAQGBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 01:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbjAQF7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:59:54 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D17923304
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 21:59:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VZluILG_1673935178;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VZluILG_1673935178)
          by smtp.aliyun-inc.com;
          Tue, 17 Jan 2023 13:59:42 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 3/3] drm/amd/display: Clean up some inconsistent indenting
Date:   Tue, 17 Jan 2023 13:59:22 +0800
Message-Id: <20230117055922.53911-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230117055922.53911-1-jiapeng.chong@linux.alibaba.com>
References: <20230117055922.53911-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_hpd.c:140 get_hpd_line() warn: inconsistent indenting.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3787
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_hpd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hpd.c b/drivers/gpu/drm/amd/display/dc/link/link_hpd.c
index 5f39dfe06e9a..4746ea623354 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hpd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hpd.c
@@ -137,10 +137,9 @@ enum hpd_source_id get_hpd_line(struct dc_link *link)
 	struct gpio *hpd;
 	enum hpd_source_id hpd_id;
 
-		hpd_id = HPD_SOURCEID_UNKNOWN;
-
+	hpd_id = HPD_SOURCEID_UNKNOWN;
 	hpd = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
-			   link->ctx->gpio_service);
+				link->ctx->gpio_service);
 
 	if (hpd) {
 		switch (dal_irq_get_source(hpd)) {
-- 
2.20.1.7.g153144c

