Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4A06EEAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 01:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbjDYXGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 19:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbjDYXGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 19:06:11 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0870EB23E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 16:06:09 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id CC9421F88B;
        Wed, 26 Apr 2023 01:06:07 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Date:   Wed, 26 Apr 2023 01:05:59 +0200
Subject: [PATCH v3 08/21] drm/msm/dpu: Remove extraneous register define
 indentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-dpu-intf-te-v3-8-693b17fe6500@somainline.org>
References: <20230411-dpu-intf-te-v3-0-693b17fe6500@somainline.org>
In-Reply-To: <20230411-dpu-intf-te-v3-0-693b17fe6500@somainline.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bunch of registers are indented with two extra spaces, looking as if
these are values corresponding to the previous register which is not the
case, rather these are simply also register offsets and should only have
a single space separating them and the #define keyword.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 41 +++++++++++++++--------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index b9dddf576c029..1d22d7dc99b86 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -38,26 +38,27 @@
 #define INTF_ACTIVE_DATA_HCTL           0x068
 #define INTF_FRAME_LINE_COUNT_EN        0x0A8
 #define INTF_FRAME_COUNT                0x0AC
-#define   INTF_LINE_COUNT               0x0B0
-
-#define   INTF_DEFLICKER_CONFIG         0x0F0
-#define   INTF_DEFLICKER_STRNG_COEFF    0x0F4
-#define   INTF_DEFLICKER_WEAK_COEFF     0x0F8
-
-#define   INTF_DSI_CMD_MODE_TRIGGER_EN  0x084
-#define   INTF_PANEL_FORMAT             0x090
-#define   INTF_TPG_ENABLE               0x100
-#define   INTF_TPG_MAIN_CONTROL         0x104
-#define   INTF_TPG_VIDEO_CONFIG         0x108
-#define   INTF_TPG_COMPONENT_LIMITS     0x10C
-#define   INTF_TPG_RECTANGLE            0x110
-#define   INTF_TPG_INITIAL_VALUE        0x114
-#define   INTF_TPG_BLK_WHITE_PATTERN_FRAMES   0x118
-#define   INTF_TPG_RGB_MAPPING          0x11C
-#define   INTF_PROG_FETCH_START         0x170
-#define   INTF_PROG_ROT_START           0x174
-#define   INTF_MUX                      0x25C
-#define   INTF_STATUS                   0x26C
+#define INTF_LINE_COUNT                 0x0B0
+
+#define INTF_DEFLICKER_CONFIG           0x0F0
+#define INTF_DEFLICKER_STRNG_COEFF      0x0F4
+#define INTF_DEFLICKER_WEAK_COEFF       0x0F8
+
+#define INTF_DSI_CMD_MODE_TRIGGER_EN    0x084
+#define INTF_PANEL_FORMAT               0x090
+#define INTF_TPG_ENABLE                 0x100
+#define INTF_TPG_MAIN_CONTROL           0x104
+#define INTF_TPG_VIDEO_CONFIG           0x108
+#define INTF_TPG_COMPONENT_LIMITS       0x10C
+#define INTF_TPG_RECTANGLE              0x110
+#define INTF_TPG_INITIAL_VALUE          0x114
+#define INTF_TPG_BLK_WHITE_PATTERN_FRAMES 0x118
+#define INTF_TPG_RGB_MAPPING            0x11C
+#define INTF_PROG_FETCH_START           0x170
+#define INTF_PROG_ROT_START             0x174
+
+#define INTF_MUX                        0x25C
+#define INTF_STATUS                     0x26C
 
 #define INTF_CFG_ACTIVE_H_EN	BIT(29)
 #define INTF_CFG_ACTIVE_V_EN	BIT(30)

-- 
2.40.1

