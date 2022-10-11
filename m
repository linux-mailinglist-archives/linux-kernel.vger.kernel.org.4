Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D135FBF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJLDsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJLDru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:47:50 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E31A7A87
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:47:44 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221012034742epoutp01dec69b219c2df4addb8a9a542da84873~dNa7L-1Hs2322123221epoutp01N
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:47:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221012034742epoutp01dec69b219c2df4addb8a9a542da84873~dNa7L-1Hs2322123221epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546462;
        bh=e2QO8IIE0yzcd49QROG9JOjfB9Dl7bhlmZ1b1T/e40I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFQdrYRpEGxEyV1uK/rUcKaGYrNiEMaglD4IvslJjU18EpXIQUDFdugCps0h4Rgqh
         SBhhsteZsouKOkq/jr462CCjNaRaNBfYBRwGiq5+74Kghqxy12zwaZtPLRu+DZre+w
         axRXSvPdZyv9zz1UG4SEmg9V7MrqAGMNwfBzAdBg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221012034740epcas5p426ba642a18ff116b5c358188e9a509c2~dNa5ynJUQ1445014450epcas5p4T;
        Wed, 12 Oct 2022 03:47:40 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MnJWX3M0Fz4x9Q9; Wed, 12 Oct
        2022 03:47:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.EB.39477.8D836436; Wed, 12 Oct 2022 12:47:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125148epcas5p10f1788595398637dbceebe1c4dbf0df2~dBMthaP_n3098030980epcas5p1B;
        Tue, 11 Oct 2022 12:51:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221011125148epsmtrp1d831b2610c551d6a40db53da27afd6ae~dBMtfYLSl2654526545epsmtrp1E;
        Tue, 11 Oct 2022 12:51:48 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-4b-634638d8ac0c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.0D.14392.4E665436; Tue, 11 Oct 2022 21:51:48 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125145epsmtip130e4165128e4af80772d985220791620~dBMqdGuN62344423444epsmtip1X;
        Tue, 11 Oct 2022 12:51:45 +0000 (GMT)
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
Subject: [Patch v3 03/15] media: s5p-mfc: Rename IS_MFCV10 macro
Date:   Tue, 11 Oct 2022 17:55:04 +0530
Message-Id: <20221011122516.32135-4-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfVBUVRjGO/fu3l0g9Ipixy1xuw0WJLiLCx4cvgpx7khjVDM17sTQnd0b
        EMvutnchokmRhMkVJEomvr8WaEQFXL4/FIINHLNmNg0adFkQCEErAjIM1HZZqP9+7/M+zzlz
        3nOOEPcYI0TCRLWe1akZFUW48toGfHz8fkGHFBJLw3Y03VHER+PlbQQyLs9gyGZc5KH+5lYB
        arlZgqNvhvr4qML8Ix+1f3uHhy7dtXctRVYemqloAGi2eIxApslhPpqYewfd6ColUE5TKx9d
        NFsFqHbEgqE60yqGqluXBCjrslmArD1tAJ3MNmMRkL5QfgHQHdYaQI/ULOB0Z7FVQBt7ZjHa
        VH+KoG8P9xB0c81xOuu7f3j0mZZ6QD/OLBPQBvMIQS+avOhrfy0KYjbJk0ISWEbJ6sSsWqFR
        JqrjQ6not+Ii4wKDJFI/aTDaT4nVTDIbSh18LcbvUKLKPgZKnMqoUuxSDMNx1N6wEJ0mRc+K
        EzScPpRitUqVVqb155hkLkUd769m9QekEklAoN34XlLCcHkvpp06kDb0aJGfAb6XGoBQCEkZ
        vLLsagAuQg+yG8AVW4gBuNp5AUBTp43vLB4A2DG6CjYCt+qOOvXLANY2zmHOIguDts5K3LEU
        QfrB3to+wsHbyBMATn6ud5hw8jMetF5fETgaW8kImNdUvhbgkd4wZ+7WGruTobBgYX7NA8ld
        8HxT35ruQobBP2sHCcdCkDztAtutVYTTdBBezfkJd/JWODfUsh4Wwdm87HVWwMnq2XWPCjb2
        nOU5ORz23SzlOY6Gkz6wsWuvU94JC641YA7GyU0wd2UKc+rusKN8g3fD0tvLfCc/BwfO1wIn
        0/Be/zjfOdN8ADO+ivwCeBX/v0MlAPVgB6vlkuNZLlAboGY/+u/OFJpkE1h76L6HO8DE+Lx/
        P8CEoB9AIU5tcwcVryo83JXMx+msThOnS1GxXD8ItM8vHxd5KjT2n6LWx0llwRJZUFCQLHhf
        kJR6xt1Y6KvwIOMZPZvEslpWt5HDhC6iDKxg85szqcouo9zycmXGGzXd42fpX1cbPuA+aQ+L
        3Nye6yXeWXip+krz/NEPqd60Z5lw1Nry1LGydyt+M+SGlwoa1MY/FlLzJ/Tp1x80HRu98QQW
        pv+cye0o2iLPnqbhuSOe5wg/A7f8w2DT3/eTzdhSo1bp7UXJ3Q7vTrs6d4R5W/RSneWi5yvR
        j8owc3NV8Z4+7UmbdfpEVNFS1dc2udionLF07r+7Pfb0fezJ2OipOM99sTq+7Mukcfnv3sJV
        N/3r0VNRj+/V5VXWDWQz3VtkoST2wpmHJZHaTLfhPRG7jj988X2s7XnenacHcREKDsksjU0r
        CQ8QRU34SKotuoqJTykel8BIfXEdx/wL+XohFnEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnO6TNNdkg0WP1Cye7pjJavFg3jY2
        i8U/njNZ3F/8mcXi0Oat7BZbrsxmtlh+/ACrxfwj51gtth98xGKx8QVQ9uLMuywWz+evY7R4
        Oesem8Wmx9dYLR6+Cre4vGsOm0XPhq2sFmuP3GW3WHr9IpPFsk1/mCwWbf3CbtG69wi7xd09
        2xgtWtqOMDlIeKyZt4bRY8fdJYwe15d8YvbYOesuu8fiPS+ZPDat6mTzuHNtD5vH5iX1Hq1H
        f7F49G1Zxejxr2kuu0fXketsHp83yXmc+vqZPYAvissmJTUnsyy1SN8ugSvj2rz9TAVPrCqO
        //3M2sB42rCLkYNDQsBE4vayyC5GLg4hgd2MEi/P3mLsYuQEistI/G87xg5hC0us/PecHaKo
        mUni3I3tLCAJNgFdif1LD7CBJEQEWhklrq/sZAJxmAVms0j8mHSAFaRKWMBBon/DPGYQm0VA
        VaLn1W0wm1fAVmLqpw9QK+QlVm84ABbnFLCT+Lj0GBuILQRU0/h+KtMERr4FjAyrGCVTC4pz
        03OLDQsM81LL9YoTc4tL89L1kvNzNzGCI09Lcwfj9lUf9A4xMnEwHmKU4GBWEuFlnO+ULMSb
        klhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTgKgw74PFcqsu
        ldiUve1ku+wlm6Saddm9KN7/7Nl9kw7VfvrvdHfXyZMvHP+t55mwXLha+IfktF2qsz9VrfEs
        annVsfJKRk6KbeiOx+bNvN/uu5/8w1Kx4c77vEnNE5Wzzn7rKHA7/frc1CvFP69PETJaNbuC
        o8ursiRdVDz4P0uAQ0nMIoPtGZn7Lwc4GW0qfbPo9WT5H482NOl+CmKv4H8mFnyRqWdmCbv6
        o4bzzcxsXTy3t81ui45vdrp8MekuO/OxncqHbU8Yn7Nm8v27YMHL5+Uxs20PvLqh7XBuWtMi
        T/67H3/U7SvvlrMonL34KbfDrzNerDkmcRdrO28I58T51zVNZJY97CZ14OdBJZbijERDLeai
        4kQAQhLBvSsDAAA=
X-CMS-MailID: 20221011125148epcas5p10f1788595398637dbceebe1c4dbf0df2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125148epcas5p10f1788595398637dbceebe1c4dbf0df2
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125148epcas5p10f1788595398637dbceebe1c4dbf0df2@epcas5p1.samsung.com>
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

Renames macro IS_MFCV10 to IS_MFCV10_PLUS so that the MFCv10 code can
be resued for MFCv12 support. Since some part of MFCv10 specific code
holds good for MFCv12 also.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h | 10 +++----
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 28 +++++++++----------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index 5304f42c8c72..e6ec4a43b290 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -771,11 +771,11 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
 #define HAS_PORTNUM(dev)	(dev ? (dev->variant ? \
 				(dev->variant->port_num ? 1 : 0) : 0) : 0)
 #define IS_TWOPORT(dev)		(dev->variant->port_num == 2 ? 1 : 0)
-#define IS_MFCV6_PLUS(dev)	(dev->variant->version >= 0x60 ? 1 : 0)
-#define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70 ? 1 : 0)
-#define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80 ? 1 : 0)
-#define IS_MFCV10(dev)		(dev->variant->version >= 0xA0 ? 1 : 0)
-#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10(dev))
+#define IS_MFCV6_PLUS(dev)	(dev->variant->version >= 0x60)
+#define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70)
+#define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80)
+#define IS_MFCV10_PLUS(dev)	(dev->variant->version >= 0xA0)
+#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
 
 #define MFC_V5_BIT	BIT(0)
 #define MFC_V6_BIT	BIT(1)
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index 72d70984e99a..ffe9f7e79eca 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -236,7 +236,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
 	else
 		mfc_write(dev, 0x3ff, S5P_FIMV_SW_RESET);
 
-	if (IS_MFCV10(dev))
+	if (IS_MFCV10_PLUS(dev))
 		mfc_write(dev, 0x0, S5P_FIMV_MFC_CLOCK_OFF_V10);
 
 	mfc_debug(2, "Will now wait for completion of firmware transfer\n");
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 8227004f6746..728d255e65fc 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -72,9 +72,9 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			  ctx->luma_size, ctx->chroma_size, ctx->mv_size);
 		mfc_debug(2, "Totals bufs: %d\n", ctx->total_dpb_count);
 	} else if (ctx->type == MFCINST_ENCODER) {
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev))
 			ctx->tmv_buffer_size = 0;
-		} else if (IS_MFCV8_PLUS(dev))
+		else if (IS_MFCV8_PLUS(dev))
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V8(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
@@ -82,7 +82,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
 			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
 			if (ctx->codec_mode != S5P_FIMV_CODEC_HEVC_ENC) {
@@ -133,7 +133,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 	switch (ctx->codec_mode) {
 	case S5P_MFC_CODEC_H264_DEC:
 	case S5P_MFC_CODEC_H264_MVC_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else if (IS_MFCV8_PLUS(dev))
 			ctx->scratch_buf_size =
@@ -152,7 +152,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			(ctx->mv_count * ctx->mv_size);
 		break;
 	case S5P_MFC_CODEC_MPEG4_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else if (IS_MFCV7_PLUS(dev)) {
 			ctx->scratch_buf_size =
@@ -172,7 +172,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		break;
 	case S5P_MFC_CODEC_VC1RCV_DEC:
 	case S5P_MFC_CODEC_VC1_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else
 			ctx->scratch_buf_size =
@@ -189,7 +189,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_H263_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else
 			ctx->scratch_buf_size =
@@ -201,7 +201,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank1.size = ctx->scratch_buf_size;
 		break;
 	case S5P_MFC_CODEC_VP8_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else if (IS_MFCV8_PLUS(dev))
 			ctx->scratch_buf_size =
@@ -230,7 +230,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			DEC_VP9_STATIC_BUFFER_SIZE;
 		break;
 	case S5P_MFC_CODEC_H264_ENC:
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 			ALIGN(ENC_V100_H264_ME_SIZE(mb_width, mb_height), 16);
@@ -254,7 +254,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		break;
 	case S5P_MFC_CODEC_MPEG4_ENC:
 	case S5P_MFC_CODEC_H263_ENC:
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
@@ -273,7 +273,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_VP8_ENC:
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width, mb_height),
@@ -452,7 +452,7 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
 
 	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
 			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx->img_width,
 					ctx->img_height);
 		} else {
@@ -668,7 +668,7 @@ static int s5p_mfc_set_enc_ref_buffer_v6(struct s5p_mfc_ctx *ctx)
 
 	mfc_debug(2, "Buf1: %p (%d)\n", (void *)buf_addr1, buf_size1);
 
-	if (IS_MFCV10(dev)) {
+	if (IS_MFCV10_PLUS(dev)) {
 		/* start address of per buffer is aligned */
 		for (i = 0; i < ctx->pb_count; i++) {
 			writel(buf_addr1, mfc_regs->e_luma_dpb + (4 * i));
@@ -2455,7 +2455,7 @@ const struct s5p_mfc_regs *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
 	R(e_h264_options, S5P_FIMV_E_H264_OPTIONS_V8);
 	R(e_min_scratch_buffer_size, S5P_FIMV_E_MIN_SCRATCH_BUFFER_SIZE_V8);
 
-	if (!IS_MFCV10(dev))
+	if (!IS_MFCV10_PLUS(dev))
 		goto done;
 
 	/* Initialize registers used in MFC v10 only.
-- 
2.17.1

