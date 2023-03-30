Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1936D0C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjC3Q6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjC3Q6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:58:38 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FBFC646
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:58:34 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id kp6-20020a170903280600b001a2945a7fdeso591109plb.18
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680195514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OjsY2D3zZ2sjOJI/DMM6//97spV+E6fw5UYIqOUq7z8=;
        b=DlRsfLib3MyZOsvAB3d+LRxd3sJ3tfd82aIAV16K+bg69XGehev1j24XodH2+gB2Fv
         TgzValaNfP6Fy1Djs680Qj6e/SHt1q4W7lR/Wj3r12re91ZdecNufAhp9Zb9jZEOzrrv
         Go1Bu72a61FMG4o6ySc7eoZnAyNoLhqmRFIX5KMoE5R6GDO24mvhgLorov7dEVh1Prlp
         jIcyDmUEEDmacvxtQWdsH3rrHejdTXtjrivccx2r59DHBbShXfouojUg83KRjVL9S6X7
         mn5bDrBo+lwfBKTdZF65rTYX2g2iPB9xDix3e/R0RqCG/4RInxU/sN/RML8DoOuBpO4M
         FAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680195514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjsY2D3zZ2sjOJI/DMM6//97spV+E6fw5UYIqOUq7z8=;
        b=XcKND9nTKdodnBa6rlpNqhaB6TZtvoh7DBGXN6twLssZzNu2bFrccfidmkgtrvrEPr
         /Eiiknr+o5a/DFtAXjXb4LFveYME4W9Ff5rlLvXsE3+bKpaZrB2Ycc4snebsxZrV9pL/
         GPFrmMIkzwmTxCwbo9Csis/epOoK2fyVejX37wo8CK9osLCWjtfx5TpOKcoJ/mxScuAh
         5oqPeFryHHxGI2nckCOMTNjbl/jbDcCH9OlcCFchQHCGl1Aup4TA9rKlxtb8tUN8D+kh
         HFtI5QD2RsfR3eHonv2MP//UDzPbrLRaLXW1YNv/lUdsyPLhASDNs94zcwAxpzkezSZR
         hMSw==
X-Gm-Message-State: AAQBX9eEMlA8tgStkEaOZCU3IBuiEgoD6otVDB8Fmj6Hj2t41PMMn5ZQ
        oi8LbREq7Kc4C3yNoF2LgsMOG4bUSjpJzQ==
X-Google-Smtp-Source: AKy350bT6+eQmZAojALY3eocg4enim01apzdl+bV09oTdD8MFcOcFvr3LeYYs09OTvUIvMpYt/PJdDqoiqOphA==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a05:6a00:98e:b0:625:f78a:56f with SMTP id
 u14-20020a056a00098e00b00625f78a056fmr3075727pfg.3.1680195513805; Thu, 30 Mar
 2023 09:58:33 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:58:24 -0700
In-Reply-To: <20230330095714.v13.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230330095714.v13.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330095714.v13.2.Ief9a81a3643d2291f6db2b3695c3a6e0159467dc@changeid>
Subject: [PATCH v13 2/4] Bluetooth: Add vhci devcoredump support
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

Changes in v13:
- Add force_devcd_timeout() to update the devcoredump timeout

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
 drivers/bluetooth/hci_vhci.c | 97 ++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

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
index c443c3b0a4da..691fe93b1976 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -278,6 +278,100 @@ static int vhci_setup(struct hci_dev *hdev)
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
+static inline void force_devcd_timeout(struct hci_dev *hdev,
+				       unsigned int timeout)
+{
+#ifdef CONFIG_DEV_COREDUMP
+	hdev->dump.timeout = msecs_to_jiffies(timeout * 1000);
+#endif
+}
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
+		force_devcd_timeout(hdev, dump_data.timeout);
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
@@ -355,6 +449,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
 				    &aosp_capable_fops);
 
+	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
+			    &force_devcoredump_fops);
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.40.0.348.gf938b09366-goog

