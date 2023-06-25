Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EED73CDCE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 03:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjFYBYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 21:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFYBYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 21:24:20 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E71E54;
        Sat, 24 Jun 2023 18:24:18 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-560c617c820so1565054eaf.3;
        Sat, 24 Jun 2023 18:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687656258; x=1690248258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1efT16ug32Wj/IcB7velfMS/W9dxeMLEvWoz2Xvc88=;
        b=Mv3zAvYL9k98W91B4UuI7FxsAoZliNAy632c2cWyoOmOzXgTT5OHGdIHThCF5PrkYT
         nkUHvFJ8sR8tO03nWpJIvitEHXV5Ii6WdcnIXOVfDsl/sOpU0e3OuN4S/YSQzQxzV0M+
         95XWGgPeTanvjrqN50yJQH/+7YYAKvwHOFHvoEcbOeFzqPvuOFkoQlUQ+bxswGmGy8eK
         TmTUjxhPh3S7sW9xQVnuAgXAkpPKhquLGjL3qv9h8Jq8yb6uJrdhPisy1iYOt+lfUl9F
         czMzxgfBMdItcsJe3mFCst5rJ/oxZKoHfpRDnyRdVg3176dvgX0fB5qABeFmOpvz2bTZ
         gA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687656258; x=1690248258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1efT16ug32Wj/IcB7velfMS/W9dxeMLEvWoz2Xvc88=;
        b=CCc7EPVObUhQIap7AZHrmGJ0R/ZxJxLx4g09Guri90NTTLhCXH166CW4kmzNZRC4ND
         VS7guXq8CxIzMrM5C+kp9FpLXIN6IHYMYLMYLYKidWCUy77ApkSMs6VblsqB8SHY8BdO
         1S5wxrt/g1TYIyAOcoJ3qxjCmIOGBaLreqMmDpuX7wRfI8ojEJOXJtGxVlEmjomkZ+VS
         4bauxkcv/7v6WL2vPbVJuACKmVo9/tplX4Q3H014QQekQXfKZosSohIrU/m7GKzVWdGB
         5Rypk5Oot6z+rYcCSiz+FCU6o9mCyco+iVx4BpbijfAQA8GH5ILi/N93OQJe8DEdbkgy
         YurQ==
X-Gm-Message-State: AC+VfDxomX/4aICjYM6e8Xtrcp0qlnlVDzBaF4cuBzQ9MiU2Zdm+YtBO
        4dLlQS//pbi4t1RxkgzUJ64=
X-Google-Smtp-Source: ACHHUZ65xB8Vy3g58wdMURysw6wuJ8fZ2aqYEiZNVh0Ct7QT/nR9J1wfzXbUWegZ4hkucXqtQdEycg==
X-Received: by 2002:a4a:de82:0:b0:55c:6812:27c5 with SMTP id v2-20020a4ade82000000b0055c681227c5mr20253372oou.9.1687656257855;
        Sat, 24 Jun 2023 18:24:17 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id i17-20020a4ad391000000b0054fba751207sm1090022oos.47.2023.06.24.18.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 18:24:17 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     Jerrod Frost <jcfrosty@proton.me>, derekjohn.clark@gmail.com,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
Subject: [PATCH v2] hwmon: (oxp-sensors) Add support for AOKZOE A1 PRO
Date:   Sat, 24 Jun 2023 22:23:44 -0300
Message-ID: <20230625012347.121352-2-samsagax@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerrod Frost <jcfrosty@proton.me>

This device is an iteration over the AOKZOE A1 with the same EC mapping
and features.

It also has support for tt_toggle.

Signed-off-by: Jerrod Frost <jcfrosty@proton.me>
Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
v2: added Jerrod signoff
---
 Documentation/hwmon/oxp-sensors.rst | 2 ++
 drivers/hwmon/oxp-sensors.c         | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 0ca1f7728c34..3adeb7406243 100644
--- a/Documentation/hwmon/oxp-sensors.rst
+++ b/Documentation/hwmon/oxp-sensors.rst
@@ -30,6 +30,7 @@ Supported devices
 Currently the driver supports the following handhelds:
 
  - AOK ZOE A1
+ - AOK ZOE A1 PRO
  - Aya Neo 2
  - Aya Neo AIR
  - Aya Neo AIR Pro
@@ -40,6 +41,7 @@ Currently the driver supports the following handhelds:
 
 "Turbo/Silent" button behaviour toggle is only supported on:
  - AOK ZOE A1
+ - AOK ZOE A1 PRO
  - OneXPlayer mini AMD (only with updated alpha BIOS)
  - OneXPlayer mini AMD PRO
 
diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 1e59d97219c4..e1a907cae820 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -77,6 +77,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)aok_zoe_a1,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AOKZOE"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AOKZOE A1 Pro"),
+		},
+		.driver_data = (void *)aok_zoe_a1,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-- 
2.41.0

