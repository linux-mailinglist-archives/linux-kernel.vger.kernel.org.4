Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C677563AE25
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiK1Qzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiK1Qzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:55:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF69F1D672;
        Mon, 28 Nov 2022 08:55:38 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso12146840wme.5;
        Mon, 28 Nov 2022 08:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs5eZY+hTOKSufklO+JsY6NTtjyubxLuJefhM9VnFWc=;
        b=eOSBQjkmpJ+pIIMvquzkibC6nEPY0y45EBs5XUUXMVMSJOaGjjMG2el/uFq4Zet2+U
         lxdjEXjckchaktzPuAt+3r1aPZAa05mok/H1Jxg74bJ6C8aMSBKgIq5rM2ugVLWwnAd5
         vnZLGeTak4Ta3RrBFarFFMyQGQV2wl2FgT6bR0mpSUhnWMOTgwGoOXyWM26lJCL/GlUs
         jvfH8xdYqQlc2CUfkvR99hd1a/ZfPGaTPB66/2Qb58OWth6ltjPc8ziaDC1mrz4P0KIH
         +ksahvtOXQSYxvv8IZRUyXLvWG7aM4sOZnRaRXt8yx4VLvsOmuBGm/ZWj7PxxnrDEqFc
         7f8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fs5eZY+hTOKSufklO+JsY6NTtjyubxLuJefhM9VnFWc=;
        b=t33US07WAYvGxsNKSv4zxskco9M2yIlu+rloB43JsfSN5VfFf/0OY0LUrVLQBTjz4Z
         0h74C6Tt+J62PP+UOjxyM6Q1sT9ozRFqbrGJ3iWAZJ/oeolizHyUL0hJK3LRc6TFUlD6
         ioB9mV9QZ7PV0WL7v8AnMziOZ40S6rPScXxT4kLidsHugPwq1sTdlp4LIDcWY/H6xYJL
         Byk+FXfmp6d6EpGqhdcFLLPAAbPILQa0M5jr19sGI03/TENGMB+vBs6uDh3eq4P2GM7/
         veH0NPHFvAhyaLNq0IASM9cWhCANl1QPZ6Yt8uUEVX9QfItlO3En38rMRkWKVCc2c2F7
         4Png==
X-Gm-Message-State: ANoB5pnYjHwg2D/Z4JA95dC+p/DXOBWRpMjn8CacpyKbXals3kZWQ6wt
        d8wY7ZTupUgpk6ITggmAKb0=
X-Google-Smtp-Source: AA0mqf5uHXOne02Q9XQdUhv5VwXOCKpuhygIvg4EkwmJRGSYhdUhsLEc9MCG1ftPkcswS7e8nkw9tA==
X-Received: by 2002:a05:600c:4f45:b0:3cf:9be3:8d26 with SMTP id m5-20020a05600c4f4500b003cf9be38d26mr30750319wmq.185.1669654537212;
        Mon, 28 Nov 2022 08:55:37 -0800 (PST)
Received: from localhost.localdomain ([94.73.35.229])
        by smtp.gmail.com with ESMTPSA id g3-20020adffc83000000b0024207ed4ce0sm8495069wrr.58.2022.11.28.08.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:55:36 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] HID: sony: Fix unused function warning
Date:   Mon, 28 Nov 2022 17:55:24 +0100
Message-Id: <20221128165524.6387-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Compiling this driver without setting "CONFIG_SONY_FF" generates the
following warning:

	drivers/hid/hid-sony.c:2358:20: warning: unused function
	'sony_send_output_report' [-Wunused-function]
	static inline void sony_send_output_report(struct sony_sc *sc)
	                   ^
	1 warning generated.

Add the missing preprocessor check to fix it.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-sony.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 03691cdcfb8e..13125997ab5e 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2355,11 +2355,13 @@ static void motion_send_output_report(struct sony_sc *sc)
 	hid_hw_output_report(hdev, (u8 *)report, MOTION_REPORT_0x02_SIZE);
 }
 
+#ifdef CONFIG_SONY_FF
 static inline void sony_send_output_report(struct sony_sc *sc)
 {
 	if (sc->send_output_report)
 		sc->send_output_report(sc);
 }
+#endif
 
 static void sony_state_worker(struct work_struct *work)
 {
-- 
2.38.1

