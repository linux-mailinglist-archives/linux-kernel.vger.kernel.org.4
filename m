Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BAD6CC84F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjC1Qm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjC1Qms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:42:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F927AA5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:42:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y144-20020a253296000000b00b69ce0e6f2dso12604609yby.18
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680021766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=akG81if4jTiA5YzyK2S4GHzKQoAhTTq+47u+UaQ/VHIofm3zkprIOu6B7rYPy0tSyl
         UGUGltoHlgfE+76EaGusuobGe+lom/TQ52hOMw/twnoJxK9R3Yk/6h0k5KShhzn3To8f
         gYW0DhK35mOjv7aS7au1ZBOmUGhsI6ryXgzUQYQSSm2PKV33DE23sYJc2rioXGa0MsUY
         f/EJgHP565/cUHbq1M1UoGXALU239pGH/qxEiGJK7Z/1A+/+hbZwROBWpoYZqp3UBI9A
         T7Drp3G2KX0M/LyhaAJvdq2xc5i4v2uGrjOj3YHmEBie7OApXYb1qHy/IfIxxHduKF8+
         EmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=t/nEyj1o169p66CC4fmAlBnPM8omnlPQhqd04a3lk547m3Sb6uj9FyxD8a7HTyCea5
         9C93n9XINuYUOuehG87KWPJWHwswnOz4wCpKuqPQ8qFiHLv9bMZY1PhL/cBTetv0d+Qj
         RZWKSYaZfZr/thv7BT8Xznf2oOTH/yvXBbmCbf7Ijh3BcyNIgkUl118Z97vkgeUoBF78
         IVfsxv1TfBaD+DqxqIeul/uz0xPcqdqXr+DcWfRNt/XwFOx53eOdYwIFgTlrBGOgTpx7
         IJlE8RoHE74KwEughU9g1B6Ga6gtqpx7pzIglVsZ2HlBpn2GFEuOhFgVx/mQBoAW5ZMj
         XtZQ==
X-Gm-Message-State: AAQBX9fCP2FIdQaS6rzzmFav9YjXoNXtuxZQ/8Pe8ZDMG9Y+Ara6r17t
        OnrbYXCgJY8EvF2LtJkL4CYMJB6BQNYAQA==
X-Google-Smtp-Source: AKy350bR6rJxmGAjFwURfQiBKLRMeY2B+66CwIhzIMLLr9+9B8WExIll1C/vuZ6mOLKs6yawoneAG/tQ3CHasw==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a81:ac46:0:b0:533:9185:fc2c with SMTP id
 z6-20020a81ac46000000b005339185fc2cmr7783218ywj.7.1680021766358; Tue, 28 Mar
 2023 09:42:46 -0700 (PDT)
Date:   Tue, 28 Mar 2023 09:42:39 -0700
In-Reply-To: <20230328094207.v11.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230328094207.v11.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328094207.v11.3.I8cd97c192e8268567b6f467ccd993ec71897318e@changeid>
Subject: [PATCH v11 3/4] Bluetooth: btusb: Add btusb devcoredump support
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

