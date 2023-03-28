Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782096CC800
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjC1Qam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjC1Qa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:30:27 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A514CC2D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:30:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id f6-20020a170902ce8600b001a25ae310a9so2280875plg.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680021026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sVqYiqqONgJinnmUNat86CZDMiZZiJLuOgYyNlqZ0G4=;
        b=LP2JH1/h7tcgzYCUI8SVxWvVevFsuhPAFOGD0UMm28p0GOSF7qsbuFk1YryWGoucKc
         pUB+rVpAyeht5JL2DWUne2HbBYviLccsU/L6WaDcgCHO636JkjRqS3Bda18reMmA7dZg
         vDtzF2/sYwXsd7PGNEXvdtbB+mM/Wz9REbcE9P+hTVWDJeGf6R8NipvWfvvHh4SztX+F
         pHw1H31eOrtPTklrmSXrZi+nmpox13UqHEM8Ij2/kSETpatfpjpO5Lu1CzhTc0iER8NL
         dBNq0p2IgVkJv7VnRehU6lsg72vnQ5UgP995GES08EZJQ7HQqkHZqyPqfvSGJNstMYze
         fcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVqYiqqONgJinnmUNat86CZDMiZZiJLuOgYyNlqZ0G4=;
        b=NfZGp2ObVRpVtqNSi1BjDQW71tp903C8cUA8orepFBM/q7kx0yKhajL3LSIRo5VuZf
         VpftHBW2fac89J7QNZfMuAZFNiRBkF2rma/2SiA3X+DFkVdn79RfiKNG5Gsn87OpFHvQ
         sn8WiGsCJANnP1W0Ubax1JbKR27azniTw1ucwJTsTd9yvijE+9lgDM4Irybo69C5p/t9
         PFlFfpn3BOQK0xAjOCkkMam/pAoaPpa5OZOD1hdU8wou/HtW+IqH4yrvtb3iVQd7920Z
         9PLP7gCbqjyDKTgrPQgMuA+CeXXS0BZSs2gkqhAGmEB72i0b5t45IsTt0oqoyPT1EJsD
         nbOw==
X-Gm-Message-State: AAQBX9fUyvwgPQBBlPhlddzNn8MhSYTyZkoJodY29sHjKf3Hz0uhUSNx
        2M3KZEhRzI6h8Ie5fIjC2YZPtOgjX6dPug==
X-Google-Smtp-Source: AKy350YyPBs8oUKKHE8mENWLtrXAGS/JHKzzoV1fN4pLTzMieRozm3qE4mqv/+Pg5EnlqcUzYRQR/m8XWFM9Lw==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a05:6a00:2e9a:b0:624:1261:918f with SMTP
 id fd26-20020a056a002e9a00b006241261918fmr7951619pfb.1.1680021026093; Tue, 28
 Mar 2023 09:30:26 -0700 (PDT)
Date:   Tue, 28 Mar 2023 09:30:17 -0700
In-Reply-To: <20230328093000.v10.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230328093000.v10.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328093000.v10.2.Ief9a81a3643d2291f6db2b3695c3a6e0159467dc@changeid>
Subject: [PATCH v10 2/4] Bluetooth: Add vhci devcoredump support
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

(no changes since v9)

Changes in v9:
- Rename hci_devcoredump_*() to hci_devcd_*()

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
index c443c3b0a4da..a265dcaf8275 100644
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
+	hci_devcd_register(hdev, vhci_coredump, vhci_coredump_hdr, NULL);
+
+	ret = hci_devcd_init(hdev, skb->len);
+	if (ret) {
+		BT_ERR("Failed to generate devcoredump");
+		kfree_skb(skb);
+		return ret;
+	}
+
+	hci_devcd_append(hdev, skb);
+	hci_devcd_complete(hdev);
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

