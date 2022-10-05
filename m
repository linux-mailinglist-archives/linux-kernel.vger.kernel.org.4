Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2108C5F57B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJEPmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJEPmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:42:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A572C671;
        Wed,  5 Oct 2022 08:42:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o5so11043108wms.1;
        Wed, 05 Oct 2022 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=oTOMb33OxXfhsJS83LS4blxwTrm8QLVlJ3F0fXKoCCM=;
        b=FLdl3F4SepxSURBD2OuAKlb1mpe7tD3c06Lez9i/fkxymbtMWAN7zSb4B8Lwi2aEJD
         U59wptq2IQCA7x02d80iHbU6ey+GLq44pWuqBe7wysp3tC5pUrxO7f1sSHliZ7JsGgU6
         XMCCZ7h9qACRCLfrwlIum1H5MVeIMY/L0DWSa/CRFxtvpuIk3mRr5NnZ8LFZTUqqVAjk
         dkUdmjz/qVsiYXBnHYarrGqTKzJnPSCIb4UKoxELelo4foGCgLVLHz7D6wAXbua1ryn/
         jpNY+dyvEnzi6hlDJIjbv2qODQvXMrzov83adcacKofMk/UcRVUvPcTCK4dQ3vlc2q8U
         Hi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oTOMb33OxXfhsJS83LS4blxwTrm8QLVlJ3F0fXKoCCM=;
        b=cT1iyo7OdYoiPSPE6RSem88eVjAFZhzx5d7DYKlrFEhwdZNivDV/U7OCiiGx5MIX0x
         v0G5N/+jhGynKJWHpnPLbs7DBaC/Qt39JBFbU3g+rCQxV+zQXt5ZVvCmJUWbS3HP4uQG
         K22qZVZ8kh6nYcr6aALZnSAianb7SV2hoOL0Pu0z222qPFtqER9R6QMNlnn4/Hx2ef6O
         6HfW3ChsoxRJuJNAVz1QArrjYPPQ2ugJRHmRWsXv5PvDfAu5Cvy8qtwmwZD7tUjXJsov
         iFThawSwZuwoTrN5CEwkoF4kmkcuIasdz49ieZ7/aomzMAll8qZIrdfjZq5JRKa/8F0m
         E8aw==
X-Gm-Message-State: ACrzQf2Gl3U+L+AZ/sfaakfI2Avh1celTtvGeZ09YufJ43H3w7wwsRgI
        TYo5eZaMhaPcA603kEf5fNM=
X-Google-Smtp-Source: AMsMyM64oKatyANTYtAAAztZEOybgVl+YuGxerknER5+ozcpdSKnmHzmax4ABnaAUB9lUhiqD7skBQ==
X-Received: by 2002:a05:600c:229a:b0:3c0:130d:320d with SMTP id 26-20020a05600c229a00b003c0130d320dmr1398773wmf.51.1664984538064;
        Wed, 05 Oct 2022 08:42:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d6692000000b0022ac1be009esm15511350wru.16.2022.10.05.08.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 08:42:17 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] HID: lenovo: Make array tp10ubkbd_led static const
Date:   Wed,  5 Oct 2022 16:42:16 +0100
Message-Id: <20221005154216.319577-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array tp10ubkbd_led on the stack but instead
make it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
V2: Fix commit message, somehow I fat fingered the first one.
---
 drivers/hid/hid-lenovo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 9dabd6323234..44763c0da444 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -985,7 +985,7 @@ static int lenovo_led_brightness_set(struct led_classdev *led_cdev,
 	struct device *dev = led_cdev->dev->parent;
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
-	u8 tp10ubkbd_led[] = { TP10UBKBD_MUTE_LED, TP10UBKBD_MICMUTE_LED };
+	static const u8 tp10ubkbd_led[] = { TP10UBKBD_MUTE_LED, TP10UBKBD_MICMUTE_LED };
 	int led_nr = 0;
 	int ret = 0;
 
-- 
2.37.3

