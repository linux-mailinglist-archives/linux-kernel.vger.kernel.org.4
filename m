Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D43650CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiLSNiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiLSNiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:38:04 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F01109;
        Mon, 19 Dec 2022 05:38:02 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1671457080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LIX+5vTgAa3AFS432HnSIazayh3H9A41Ekpfui0oqko=;
        b=ZPxTBmXn46y8JX7TObeUVrjphJFqsQjhpBM38Vvn9EhNHmbSaWRO05JAJassxHYIgYW1mb
        Mb4YGCBlRcrpNAtSbUk19qnJFdFJpaiDn9fxpaRD7MZJAWUSiS2aWQB6QyDaa1/OXj7Hw/
        x17EcuiWF1zsZ7gtNcc009YUoccjmeU=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-input@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: synaptics-rmi4: Fix SPI device ID
Date:   Mon, 19 Dec 2022 13:37:15 +0000
Message-Id: <20221219133717.1638496-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the ID being set to "rmi4_spi" causes this warning:
"SPI driver rmi4_spi has no spi_device_id for syna,rmi4-spi"

Change the ID to rmi4-spi to stop this warning.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 drivers/input/rmi4/rmi_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index c82edda66b23..aa3a6a8544d4 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -510,7 +510,7 @@ static const struct dev_pm_ops rmi_spi_pm = {
 };
 
 static const struct spi_device_id rmi_id[] = {
-	{ "rmi4_spi", 0 },
+	{ "rmi4-spi", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, rmi_id);
-- 
2.39.0

