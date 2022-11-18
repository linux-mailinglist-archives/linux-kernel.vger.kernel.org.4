Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060E262F18B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbiKRJlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbiKRJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:40:55 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2472CAF0AB;
        Fri, 18 Nov 2022 01:40:24 -0800 (PST)
Received: from pyrite.tail37cf.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 475BBCE1;
        Fri, 18 Nov 2022 10:40:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668764422;
        bh=FPCiCOCNyslyynz0t5SREsW5aFZwSGxK0F1dxJKpOLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lR4JJyUnTy4uK10+TOuXm4Hmqtnt418b9D44q/EjUwCFc/cD6LYCvGBGbhEme/zR/
         oVzlb+yX9jmuhEITImQs+gYinbF3cCmjDwfChABh3kCQznNobhzW62eCnZnmFmaNSo
         PYGA2haBQ3klxQjI72ygNH/CgSdjtv5TGS7byqoo=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/14] media: rkisp1: Add register definitions for the test pattern generator
Date:   Fri, 18 Nov 2022 18:39:27 +0900
Message-Id: <20221118093931.1284465-11-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add register definitions and value macros for the test pattern generator
block in the ISP.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Dafna Hirschfeld <dafna@fastmail.com>
---
 .../platform/rockchip/rkisp1/rkisp1-regs.h    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
index 6597c563f892..3dd1bfec288f 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
@@ -718,6 +718,27 @@
 #define RKISP1_CIF_ISP_DPF_SPATIAL_COEFF_MAX		0x1F
 #define RKISP1_CIF_ISP_DPF_NLL_COEFF_N_MAX		0x3FF
 
+/* TPG */
+#define RKISP1_CIF_ISP_TPG_CTRL_ENA			BIT(0)
+#define RKISP1_CIF_ISP_TPG_CTRL_IMG_3X3_COLOR_BLOCK	(0 << 1)
+#define RKISP1_CIF_ISP_TPG_CTRL_IMG_COLOR_BAR		(1 << 1)
+#define RKISP1_CIF_ISP_TPG_CTRL_IMG_GRAY_BAR		(2 << 1)
+#define RKISP1_CIF_ISP_TPG_CTRL_IMG_HIGHLIGHT_GRID	(3 << 1)
+#define RKISP1_CIF_ISP_TPG_CTRL_IMG_RAND		(4 << 1)
+#define RKISP1_CIF_ISP_TPG_CTRL_CFA_RGGB		(0 << 4)
+#define RKISP1_CIF_ISP_TPG_CTRL_CFA_GRBG		(1 << 4)
+#define RKISP1_CIF_ISP_TPG_CTRL_CFA_GBRB		(2 << 4)
+#define RKISP1_CIF_ISP_TPG_CTRL_CFA_BGGR		(3 << 4)
+#define RKISP1_CIF_ISP_TPG_CTRL_DEPTH_8			(0 << 6)
+#define RKISP1_CIF_ISP_TPG_CTRL_DEPTH_10		(1 << 6)
+#define RKISP1_CIF_ISP_TPG_CTRL_DEPTH_12		(2 << 6)
+#define RKISP1_CIF_ISP_TPG_CTRL_DEF_SYNC		BIT(8)
+#define RKISP1_CIF_ISP_TPG_CTRL_MAX_SYNC		BIT(9)
+#define RKISP1_CIF_ISP_TPG_CTRL_SOL_1080P		(0 << 10)
+#define RKISP1_CIF_ISP_TPG_CTRL_SOL_720P		(1 << 10)
+#define RKISP1_CIF_ISP_TPG_CTRL_SOL_4K			(2 << 10)
+#define RKISP1_CIF_ISP_TPG_CTRL_SOL_USER_DEFINED	(3 << 10)
+
 /* =================================================================== */
 /*                            CIF Registers                            */
 /* =================================================================== */
@@ -913,6 +934,17 @@
 #define RKISP1_CIF_ISP_SH_DELAY			(RKISP1_CIF_ISP_SH_BASE + 0x00000008)
 #define RKISP1_CIF_ISP_SH_TIME			(RKISP1_CIF_ISP_SH_BASE + 0x0000000C)
 
+#define RKISP1_CIF_ISP_TPG_BASE			0x00000700
+#define RKISP1_CIF_ISP_TPG_CTRL			(RKISP1_CIF_ISP_TPG_BASE + 0x00000000)
+#define RKISP1_CIF_ISP_TPG_TOTAL_IN		(RKISP1_CIF_ISP_TPG_BASE + 0x00000004)
+#define RKISP1_CIF_ISP_TPG_ACT_IN		(RKISP1_CIF_ISP_TPG_BASE + 0x00000008)
+#define RKISP1_CIF_ISP_TPG_FP_IN		(RKISP1_CIF_ISP_TPG_BASE + 0x0000000C)
+#define RKISP1_CIF_ISP_TPG_BP_IN		(RKISP1_CIF_ISP_TPG_BASE + 0x00000010)
+#define RKISP1_CIF_ISP_TPG_W_IN			(RKISP1_CIF_ISP_TPG_BASE + 0x00000014)
+#define RKISP1_CIF_ISP_TPG_GAP_IN		(RKISP1_CIF_ISP_TPG_BASE + 0x00000018)
+#define RKISP1_CIF_ISP_TPG_GAP_STD_IN		(RKISP1_CIF_ISP_TPG_BASE + 0x0000001C)
+#define RKISP1_CIF_ISP_TPG_RANDOM_SEED_IN	(RKISP1_CIF_ISP_TPG_BASE + 0x00000020)
+
 #define RKISP1_CIF_C_PROC_BASE			0x00000800
 #define RKISP1_CIF_C_PROC_CTRL			(RKISP1_CIF_C_PROC_BASE + 0x00000000)
 #define RKISP1_CIF_C_PROC_CONTRAST		(RKISP1_CIF_C_PROC_BASE + 0x00000004)
-- 
2.35.1

