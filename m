Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD136CB318
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjC1BTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjC1BTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:19:10 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9CE2117
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:19:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k3-20020a170902ce0300b0019ca6e66303so6723224plg.18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679966344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=XyFLtl/5xKP+J4XEIX0wfelHUuTwFHtfLQLUMR0MLPBm+IxTXAkLytPRNmH00qN7CH
         mdz9BCoC9fCDLYGDK5cwlaTJzjnBIzJVSlX88gvb41TAGW0G8pXsSXrRv7Xoehv3BBfH
         5hCvbAoGfljbkeVpDI2KuA8mWujfUE2JJCoWoRBi6zO9M05QXzuqCrpuzzQDGqXLTwui
         IbAQY74ug1vpWqD9DuoESSp+kvpKZQm4tRjcB9lRnt0D0doowOclDegh9iSgsSXciCZf
         jfE7URODKNcCcWOrI7tVPeIrEZFKaXXjkX2ApAI5nsczPfnh/qBYaRPlOsmpWTM6OplO
         jZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679966344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=rU+uhCTBpvuDoFKRzBUT1/dMextjT2VxI7s1OgclVBWUVaiOXGSocm/2n/wPhgdpKO
         jS4yPYOFwqDBms1vUL/rT+Y0/4sJTm94UKVQSus3U3jYH0rHXpmozkLsDvRs5F/s+df7
         QaprLq5XI5htw4vU8gdICeC3n3BeoocxbXpCZ562R6DnbjZ67JgGhdKLwT3T2Kil/biD
         YQvaMQ1GgDpGns5QqdQ6Y6i/AvwTdqSpowwsHDLheQ1PeW1V8VKBi1Wsl0+r0Yp1p+pE
         TGPncSVBSN9Rc4/4DZh58h3K30jOSogguq87GDepyfQaBUI3fLZRET5yNJEmJqQvoxue
         U1iQ==
X-Gm-Message-State: AAQBX9eBlKri2ewUUwP5L/QzcgDr7ycqWngVvLK4NOqbFuIVmSVgxner
        tAig4aYuYVYI+BJvHVGWjVDk330YZ8royQ==
X-Google-Smtp-Source: AKy350aDQyXH8Z6uCN+o1t4aSklBoh4FNFzYy5pA6U0E0t0xbLqUtjmcFFEGh3nIbSf7k8AE1jLZQH9DUIoEIg==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:90a:3ec2:b0:23f:4b8d:2393 with SMTP
 id k60-20020a17090a3ec200b0023f4b8d2393mr4025254pjc.8.1679966344653; Mon, 27
 Mar 2023 18:19:04 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:18:56 -0700
In-Reply-To: <20230327181825.v9.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230327181825.v9.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230327181825.v9.3.I8cd97c192e8268567b6f467ccd993ec71897318e@changeid>
Subject: [PATCH v9 3/4] Bluetooth: btusb: Add btusb devcoredump support
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

