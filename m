Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60253691608
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjBJBGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBJBGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:06:05 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ECB5EA2B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 17:06:02 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VbHf6.e_1675991158;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VbHf6.e_1675991158)
          by smtp.aliyun-inc.com;
          Fri, 10 Feb 2023 09:05:59 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: clean up some inconsistent indentings
Date:   Fri, 10 Feb 2023 09:05:58 +0800
Message-Id: <20230210010558.10621-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:145 get_ddc_line() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:201 dc_link_construct_phy() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4026
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 13a766273755..23f668d90460 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -142,7 +142,7 @@ static enum channel_id get_ddc_line(struct dc_link *link)
 	struct ddc *ddc;
 	enum channel_id channel;
 
-		channel = CHANNEL_ID_UNKNOWN;
+	channel = CHANNEL_ID_UNKNOWN;
 
 	ddc = get_ddc_pin(link->ddc);
 
@@ -196,8 +196,8 @@ static bool dc_link_construct_phy(struct dc_link *link,
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
-		link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
-		link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
+	link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
+	link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
 	link->link_status.dpcd_caps = &link->dpcd_caps;
 
 	link->dc = init_params->dc;
-- 
2.20.1.7.g153144c

