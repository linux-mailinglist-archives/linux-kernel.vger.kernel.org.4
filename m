Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902176EBB37
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 22:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDVUue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 16:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDVUua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 16:50:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EAD26AF;
        Sat, 22 Apr 2023 13:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84DCF6143A;
        Sat, 22 Apr 2023 20:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0297C4339B;
        Sat, 22 Apr 2023 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682196627;
        bh=7zeW/xv++SWINuXHU/MUsAajCSk6VKuZ5VI+UwjVzBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YizmBtL0rRsM3d+Df6GBDq/V9QiNOcl0Xv1c43rft7AAu2fuqHImyp63WRVLj44xk
         iSPwrBtUCVY3O0368OleeeyNlnKWBbikBoVMEgLDWAaprOuQv7E2xUDZMEdiwbph+1
         wBbSZjfd1U1KanoouNkBIWr6xNO6owrq8YSXK7zLfjsoC3BQ8v9/lt8GapL7dcguZt
         TPH3pePHTaaJfDIEABArHMG1alA2fZ131vqH0anad/I1cLstX3P4lHmBPUpAmqt9Rw
         3Ys+5GJ/JYyBb0MoHb6QAfrJ7+y0QFi524ePijpUos1ksTrvfsyW7/EaLghMxJOt6z
         BEf8/b49KE8vw==
Received: by mercury (Postfix, from userid 1000)
        id 0FEDC1066CC3; Sat, 22 Apr 2023 22:50:25 +0200 (CEST)
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
Subject: [PATCH v2 04/13] drm/panel: sitronix-st7789v: remove unused constants
Date:   Sat, 22 Apr 2023 22:50:03 +0200
Message-Id: <20230422205012.2464933-5-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230422205012.2464933-1-sre@kernel.org>
References: <20230422205012.2464933-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

