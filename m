Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B5660319C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJRRbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJRRa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:30:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA000915DB;
        Tue, 18 Oct 2022 10:30:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so33957607ejb.13;
        Tue, 18 Oct 2022 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYKgG0LMSWdFCkFBvpgRCf6xvkpxbpR1Y/IhJK8NIQk=;
        b=HlF4hL5iJ0McEsINo0CIpDmn5mHEL7FCDLnYfBFBjGn+1S9Yq2LICxyUcSaDTubjcW
         Xn+BqsTNgFP7tkspSlClvwW4KJPsVw6FWA10jhUaD+6eCNqPLiHqrmtwPnt2eymHcV6d
         O4IfcOQ9GP6AB1gUPbc0xTfp/aoLScJDYpdSXq0s/Fga2VNqgP699aLqRD9kbS9y2Dhv
         +zWSiuRawtuj6qEb9z+f4AGLxTBXtwsDCQk4wU6HK5H4hleKKSKh5DHOAd9GDFX64sDd
         NZLT3pGtbr1EY7lnNL/34sgx8U1kzmIRLfyKPBVjFEnaS+am+3M2DI9D+ryXCI3KhNso
         cNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYKgG0LMSWdFCkFBvpgRCf6xvkpxbpR1Y/IhJK8NIQk=;
        b=AgUeybB1n7mRO48rRf5vV1yWMoESdNLe3hYkSshEKEHvEjaf61kdN/EETiIczwOPNa
         AYmM+1QLUDdKSS/aO8WBq7piRSXinZfqT8hqe3oPwlAZOPX9vTjm8h7GJ39p4Eer6bgb
         PC3kzsM1Ax7ddfEK9jS023BF3/W7YuxdPUWkmYWvq5ZUXCnyKwJScSSA1SI88wmOHcYP
         E/218JEmF+MlXJqF+K4s6QxAqzYpYBf6GWfUyLlUY/XUdpzQKOLnwmNdAsAgVyAqgiit
         /DjH4QzTZKGJzanNkF46oBfYQvK5aqG4t99z4qcvOq3Dwtprih0g6uI9PU0+cUZuQhxD
         geLQ==
X-Gm-Message-State: ACrzQf3ZUZ6VKiU2hokaCE27dnwFSQveym5YIOkgwQNyVRPtKbiS4fBm
        qNzkQQGw7r/sJsFAQz1XZ00=
X-Google-Smtp-Source: AMsMyM6Xo5Xp1kS9xHvNlSLxvSCRACinwxbQv1M0TwoK3FbxlR0uOSqjtwL1FuWFL90ah4X0KRX43Q==
X-Received: by 2002:a17:907:7618:b0:78d:ad63:2828 with SMTP id jx24-20020a170907761800b0078dad632828mr3472662ejc.27.1666114255277;
        Tue, 18 Oct 2022 10:30:55 -0700 (PDT)
Received: from NB-100745.open-synergy.com ([2a02:8109:9cc0:1f6c:99ac:492:d524:d338])
        by smtp.gmail.com with ESMTPSA id q5-20020aa7d445000000b0044bfdbd8a33sm9157683edr.88.2022.10.18.10.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 10:30:54 -0700 (PDT)
From:   Igor Skalkin <igor375@gmail.com>
X-Google-Original-From: Igor Skalkin <Igor.Skalkin@opensynergy.com>
To:     virtualization@lists.linux-foundation.org, luiz.dentz@gmail.com,
        mst@redhat.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, jasowang@redhat.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>
Subject: [PATCH v2 1/1] virtio_bt: Fix alignment in configuration struct
Date:   Tue, 18 Oct 2022 19:30:50 +0200
Message-Id: <20221018173050.581812-2-Igor.Skalkin@opensynergy.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221018173050.581812-1-Igor.Skalkin@opensynergy.com>
References: <20221018173050.581812-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current version of the configuration structure has unaligned
16-bit fields, but according to the specification [1], access to
the configuration space must be aligned.

Add a second, aligned  version of the configuration structure
and a new feature bit indicating that this version is being used.

[1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf

Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
---
 drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
 include/uapi/linux/virtio_bt.h |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 67c21263f9e0..35f8041722c8 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -306,7 +306,12 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_VND_HCI)) {
 		__u16 vendor;
 
-		virtio_cread(vdev, struct virtio_bt_config, vendor, &vendor);
+		if (virtio_has_feature(vdev, VIRTIO_BT_F_CONFIG_V2))
+			virtio_cread(vdev, struct virtio_bt_config_v2,
+				     vendor, &vendor);
+		else
+			virtio_cread(vdev, struct virtio_bt_config,
+				     vendor, &vendor);
 
 		switch (vendor) {
 		case VIRTIO_BT_CONFIG_VENDOR_ZEPHYR:
@@ -339,8 +344,12 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_MSFT_EXT)) {
 		__u16 msft_opcode;
 
-		virtio_cread(vdev, struct virtio_bt_config,
-			     msft_opcode, &msft_opcode);
+		if (virtio_has_feature(vdev, VIRTIO_BT_F_CONFIG_V2))
+			virtio_cread(vdev, struct virtio_bt_config_v2,
+				     msft_opcode, &msft_opcode);
+		else
+			virtio_cread(vdev, struct virtio_bt_config,
+				     msft_opcode, &msft_opcode);
 
 		hci_set_msft_opcode(hdev, msft_opcode);
 	}
@@ -387,6 +396,7 @@ static const unsigned int virtbt_features[] = {
 	VIRTIO_BT_F_VND_HCI,
 	VIRTIO_BT_F_MSFT_EXT,
 	VIRTIO_BT_F_AOSP_EXT,
+	VIRTIO_BT_F_CONFIG_V2,
 };
 
 static struct virtio_driver virtbt_driver = {
diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
index a7bd48daa9a9..af798f4c9680 100644
--- a/include/uapi/linux/virtio_bt.h
+++ b/include/uapi/linux/virtio_bt.h
@@ -9,6 +9,7 @@
 #define VIRTIO_BT_F_VND_HCI	0	/* Indicates vendor command support */
 #define VIRTIO_BT_F_MSFT_EXT	1	/* Indicates MSFT vendor support */
 #define VIRTIO_BT_F_AOSP_EXT	2	/* Indicates AOSP vendor support */
+#define VIRTIO_BT_F_CONFIG_V2	3	/* Use second version configuration */
 
 enum virtio_bt_config_type {
 	VIRTIO_BT_CONFIG_TYPE_PRIMARY	= 0,
@@ -28,4 +29,11 @@ struct virtio_bt_config {
 	__u16 msft_opcode;
 } __attribute__((packed));
 
+struct virtio_bt_config_v2 {
+	__u8  type;
+	__u8  alignment;
+	__u16 vendor;
+	__u16 msft_opcode;
+};
+
 #endif /* _UAPI_LINUX_VIRTIO_BT_H */
-- 
2.37.2

