Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480956107BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbiJ1COk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiJ1COe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:14:34 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAACD6A;
        Thu, 27 Oct 2022 19:14:26 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DA5E1A0A58;
        Fri, 28 Oct 2022 04:14:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 429A11A0AC9;
        Fri, 28 Oct 2022 04:14:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3BB93180327D;
        Fri, 28 Oct 2022 10:14:23 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     shengjiu.wang@gmail.com, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de
Subject: [PATCH v3 3/3] dt-bindings: clock: imx8mp: Remove unused IMX8MP_CLK_AUDIO_ROOT
Date:   Fri, 28 Oct 2022 09:53:45 +0800
Message-Id: <1666922026-6943-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1666922026-6943-1-git-send-email-shengjiu.wang@nxp.com>
References: <1666922026-6943-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused IMX8MP_CLK_AUDIO_ROOT which is replaced by
IMX8MP_CLK_AUDIO_AHB_ROOT.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/dt-bindings/clock/imx8mp-clock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 2f6fec299662..6619227f51ab 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -286,7 +286,6 @@
 #define IMX8MP_CLK_TSENSOR_ROOT			281
 #define IMX8MP_CLK_VPU_ROOT			282
 #define IMX8MP_CLK_MRPR_ROOT			283
-#define IMX8MP_CLK_AUDIO_ROOT			284
 #define IMX8MP_CLK_DRAM_ALT_ROOT		285
 #define IMX8MP_CLK_DRAM_CORE			286
 #define IMX8MP_CLK_ARM				287
-- 
2.34.1

