Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE2F6D0C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjC3Q6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjC3Q6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:58:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D71D729F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:58:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54161af1984so192566367b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680195515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=sPkOM60p9XfgUbH7pBqUd6F96vI0z12zFZQETS/H9riaTmwdSkGlenqKyfhBTC/U7j
         PtK54UDOLWnX+Fx3oyis0o7DI4JTPlvINvBlMalUduIzcBbSrqy/DNY5WnhiJmE5DeE5
         yMmgRWeuadZKKUzXv53Lql8cXIa9Jy/DGqd5uq82/xEaNu+X+vVYbrByUn8OVSi/7i+V
         +qNOkz1irQ9lYHRKlu3ddPhy71wJIVT4+vms7OaxKK8/k4HVrY9bmPSspeAQqWnoRmJ8
         rWp7snGpEq5ca3mAtorvXHsfSUn7C/yI8e0ca96v3VuWFMQgGjV+Ux6CzAer9A5KX3CY
         4Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680195515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=6W3WCV3fwi9PXOigWKYJIJSAsIia2ga39mZ9mpyFhGTJ8glYMUdUSarG0s5OYdoB0m
         Q+/bkjpONf7zgmMxyA5JH+ctz6QKehDudDVjcfzwddy4WVgz2vEZAjpWr5p+CYqYyvfL
         iOSVFF53VD+jLShlQQp1xDigH2ImP386r0wOdnXS3Ce/uT7plhhtIxXdCOpkKdtKxZLQ
         I0k0+9I3IEZYsElU+yhPGmtEWJgI59/h7Qkcz+CzGWz+AmbmcE+mjdrBNVZL7pkj2LQS
         8q5M/TcvH7+JQQsYe8JzIyztJ1fZ1VcEEAbM2f5VBx+TrwMPE30MdXl3XR7nXW/W02L4
         XGNA==
X-Gm-Message-State: AAQBX9dWHi31jhPbTBFL6hL1D6sQZxycDlJzrp91fngDVESRFbnXSsTT
        P6LhezXUnG45nR4owWY6epJfq8uuJZl6mA==
X-Google-Smtp-Source: AKy350boZukWbuXgC6wUO0k6aTTxUoc9xBZqgphDIqIKwRq3W8Ollw1lCQYK6HXG5SVcl6J/Wqfv3dF36Fagsw==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a05:6902:1003:b0:b1d:5061:98e3 with SMTP
 id w3-20020a056902100300b00b1d506198e3mr16426997ybt.6.1680195515673; Thu, 30
 Mar 2023 09:58:35 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:58:25 -0700
In-Reply-To: <20230330095714.v13.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230330095714.v13.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330095714.v13.3.I8cd97c192e8268567b6f467ccd993ec71897318e@changeid>
Subject: [PATCH v13 3/4] Bluetooth: btusb: Add btusb devcoredump support
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

