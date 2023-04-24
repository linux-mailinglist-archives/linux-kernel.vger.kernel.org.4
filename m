Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF3A6EC3AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 04:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjDXChp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 22:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXChn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 22:37:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432E210C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 19:37:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso3220387b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 19:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682303861; x=1684895861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rG7y1ORd4NtyVKliopoYVE2xbqXOKPkKKGLmGbF+jLI=;
        b=O4hqeXacnk2fOZT8On/zA3U3lWtWd+XVCSssK+wNGOlJr/ZvJxGE3hu2DBS9+XSLgK
         ZsH8imVp1fVdEifHYu9SRsibeP1EtgOtuIVhnpfIYW6/CWVDpMlL1R5jpYBxrI4NsvCy
         8wT0Q0yNBOtSCIb+tFStFXInQepsADd9Fp93Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682303861; x=1684895861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rG7y1ORd4NtyVKliopoYVE2xbqXOKPkKKGLmGbF+jLI=;
        b=R/UssUBvbK+Xjg/z2zlkoMnEQ5B/FqwJiKw5Pn70p70ZfYF3IAwwvHFwqfeAcJ3kEF
         NeAteUtsN0JHVAhH9JFM3BM+zFr6nv1ynXpucmNc8QQv1RCV9VGR52t5zXxBgV5/e75U
         91BTMnBt0KAYgEpyT3yVolLCnBzMhcnnqol9yHNbwPieTRusVq6rWz8OzlI0aasoXrTP
         9yWyWgEYX7XRxDsXdgcRvvBJcKmhPyk9JTlvYqfy2pHDxaxu7iuIfAaNXrKVwK/sJHjY
         /NiUW4BV+FeLoJOtwMIGVmKS+dEIXoddlFAKnhR/axCFuLhnIOaQXihijPzwVAtIfatG
         GsMA==
X-Gm-Message-State: AAQBX9fpS003xCQRjgh+jNmuUhRLrMTbKt4u4IqukfV6sckxu7vbbJl7
        QMWOExLIOsVcT9HLGtVGHBYOeEXS5ixrt/k8KUw=
X-Google-Smtp-Source: AKy350bBnftD/HHy8rxOUm/7IuGBVYV9DNYJ5mqlC0VSZP3qeMq0uM3/KUA4IzpkxWMZ4DXAixuDiQ==
X-Received: by 2002:a05:6a00:2448:b0:63b:7a55:ae89 with SMTP id d8-20020a056a00244800b0063b7a55ae89mr16079280pfj.27.1682303861242;
        Sun, 23 Apr 2023 19:37:41 -0700 (PDT)
Received: from lschyip920.tpe.corp.google.com ([2401:fa00:1:10:bfaf:abfa:f282:5b11])
        by smtp.gmail.com with ESMTPSA id m30-20020a62a21e000000b0063aa1763146sm6459443pff.17.2023.04.23.19.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 19:37:40 -0700 (PDT)
From:   Sung-Chi Li <lschyi@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     phoenixshen@chromium.org, chentsung@chromium.org,
        Sung-Chi Li <lschyi@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH] HID: google: add jewel USB id
Date:   Mon, 24 Apr 2023 10:37:36 +0800
Message-ID: <20230424023736.338464-1-lschyi@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 1 additional hammer-like device.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---

 drivers/hid/hid-google-hammer.c | 2 ++
 drivers/hid/hid-ids.h           | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 7ae5f27df54d..c6bdb9c4ef3e 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -586,6 +586,8 @@ static const struct hid_device_id hammer_devices[] = {
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_EEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_JEWEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MAGNEMITE) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c2e9b6d1fd7d..c40cd6f1095f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -528,6 +528,7 @@
 #define USB_DEVICE_ID_GOOGLE_MOONBALL	0x5044
 #define USB_DEVICE_ID_GOOGLE_DON	0x5050
 #define USB_DEVICE_ID_GOOGLE_EEL	0x5057
+#define USB_DEVICE_ID_GOOGLE_JEWEL	0x5061
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
-- 
2.40.0.634.g4ca3ef3211-goog

