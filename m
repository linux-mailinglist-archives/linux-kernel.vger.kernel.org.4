Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C415B6CC801
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjC1Qap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjC1Qaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:30:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F60CC2D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:30:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5425c04765dso124921307b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680021028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=iHSKdWsbQy/GeVzBB8qj+guo53lEw4PtllPBGrE0VU/M2dkD23/QOZGGuR0wKM1woY
         xoRId10Gu9qAKC5ovRdE30LmAdcD4GA4VgwOvURL5CKioWDBdCPVcAgPqKSm/GnRBLC6
         Wr1asA9XzPKSlnb3CkPAvOeE1DSAsxamg7910KDePodfi8AFZRY98KL1TEJ0DhKqnY9i
         Ff4neDE62XKXPZQYmz8aDY8qlxjyhhLp9tWIv3nrlugxV+bmhh+Xng2r74fru7LZ/LPQ
         jsNBwK15z+3dffzyJ4LfvNokbOI11Gq4phqSvLhgy0v7wXktgPHVTH0LyaUBlCRQ1y46
         hZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=DHXvgeAYJ9GdIPGc2g14iM44IrZNU4ukvG8W+6x0SJAzOGsohY4mr2LRrSNGBfB7DW
         TL+HU4EE0mpgTyiRaSDb6dnlEiV2XrGK3+LpIL5qJDhRl5LQRevW9fc9t+fMU9zzkLxw
         SNwL7+zpnEyYlRzOnRs7BcmorcSoK46Z+67RIYT5vlBEQuCcMrUEyz48W6Aa3IxNWtjF
         RWQHzZ04sgGr7/NWIA20SqXL9VsUBgbaTy9kXT5kklxESNMcNk31IzrK1BPZGmSe/PPs
         daHsInjpgGG+hmJC8VEcmhsNN8A3nrM2ofz0OGx6QiCxYukjZk+bhdoQQgJhhMlPUC2T
         lWjg==
X-Gm-Message-State: AAQBX9dxYjF0qSfMCIWqsnAgSzlZKDwyexTOBwPsD3uZ1GBJWF+BP0+R
        IVaBByZrZxxR38XY8CkD/YPCRe0ueMfzqQ==
X-Google-Smtp-Source: AKy350Y+wvZPoh9LYygwBjPZLYtS2gxTdz4mEbJFt4wl+JyIyElkUuBFLZepi30FgdKKeHfY3LJ+7SitnobFzw==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a05:6902:154e:b0:b77:d2db:5f8f with SMTP
 id r14-20020a056902154e00b00b77d2db5f8fmr10015853ybu.12.1680021027873; Tue,
 28 Mar 2023 09:30:27 -0700 (PDT)
Date:   Tue, 28 Mar 2023 09:30:18 -0700
In-Reply-To: <20230328093000.v10.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230328093000.v10.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328093000.v10.3.I8cd97c192e8268567b6f467ccd993ec71897318e@changeid>
Subject: [PATCH v10 3/4] Bluetooth: btusb: Add btusb devcoredump support
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

