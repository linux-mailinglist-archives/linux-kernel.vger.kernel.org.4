Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850126CFB39
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjC3GFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjC3GFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:05:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448B9211B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:05:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z31-20020a25a122000000b00b38d2b9a2e9so17584730ybh.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680156331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=T2Xd/vq4QTC43NzxMiqSqBA8msNyNnHwNo6UYCR6DdjwKSdN7puBZQbpLOgxQylu5B
         6MryFowxU9/CeP3PrNz+SadXmpimku7vRJFPmIOAC8YNblPOJSp8D77HXjV0tpgVLiVI
         4N9IJgrdUVI0eYrleZN00+XjcsyauZiCpIOvxba7pJHKJ8UIiMTqNEqYHHJdJlrU36Jf
         1UHQ85XZwKvyo5W1l8U1Y/vTNdvQ4/1V3Kab1d5t33t/oC2QF85nUUxF5svdiLJGLxAU
         Nm64To0CMn9CYygJZW+ulUToZlW0X1dmq9+XUIH++wvAE4gbShgrsYTjPbJkv00R6QjC
         SBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680156331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=cHz7KmCZPO0/gpek6gimmGBqyF1E/8LDxhRxXVRI6bZLZrwY9pcnaQH7PdXWmnE+r/
         PzvW72Yqt/ysx7EA3mXMu4QNqbnQOeHCLeU7SX8MoOSM1rrxb2BrZD7HRD9ovAnN68ch
         GWXmfnFEgKVbN469B4P3Xqrqa8rkSIV1Pq+hZYTMwSXwObPDFdVfplKeYVWtrlADy+QV
         wSQsIl0BNJbGfcf6P4oVaR62aM3EAFcr1t09ZiEMOVD9IcWTECei4jVBcxvInG7Qsa++
         6zkdFeYkVFN/jzwfvso3qvIgotrYvRk5jv5Gh3iFfsjK2y09r//tcdeRAzKVAg+hjOSD
         V7ig==
X-Gm-Message-State: AAQBX9fCy9QP/DOFZBDZ2vbRPtZ4dnDKPWEqa9SgpGH+5Y3X5PmjEIkv
        yf1op3TgeFwdT4/OsZwwzCvG6CmWE9KTPQ==
X-Google-Smtp-Source: AKy350Ymcg4w/g2wSAcLxooGhAl1H3npi/oStK8CaFgkf+a/KCg3Ivngm5jyRNcMN8ZTdNEfsgXG2vqkJDuU+Q==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a25:e08a:0:b0:b72:fff0:2f7f with SMTP id
 x132-20020a25e08a000000b00b72fff02f7fmr3211068ybg.4.1680156331464; Wed, 29
 Mar 2023 23:05:31 -0700 (PDT)
Date:   Wed, 29 Mar 2023 23:05:22 -0700
In-Reply-To: <20230329230447.v12.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230329230447.v12.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230329230447.v12.3.I8cd97c192e8268567b6f467ccd993ec71897318e@changeid>
Subject: [PATCH v12 3/4] Bluetooth: btusb: Add btusb devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the btusb driver side .coredump() callback to
trigger a devcoredump via sysfs.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v6)

Changes in v6:
- Remove dev->coredump_disabled check since the sysfs flag related
  change has been abandoned

Changes in v4:
- New patch in the series

 drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4ca91c033d2f..9c9f7bf1375a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4385,6 +4385,17 @@ static int btusb_resume(struct usb_interface *intf)
 }
 #endif
 
+#ifdef CONFIG_DEV_COREDUMP
+static void btusb_coredump(struct device *dev)
+{
+	struct btusb_data *data = dev_get_drvdata(dev);
+	struct hci_dev *hdev = data->hdev;
+
+	if (hdev->dump.coredump)
+		hdev->dump.coredump(hdev);
+}
+#endif
+
 static struct usb_driver btusb_driver = {
 	.name		= "btusb",
 	.probe		= btusb_probe,
@@ -4396,6 +4407,14 @@ static struct usb_driver btusb_driver = {
 	.id_table	= btusb_table,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
+
+#ifdef CONFIG_DEV_COREDUMP
+	.drvwrap = {
+		.driver = {
+			.coredump = btusb_coredump,
+		},
+	},
+#endif
 };
 
 module_usb_driver(btusb_driver);
-- 
2.40.0.348.gf938b09366-goog

