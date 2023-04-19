Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6776F6E74D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjDSITy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjDSITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:19:49 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7803F18B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:19:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id A57181835D2872;
        Wed, 19 Apr 2023 16:19:28 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yunchuan <yunchuan@nfschina.com>
Subject: [PATCH] firmware: arm_scmi: Remove unnecessary (void*) conversions
Date:   Wed, 19 Apr 2023 16:19:20 +0800
Message-Id: <20230419081920.857144-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: yunchuan <yunchuan@nfschina.com>
---
 drivers/firmware/arm_scmi/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index d68c01cb7aa0..f0863b9c0e5d 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -392,7 +392,7 @@ static bool virtio_chan_available(struct device_node *of_node, int idx)
 	if (WARN_ON_ONCE(!scmi_vdev))
 		return false;
 
-	channels = (struct scmi_vio_channel *)scmi_vdev->priv;
+	channels = scmi_vdev->priv;
 
 	switch (idx) {
 	case VIRTIO_SCMI_VQ_TX:
-- 
2.30.2

