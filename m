Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECC45BAE88
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiIPNuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIPNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:50:19 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07102580AE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:50:17 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l6so11354280ilk.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=AKed33L7/gXTrNguuIgtZfEgy2m6ebn7NIyiYlN3tNg=;
        b=fMC6MCN8yaUgRG6eEbFrh+Zx9PoNaDmY8Q7MQgeExwWGPITQYUig86e2s+ssPLlJNE
         lNQouaOpKfKvNeMKkeCHAdPrFq6csgzvHfWUmHnopOTOouRQGwDpH4WbJ8V5QpiGAO7H
         V8U3MYz1sSnxqnvaSORhpGKVgHf8u0NAM+2XA9duD/8IS1jCSEL9PX2T0v3aWF6Gc3kk
         ZviUMYq0sRFLFCJokvaKyEMAytZFSFsUxFq4kcwiJ+0zdqPyuc6sYpMy6BVAdcrXKUnz
         /cp6ino3VovOO5E5KQWERD06QXNUpZzTGOOIRcHW9MDLICvJokDiJxyMVaUBm4y72WBS
         lLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=AKed33L7/gXTrNguuIgtZfEgy2m6ebn7NIyiYlN3tNg=;
        b=GdQ+l20ZQ4GBHDbNq54gdTysQovzWH1DzVWBsidmCcxOtiijiLiVDKymDC3M6J79II
         cnYyKv6Pv5MwWjTO+WSjhHzoDhRYw6hB4KHHxS3KAhMcHZSYhafAYolgogBwAfx2GQ4M
         Z4AAC5sChDcl2S5vTf6UdYfKsmqKy772VI9o173HYdfdC1lTAiGshnNFymrcTdPDpIsU
         ntsNrShj2z3jIREgd87U95ucvhnjv8WP537JOYo6N7su6qIafRCXQcIdExwABWwNSBOq
         jwUvhDRAdhzJxqyrC9h7uZnoBjFzMG4BYRwxFxCgs0Z83ALah7fpD8G7I0axyUAMZKGa
         167Q==
X-Gm-Message-State: ACrzQf1qaEKwbbQfWDvTs3x/oMUm9YDVzjMd1Ij7w4KTzf7rkIDiBmNe
        DEvpanSI0+k2ufEatpt3BFA=
X-Google-Smtp-Source: AMsMyM5ENhHIjQTMpHESgGfVi4JrbNsBL2JXlAsCjRr/7HcLP8f/u0Ufh618QDhyrOQ/5kvUBHYEpg==
X-Received: by 2002:a05:6e02:1c8d:b0:2eb:77fc:5618 with SMTP id w13-20020a056e021c8d00b002eb77fc5618mr2284907ill.268.1663336217063;
        Fri, 16 Sep 2022 06:50:17 -0700 (PDT)
Received: from localhost.localdomain ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id b23-20020a056638389700b00358f3cc92acsm2283153jav.36.2022.09.16.06.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:50:16 -0700 (PDT)
From:   Matthew <ruinairas1992@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Matthew <ruinairas1992@gmail.com>
Subject: [PATCH] Updated the orientation quirks to support the many variations of ONEXPLAYER and AokZoe devices.
Date:   Fri, 16 Sep 2022 07:50:14 -0600
Message-Id: <20220916135014.2873-1-ruinairas1992@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
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

Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
---
 .../gpu/drm/drm_panel_orientation_quirks.c    | 86 ++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index fc1728d46ac2..15203c134717 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -115,6 +115,18 @@ static const struct drm_dmi_panel_orientation_data lcd1280x1920_rightside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd800x1280_leftside_up = {
+	.width = 800,
+	.height = 1280,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
+static const struct drm_dmi_panel_orientation_data lcd1200x1920_leftside_up = {
+	.width = 1200,
+	.height = 1920,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd1600x2560_leftside_up = {
 	.width = 1600,
 	.height = 2560,
@@ -128,6 +140,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "One S1003"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AOKZOE A1 AR07 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AOKZOE"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AOKZOE A1 AR07"),
+		},
+		.driver_data = (void *)&lcd1200x1920_leftside_up,
 	}, {	/* Asus T100HA */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
@@ -308,12 +326,78 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Default string"),
 		},
 		.driver_data = (void *)&onegx1_pro,
-	}, {	/* OneXPlayer */
+	}, {	/* OneXPlayer 800P Original DMI Values */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK TECHNOLOGY CO., LTD."),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
+		},
+		.driver_data = (void *)&lcd800x1280_leftside_up,
+	}, {	/* OneXPlayer 1200P Original DMI Values */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK TECHNOLOGY CO., LTD."),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
+		},
+		.driver_data = (void *)&lcd1200x1920_leftside_up,
+	}, {	/* OneXPlayer 1600P Original DMI Values */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK TECHNOLOGY CO., LTD."),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer Gundam Edition Bios Updated */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER GUNDAM GA72"),
+		},
+		.driver_data = (void *)&lcd1200x1920_leftside_up,
+	}, {	/* ONEXPLAYER mini A07 800P Bios Updated */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER mini A07"),
+		},
+		.driver_data = (void *)&lcd800x1280_leftside_up,
+	}, {	/* ONEXPLAYER mini A07 1200P Bios Updated*/
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER mini A07"),
+		},
+		.driver_data = (void *)&lcd1200x1920_leftside_up,
+	}, {	/* ONEXPLAYER mini GA72 800P Bios Updated*/
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER mini GA72"),
+		},
+		.driver_data = (void *)&lcd800x1280_leftside_up,
+	}, {	/* ONEXPLAYER mini GA72 1200P Bios Updated*/
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER mini GA72"),
+		},
+		.driver_data = (void *)&lcd1200x1920_leftside_up,
+	}, {	/* ONEXPLAYER mini GT72 800P Bios Updated*/
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER mini GT72"),
+		},
+		.driver_data = (void *)&lcd800x1280_leftside_up,
+	}, {	/* ONEXPLAYER mini GT72 1200P Bios Updated*/
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER mini GT72"),
+		},
+		.driver_data = (void *)&lcd1200x1920_leftside_up,
+	}, {	/* OneXPlayer 1 8.4" Intel Bios Updated */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER 1 T08"),
+		},
+		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer 1S 8.4" Intel Bios Updated */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER 1S T08"),
+		},
+		.driver_data = (void *)&lcd1600x2560_leftside_up,
 	}, {	/* Samsung GalaxyBook 10.6 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-- 
2.37.3

