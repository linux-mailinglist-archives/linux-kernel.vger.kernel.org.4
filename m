Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947106562B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiLZMzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiLZMzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:55:12 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51580DFA;
        Mon, 26 Dec 2022 04:55:11 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso4058203wms.5;
        Mon, 26 Dec 2022 04:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUVWBQlXKzFP1zq6JqAFf3+HtIMfgJ5UD/Yw7gpSm3A=;
        b=bhVxIBlogKDWgM4hWTkPzeV3uP91M71P36NvwvlJkKq7l7+/sPm8DzimOpJW1aNtBB
         H88Yk/fQU8PseFGTHfHAbdZPb/kzCbYIvahtVprcQsSYwussIq9ZqhwQsePZQA9gmWa3
         kyqmxV+hORFTqFLI4d9nm7+6+P0LU7qmDZyrohvRyuPANGEPkT6xPfsNF+BnSJcT3I1I
         kExjPc55h4oUnxf+k5ATlNhms9MHkIbkW0TY7RoralIhG62C//bN4XAfq+ZreoKxwe5K
         Uwthiyyb5a+diIwMAVtc1l644IXgc8YcO/h213sejsOPzrAdffSlcX4K2fEmhE9N0r62
         dmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUVWBQlXKzFP1zq6JqAFf3+HtIMfgJ5UD/Yw7gpSm3A=;
        b=CBkkzbdYv3ZCiIOn/TGducJipDK6e6FQaASusxrjihJgsjwrjX41j3XsK7w9PMe1SM
         rAA/BxXTFof/AoJ53HkmaV+SBU8hdc/plOFg3eHtvVZ9WaYWPP2dKfz+mcTnQgGMNxkL
         nI0JrVqScRQR8Dq+d4mMAu7tc26780JVRUArwkHhLRTy5/4WhqM5/pZN9L/kRVEgL5iB
         JBj18y3f+hUX4qzSQqpco5RfGzAKdQWpHzgYp00Evcb0w6iJZ5mRN6ISiAkeDqkdjABq
         Ri9+gJ7m5/Y3UzrMTsQpcvWY77HAm9en1uFlmYg48UDhUZZiVOaC2dVJP7N2+b3Houve
         r8Sg==
X-Gm-Message-State: AFqh2krxRhJacpOswbOtuH+isvoNAwehCoMj02ZJU8iICbtlSwfw2IXQ
        nV2PCunSN24ZHL8MgWKY4o0=
X-Google-Smtp-Source: AMrXdXvLLumkNKUkTxr/yZr3WSkAP1yx8Oi82c8wjOEgDZ4hrEOomRjZR4ZDmYIlKeOTostzcQ6/Vw==
X-Received: by 2002:a05:600c:3844:b0:3d2:191d:2420 with SMTP id s4-20020a05600c384400b003d2191d2420mr13109943wmr.7.1672059309824;
        Mon, 26 Dec 2022 04:55:09 -0800 (PST)
Received: from localhost.localdomain ([94.73.32.212])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003cf894dbc4fsm13684497wmq.25.2022.12.26.04.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 04:55:09 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Mia Kanashi <chad@redpilled.dev>,
        Andreas Grosse <andig.mail@t-online.de>
Subject: [PATCH 2/6] HID: uclogic: Add battery quirk
Date:   Mon, 26 Dec 2022 13:54:50 +0100
Message-Id: <20221226125454.16106-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221226125454.16106-1-jose.exposito89@gmail.com>
References: <20221226125454.16106-1-jose.exposito89@gmail.com>
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

Some UGEE v2 tablets have a wireless version with an internal battery
and their firmware is able to report their battery level.

However, there was not found a field on their descriptor indicating
whether the tablet has battery or not, making it mandatory to classify
such devices through the UCLOGIC_BATTERY_QUIRK quirk.

Tested-by: Mia Kanashi <chad@redpilled.dev>
Tested-by: Andreas Grosse <andig.mail@t-online.de>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 5 +++++
 drivers/hid/hid-uclogic-params.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 2d46d4d50604..37cf4a93eafa 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1222,6 +1222,11 @@ static int uclogic_params_ugee_v2_init_frame_mouse(struct uclogic_params *p)
  */
 static bool uclogic_params_ugee_v2_has_battery(struct hid_device *hdev)
 {
+	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (drvdata->quirks & UCLOGIC_BATTERY_QUIRK)
+		return true;
+
 	/* The XP-PEN Deco LW vendor, product and version are identical to the
 	 * Deco L. The only difference reported by their firmware is the product
 	 * name. Add a quirk to support battery reporting on the wireless
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index 10a05c7fd939..b0e7f3807939 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -20,6 +20,7 @@
 #include <linux/hid.h>
 
 #define UCLOGIC_MOUSE_FRAME_QUIRK	BIT(0)
+#define UCLOGIC_BATTERY_QUIRK		BIT(1)
 
 /* Types of pen in-range reporting */
 enum uclogic_params_pen_inrange {
-- 
2.38.1

