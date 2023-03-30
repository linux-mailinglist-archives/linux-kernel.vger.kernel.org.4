Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F96CFB38
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjC3GFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC3GFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:05:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29F51BD6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:05:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-545e529206eso119414537b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680156333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdWPjBXZOPMosgtbDYXpGuXQ6q7Yes9wR9g9zEmd0+Y=;
        b=TkhZ6ElIxgEP5ihEto1sbio6fSUafe5E/dxy+pa8qEfBmYJJv1z0LapLSccg5PPdsN
         b/7drndQEdYeQwTa0X9ppt7i3Zyh9BdsWfWzyZGmJ541cfIw/DzBkREDnA4IDNcM/iks
         iokhrgPzYn2fDxMwKfq2DsqA7BC4EZAgYbOPhOtgpXwTZE+Ud8ajrSeFhgLJ8EM0oWAs
         pZZndS/exGwD1/uzjpBdCGLwn0gh6tVbU3Yt5CyvlmOYa4v7S0I+JUoHvY5bqYVcTm/R
         dazKY3pJ+TkMPu+t/fN5B1SM6eKMsLLdg5HpmbRwQ3REfLbU9Fnt1rqqDiL4BrNaALTL
         WszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680156333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdWPjBXZOPMosgtbDYXpGuXQ6q7Yes9wR9g9zEmd0+Y=;
        b=6BSwUKMDiNl1VFlwYVFQKmLtU2ftqRvZ9wNdcdSKioLY46LvfngGiz/PJMpzptdP1Q
         AXUQc1k2zqKThhqv7YRKl3+2CGDaSYY2ZjEnyJ3BAJQr2+mnO6HX6RKHrTaPoQ3Rmj4g
         CTobtFOFC8cLVxsZY9ZnjdXh5lg/mU+wNjt9fhC/HtS40tVLQc8luqqZYO9N7l1eAR7r
         nXxS8K76+jQg+l+9nZDyY3vLZmhQVQ37SbscNrZ7KwGWsnIEfEZFhaWTibYH4Xa4uW4j
         Ivns8kB5Bq0IcJCkDktiI2T+StUJstiMxCOplH3YvwKeTBkrSRUjuBwyQj/n4QjlElDz
         d2Cw==
X-Gm-Message-State: AAQBX9fb27OXy8dftTr7kEFXsveEHb83GWNtVVLXe1m+I6DehMihmf1l
        +GMnVu5nRdKfDOMFLC0zu3YnxwpTulDbAw==
X-Google-Smtp-Source: AKy350YN58bTNUjqz6Duo9kClR22ueLENIS9/zrzovaZEoOaZXcWpcE5PLlUU3/4C4ahD6je3L0BTMtDEKr8Uw==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a05:6902:120f:b0:b73:caa7:f05e with SMTP
 id s15-20020a056902120f00b00b73caa7f05emr14533734ybu.2.1680156333104; Wed, 29
 Mar 2023 23:05:33 -0700 (PDT)
Date:   Wed, 29 Mar 2023 23:05:23 -0700
In-Reply-To: <20230329230447.v12.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230329230447.v12.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230329230447.v12.4.I8ac78c64382c66cdb49076a2053ef9c44ebf1ea3@changeid>
Subject: [PATCH v12 4/4] Bluetooth: btintel: Add Intel devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
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

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Intercept debug exception events from the controller and put them into
a devcoredump using hci devcoredump APIs. The debug exception contains
data in a TLV format and it will be parsed in userspace.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
---

(no changes since v9)

Changes in v9:
- Rename hci_devcoredump_*() to hci_devcd_*()

Changes in v8:
- Update btintel_dmp_hdr() to use skb
- Use driver name reference instead of copying it

Changes in v7:
- Update btintel_coredump() and btusb_intel_diagnostics()

Changes in v6:
- Implement btintel_coredump()

Changes in v4:
- Add btintel_coredump() placeholder

Changes in v2:
- Create a local struct to store coredump_info in btintel.c
- Call btintel_register_devcoredump_support() from btintel.c
- Fix strncpy() destination bound warning

 drivers/bluetooth/btintel.c | 72 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h | 12 +++++--
 drivers/bluetooth/btusb.c   | 54 ++++++++++++++++++++++++----
 3 files changed, 128 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index bede8b005594..19698d5c3c1c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -36,6 +36,12 @@ struct cmd_write_boot_params {
 	u8  fw_build_yy;
 } __packed;
 
+static struct {
+	const char *driver_name;
+	u8         hw_variant;
+	u32        fw_build_num;
+} coredump_info;
+
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -308,6 +314,9 @@ int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 		return -EINVAL;
 	}
 
+	coredump_info.hw_variant = ver->hw_variant;
+	coredump_info.fw_build_num = ver->fw_build_num;
+
 	bt_dev_info(hdev, "%s revision %u.%u build %u week %u %u",
 		    variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
 		    ver->fw_build_num, ver->fw_build_ww,
@@ -502,6 +511,9 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
+	coredump_info.hw_variant = INTEL_HW_VARIANT(version->cnvi_bt);
+	coredump_info.fw_build_num = version->build_num;
+
 	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", variant,
 		    2000 + (version->timestamp >> 8), version->timestamp & 0xff,
 		    version->build_type, version->build_num);
@@ -1453,6 +1465,59 @@ int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
 }
 EXPORT_SYMBOL_GPL(btintel_set_quality_report);
 
+static void btintel_coredump(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, 0xfc4e, 0, NULL, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Coredump failed (%ld)", PTR_ERR(skb));
+		return;
+	}
+
+	kfree_skb(skb);
+}
+
+static void btintel_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	char buf[80];
+
+	snprintf(buf, sizeof(buf), "Controller Name: 0x%X\n",
+		 coredump_info.hw_variant);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Firmware Version: 0x%X\n",
+		 coredump_info.fw_build_num);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Driver: %s\n", coredump_info.driver_name);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Vendor: Intel\n");
+	skb_put_data(skb, buf, strlen(buf));
+}
+
+static int btintel_register_devcoredump_support(struct hci_dev *hdev)
+{
+	struct intel_debug_features features;
+	int err;
+
+	err = btintel_read_debug_features(hdev, &features);
+	if (err) {
+		bt_dev_info(hdev, "Error reading debug features");
+		return err;
+	}
+
+	if (!(features.page1[0] & 0x3f)) {
+		bt_dev_dbg(hdev, "Telemetry exception format not supported");
+		return -EOPNOTSUPP;
+	}
+
+	hci_devcd_register(hdev, btintel_coredump, btintel_dmp_hdr, NULL);
+
+	return err;
+}
+
 static const struct firmware *btintel_legacy_rom_get_fw(struct hci_dev *hdev,
 					       struct intel_version *ver)
 {
@@ -2582,6 +2647,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			btintel_set_msft_opcode(hdev, ver.hw_variant);
 
 			err = btintel_bootloader_setup(hdev, &ver);
+			btintel_register_devcoredump_support(hdev);
 			break;
 		default:
 			bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
@@ -2655,6 +2721,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		btintel_set_msft_opcode(hdev, ver.hw_variant);
 
 		err = btintel_bootloader_setup(hdev, &ver);
+		btintel_register_devcoredump_support(hdev);
 		break;
 	case 0x17:
 	case 0x18:
@@ -2678,6 +2745,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 					INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
 
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
+		btintel_register_devcoredump_support(hdev);
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
@@ -2727,7 +2795,7 @@ static int btintel_shutdown_combined(struct hci_dev *hdev)
 	return 0;
 }
 
-int btintel_configure_setup(struct hci_dev *hdev)
+int btintel_configure_setup(struct hci_dev *hdev, const char *driver_name)
 {
 	hdev->manufacturer = 2;
 	hdev->setup = btintel_setup_combined;
@@ -2736,6 +2804,8 @@ int btintel_configure_setup(struct hci_dev *hdev)
 	hdev->set_diag = btintel_set_diag_combined;
 	hdev->set_bdaddr = btintel_set_bdaddr;
 
+	coredump_info.driver_name = driver_name;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_configure_setup);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 8e7da877efae..c34553fef3b0 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -150,6 +150,13 @@ struct btintel_loc_aware_reg {
 	__le32 delta;
 } __packed;
 
+#define INTEL_TLV_TYPE_ID		0x01
+
+#define INTEL_TLV_SYSTEM_EXCEPTION	0x00
+#define INTEL_TLV_FATAL_EXCEPTION	0x01
+#define INTEL_TLV_DEBUG_EXCEPTION	0x02
+#define INTEL_TLV_TEST_EXCEPTION	0xDE
+
 #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
 #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
@@ -219,7 +226,7 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params);
 int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
 			      const struct firmware *fw, u32 *boot_param);
-int btintel_configure_setup(struct hci_dev *hdev);
+int btintel_configure_setup(struct hci_dev *hdev, const char *driver_name);
 void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
 void btintel_secure_send_result(struct hci_dev *hdev,
 				const void *ptr, unsigned int len);
@@ -300,7 +307,8 @@ static inline int btintel_download_firmware(struct hci_dev *dev,
 	return -EOPNOTSUPP;
 }
 
-static inline int btintel_configure_setup(struct hci_dev *hdev)
+static inline int btintel_configure_setup(struct hci_dev *hdev,
+					  const char *driver_name)
 {
 	return -ENODEV;
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9c9f7bf1375a..414426314600 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2376,16 +2376,47 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	return btusb_recv_bulk(data, buffer, count);
 }
 
+static int btusb_intel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct intel_tlv *tlv = (void *)&skb->data[5];
+
+	/* The first event is always an event type TLV */
+	if (tlv->type != INTEL_TLV_TYPE_ID)
+		goto recv_frame;
+
+	switch (tlv->val[0]) {
+	case INTEL_TLV_SYSTEM_EXCEPTION:
+	case INTEL_TLV_FATAL_EXCEPTION:
+	case INTEL_TLV_DEBUG_EXCEPTION:
+	case INTEL_TLV_TEST_EXCEPTION:
+		/* Generate devcoredump from exception */
+		if (!hci_devcd_init(hdev, skb->len)) {
+			hci_devcd_append(hdev, skb);
+			hci_devcd_complete(hdev);
+		} else {
+			bt_dev_err(hdev, "Failed to generate devcoredump");
+			kfree_skb(skb);
+		}
+		return 0;
+	default:
+		bt_dev_err(hdev, "Invalid exception type %02X", tlv->val[0]);
+	}
+
+recv_frame:
+	return hci_recv_frame(hdev, skb);
+}
+
 static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
-		struct hci_event_hdr *hdr = (void *)skb->data;
+	struct hci_event_hdr *hdr = (void *)skb->data;
+	const char diagnostics_hdr[] = { 0x87, 0x80, 0x03 };
 
-		if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
-		    hdr->plen > 0) {
-			const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
-			unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
+	if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
+	    hdr->plen > 0) {
+		const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
+		unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
 
+		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
 			switch (skb->data[2]) {
 			case 0x02:
 				/* When switching to the operational firmware
@@ -2404,6 +2435,15 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 				break;
 			}
 		}
+
+		/* Handle all diagnostics events separately. May still call
+		 * hci_recv_frame.
+		 */
+		if (len >= sizeof(diagnostics_hdr) &&
+		    memcmp(&skb->data[2], diagnostics_hdr,
+			   sizeof(diagnostics_hdr)) == 0) {
+			return btusb_intel_diagnostics(hdev, skb);
+		}
 	}
 
 	return hci_recv_frame(hdev, skb);
@@ -4008,7 +4048,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	/* Combined Intel Device setup to support multiple setup routine */
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
-		err = btintel_configure_setup(hdev);
+		err = btintel_configure_setup(hdev, btusb_driver.name);
 		if (err)
 			goto out_free_dev;
 
-- 
2.40.0.348.gf938b09366-goog

