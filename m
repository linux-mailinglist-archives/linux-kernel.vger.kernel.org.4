Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE745FBF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJLDsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJLDrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:47:53 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D341A7AB0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:47:45 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221012034743epoutp0189a6f18565b2dac50418141876f0de7b~dNa8a-gE72161421614epoutp013
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:47:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221012034743epoutp0189a6f18565b2dac50418141876f0de7b~dNa8a-gE72161421614epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546463;
        bh=ModkGWxFDAKDKfWBNLUkFoSdAkUWBo2U6vKDYwnN88I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pqkox3fBLWlgb8yi0sbAT1aPfvcz/zGIKCs0MRpKyYxw/gGgT4i2yXhTJelBrL9XN
         zLAFcjHi+56bnDPnokUJff9Z/fbvlcKjZ3TSFzz3PbnTP+IyaAFa+V/FF/wmfDtVrl
         YifsP5S/5dzR8eGUjtHsndOSL7QhqbkmbbsA7L6Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221012034742epcas5p4a0bec7051be65151b6f19d0491579700~dNa70L6s-3230832308epcas5p40;
        Wed, 12 Oct 2022 03:47:42 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MnJWb3b7bz4x9Pv; Wed, 12 Oct
        2022 03:47:39 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.72.56352.BD836436; Wed, 12 Oct 2022 12:47:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221011125152epcas5p3a9966cfafa53928023a97143d5e3a7f0~dBMwutmWQ1027410274epcas5p3N;
        Tue, 11 Oct 2022 12:51:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221011125152epsmtrp1ea4b935ae0797f7f3f6836ae4d062734~dBMwsOnnb2656926569epsmtrp13;
        Tue, 11 Oct 2022 12:51:52 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-0f-634638dbd03f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.84.18644.7E665436; Tue, 11 Oct 2022 21:51:52 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125148epsmtip184e73f6e1c42751e055122decc293f32~dBMtmSfeC2178621786epsmtip1r;
        Tue, 11 Oct 2022 12:51:48 +0000 (GMT)
From:   aakarsh jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v3 04/15] media: s5p-mfc: Add initial support for MFCv12
Date:   Tue, 11 Oct 2022 17:55:05 +0530
Message-Id: <20221011122516.32135-5-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTeVBTVxTG5773khechnmNtlwpRUy1UzIFE7ZeHECrlD6gCx07I60daCa8
        EoaQZLK0inXKUhAYxYDaCkSgJGiHTQlbwKCAKbZ0UZaBTjGspRBqFwkWKw5tQqD97/ed8517
        zpx7LwfnTbO9OWlyDaOSi2V89hai/ab/CwHjKEYivJ7lhebMZSw0VdnORoaH8xiaNDgI1NfS
        RqLWkQocXb7Vw0JV1h9YqKN3hkDNC87sYJmNQPNVTQDZyyfYyDQ7ykLTi4fRcJeejU5dbWOh
        RquNRLVjgxi6ZHqMoZq2ZRLldVtJZLO0A/RpvhXbD+mGygZAm21GQI8Zl3C6s9xG0gaLHaNN
        dYVs+u6ohU23GD+h8756RNDFrXWAXsu5SNJF1jE27TD50gMPHGSC57vpEVJGnMKo/Bi5RJGS
        Jk+N5McfSj6YHBomFAWIwtFLfD+5OIOJ5Ee/lhAQkyZzroHv96FYpnWGEsRqNX9PVIRKodUw
        flKFWhPJZ5QpMmWIMlAtzlBr5amBckazVyQUBoU6je+nS22nn1MWnARHO2uCs0CJsgh4cCAV
        Am1dy2QR2MLhUdcANBZPY26xBOBi/S+EWzgAXKvLZm+WPGqy4+5EF4BT3WaWW+RhcObcN6TL
        xaYC4I3anvWKbVQ2gLMFGpcJp3IJaPtudd20laLhiqFtnQlqNywfzCVczKUi4Y8Tdpa73Q5Y
        f7UHd7EHFQXv1/azXQdB6qQHnM+dxN2maPjZPR3p5q1w8VbrBntD+5n8DZbA2Rr7hl8Gr1jO
        EW7eB3tG9E7mOKfzh1e69rjDz8LzA02Yi3HKE55e/Rlzx7nQXLnJz0P93Ycbc/rAm/W1wM00
        vDNYsLGiEgALHlwidMC3/P8W1QDUge2MUp2RyqhDlcFy5qP/rk2iyDCB9bcuiDeDmak/A/sA
        xgF9AHJw/jYuqDog4XFTxMcyGZUiWaWVMeo+EOpcYAnu/ZRE4fwsck2yKCRcGBIWFhYSHhwm
        4ntxDRcEEh6VKtYw6QyjZFSbdRjHwzsLw6eO19j0jv7CjwnPs6L7cb4RAzKv4sbUD/66nVQi
        rjYOS5KDLvCSrCeCpCiqPpGnF5Uunz0+WWTgleYyNYOOid/3/aGrvghzdmHA7PNP866hBv+d
        h35aSHHM/dYo0I93FJa9FXetGg0XrNhRfOLyExnT3PHtAkv+iUXdM2/8HffeF4cr33n5SMWT
        b2frJrW3PZsF2T2vClsyed9ed4j42sfR+LEl61Bv7JerHTplf71pxCfpfKzAPvp0TnC76iht
        MH5veSXxxd1zVOebCzuOHJjKLkyMrZCujNxoPPjrvd6dzd2soTzy8lpE++dVpErSnZX5esT+
        vcL0uq/vxJwyluZK+YRaKhYJcJVa/C/tDi1VdAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSnO6LNNdkgx0XGC2e7pjJavFg3jY2
        i8U/njNZ3F/8mcXi0Oat7BZbrsxmtlh+/ACrxfwj51gtth98xGKx8QVQ9uLMuywWz+evY7R4
        Oesem8Wmx9dYLR6+Cre4vGsOm0XPhq2sFmuP3GW3WHr9IpPFsk1/mCwWbf3CbtG69wi7xd09
        2xgtWtqOMDlIeKyZt4bRY8fdJYwe15d8YvbYOesuu8fiPS+ZPDat6mTzuHNtD5vH5iX1Hq1H
        f7F49G1Zxejxr2kuu0fXketsHp83yXmc+vqZPYAvissmJTUnsyy1SN8ugSvjbq9yQUc7Y8XO
        RcYNjBMLuhg5OSQETCR+rXvJDGILCexglDh3rRYiLiPxv+0YO4QtLLHy33MgmwuopplJ4nnj
        PRaQBJuArsT+pQfYQBIiAq2MEtdXdjKBOMwCs1kkfkw6wApSJSzgIfF98VawUSwCqhKzLjaD
        dfMK2ErcuPeSFWKFvMTqDQfAzuAUsJP4uPQYG8RJthKN76cyTWDkW8DIsIpRMrWgODc9t9iw
        wCgvtVyvODG3uDQvXS85P3cTIzjutLR2MO5Z9UHvECMTB+MhRgkOZiURXsb5TslCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MEk9u9m6jjPYZsaqvFVd
        nX8eRJRaHymalre7u6ldwvKGeujEdVsWKF2VTWSarPpBZ5/vPg/LF0Hvbtd/zV4neWJCn8Sy
        83u4dx/fUfZZ5YAp0x9DngVNh5amnv/7vnCRfEtw5QONnk8xfbLcx3YbmVvkb86cEsN6/EKU
        YRfnlN/cC1ZsjrVMX3kq/NTllPKQbL/Ntx88beG/3roqUDVE7tdUrbd6k38niDafuqz7YeUK
        XcVQhrjoc0umunJzv54SON3+tNX+dqU6keq7gZyxVav3zZ2Svpn91ufLR8QzdZksWKR29Nb9
        525raJpzba7E8ljNiwFXDlnNdK/kOf6I+9HjF0vvJpn0bJywJ/BUd4kSS3FGoqEWc1FxIgA3
        VDtLKgMAAA==
X-CMS-MailID: 20221011125152epcas5p3a9966cfafa53928023a97143d5e3a7f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125152epcas5p3a9966cfafa53928023a97143d5e3a7f0
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125152epcas5p3a9966cfafa53928023a97143d5e3a7f0@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Smitha T Murthy <smitha.t@samsung.com>

Add support for MFCv12, with a new register file and necessary hw
control, decoder, encoder and structural changes. Add luma dbp, chroma
dpb and mv sizes for each codec as per the UM for MFCv12, along with
appropriate alignment.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   | 50 +++++++++++
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  | 30 +++++++
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h | 15 +++-
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  6 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    |  5 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  8 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 83 ++++++++++++++++---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |  6 +-
 9 files changed, 175 insertions(+), 30 deletions(-)
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h

diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
new file mode 100644
index 000000000000..6c68a45082d0
--- /dev/null
+++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Register definition file for Samsung MFC V12.x Interface (FIMV) driver
+ *
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ *     http://www.samsung.com/
+ */
+
+#ifndef _REGS_MFC_V12_H
+#define _REGS_MFC_V12_H
+
+#include <linux/sizes.h>
+#include "regs-mfc-v10.h"
+
+/* MFCv12 Context buffer sizes */
+#define MFC_CTX_BUF_SIZE_V12		(30 * SZ_1K)
+#define MFC_H264_DEC_CTX_BUF_SIZE_V12	(2 * SZ_1M)
+#define MFC_OTHER_DEC_CTX_BUF_SIZE_V12	(30 * SZ_1K)
+#define MFC_H264_ENC_CTX_BUF_SIZE_V12	(100 * SZ_1K)
+#define MFC_HEVC_ENC_CTX_BUF_SIZE_V12	(40 * SZ_1K)
+#define MFC_OTHER_ENC_CTX_BUF_SIZE_V12	(25 * SZ_1K)
+
+/* MFCv12 variant defines */
+#define MAX_FW_SIZE_V12			(SZ_1M)
+#define MAX_CPB_SIZE_V12		(7 * SZ_1M)
+#define MFC_VERSION_V12			0xC0
+#define MFC_NUM_PORTS_V12		1
+#define S5P_FIMV_CODEC_VP9_ENC		27
+
+/* Encoder buffer size for MFCv12 */
+#define ENC_V120_BASE_SIZE(x, y) \
+	(((x + 3) * (y + 3) * 8) \
+	+ (((y * 64) + 2304) * (x + 7) / 8))
+
+#define ENC_V120_H264_ME_SIZE(x, y) \
+	ALIGN((ENC_V120_BASE_SIZE(x, y) \
+	+ (DIV_ROUND_UP(x * y, 64) * 32)), 256)
+
+#define ENC_V120_MPEG4_ME_SIZE(x, y) \
+	ALIGN((ENC_V120_BASE_SIZE(x, y) \
+	+ (DIV_ROUND_UP(x * y, 128) * 16)), 256)
+
+#define ENC_V120_VP8_ME_SIZE(x, y) \
+	ALIGN(ENC_V120_BASE_SIZE(x, y), 256)
+
+#define ENC_V120_HEVC_ME_SIZE(x, y)     \
+	ALIGN((((x + 3) * (y + 3) * 32)       \
+	+ (((y * 128) + 2304) * (x + 3) / 4)), 256)
+
+#endif /*_REGS_MFC_V12_H*/
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index fca5c6405eec..fe07112f013f 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -775,6 +775,8 @@ static int s5p_mfc_open(struct file *file)
 	INIT_LIST_HEAD(&ctx->dst_queue);
 	ctx->src_queue_cnt = 0;
 	ctx->dst_queue_cnt = 0;
+	ctx->is_422 = 0;
+	ctx->is_10bit = 0;
 	/* Get context number */
 	ctx->num = 0;
 	while (dev->ctx[ctx->num]) {
@@ -1637,6 +1639,31 @@ static struct s5p_mfc_variant mfc_drvdata_v10 = {
 	.fw_name[0]     = "s5p-mfc-v10.fw",
 };
 
+static struct s5p_mfc_buf_size_v6 mfc_buf_size_v12 = {
+	.dev_ctx        = MFC_CTX_BUF_SIZE_V12,
+	.h264_dec_ctx   = MFC_H264_DEC_CTX_BUF_SIZE_V12,
+	.other_dec_ctx  = MFC_OTHER_DEC_CTX_BUF_SIZE_V12,
+	.h264_enc_ctx   = MFC_H264_ENC_CTX_BUF_SIZE_V12,
+	.hevc_enc_ctx   = MFC_HEVC_ENC_CTX_BUF_SIZE_V12,
+	.other_enc_ctx  = MFC_OTHER_ENC_CTX_BUF_SIZE_V12,
+};
+
+static struct s5p_mfc_buf_size buf_size_v12 = {
+	.fw     = MAX_FW_SIZE_V12,
+	.cpb    = MAX_CPB_SIZE_V12,
+	.priv   = &mfc_buf_size_v12,
+};
+
+static struct s5p_mfc_variant mfc_drvdata_v12 = {
+	.version        = MFC_VERSION_V12,
+	.version_bit    = MFC_V12_BIT,
+	.port_num       = MFC_NUM_PORTS_V12,
+	.buf_size       = &buf_size_v12,
+	.fw_name[0]     = "s5p-mfc-v12.fw",
+	.clk_names	= {"mfc"},
+	.num_clocks	= 1,
+};
+
 static const struct of_device_id exynos_mfc_match[] = {
 	{
 		.compatible = "samsung,mfc-v5",
@@ -1656,6 +1683,9 @@ static const struct of_device_id exynos_mfc_match[] = {
 	}, {
 		.compatible = "samsung,mfc-v10",
 		.data = &mfc_drvdata_v10,
+	}, {
+		.compatible = "tesla,fsd-mfc",
+		.data = &mfc_drvdata_v12,
 	},
 	{},
 };
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index e6ec4a43b290..dd2e9f7704ab 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -19,7 +19,7 @@
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-v4l2.h>
 #include "regs-mfc.h"
-#include "regs-mfc-v10.h"
+#include "regs-mfc-v12.h"
 
 #define S5P_MFC_NAME		"s5p-mfc"
 
@@ -720,6 +720,8 @@ struct s5p_mfc_ctx {
 	struct v4l2_ctrl *ctrls[MFC_MAX_CTRLS];
 	struct v4l2_ctrl_handler ctrl_handler;
 	size_t scratch_buf_size;
+	int is_10bit;
+	int is_422;
 };
 
 /*
@@ -775,6 +777,7 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
 #define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70)
 #define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80)
 #define IS_MFCV10_PLUS(dev)	(dev->variant->version >= 0xA0)
+#define IS_MFCV12(dev)		(dev->variant->version >= 0xC0)
 #define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
 
 #define MFC_V5_BIT	BIT(0)
@@ -782,11 +785,15 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
 #define MFC_V7_BIT	BIT(2)
 #define MFC_V8_BIT	BIT(3)
 #define MFC_V10_BIT	BIT(5)
+#define MFC_V12_BIT	BIT(7)
 
 #define MFC_V5PLUS_BITS		(MFC_V5_BIT | MFC_V6_BIT | MFC_V7_BIT | \
-					MFC_V8_BIT | MFC_V10_BIT)
+					MFC_V8_BIT | MFC_V10_BIT | MFC_V12_BIT)
 #define MFC_V6PLUS_BITS		(MFC_V6_BIT | MFC_V7_BIT | MFC_V8_BIT | \
-					MFC_V10_BIT)
-#define MFC_V7PLUS_BITS		(MFC_V7_BIT | MFC_V8_BIT | MFC_V10_BIT)
+					MFC_V10_BIT | MFC_V12_BIT)
+#define MFC_V7PLUS_BITS		(MFC_V7_BIT | MFC_V8_BIT | MFC_V10_BIT | \
+					MFC_V12_BIT)
+
+#define MFC_V10PLUS_BITS	(MFC_V10_BIT | MFC_V12_BIT)
 
 #endif /* S5P_MFC_COMMON_H_ */
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index ffe9f7e79eca..877e5bceb75b 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -130,7 +130,7 @@ int s5p_mfc_reset(struct s5p_mfc_dev *dev)
 			mfc_write(dev, 0, S5P_FIMV_REG_CLEAR_BEGIN_V6 + (i*4));
 
 		/* check bus reset control before reset */
-		if (dev->risc_on)
+		if (dev->risc_on && !IS_MFCV12(dev))
 			if (s5p_mfc_bus_reset(dev))
 				return -EIO;
 		/* Reset
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
index 268ffe4da53c..e219cbcd86d5 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
@@ -146,7 +146,7 @@ static struct s5p_mfc_fmt formats[] = {
 		.codec_mode	= S5P_FIMV_CODEC_HEVC_DEC,
 		.type		= MFC_FMT_DEC,
 		.num_planes	= 1,
-		.versions	= MFC_V10_BIT,
+		.versions	= MFC_V10PLUS_BITS,
 		.flags		= V4L2_FMT_FLAG_DYN_RESOLUTION |
 				  V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM,
 	},
@@ -155,7 +155,7 @@ static struct s5p_mfc_fmt formats[] = {
 		.codec_mode	= S5P_FIMV_CODEC_VP9_DEC,
 		.type		= MFC_FMT_DEC,
 		.num_planes	= 1,
-		.versions	= MFC_V10_BIT,
+		.versions	= MFC_V10PLUS_BITS,
 		.flags		= V4L2_FMT_FLAG_DYN_RESOLUTION,
 	},
 };
@@ -355,7 +355,7 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 		pix_mp->width = ctx->buf_width;
 		pix_mp->height = ctx->buf_height;
 		pix_mp->field = V4L2_FIELD_NONE;
-		pix_mp->num_planes = 2;
+		pix_mp->num_planes = ctx->dst_fmt->num_planes;
 		/* Set pixelformat to the format in which MFC
 		   outputs the decoded frame */
 		pix_mp->pixelformat = ctx->dst_fmt->fourcc;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index b65e506665af..143d95fe2f89 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -92,7 +92,7 @@ static struct s5p_mfc_fmt formats[] = {
 		.codec_mode	= S5P_FIMV_CODEC_HEVC_ENC,
 		.type		= MFC_FMT_ENC,
 		.num_planes	= 1,
-		.versions	= MFC_V10_BIT,
+		.versions	= MFC_V10PLUS_BITS,
 	},
 };
 
@@ -1179,7 +1179,8 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
 		if (FW_HAS_E_MIN_SCRATCH_BUF(dev)) {
 			ctx->scratch_buf_size = s5p_mfc_hw_call(dev->mfc_ops,
 					get_e_min_scratch_buf_size, dev);
-			ctx->bank1.size += ctx->scratch_buf_size;
+			if (!IS_MFCV12(dev))
+				ctx->bank1.size += ctx->scratch_buf_size;
 		}
 		ctx->state = MFCINST_HEAD_PRODUCED;
 	}
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
index b9831275f3ab..87ac56756a16 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
@@ -166,9 +166,9 @@ struct s5p_mfc_regs {
 	void __iomem *d_decoded_third_addr;/* only v7 */
 	void __iomem *d_used_dpb_flag_upper;/* v7 and v8 */
 	void __iomem *d_used_dpb_flag_lower;/* v7 and v8 */
-	void __iomem *d_min_scratch_buffer_size; /* v10 */
-	void __iomem *d_static_buffer_addr; /* v10 */
-	void __iomem *d_static_buffer_size; /* v10 */
+	void __iomem *d_min_scratch_buffer_size; /* v10 and v12 */
+	void __iomem *d_static_buffer_addr; /* v10 and v12 */
+	void __iomem *d_static_buffer_size; /* v10 and v12 */
 
 	/* encoder registers */
 	void __iomem *e_frame_width;
@@ -268,7 +268,7 @@ struct s5p_mfc_regs {
 	void __iomem *e_vp8_hierarchical_qp_layer0;/* v7 and v8 */
 	void __iomem *e_vp8_hierarchical_qp_layer1;/* v7 and v8 */
 	void __iomem *e_vp8_hierarchical_qp_layer2;/* v7 and v8 */
-	void __iomem *e_min_scratch_buffer_size; /* v10 */
+	void __iomem *e_min_scratch_buffer_size; /* v10 and v12 */
 	void __iomem *e_num_t_layer; /* v10 */
 	void __iomem *e_hier_qp_layer0; /* v10 */
 	void __iomem *e_hier_bit_rate_layer0; /* v10 */
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 728d255e65fc..5d14ccf8b4fe 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -60,12 +60,14 @@ static void s5p_mfc_release_dec_desc_buffer_v6(struct s5p_mfc_ctx *ctx)
 static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	unsigned int mb_width, mb_height;
+	unsigned int mb_width, mb_height, width64, height32;
 	unsigned int lcu_width = 0, lcu_height = 0;
 	int ret;
 
 	mb_width = MB_WIDTH(ctx->img_width);
 	mb_height = MB_HEIGHT(ctx->img_height);
+	width64 = ALIGN(ctx->img_width, 64);
+	height32 = ALIGN(ctx->img_height, 32);
 
 	if (ctx->type == MFCINST_DECODER) {
 		mfc_debug(2, "Luma size:%d Chroma size:%d MV size:%d\n",
@@ -82,7 +84,44 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
+			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
+			if (ctx->codec_mode == S5P_FIMV_CODEC_HEVC_ENC &&
+								ctx->is_10bit) {
+				ctx->luma_dpb_size =
+					width64 * height32 +
+					ALIGN(DIV_ROUND_UP(lcu_width * 32, 4),
+							16) * height32 + 128;
+				if (ctx->is_422)
+					ctx->chroma_dpb_size =
+						ctx->luma_dpb_size;
+				else
+					ctx->chroma_dpb_size =
+						width64 * height32 / 2 +
+						ALIGN(DIV_ROUND_UP(lcu_width *
+						32, 4), 16) * height32 / 2 + 128;
+			} else if (ctx->codec_mode == S5P_FIMV_CODEC_VP9_ENC &&
+					ctx->is_10bit) {
+				ctx->luma_dpb_size =
+					ALIGN(ctx->img_width * 2, 128) *
+					height32 + 64;
+				ctx->chroma_dpb_size =
+					ALIGN(ctx->img_width * 2, 128) *
+					height32 / 2 + 64;
+			} else {
+				ctx->luma_dpb_size =
+					width64 * height32 + 64;
+				if (ctx->is_422)
+					ctx->chroma_dpb_size =
+						ctx->luma_dpb_size;
+				else
+					ctx->chroma_dpb_size =
+						width64 * height32 / 2 + 64;
+			}
+			ctx->luma_dpb_size = ALIGN(ctx->luma_dpb_size + 256, SZ_2K);
+			ctx->chroma_dpb_size = ALIGN(ctx->chroma_dpb_size + 256, SZ_2K);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
 			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
 			if (ctx->codec_mode != S5P_FIMV_CODEC_HEVC_ENC) {
@@ -230,7 +269,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			DEC_VP9_STATIC_BUFFER_SIZE;
 		break;
 	case S5P_MFC_CODEC_H264_ENC:
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ENC_V120_H264_ME_SIZE(mb_width, mb_height);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 			ALIGN(ENC_V100_H264_ME_SIZE(mb_width, mb_height), 16);
@@ -254,7 +297,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		break;
 	case S5P_MFC_CODEC_MPEG4_ENC:
 	case S5P_MFC_CODEC_H263_ENC:
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ENC_V120_MPEG4_ME_SIZE(mb_width, mb_height);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
@@ -273,7 +320,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_VP8_ENC:
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ENC_V120_VP8_ME_SIZE(mb_width, mb_height);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width, mb_height),
@@ -297,9 +348,14 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_HEVC_ENC:
+		if (IS_MFCV12(dev))
+			ctx->me_buffer_size =
+				ENC_V120_HEVC_ME_SIZE(lcu_width, lcu_height);
+		else
+			ctx->me_buffer_size =
+				ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width,
+							lcu_height), 16);
 		mfc_debug(2, "Use min scratch buffer size\n");
-		ctx->me_buffer_size =
-			ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width, lcu_height), 16);
 		ctx->scratch_buf_size = ALIGN(ctx->scratch_buf_size, 256);
 		ctx->bank1.size =
 			ctx->scratch_buf_size + ctx->tmv_buffer_size +
@@ -452,12 +508,15 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
 
 	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
 			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
-		if (IS_MFCV10_PLUS(dev)) {
-			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx->img_width,
-					ctx->img_height);
+		if (IS_MFCV12(dev)) {
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx->img_width,
+					ctx->img_height, 1024);
+		} else if (IS_MFCV10_PLUS(dev)) {
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx->img_width,
+					ctx->img_height, 512);
 		} else {
-			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V6(ctx->img_width,
-					ctx->img_height);
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx->img_width,
+					ctx->img_height, 128);
 		}
 	} else if (ctx->codec_mode == S5P_MFC_CODEC_HEVC_DEC) {
 		ctx->mv_size = s5p_mfc_dec_hevc_mv_size(ctx->img_width,
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
index e4dd03c5454c..30269f3e68e8 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
@@ -19,10 +19,8 @@
 
 #define MB_WIDTH(x_size)		DIV_ROUND_UP(x_size, 16)
 #define MB_HEIGHT(y_size)		DIV_ROUND_UP(y_size, 16)
-#define S5P_MFC_DEC_MV_SIZE_V6(x, y)	(MB_WIDTH(x) * \
-					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 128)
-#define S5P_MFC_DEC_MV_SIZE_V10(x, y)	(MB_WIDTH(x) * \
-					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 512)
+#define S5P_MFC_DEC_MV_SIZE(x, y, offset)	(MB_WIDTH(x) * \
+					(((MB_HEIGHT(y)+1)/2)*2) * 64 + offset)
 #define S5P_MFC_LCU_WIDTH(x_size)	DIV_ROUND_UP(x_size, 32)
 #define S5P_MFC_LCU_HEIGHT(y_size)	DIV_ROUND_UP(y_size, 32)
 
-- 
2.17.1

