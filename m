Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574DC6CFB35
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjC3GFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC3GFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:05:31 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195571BD6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:05:30 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id i192-20020a6287c9000000b0062a43acb7faso8187437pfe.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680156329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TK8Pqe0H+wW+YnvKs1zy8YAiRGfAiSTpV51i3utUysc=;
        b=h9lxmeemslc/r3j5gvXGGV9f8TmhgLBo5oI2zh7aWCaA57qPjSqnjvi5YsYXyeQCI5
         9XAFo2V7zUVJ8tp9VRBUmPecgoizE23wvj5ZXqCMXrLK+cqkFr6Ir4/WHl9ZRz5P/EPp
         zvI5+alEbzOjV2WARNb6Q/cehw4UXwTu5zvCO2Qs2hr8rJbe0rvIdHUHZVu5T5e1tdTc
         /mL6K2/EHi9njWwBmLXWWF0CGqOYLehd+eym4guf1MjAADy2UocGylIGicIAWCfQQXHm
         NJZrCXqYgolWqGi/D2UuC9nA7eV4hAIQWM99L0KAAkZ5/0MsCt02olwEV2RpD9IQYi/h
         kqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680156329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TK8Pqe0H+wW+YnvKs1zy8YAiRGfAiSTpV51i3utUysc=;
        b=jLQUiHwx+/NWnc4s4zR3jj3UoGEtyKD2GY+whWI+5xH1VeH3kBHTrcjmTUqIA2iNC5
         lCawvWLbTFtEzNYoWxPKkdtFl8v4AZ5rPtucY+hsLl27o0RlngtPicUfHEZrD8TLcN/C
         MId0yyxkPasA8yo+GVSxnZjRRdrULOARSuRz6dqfGdy1wOYgJ0iaospTSqRP7Pl1zow0
         0lgaReBqQdgS5XMGXS2//odIUF76SBBias+JkJaNhvWu3O2Ykc4h6y6/05O3xDRNifny
         k998e2KUhuPaFZJ1URd/ZLkF5E+41IwvKuccH8HDH4z4YOlLvJniyDMDUwE4+j0J1qlO
         TzWw==
X-Gm-Message-State: AAQBX9cbUCGUzsOjEvS8DnaQnSzvuvO/aex7tYZ1D0VIXnedNVTOGX7m
        CkQHq59UoY0ToJMz+mcJaAsseTiwNK3XTg==
X-Google-Smtp-Source: AKy350YnWaimCIE2Mx4jWxiWQLtr5mH+8xCn8mMe0yJOvKHm6H7Mlqt6rlBVmVI2CSR1RraVtGW0Mt82HYmH3w==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a05:6a00:2d1d:b0:61c:67d2:a332 with SMTP
 id fa29-20020a056a002d1d00b0061c67d2a332mr2559597pfb.3.1680156329537; Wed, 29
 Mar 2023 23:05:29 -0700 (PDT)
Date:   Wed, 29 Mar 2023 23:05:21 -0700
In-Reply-To: <20230329230447.v12.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230329230447.v12.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230329230447.v12.2.Ief9a81a3643d2291f6db2b3695c3a6e0159467dc@changeid>
Subject: [PATCH v12 2/4] Bluetooth: Add vhci devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
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

Changes in v12:
- Rename force_devcoredump_write() to force_devcd_write()
- Update force_devcd_write() to handle coredump state and timeout

Changes in v9:
- Rename hci_devcoredump_*() to hci_devcd_*()

Changes in v8:
- Update vhci_coredump_hdr() to use skb

Changes in v7:
- New patch in the series

 drivers/bluetooth/Kconfig    |  1 +
 drivers/bluetooth/hci_vhci.c | 89 ++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

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
index c443c3b0a4da..3aaf9a64ffe9 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -278,6 +278,92 @@ static int vhci_setup(struct hci_dev *hdev)
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
+#define MAX_COREDUMP_LINE_LEN	40
+
+struct devcoredump_test_data {
+	enum devcoredump_state state;
+	unsigned int timeout;
+	char data[MAX_COREDUMP_LINE_LEN];
+};
+
+static ssize_t force_devcd_write(struct file *file, const char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct vhci_data *data = file->private_data;
+	struct hci_dev *hdev = data->hdev;
+	struct sk_buff *skb = NULL;
+	struct devcoredump_test_data dump_data;
+	int ret;
+
+	ret = simple_write_to_buffer(&dump_data, sizeof(dump_data), ppos,
+				     user_buf, count);
+	if (ret < count)
+		return ret;
+
+	skb = alloc_skb(sizeof(dump_data.data), GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+	skb_put_data(skb, &dump_data.data, sizeof(dump_data.data));
+
+	hci_devcd_register(hdev, vhci_coredump, vhci_coredump_hdr, NULL);
+
+	/* Force the devcoredump timeout */
+	if (dump_data.timeout)
+		hdev->dump.timeout = msecs_to_jiffies(dump_data.timeout * 1000);
+
+	ret = hci_devcd_init(hdev, skb->len);
+	if (ret) {
+		BT_ERR("Failed to generate devcoredump");
+		kfree_skb(skb);
+		return ret;
+	}
+
+	hci_devcd_append(hdev, skb);
+
+	switch (dump_data.state) {
+	case HCI_DEVCOREDUMP_DONE:
+		hci_devcd_complete(hdev);
+		break;
+	case HCI_DEVCOREDUMP_ABORT:
+		hci_devcd_abort(hdev);
+		break;
+	case HCI_DEVCOREDUMP_TIMEOUT:
+		/* Do nothing */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations force_devcoredump_fops = {
+	.open		= simple_open,
+	.write		= force_devcd_write,
+};
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -355,6 +441,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
 				    &aosp_capable_fops);
 
+	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
+			    &force_devcoredump_fops);
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.40.0.348.gf938b09366-goog

