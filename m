Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AE703D00
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbjEOStD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbjEOSs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:48:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D76A1491A;
        Mon, 15 May 2023 11:48:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f24ceae142so11672144e87.3;
        Mon, 15 May 2023 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684176537; x=1686768537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTBWs9VN/AmEk5vXMNYksrxne0o7kn1chFKcCzHHpNU=;
        b=OfaA86AQomUNauoaFFPAvp3N+WxOxPoBcEeP/Gjw1guhaydm3FI/3cQZlWmwOCjFPi
         X8gab610LUS17dQH5D4A13bMC9ARjpVwDt2glchCCIUO9CtoaGpTJR3YSnLRxnBD36/U
         Ts0l9jG+xFfL8jWyHT6jKuqdpRPd1onYvl1I+K/jtkdyA7XuQiqGyvQPrCR2Z9DRhOfZ
         ETv3nrX3aQILZjZMsswt9S/upRVOmL0Zz3Q9xDa+22ONb0fxYulAiIrW8SGG2xhTFvhb
         OAYWmxgQXvMk4VKX6BWPVc/CdR4kaDIzq8eNdTGEencaRY7v5S1MEaldvYge7eUazfq+
         grTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684176537; x=1686768537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTBWs9VN/AmEk5vXMNYksrxne0o7kn1chFKcCzHHpNU=;
        b=PV+l2zr3+5fYbg01Chqzeb51luHs0QT3j1A6Tmf5y7WIXYaU0MW0vnXdGk0bf0Umh6
         1S6hAxmLv5iQCx68ix4opIK49kfH02lwoCqCjnposh/MM9jZ86GOOcoocCsLmrkuM9kX
         nV3K9ktHzcUyTIicpBXOSvppno5TTLUzZEYSqAeL0J7NCW6i7iwwD4FVqZe6734ujFNn
         SpY7tHCQ5/zZBhPA5m689X2SlRfLQSnibM/HAAEaETeiyZHGUcMcqJwxZ6kwMSduNb5G
         PjVaOEbVncRaWxiCPAp070l1gAyBE6VncdFIhb05gEFbtwOZ+kfIlYpCrz2pt5hLmmC9
         mOww==
X-Gm-Message-State: AC+VfDxlMdjR5iz6qlxkahur9x42cff80Ew3NuaJMRwXeHhH+Lf5HzpP
        tcPIw+X5erPluNvBy8/dvfA=
X-Google-Smtp-Source: ACHHUZ79wHJB/Ghdi7Cm4011cCmntxQXuFSxHB/31ZlUzeFBiBemCtGnbVt+2cD1sM0VJ+L0Xyrh5w==
X-Received: by 2002:a19:5214:0:b0:4f3:8411:f146 with SMTP id m20-20020a195214000000b004f38411f146mr913589lfb.68.1684176536567;
        Mon, 15 May 2023 11:48:56 -0700 (PDT)
Received: from komp.lan (83.24.33.169.ipv4.supernova.orange.pl. [83.24.33.169])
        by smtp.gmail.com with ESMTPSA id z5-20020ac24f85000000b004ec8de8ab43sm2655742lfs.139.2023.05.15.11.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:48:56 -0700 (PDT)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel-orientation-quirks: Change Air's quirk to support Air Plus
Date:   Mon, 15 May 2023 20:48:43 +0200
Message-Id: <20230515184843.1552612-1-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

It turned out that Aya Neo Air Plus had a different board name than
expected.
This patch changes Aya Neo Air's quirk to account for that, as both
devices share "Air" in DMI product name.

Tested on Air claiming to be an Air Pro, and on Air Plus.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index b1a38e6ce2f8..0cb646cb04ee 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -179,7 +179,7 @@ static const struct dmi_system_id orientation_data[] = {
 	}, {	/* AYA NEO AIR */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
-		  DMI_MATCH(DMI_BOARD_NAME, "AIR"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYA NEO NEXT */
-- 
2.40.1

