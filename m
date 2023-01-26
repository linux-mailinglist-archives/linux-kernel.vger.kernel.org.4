Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A695067CA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjAZMK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjAZMK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:10:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D541080
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:10:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z11so1696592ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVbivV8EGu+km89gAq7ikjZD9Nt9wLtDAtt21fJbyIE=;
        b=Z+Jx3ESL49Z2PCF4IUnISXt1Ax3Bh5RhOtxjA77Q+aTXwdTogaLdApCZ0YageHuLgS
         qtiYhwM7TJDQQE0gtq3wj3rQUL+qBWAvUl9jsDW1xrQZKGL7EgWvxNPuBBvULej9v72Z
         uXzY72TclGoeq2vUHaX6eq6+1gn2y/RP7Md/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVbivV8EGu+km89gAq7ikjZD9Nt9wLtDAtt21fJbyIE=;
        b=WkRjNaUeKFmWymZNSX4R51peqDIibnECJ94/XUL66MARZavcPwLlWSYehXP/uwCJMA
         ZgdFbmhSn7AjxHUE45ro1oVIHK1ihIWIv0sJnhde3TM/LL+b9O36KgPZ/ufXt/4d24hO
         fYhnBt0G6rfg5D5ZQ7EvsE35ijIhP3ccbzhskBwBpWs7X9cYpUxM6OE6t4iU4ttXSIgv
         0112AJFYisemyJw2OGFRLeJaUBzqKrjxqDyy5S2PMnTHJG3u5KMxvHb8iGF9mkfqMYmr
         fxEb1ZMlooob7+YFAkJGFkNeA47/pt2UrIDHP/NVCoAfPqNPELan5KfOIMnVVVREkcPx
         G9Eg==
X-Gm-Message-State: AFqh2krbZflVWzUVv/a+x6ABzQkqw9rrmsTt7DrKE/zMHm3ZueqoOl5+
        CbKElhjpeWbOTTRONZ1TTw5P0w==
X-Google-Smtp-Source: AMrXdXsukXmzEgZnFOHM0z7on12mUpXq2NJAYUtr0KLvu8zMkX/pzniYGESNkYwGVqZ6WycqNgozXw==
X-Received: by 2002:a05:6402:3214:b0:49d:bc8c:c3eb with SMTP id g20-20020a056402321400b0049dbc8cc3ebmr43983796eda.15.1674735053993;
        Thu, 26 Jan 2023 04:10:53 -0800 (PST)
Received: from pborrello-1.vm.vusec.net (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0049ef56c01d0sm645490edt.79.2023.01.26.04.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 04:10:53 -0800 (PST)
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
Subject: [PATCH v2 3/5] HID: dualsense_remove: manually unregister leds
Date:   Thu, 26 Jan 2023 12:09:18 +0000
Message-Id: <20230125-hid-unregister-leds-v2-3-514437b19297@diag.uniroma1.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEc3jaDRzvw4wqomWTZ4QiGT7ndm0u+LQuqDTOWB=B-6w=2yzg@mail.gmail.com>
References: <20230125-hid-unregister-leds-v2-0-514437b19297@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674734023; l=1556; i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id; bh=I/aK9DcIPRri1R7+BoQmPFot08oQLGwMbJpqlNV1B8M=; b=x78P2ebxLLwLOWOjBnnzLG/enTMXSF9YH3QbZDzWhLC4Tzv7V/zRQOi1YIKOhINhDOkegJK42hLC m1jeKayWD9ELcEL8IQp12s8Y82S82CkgS5gm1+YzswCDoo5jieve
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519; pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unregister the LED controllers before device removal, to prevent
unnecessary runs of dualsense_player_led_set_brightness().

Fixes: 8c0ab553b072 ("HID: playstation: expose DualSense player LEDs through LED class.")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>

---

Contrary to the other patches in this series, failing to unregister
the led controller does not results into a use-after-free thanks
to the output_worker_initialized variable and the spinlock checks.

Changes in v2:
- Unregister multicolor led controller
- Clarify UAF
- Link to v1: https://lore.kernel.org/all/20230125-hid-unregister-leds-v1-3-9a5192dcef16@diag.uniroma1.it/
---
 drivers/hid/hid-playstation.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 27c40894acab..f23186ca2d76 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -1503,11 +1503,17 @@ static void dualsense_remove(struct ps_device *ps_dev)
 {
 	struct dualsense *ds = container_of(ps_dev, struct dualsense, base);
 	unsigned long flags;
+	int i;
 
 	spin_lock_irqsave(&ds->base.lock, flags);
 	ds->output_worker_initialized = false;
 	spin_unlock_irqrestore(&ds->base.lock, flags);
 
+	for (i = 0; i < ARRAY_SIZE(ds->player_leds); i++)
+		devm_led_classdev_unregister(&ps_dev->hdev->dev, &ds->player_leds[i]);
+
+	devm_led_classdev_multicolor_unregister(&ps_dev->hdev->dev, &ds->lightbar);
+
 	cancel_work_sync(&ds->output_worker);
 }
 

-- 
2.25.1
