Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4436581D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbiL1QcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiL1Qbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:31:39 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DE11C113
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:27:55 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 253D632002FB;
        Wed, 28 Dec 2022 11:27:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 28 Dec 2022 11:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672244874; x=1672331274; bh=k1jw7prIecCK9PqphsN3qWRlG
        ngXIbmWqvs3m/zFc78=; b=JzE+szhB/q3OHjuOXgjukbGQve4Ad50vdmnw19NuC
        eunjp0gTYik63zu2/Z/Ms5QlTfmJ5pLKhLfwGl1Rjr4L5wBEGD0SHnTHKKtEp79D
        PHxwppXMyY4ZQU0jIEYBOkf9Pu+R1eMs5aH5bJBAsEv6uLSk9sA2/rrS3et1EJM8
        +B1vkg1XcT86TxYMUTZNJobzBtQ+aGv59uD5S9ONRthf8vHPUVq9nzCU/ilvvbw9
        T0HwLQO3yPZwcu0m0FBbuQBLcLbhyjXTvRHywqFN6nebEy6L58tUaCY3ljIoqoNP
        5mxKoNxeZdgWVHqkgbORTi3O7iGAs6PSDgL0ccvOtdo4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672244874; x=1672331274; bh=k1jw7prIecCK9PqphsN3qWRlGngXIbmWqvs
        3m/zFc78=; b=GTrwt7emst8sYUEVNRfZdZOAzN3a6NLnqkGZ8szSn0nB7FVRzaA
        8sOZUtHz03dVgUcb8oSAMVAHzuanjicl54VwWwhedHrfolbHDz5Fjx4pk6RIuFru
        ts1j9GhdJUs9Idw6QYpnx7RO5qfQdCSwWjKVzXCI6hRoug9gnqU+XSKDOFxdPQFO
        S3vuV6CfLBDhZEh7eb/k81vVsuW8KMF5ZEQO9cMUMY12OSlMgxOIb0bZ9F/mTvrn
        dTDswTpOid75th2nRVrdWmIx16cstxyKd9V2KyL1qXxcBOdint06hiCJcq8w87qY
        tD0DgaYgXSjVuzOLXBLGYkczfBJY1KMia5A==
X-ME-Sender: <xms:im6sY4xeTNXmf61Wz4ru8YkroB7SH2t-MVCCISrcReiq2f_IPMU7Hw>
    <xme:im6sY8QlfEfCf0MoeuonGdg6VNu_3l0wf_bwpuZN1s85bf1MaCTQxUXnCk-tI8XG3
    2hb3Q3oy8Ojz5LHUw>
X-ME-Received: <xmr:im6sY6WE2rm2hX14TNaEDiPxOa97NYLzYS2axQDDFgm6lZ4eYQaGopJdy4rprpY0wlh7tJ2S5D8n3arOJDbtmrOAb9OAKEg14-jlz7gMSCHWhhcH6o6HmQGlyk1LuZMNiL4GXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhho
    lhhlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepkeehffethedtteffgfefteetje
    dvfeelueevudffgfeutdejvdehledvvdffhfevnecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:im6sY2gkNhjSa2cjqzr7RdmsSRHxua4VsGyMyyvdeB6K14bwne0czA>
    <xmx:im6sY6C05u915n-b0FxEyLUA9aCz_Ki7N9RNBbNMjFtsqoAPg8jZwg>
    <xmx:im6sY3JE6S8M4odWfEJ7iS5lovd45KgM5aUK-MFDtWso3t8tzO7KJw>
    <xmx:im6sY9O11264CIRGrzIUntFXfRM1MS8AB6dLDjFtaMgtouuf2_4zFQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 11:27:53 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: axp20x: Switch to the sys-off handler API
Date:   Wed, 28 Dec 2022 10:27:52 -0600
Message-Id: <20221228162752.14204-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes a layer of indirection through pm_power_off() and allows
the PMIC handler to be used as a fallback when firmware power off fails.
This happens on boards like the Clockwork DevTerm R-01 where OpenSBI
does not know how to use the PMIC to power off the board.

Move the check for AXP288 to avoid registering a dummy handler.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
Note: this patch depends on updating the PSCI driver first[1] to keep
the existing callback priority.

[1]: https://lore.kernel.org/lkml/20221105214841.7828-1-samuel@sholland.org/

 drivers/mfd/axp20x.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 47fd700f284f..58f82f1f4b43 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -23,7 +23,7 @@
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/pm_runtime.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -825,17 +825,17 @@ static const struct mfd_cell axp813_cells[] = {
 	},
 };
 
-static struct axp20x_dev *axp20x_pm_power_off;
-static void axp20x_power_off(void)
+static int axp20x_power_off(struct sys_off_data *data)
 {
-	if (axp20x_pm_power_off->variant == AXP288_ID)
-		return;
+	struct axp20x_dev *axp20x = data->cb_data;
 
-	regmap_write(axp20x_pm_power_off->regmap, AXP20X_OFF_CTRL,
+	regmap_write(axp20x->regmap, AXP20X_OFF_CTRL,
 		     AXP20X_OFF);
 
 	/* Give capacitors etc. time to drain to avoid kernel panic msg. */
 	mdelay(500);
+
+	return NOTIFY_DONE;
 }
 
 int axp20x_match_device(struct axp20x_dev *axp20x)
@@ -1002,10 +1002,11 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 		return ret;
 	}
 
-	if (!pm_power_off) {
-		axp20x_pm_power_off = axp20x;
-		pm_power_off = axp20x_power_off;
-	}
+	if (axp20x->variant != AXP288_ID)
+		devm_register_sys_off_handler(axp20x->dev,
+					      SYS_OFF_MODE_POWER_OFF,
+					      SYS_OFF_PRIO_DEFAULT,
+					      axp20x_power_off, axp20x);
 
 	dev_info(axp20x->dev, "AXP20X driver loaded\n");
 
@@ -1015,11 +1016,6 @@ EXPORT_SYMBOL(axp20x_device_probe);
 
 void axp20x_device_remove(struct axp20x_dev *axp20x)
 {
-	if (axp20x == axp20x_pm_power_off) {
-		axp20x_pm_power_off = NULL;
-		pm_power_off = NULL;
-	}
-
 	mfd_remove_devices(axp20x->dev);
 	regmap_del_irq_chip(axp20x->irq, axp20x->regmap_irqc);
 }
-- 
2.37.4

