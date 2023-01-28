Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B385D67F714
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjA1KWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjA1KWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:22:10 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB4C169;
        Sat, 28 Jan 2023 02:22:08 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kt14so19814650ejc.3;
        Sat, 28 Jan 2023 02:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4CRR4r0MZ+tPXqof/6V6RPxQYuUvZaCxsFPAFM4cyeo=;
        b=qDdMJ2Jx3MmTPNxx8QI39ZBnCWXIyEPILLUB3UeSEwAms+RjYhmHcq0wgIXnoHHJ+z
         paQFhlN3XNS/0pTJ5oHv7kwm4jGyKjHAp/7YVSwxOznudzxxcCLfPeRXPeA6fSwVBWrR
         bCdIVGMNP44E2q9+CwMP2wWL4HC8f8jb1xxis1NQIngrtjMXubVhts0in2lfk2PZKmer
         y66eJTk7vDwTcV5jpruk9he+Q6/g64Zh6uLPaWk/Ow5hgU1Vv5B9tIfvN2wfGPYbEke4
         tjPbX5QNuDwM/lWjCwkwGNk+QqpikNAJblBYyy1kRCh4BAkiVQsObJ7urjrMk6kyBlYI
         PQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CRR4r0MZ+tPXqof/6V6RPxQYuUvZaCxsFPAFM4cyeo=;
        b=d85V/broB3ms7l15jenhL0E4o0EK2ahu3mhfwbUWl6ciU1zObsTRfssBQ7xi+CyCzn
         fJqhHOaACETc1jVp/2yn5L4AkpnBv0iJuYmyThcj4qttgCWkmMDK1ex5VxGuNfXJJH/C
         zpknoDUOzLABfPnSvB9LYgltvybWxgqSZxepji7k80TXl1s4Sb/Ht349nZhO1Vuio+Ds
         oeD8AZjPDsIeYg+RhZQTDvecXnWK5/e4nmOOdxOED4DuHUkxm4j7DhF4wri+cpihmk11
         kDBct5Py3mo2DqNzpdKsz308hLkfvW7WgprcYYIaEMLXWLk9YIfbdABgrxX4VSvT65IQ
         EhcQ==
X-Gm-Message-State: AO0yUKV7B/Z3CECF5v57IgdHZIuQ6mS5z/hPE2vPbSfNF0l/99EWdzRM
        47GFdmaQ0EF40RBPUzVKZ+TKLLu2ZIA=
X-Google-Smtp-Source: AK7set/PdIk85tcctr/HUuUiEqAamXktWGt/O9i2DDGe5hvM9VsLdbgM8/LYcolzYkoLhTkCg+Re1g==
X-Received: by 2002:a17:906:28d2:b0:87d:f29:3a14 with SMTP id p18-20020a17090628d200b0087d0f293a14mr3810549ejd.68.1674901326510;
        Sat, 28 Jan 2023 02:22:06 -0800 (PST)
Received: from caracal.museclub.art (p200300cf9f0a9b009a6833f6d97b7651.dip0.t-ipconnect.de. [2003:cf:9f0a:9b00:9a68:33f6:d97b:7651])
        by smtp.googlemail.com with ESMTPSA id lj8-20020a170906f9c800b007c14ae38a80sm31456ejb.122.2023.01.28.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 02:22:05 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Eric Nguyen <linux@drogman.ch>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add zenith ii extreme alpha
Date:   Sat, 28 Jan 2023 11:21:34 +0100
Message-Id: <20230128102135.5199-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
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

From: Eric Nguyen <linux@drogman.ch>

The ROG ZENITH II EXTREME ALPHA provides the same set of sensors as the
no-ALPHA version. Tested with the hardware [1].

[1] https://github.com/zeule/asus-ec-sensors/issues/31

Signed-off-by: Eric Nguyen <linux@drogman.ch>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 drivers/hwmon/asus-ec-sensors.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 02f4ad314a1e..a4039f2f9ca4 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -23,6 +23,7 @@ Supported boards:
  * ROG STRIX X570-I GAMING
  * ROG STRIX Z690-A GAMING WIFI D4
  * ROG ZENITH II EXTREME
+ * ROG ZENITH II EXTREME ALPHA
 
 Authors:
     - Eugene Shalygin <eugene.shalygin@gmail.com>
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index a901e4e33d81..bd7beefde586 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -466,6 +466,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_z690_a_gaming_wifi_d4),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME",
 					&board_info_zenith_ii_extreme),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME ALPHA",
+					&board_info_zenith_ii_extreme),
 	{},
 };
 
-- 
2.39.1

