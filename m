Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2C6084EB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJVGGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJVGGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:06:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3472629F12C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:06:09 -0700 (PDT)
X-QQ-mid: bizesmtp85t1666418758tyusmhdu
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:05:57 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: mhDoKBI5A3ATK8ywXlCpoa1WQWXf6h02BTkLcofe/Cg10W02z6GQMH5yEeuCs
        4AA0A9hwr5YUyJ2m8OtRtQm4uDjSjonZduer1En4GDCRUmBeTs8r5PT0Ez3Aiyoc6BkMDbz
        CozbV/ZtcmCn93t3xFzWF0l7CQgnGsc96lloRlFEvzuywwxfa7kCWcdkCZA5eEil1jqbJPw
        X/pFiXQ+jsJo9NY3B/4r3RwQ7zrFh4T9E0YcDaGFN7j2pkBh+yaDPwQ5iVYWxiKV/+fDuvW
        dp4iddf19HmtC8lDOs5Re6na7dOVmUTVU8WKj4zjVAgsLUNmsK56R4QRAH76HDvA4wMqDg0
        +cQC97ZqwLySKxS3uk1uT06/Zr8ixMeHBdrsVKdvf6YG18j+mU=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] gpu/drm: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:05:51 +0800
Message-Id: <20221022060551.56918-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index c40bde96cfdf..ae12cca8b123 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -605,7 +605,7 @@ int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi)
 EXPORT_SYMBOL(mipi_dsi_turn_on_peripheral);
 
 /*
- * mipi_dsi_set_maximum_return_packet_size() - specify the maximum size of the
+ * mipi_dsi_set_maximum_return_packet_size() - specify the maximum size of
  *    the payload in a long packet transmitted from the peripheral back to the
  *    host processor
  * @dsi: DSI peripheral device
-- 
2.36.1

