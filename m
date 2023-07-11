Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F3A74E9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGKJMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKJME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:12:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA69F93
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:12:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6686ef86110so2911015b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689066720; x=1691658720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pTyng55pA+kR26hSGNkbT7uPc2zM3Salr3BcTTccrew=;
        b=SUgHYxeroF3XQD5mLBG6WvDW8h79eCpFmw8FDDbwqgfmQT/M1HhLGNbF5Mv+qq6RPS
         0wAvtcCPRU1K/2HZg5NbqiLkyKt5DuMqje/TSzxnlAvp9fRWqp664zafty+3tzCnKAB0
         PqJ86i/yY4NeK8WCadQXicFPZUa3xW6AGfaZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066720; x=1691658720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTyng55pA+kR26hSGNkbT7uPc2zM3Salr3BcTTccrew=;
        b=U1TRsWaqkbwswcBJ24DJSTTi7HvIm0wSjKiNc918iCj+4MaxntQe4XF14ydlVLSTtv
         TDM3dYRP/QRhX4rbHCKxsz5+pCMAVQsBDH0kM5OqasjCwrSIypTlrj8J3Gb/OEBMMg85
         AwKPacPB+sZ7SOjT4We/v1MdOUlEsjFNOIE+hrDhlevNMBbTyYTBsNh6DDpQzCH0uW3I
         amuK2LqHLOoZ1QYWQA4TMjvCK/ZIBlNCMU8IgRf/yd7wpjwIBOl72MCS2KDSy1FdOTUG
         o+JWF0J1hzTo0+jw7VeidRsREjyiPrTyrKsDlPPphAbaGFCRd74sd2dufzReKnwpZ3lU
         o7mg==
X-Gm-Message-State: ABy/qLZZElm+UPMQloswbQVHNEnZ56uFj3Rb94fsDeSOlHq1Bl4sB7Gx
        yXRmnNUKPv23AaEFcBqgWGsayQ==
X-Google-Smtp-Source: APBJJlGbyDeSbMnlXiDQleGQjRRmmMxCouiDLMo1SZSGsbaB1huQXuXugpl4cI2dKKGuxhsUNasHow==
X-Received: by 2002:a05:6a20:3c8a:b0:12d:3069:69e1 with SMTP id b10-20020a056a203c8a00b0012d306969e1mr14020579pzj.60.1689066720255;
        Tue, 11 Jul 2023 02:12:00 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:23f8:a996:7e53:c71a])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001b8896cd57bsm1336239plg.269.2023.07.11.02.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:11:59 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: Add AUO B116XAB01.4 (HW:0A) panel entry
Date:   Tue, 11 Jul 2023 17:11:54 +0800
Message-ID: <20230711091155.2216848-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This panel is found at least on the MT8183-based Juniper Chromebook,
also known as the Acer Chromebook Spin 311. It matches the common
delay_200_500_e50 set of delay timings.

Add an entry for it.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index fbd114b4f0be..df7e3cff004c 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1866,6 +1866,7 @@ static const struct panel_delay delay_200_500_e200 = {
  */
 static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120XAN01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
-- 
2.41.0.390.g38632f3daf-goog

