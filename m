Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691336A64C2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCABZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCABY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:24:58 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F26D34029;
        Tue, 28 Feb 2023 17:24:57 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id i9so15674353lfc.6;
        Tue, 28 Feb 2023 17:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5cRFm227imHx7peNmst/t/e9LH/4Jc6EGknoWY1kPI=;
        b=YxXq+ZrONLGpm82Yc3EQGO1MTc1p61AIuW59S8oWyZt90bM5PTWVJuDcOKuC0kSGpU
         cz04FSxB3oA7Ic82K7KD9sgKHUiFUs8SRUn0CX4U0q81VlpjKqU7FubJyAnPkrHeEM2e
         C9894qk47RMQ8qu8sFNVo+tz8nWN4xfinbQHtrc6fj63SDjwb+7E2Zo+U4im5m8iTLWt
         8EKqnko+W74WvapZiv/wLJwl1Imysvcc6/z5weDdtpYOzBkHhgBUc24ATjbugbSQ8H/5
         zjZfViGxhmh4uEimiDU6y6dbFwKc0tj74XdpoDA/y/3I5XHvLp+1T4ULHG7foikBM/i3
         92eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5cRFm227imHx7peNmst/t/e9LH/4Jc6EGknoWY1kPI=;
        b=qMypNFCSDAs/gD+nvopCW6jVfyTioD7chnNxgle8rPPPMsnB5Kn+lcYtLVLx9f0rXQ
         6KQgqASVLCG+c6gapMEcJ7F5Wi9haW7L+nnZKC+3TlGdQIixH8U+fsT4YuPAf/yfCCIP
         RzWeXx2jUBSto89alQtbphIa4xeKUDhKZK0j3/Pm9jVnzbbWR8p07ql02j1cfCcpXp5J
         qLbdzko8vvOzloaTVXNdYFRJyReOK5hsQOUdfj+MeYm/HaczinVsNDABbVmz9nqNjh8q
         QkLnYyeBE9cPeSZNcmfJIBNCl66o5BiPTjjS9j11d5m66XhdmaSGXvLcmGMKSKAsuAgk
         He/A==
X-Gm-Message-State: AO0yUKV6WqU4WbUOiZUqClQDP5APPfEiwpdo451oqiaLmarvTIQxuSVE
        HSNt5NRL77yyEj+bCcyMG+p3zbB5zi5r2Q==
X-Google-Smtp-Source: AK7set9RpoQ6aX9+ikYCbReDL3BEUCND4kdDw+DKXX65EZCVJS0OqWqTQoqMuOYc4ZgmrsfoeMnFJA==
X-Received: by 2002:ac2:5690:0:b0:4db:3e2d:3efc with SMTP id 16-20020ac25690000000b004db3e2d3efcmr1266275lfr.10.1677633895729;
        Tue, 28 Feb 2023 17:24:55 -0800 (PST)
Received: from rafal-laptop.. (user-5-173-64-27.play-internet.pl. [5.173.64.27])
        by smtp.gmail.com with ESMTPSA id d2-20020ac25ec2000000b004db0d97b053sm1517700lfq.137.2023.02.28.17.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 17:24:55 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Szalecki?= <perexist7@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Szalecki?= <perexist7@gmail.com>,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 1/1] HID: logitech-hidpp: Add support for Logitech MX Master 3S mouse
Date:   Wed,  1 Mar 2023 02:23:56 +0100
Message-Id: <20230301012356.940756-1-perexist7@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add signature for the Logitech MX Master 3S mouse over Bluetooth.

Signed-off-by: Rafał Szalecki <perexist7@gmail.com>
---
Hello,

I'm sending the patch to add the support for Logitech MX Master 3S mouse. The main reason for adding the support for this mouse was to enable high precision scrolling as it is now supported by Wayland composers. Tested with KDE 5.27. High precision scrolling was configured with Solaar and successfully tested with Brave browser.

 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 25dcda76d6c7..5fc88a063297 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4399,6 +4399,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a) },
 	{ /* MX Master 3 mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
+	{ /* MX Master 3S mouse over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb034) },
 	{}
 };
 
-- 
2.37.2

