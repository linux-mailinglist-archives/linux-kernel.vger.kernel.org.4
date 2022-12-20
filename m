Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BEA651C93
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiLTIvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLTIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:51:29 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4734E6E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 00:51:28 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3e:7d24:3f0:3e81:fb16:ab4d])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 84C4C706;
        Tue, 20 Dec 2022 09:51:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671526287;
        bh=qliMi8NeM0JMYKJ9CEAM47jiAbdrpvNTIc87DNgEnd4=;
        h=From:To:Cc:Subject:Date:From;
        b=rwuz4adDmF2KwXZZIZ839wLUo1KiC7Eht7pFJXQKvMU4+gPSfx+gfeXy5JwCmBXgV
         1J39/mQoZwTCQLhDwG/jQTgr80JXmbJELx2sQzLCwbyyoLBsyGmbVBqm5bKMl6ob6k
         qvf3MXnVJzad8TAMv8rYuUR62g+xDe9WTLReleu0=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH] platform: Document platform_add_devices() return value
Date:   Tue, 20 Dec 2022 14:21:16 +0530
Message-Id: <20221220085116.19837-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_add_devices() returns 0 on success and negative
errno on failure. Document it.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/base/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 968f3d71eeab..9759dddc5531 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -499,6 +499,8 @@ EXPORT_SYMBOL_GPL(platform_get_irq_byname_optional);
  * platform_add_devices - add a numbers of platform devices
  * @devs: array of platform devices to add
  * @num: number of platform devices in array
+ *
+ * Return: 0 on success, negative error number on failure.
  */
 int platform_add_devices(struct platform_device **devs, int num)
 {
-- 
2.38.1

