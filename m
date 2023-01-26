Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B156C67CAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbjAZMME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjAZMMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:12:02 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EDE69B22
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:12:01 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y19so1684281edc.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q79upilYUaTabLjtO3bZo14lYpmZpgLc63/mP4eG9WA=;
        b=OAQfmmoGQF9nB8ZfcKyXxyaWHRJX11Xof3DYunbo84PQLWL7/LTQ7CaHKLciNAQTt5
         4rcYuYqWzT59GU1VyKtOVQDVl30rYzrqC3jVc59DVtnY8oV+TdV/zvurtyjUKjpZ4BIp
         4dXfs+XQ+rupwImhp2ce/G0Ll+7Pgrc603aLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q79upilYUaTabLjtO3bZo14lYpmZpgLc63/mP4eG9WA=;
        b=KpyjYhEICtkjLwLMLVGEQ/eCwg2AsQzm7x/4sJ8c1d75XRCMlRM4X6HwW/YjOjFarj
         9HRXCvrU3y0LH0tUBQluqr+BSqlPNGGcWTUVJYfrqkCFA2kEH7zTyvN5w+LiD4tCdCuA
         NHg5cv3NU8309HOjWmBP1WlbUQdyGwuU/a07tnMom8QtDexX5jIBA4GHDdJjv1RoqdXs
         ONsOVyxluDoYoRIn/QOsPGcFfKf7iHFiaB9FlF+npxeZh6w3JkjQLKidt6fonTQRTKss
         P82gXpfY4wWQNLvbUl5MsFZXQZgKJM74Vihm5GQ4s51s5PIfg8vFYR9Vba5n2f/fgTqm
         +/BQ==
X-Gm-Message-State: AO0yUKWkKDT2yPZj9nFsDuwVgf+JCiXTiguLdtzEYemw8vASoaS3fOE/
        Lu/leC4YT6Sv5zWQ0Efy/wba5g==
X-Google-Smtp-Source: AK7set/RV50N96WMsCaAcARPhfwM7z9emlZm/nH0tlMwVFusCkz5W1dfy86jfgB9opXY0tNW53iZhA==
X-Received: by 2002:a05:6402:190:b0:4a0:8f60:4f46 with SMTP id r16-20020a056402019000b004a08f604f46mr9449504edv.15.1674735119667;
        Thu, 26 Jan 2023 04:11:59 -0800 (PST)
Received: from pborrello-1.vm.vusec.net (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id w11-20020a50fa8b000000b0049e09105705sm644044edr.62.2023.01.26.04.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 04:11:59 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
To:     Roderick Colenbrander <thunderbird2k@gmail.com>
Cc:     Pietro Borrello <borrello@diag.uniroma1.it>,
        linux-leds@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v2 4/5] HID: dualshock4_remove: manually unregister leds
Date:   Thu, 26 Jan 2023 12:11:42 +0000
Message-Id: <20230125-hid-unregister-leds-v2-4-514437b19297@diag.uniroma1.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEc3jaDRzvw4wqomWTZ4QiGT7ndm0u+LQuqDTOWB=B-6w=2yzg@mail.gmail.com>
References: <20230125-hid-unregister-leds-v2-0-514437b19297@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674734023; l=1491; i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id; bh=VPrVVBqqogjSwkjTCQxGFur+jXJWf031MbQaC/naVuk=; b=QqdXEngDfNOZIrOa2KlMzlEnb2T9sRwEwzbMotxYqBGLd6rLohqz/oCflt0Xi2C0F4IUpxWEFqrx JG9f5+PoCjOAgtRyclf/hzZbrARfaDO1Rb3+3XewKkHifnTDhe3Y
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519; pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unregister the LED controllers before device removal, to prevent
unnecessary runs of dualshock4_led_set_brightness().

Fixes: 4521109a8f40 ("HID: playstation: support DualShock4 lightbar.")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>

---

Contrary to the other patches in this series, failing to unregister
the led controller does not results into a use-after-free thanks
to the output_worker_initialized variable and the spinlock checks.

Changes in v2:
- Clarify UAF
- Link to v1: https://lore.kernel.org/all/20230125-hid-unregister-leds-v1-4-9a5192dcef16@diag.uniroma1.it/
---
 drivers/hid/hid-playstation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index f23186ca2d76..b41657842e26 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -2434,11 +2434,15 @@ static void dualshock4_remove(struct ps_device *ps_dev)
 {
 	struct dualshock4 *ds4 = container_of(ps_dev, struct dualshock4, base);
 	unsigned long flags;
+	int i;
 
 	spin_lock_irqsave(&ds4->base.lock, flags);
 	ds4->output_worker_initialized = false;
 	spin_unlock_irqrestore(&ds4->base.lock, flags);
 
+	for (i = 0; i < ARRAY_SIZE(ds4->lightbar_leds); i++)
+		devm_led_classdev_unregister(&ps_dev->hdev->dev, &ds4->lightbar_leds[i]);
+
 	cancel_work_sync(&ds4->output_worker);
 
 	if (ps_dev->hdev->product == USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE)

-- 
2.25.1
