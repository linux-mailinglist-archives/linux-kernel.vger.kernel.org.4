Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6D56C7226
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjCWVKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjCWVK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:10:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EBF24CBB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:10:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e23-20020a25e717000000b00b66ab374ba1so18426961ybh.22
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679605827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vb8xGekqLZEVswI0VXnWBbiOZDnEjcKbHS0+1g7cZR4=;
        b=L+DAp2MOt1+8vAsdO/zxTmqAUl6PsMPqtBeQXy0P2jSvlukJIyVJjOqgOPy+UKV0H1
         x8mmXxHbULbceu1L/ka66cuA4w8ZH/XyUJ44nLaTPk7I9F//Ec4Wo6lS8yM9lkJN3ypB
         l1f0sysmj7ibeMdHoDuVJQhymiW98UsjMmaM+yvpS2So+/jfS44Ufv2LizHWFmuZULEV
         VmubLNxsmTe3nS8ksdXCCb9k1Ue5Etede03yupybyDCPn0AtuvPa42GQciMCtb8rWtff
         T56hLVMzbANMVRr9jAYbjE0Hhp41GCzLeGyLKVbaJjl1U3dpdeLdjuhn0ZwyItVTW5Pj
         uNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679605827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vb8xGekqLZEVswI0VXnWBbiOZDnEjcKbHS0+1g7cZR4=;
        b=ayHfHj9j51P2f2jB0hSVCpjEKIBnkoYh4tR5ILVwiN6ZhsUT4FwnQyZMpvBiuhj0Mu
         gfgo4vi5rj5zpWbCg7QfdQr0Ul9f2CSqcUDL4GaUfkH4mlpSw6lidy6e4tQ7mrIOs+oK
         Q9ryPz50G0u7U905cWQ3jTPywnWBnnYb+3jHY37hBIcjOhEeE6QfEPiaI/laVrp2PqqT
         nJ0IzSHsr+aBpSDdC5uUFviGqvJH4Rw01fIPLMv6IWiekhdJLljPYwLX3rb5sqPYsh1q
         fEKGC+WbItTfKcIHUzjOzlwV9MaEnGMCV7SuM5cnAUKJ7nYoBK6LaMZa/j5cYIxCZN2b
         VXmA==
X-Gm-Message-State: AAQBX9dFbfaTje+vInBOWcL/XFQnMgrUIZfFcD9VNx6oENa4fm/1b6fr
        52VBrQfExzM9rGiq8Oxgbq1ctg1JXf8rug==
X-Google-Smtp-Source: AKy350bu4TW4l20Z3Ldxb/R0F1xir4olYbbOOl5RxmNznamXu2tiEKHzmbLClVF0jJHQciyDqGDlbu6V9qqTdg==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a81:a782:0:b0:541:a17f:c77d with SMTP id
 e124-20020a81a782000000b00541a17fc77dmr2498836ywh.10.1679605826783; Thu, 23
 Mar 2023 14:10:26 -0700 (PDT)
Date:   Thu, 23 Mar 2023 14:10:16 -0700
In-Reply-To: <20230323140942.v8.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230323140942.v8.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230323140942.v8.2.Ief9a81a3643d2291f6db2b3695c3a6e0159467dc@changeid>
Subject: [PATCH v8 2/4] Bluetooth: Add vhci devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>,
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

Add devcoredump support for vhci that creates forcce_devcoredump debugfs
entry. This is used for mgmt-tester tests.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

Changes in v8:
- Update vhci_coredump_hdr() to use skb

Changes in v7:
- New patch in the series

 drivers/bluetooth/Kconfig    |  1 +
 drivers/bluetooth/hci_vhci.c | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 5a1a7bec3c42..7bc7a765ad69 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -363,6 +363,7 @@ config BT_HCIBLUECARD
 
 config BT_HCIVHCI
 	tristate "HCI VHCI (Virtual HCI device) driver"
+	select WANT_DEV_COREDUMP
 	help
 	  Bluetooth Virtual HCI device driver.
 	  This driver is required if you want to use HCI Emulation software.
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index c443c3b0a4da..1c3c27b7e9b6 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -278,6 +278,67 @@ static int vhci_setup(struct hci_dev *hdev)
 	return 0;
 }
 
+static void vhci_coredump(struct hci_dev *hdev)
+{
+	/* No need to do anything */
+}
+
+static void vhci_coredump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	char buf[80];
+
+	snprintf(buf, sizeof(buf), "Controller Name: vhci_ctrl\n");
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Firmware Version: vhci_fw\n");
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Driver: vhci_drv\n");
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Vendor: vhci\n");
+	skb_put_data(skb, buf, strlen(buf));
+}
+
+static ssize_t force_devcoredump_write(struct file *file,
+				       const char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	struct vhci_data *data = file->private_data;
+	struct hci_dev *hdev = data->hdev;
+	struct sk_buff *skb = NULL;
+	char buf[512];
+	int ret;
+
+	ret = simple_write_to_buffer(&buf, sizeof(buf), ppos, user_buf, count);
+	if (ret < count)
+		return ret;
+
+	skb = alloc_skb(count, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+	skb_put_data(skb, &buf, count);
+
+	hci_devcoredump_register(hdev, vhci_coredump, vhci_coredump_hdr, NULL);
+
+	ret = hci_devcoredump_init(hdev, skb->len);
+	if (ret) {
+		BT_ERR("Failed to generate devcoredump");
+		kfree_skb(skb);
+		return ret;
+	}
+
+	hci_devcoredump_append(hdev, skb);
+	hci_devcoredump_complete(hdev);
+
+	return count;
+}
+
+static const struct file_operations force_devcoredump_fops = {
+	.open		= simple_open,
+	.write		= force_devcoredump_write,
+};
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -355,6 +416,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
 				    &aosp_capable_fops);
 
+	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
+			    &force_devcoredump_fops);
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.40.0.348.gf938b09366-goog

