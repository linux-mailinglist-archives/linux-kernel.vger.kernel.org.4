Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01EA6BF638
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCQXYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCQXYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:24:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D50F35EC0;
        Fri, 17 Mar 2023 16:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C67B5B8271C;
        Fri, 17 Mar 2023 23:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE2CC4339C;
        Fri, 17 Mar 2023 23:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679095440;
        bh=7zeW/xv++SWINuXHU/MUsAajCSk6VKuZ5VI+UwjVzBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oon7fQ63+T04Zh46LzIjjMnKzu7RVWFkh401wjUBx9r8l/PuApGlc3X5C9u9a4pSL
         iVAXk2jEUlDuB9+ksE+jMWjijnlu8P6i8QsVuS9ZSqyDL3xCRFqNaDj4KXbFdDVwYu
         njEpU+HKW71wYj51XLz1lfkomURP/6Q7e+mOkhaVdKkcF6k0jirGWE/y8ExI/r0JUd
         Uq80Rd8QQQTLLecU2TG9uj9xEst35Y99/1JKs5INmdTRkxDIIyCMwJnwuKWTMhNhcp
         xR41+zNi5gMRqGINIlkQGBCHnbN/yQjdT7NC79IC1AWc6WhcXeHwFtsrQMq6Qet7e/
         aNlvjAEkleF8A==
Received: by mercury (Postfix, from userid 1000)
        id DF4BB1062104; Sat, 18 Mar 2023 00:23:57 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 4/7] drm/panel: sitronix-st7789v: remove unused constants
Date:   Sat, 18 Mar 2023 00:23:52 +0100
Message-Id: <20230317232355.1554980-5-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317232355.1554980-1-sre@kernel.org>
References: <20230317232355.1554980-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ST7789V_COLMOD_RGB_FMT_18BITS and ST7789V_COLMOD_CTRL_FMT_18BITS
are unused in favour of MIPI_DCS_PIXEL_FMT_18BIT, remove them.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index e4d8dea1db36..f7566551b5e2 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -15,9 +15,6 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
-#define ST7789V_COLMOD_RGB_FMT_18BITS		(6 << 4)
-#define ST7789V_COLMOD_CTRL_FMT_18BITS		(6 << 0)
-
 #define ST7789V_RAMCTRL_CMD		0xb0
 #define ST7789V_RAMCTRL_RM_RGB			BIT(4)
 #define ST7789V_RAMCTRL_DM_RGB			BIT(0)
-- 
2.39.2

