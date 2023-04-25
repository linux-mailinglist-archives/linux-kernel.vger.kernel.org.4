Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CC86EEAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 01:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbjDYXGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 19:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjDYXGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 19:06:11 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078F9AF24
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 16:06:10 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 9809E1FA71;
        Wed, 26 Apr 2023 01:06:08 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Date:   Wed, 26 Apr 2023 01:06:00 +0200
Subject: [PATCH v3 09/21] drm/msm/dpu: Sort INTF registers numerically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-dpu-intf-te-v3-9-693b17fe6500@somainline.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bunch of registers were appended at the end in e.g. commit
91143873a05d ("drm/msm/dpu: Add MISR register support for interface")
rather than being inserted in a place that maintains numerical sorting:
restore said numerical sorting.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 1d22d7dc99b86..1491568f86fcb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -36,6 +36,10 @@
 #define INTF_CONFIG2                    0x060
 #define INTF_DISPLAY_DATA_HCTL          0x064
 #define INTF_ACTIVE_DATA_HCTL           0x068
+
+#define INTF_DSI_CMD_MODE_TRIGGER_EN    0x084
+#define INTF_PANEL_FORMAT               0x090
+
 #define INTF_FRAME_LINE_COUNT_EN        0x0A8
 #define INTF_FRAME_COUNT                0x0AC
 #define INTF_LINE_COUNT                 0x0B0
@@ -44,8 +48,6 @@
 #define INTF_DEFLICKER_STRNG_COEFF      0x0F4
 #define INTF_DEFLICKER_WEAK_COEFF       0x0F8
 
-#define INTF_DSI_CMD_MODE_TRIGGER_EN    0x084
-#define INTF_PANEL_FORMAT               0x090
 #define INTF_TPG_ENABLE                 0x100
 #define INTF_TPG_MAIN_CONTROL           0x104
 #define INTF_TPG_VIDEO_CONFIG           0x108
@@ -57,6 +59,9 @@
 #define INTF_PROG_FETCH_START           0x170
 #define INTF_PROG_ROT_START             0x174
 
+#define INTF_MISR_CTRL                  0x180
+#define INTF_MISR_SIGNATURE             0x184
+
 #define INTF_MUX                        0x25C
 #define INTF_STATUS                     0x26C
 
@@ -66,9 +71,6 @@
 #define INTF_CFG2_DATABUS_WIDEN	BIT(0)
 #define INTF_CFG2_DATA_HCTL_EN	BIT(4)
 
-#define INTF_MISR_CTRL			0x180
-#define INTF_MISR_SIGNATURE		0x184
-
 static const struct dpu_intf_cfg *_intf_offset(enum dpu_intf intf,
 		const struct dpu_mdss_cfg *m,
 		void __iomem *addr,

-- 
2.40.1

