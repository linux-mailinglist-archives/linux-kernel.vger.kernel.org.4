Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68B65FBFA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJLDtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJLDs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:48:28 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40535A99E1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:47:59 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221012034757epoutp03d63937b990607c64ab5c564cff2ae3c9~dNbJLskUr2718227182epoutp036
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:47:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221012034757epoutp03d63937b990607c64ab5c564cff2ae3c9~dNbJLskUr2718227182epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546477;
        bh=WEsZ6wE4E1YB1ommn23BbEZzCmsr2JF0Deqy/8l8VXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uiu7N9hbQVhZQY+VTIyvLD1YjW+4NqAfFfTmcahWZ7c6ZkQu8MKKoT3WENKFsH6e6
         frNWZTMSUH6154lDUNXrBz3ioihqAr2eImUKBYH0KYVbFt/Vo3gnqSEMacgVk9fGFm
         /vDhl1IJDBx3qjNYNCNcqoNOSz+GveEpZuR8/9I0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221012034755epcas5p32ad5330ee8ae09bdf106e4e2f6920f71~dNbIBzo0j0326403264epcas5p3P;
        Wed, 12 Oct 2022 03:47:55 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MnJWs0022z4x9Q3; Wed, 12 Oct
        2022 03:47:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.FB.39477.8E836436; Wed, 12 Oct 2022 12:47:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221011125202epcas5p4ef2d0dc9b6c434912b5c552c20bff4f5~dBM6N0QQx1275512755epcas5p4U;
        Tue, 11 Oct 2022 12:52:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221011125202epsmtrp2032248f9f2abbe404a84eef82ef4b712~dBM6Msbp91820318203epsmtrp2-;
        Tue, 11 Oct 2022 12:52:02 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-86-634638e8e36b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.1D.14392.2F665436; Tue, 11 Oct 2022 21:52:02 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125158epsmtip10bec6fea4bb1c315708813869379c2a2~dBM3C96452179321793epsmtip18;
        Tue, 11 Oct 2022 12:51:58 +0000 (GMT)
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
Subject: [Patch v3 07/15] media: s5p-mfc: Add support for VP9 encoder.
Date:   Tue, 11 Oct 2022 17:55:08 +0530
Message-Id: <20221011122516.32135-8-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1DTZRzHe77f7bsNm34DPZ9IjZvCBQZsMuYDCXXK0TctQrjs0j/m98Y3
        4Bjb3EZqZVIyTxE6ubCC+KUwlI2BTcBJ4yCYP5hkiFMO2EikFEZ4CEqcZrQxqP9e97w/78/n
        fZ/nebi4/wgRyM1UaBm1gpYLCD9WS1doaPgYSpQJ7w+J0R+WEja6W9FCoOq5Bxj6rXqGhTov
        NHNQk+MHHJ292sFGlbYbbHTx53ss9OOYR71Z4mKhB5UNAI2XDhPIPHqHjUbcH6JbrWUEKjjf
        zEYmm4uD9P03MVRr/htDZ5ofc5CuzcZBLmsLQHlHbdhbkKqvqAeUxVUDqP6aaZy6VOriUNXW
        cYwyG44TlPOOlaAu1BymdJefsqivmwyA+uercg6Vb+snqBnzOsr+ZIaTvHx31pYMhk5j1EGM
        QqZMy1Skxwl2pEq3SaMlQlG4KAZtFgQp6GwmTpDwbnJ4YqbcswZB0Ce0PMdzlExrNILI+C1q
        ZY6WCcpQarRxAkaVJleJVREaOluTo0iPUDDaWJFQuCnaU7g3K+OXwfts1UAhOOAcn8NzQYM2
        H/C4kBRDU66ByAd+XH/yJwAvGp6zvII/OQ1gQc+iMAtg20AXZ8lxreUe8AltAP46WM/2OXQY
        HOohvUyQ4bBd30F4eSX5JYCjx7ReA04eYUFXz7OFTgFkInzSfhb3MosMhqemijEv88k46DBO
        sXzTXoXG8x0LNTwyHj7SX1mIBMkTPNj+p5XtK0qAvd/dxnwcAN1XmxajBsKZh22Ej2Vw9Mw4
        7mM5bLQWLw54E3Y4yjzM9aQLhY2tkb7jtfCUvWGhJU4uh4XPfl9sz4eWiiUOgWXOucUIa2CX
        UQ98TMHq8gnMt6EiAKf6LoGTYF3p/yOqADCAlxmVJjud0USrNimY/f9dm0yZbQYLbz1suwWM
        3J2K6AQYF3QCyMUFK/mgcqvMn59GH/yUUSul6hw5o+kE0Z4FFuGBq2RKz2dRaKUicYxQLJFI
        xDFREpFgNb/6+zCZP5lOa5kshlEx6iUfxuUF5mLK8h1doRsz6r5IGeaNkuvnLbX7tvGC7Ydb
        ox7JrGv2TJwLyNtpMsXax1asl/btPdbdnfBeX2xDFN007RS99MLnrxSeK3s4Ieg5EMmbdAyS
        ZQUh7lVCu9+RDrsqtCg1pbHqdmmjfjJlp2nZa3X803XB6hDqRPHb3Xuuv17wvhW+IZWM6WpT
        r6T1lxz8GI0sM26IsW4Gw1VrH0/yNsza/uo1Ois2Ci/XSD9w7HN/9o0fp1+/3eLWJfGTiCTz
        i4ahdw59m1t59FDV8d2nu4UO066pYZ1xa/Cs/GTrDWesfCD+RPqtXmzF85Ka+f3sp+5rA6v9
        ylMT60pyRlo488a8XbMfBV0XsDQZtCgMV2vofwE/0WHAdAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnO6nNNdkg+dNPBZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJVx9tYz1oKbvYwV
        d17+YG5gXFfSxcjJISFgInFi2yPGLkYuDiGB3YwSq361sEEkZCT+tx1jh7CFJVb+e84OUdTM
        JPH/5VWwBJuArsT+pQfYQBIiAq2MEtdXdjKBOMwCs1kkfkw6wApSJSzgJvF1/3JmEJtFQFVi
        6ocpTCA2r4CtxJXVH1ggVshLrN5wAKyGU8BO4uPSY2BnCAHVNL6fyjSBkW8BI8MqRsnUguLc
        9NxiwwLDvNRyveLE3OLSvHS95PzcTYzg6NPS3MG4fdUHvUOMTByMhxglOJiVRHgZ5zslC/Gm
        JFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cCkP4+x9HqXa9+h
        GT3aD+wDe1ftXHUvyDuX49GXRbKNPjH7gqQc9nGuE9pW4Fdzd/KhvU09cwtD/rRuVfN1dXt8
        9iLfg5Ou0VlPFi8JaDReOb1P8d3E36aG74rL29fxGT1jfzNd3+RrpdOMXTweup49t3dcuNO+
        +R53k85XdmFDaf7Fvjzy22Z8q55lqft1s+vxhNr3X/kXKetf3qDvx2omz7TMM2b7nrN3RA12
        M4alitfeWi+5W+2T16Ml3i/3Tz3RL/Z244r+dN79G+7+njSpSPOG/4Ws9Z+k30VlmiQ6O035
        WL9SS1qza+Hj94fy3zdl2Bpo3Hy17U7v2QyWpmp7p9qbdUfLF2Rv2sGw//w5JZbijERDLeai
        4kQAb6gLvS0DAAA=
X-CMS-MailID: 20221011125202epcas5p4ef2d0dc9b6c434912b5c552c20bff4f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125202epcas5p4ef2d0dc9b6c434912b5c552c20bff4f5
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125202epcas5p4ef2d0dc9b6c434912b5c552c20bff4f5@epcas5p4.samsung.com>
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

Add VP9 encoder support and necessary registers, V4L2 CIDs, vp9
encoder parameters.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   |   8 +
 .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c |   3 +
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  27 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 273 ++++++++++++++++++
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |   2 +
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 121 ++++++++
 6 files changed, 433 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
index 6c68a45082d0..7cb74a9cb769 100644
--- a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
+++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
@@ -12,6 +12,10 @@
 #include <linux/sizes.h>
 #include "regs-mfc-v10.h"
 
+/* MFCv12 register definitions*/
+#define S5P_FIMV_E_VP9_OPTION_V12		0xFD90
+#define S5P_FIMV_E_VP9_GOLDEN_FRAME_OPTION_V12	0xFD98
+
 /* MFCv12 Context buffer sizes */
 #define MFC_CTX_BUF_SIZE_V12		(30 * SZ_1K)
 #define MFC_H264_DEC_CTX_BUF_SIZE_V12	(2 * SZ_1M)
@@ -47,4 +51,8 @@
 	ALIGN((((x + 3) * (y + 3) * 32)       \
 	+ (((y * 128) + 2304) * (x + 3) / 4)), 256)
 
+#define ENC_V120_VP9_ME_SIZE(x, y)      \
+	((((x * 2) + 3) * ((y * 2) + 3) * 128)	\
+	+ (((y * 256) + 2304) * (x + 1) / 2))
+
 #endif /*_REGS_MFC_V12_H*/
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
index f8588e52dfc8..d524815cd38a 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
@@ -121,6 +121,9 @@ static int s5p_mfc_open_inst_cmd_v6(struct s5p_mfc_ctx *ctx)
 	case S5P_MFC_CODEC_HEVC_ENC:
 		codec_type = S5P_FIMV_CODEC_HEVC_ENC;
 		break;
+	case S5P_MFC_CODEC_VP9_ENC:
+		codec_type = S5P_FIMV_CODEC_VP9_ENC;
+		break;
 	default:
 		codec_type = S5P_FIMV_CODEC_NONE_V6;
 	}
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index dd2e9f7704ab..10abaa50d7db 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -57,7 +57,7 @@
 #define MFC_ENC_CAP_PLANE_COUNT	1
 #define MFC_ENC_OUT_PLANE_COUNT	2
 #define STUFF_BYTE		4
-#define MFC_MAX_CTRLS		128
+#define MFC_MAX_CTRLS		147
 
 #define S5P_MFC_CODEC_NONE		-1
 #define S5P_MFC_CODEC_H264_DEC		0
@@ -77,6 +77,7 @@
 #define S5P_MFC_CODEC_H263_ENC		23
 #define S5P_MFC_CODEC_VP8_ENC		24
 #define S5P_MFC_CODEC_HEVC_ENC		26
+#define S5P_MFC_CODEC_VP9_ENC		27
 
 #define S5P_MFC_R2H_CMD_EMPTY			0
 #define S5P_MFC_R2H_CMD_SYS_INIT_RET		1
@@ -483,6 +484,29 @@ struct s5p_mfc_hevc_enc_params {
 	u8 prepend_sps_pps_to_idr;
 };
 
+/**
+ * struct s5p_mfc_vp9_enc_params - encoding parameters for vp9
+ */
+struct s5p_mfc_vp9_enc_params {
+	u32 rc_framerate;
+	u8 vp9_profile;
+	u8 rc_min_qp;
+	u8 rc_max_qp;
+	u8 rc_frame_qp;
+	u8 rc_p_frame_qp;
+	u8 vp9_goldenframesel;
+	u8 vp9_gfrefreshperiod;
+	u8 hier_qp_enable;
+	u8 hier_qp_layer[3];
+	u8 hier_rc_enable;
+	u32 hier_bit_layer[3];
+	u8 num_refs_for_p;
+	u8 num_hier_layer;
+	u8 max_partition_depth;
+	u8 intra_pu_split_disable;
+	u8 ivf_header;
+};
+
 /*
  * struct s5p_mfc_enc_params - general encoding parameters
  */
@@ -521,6 +545,7 @@ struct s5p_mfc_enc_params {
 		struct s5p_mfc_mpeg4_enc_params mpeg4;
 		struct s5p_mfc_vp8_enc_params vp8;
 		struct s5p_mfc_hevc_enc_params hevc;
+		struct s5p_mfc_vp9_enc_params vp9;
 	} codec;
 
 };
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 143d95fe2f89..197667ab1fbc 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -94,6 +94,14 @@ static struct s5p_mfc_fmt formats[] = {
 		.num_planes	= 1,
 		.versions	= MFC_V10PLUS_BITS,
 	},
+	{
+		.fourcc         = V4L2_PIX_FMT_VP9,
+		.codec_mode     = S5P_FIMV_CODEC_VP9_ENC,
+		.type           = MFC_FMT_ENC,
+		.num_planes     = 1,
+		.versions       = MFC_V12_BIT,
+	},
+
 };
 
 #define NUM_FORMATS ARRAY_SIZE(formats)
@@ -1055,6 +1063,174 @@ static struct mfc_control controls[] = {
 		.step = 1,
 		.default_value = 0,
 	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_PROFILE,
+		.type = V4L2_CTRL_TYPE_MENU,
+		.minimum = V4L2_MPEG_VIDEO_VP9_PROFILE_0,
+		.maximum = V4L2_MPEG_VIDEO_VP9_PROFILE_2,
+		.step = 1,
+		.default_value = V4L2_MPEG_VIDEO_VP9_PROFILE_0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_I_FRAME_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 1,
+		.maximum = 255,
+		.step = 1,
+		.default_value = 1,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_P_FRAME_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 1,
+		.maximum = 255,
+		.step = 1,
+		.default_value = 1,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_MAX_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 230,
+		.maximum = 255,
+		.step = 1,
+		.default_value = 255,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_MIN_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 1,
+		.maximum = 24,
+		.step = 1,
+		.default_value = 1,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_RC_FRAME_RATE,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 1,
+		.maximum = (1 << 16) - 1,
+		.step = 1,
+		.default_value = 1,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL,
+		.type = V4L2_CTRL_TYPE_MENU,
+		.minimum = V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV,
+		.maximum = V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD,
+		.step = 1,
+		.default_value = V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 0,
+		.maximum = ((1 << 16) - 1),
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES,
+		.type = V4L2_CTRL_TYPE_MENU,
+		.minimum = V4L2_CID_CODEC_VP9_1_REF_PFRAME,
+		.maximum = V4L2_CID_CODEC_VP9_2_REF_PFRAME,
+		.step = 1,
+		.default_value = V4L2_CID_CODEC_VP9_1_REF_PFRAME,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 0,
+		.maximum = 2,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH,
+		.type = V4L2_CTRL_TYPE_MENU,
+		.minimum = V4L2_CID_CODEC_VP9_0_PARTITION,
+		.maximum = V4L2_CID_CODEC_VP9_1_PARTITION,
+		.step = 1,
+		.default_value = V4L2_CID_CODEC_VP9_0_PARTITION,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.step = 1,
+		.default_value = 0,
+	},
 	{
 		.id = V4L2_CID_MIN_BUFFERS_FOR_OUTPUT,
 		.type = V4L2_CTRL_TYPE_INTEGER,
@@ -1791,6 +1967,36 @@ static void __enc_update_hevc_qp_ctrls_range(struct s5p_mfc_ctx *ctx,
 	}
 }
 
+/*
+ * Update range of all VP9 quantization parameter controls that depend on the
+ * V4L2_CID_CODEC_VP9_MIN_QP, V4L2_CID_CODEC_VP9_MAX_QP controls.
+ */
+static void __enc_update_vp9_qp_ctrls_range(struct s5p_mfc_ctx *ctx,
+						int min, int max)
+{
+	static const int __vp9_qp_ctrls[] = {
+		V4L2_CID_CODEC_VP9_I_FRAME_QP,
+		V4L2_CID_CODEC_VP9_P_FRAME_QP,
+		V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP,
+		V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP,
+		V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP,
+	};
+	struct v4l2_ctrl *ctrl = NULL;
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(__vp9_qp_ctrls); i++) {
+		for (j = 0; j < ARRAY_SIZE(ctx->ctrls); j++) {
+			if (ctx->ctrls[j]->id == __vp9_qp_ctrls[i]) {
+				ctrl = ctx->ctrls[j];
+				break;
+			}
+		}
+		if (WARN_ON(!ctrl))
+			break;
+		__v4l2_ctrl_modify_range(ctrl, min, max, ctrl->step, min);
+	}
+}
+
 static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct s5p_mfc_ctx *ctx = ctrl_to_ctx(ctrl);
@@ -2194,6 +2400,73 @@ static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:
 		p->codec.hevc.prepend_sps_pps_to_idr = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
+		p->codec.vp9.vp9_profile = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_RC_FRAME_RATE:
+		p->codec.vp9.rc_framerate = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_MIN_QP:
+		p->codec.vp9.rc_min_qp = ctrl->val;
+		__enc_update_vp9_qp_ctrls_range(ctx, ctrl->val,
+			p->codec.vp9.rc_max_qp);
+		break;
+	case V4L2_CID_CODEC_VP9_MAX_QP:
+		p->codec.vp9.rc_max_qp = ctrl->val;
+		__enc_update_vp9_qp_ctrls_range(ctx,
+				p->codec.vp9.rc_min_qp, ctrl->val);
+		break;
+	case V4L2_CID_CODEC_VP9_I_FRAME_QP:
+		p->codec.vp9.rc_frame_qp = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_P_FRAME_QP:
+		p->codec.vp9.rc_p_frame_qp = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL:
+		p->codec.vp9.vp9_goldenframesel = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD:
+		p->codec.vp9.vp9_gfrefreshperiod = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE:
+		p->codec.vp9.hier_qp_enable = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE:
+		p->codec.vp9.hier_rc_enable = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP:
+		p->codec.vp9.hier_qp_layer[0] = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP:
+		p->codec.vp9.hier_qp_layer[1] = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP:
+		p->codec.vp9.hier_qp_layer[2] = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR:
+		p->codec.vp9.hier_bit_layer[0] = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR:
+		p->codec.vp9.hier_bit_layer[1] = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR:
+		p->codec.vp9.hier_bit_layer[2] = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES:
+		p->codec.vp9.num_refs_for_p = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER:
+		p->codec.vp9.num_hier_layer = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH:
+		p->codec.vp9.max_partition_depth = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT:
+		p->codec.vp9.intra_pu_split_disable = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER:
+		p->codec.vp9.ivf_header = ctrl->val;
+		break;
 	default:
 		v4l2_err(&dev->v4l2_dev, "Invalid control, id=%d, val=%d\n",
 							ctrl->id, ctrl->val);
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
index 87ac56756a16..a005623e2daa 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
@@ -277,6 +277,8 @@ struct s5p_mfc_regs {
 	void __iomem *e_hevc_lf_beta_offset_div2; /* v10 */
 	void __iomem *e_hevc_lf_tc_offset_div2; /* v10 */
 	void __iomem *e_hevc_nal_control; /* v10 */
+	void __iomem *e_vp9_options; /* v12 */
+	void __iomem *e_vp9_golden_frame_option; /* v12 */
 };
 
 struct s5p_mfc_hw_ops {
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 5d14ccf8b4fe..87bd10b34620 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -363,6 +363,17 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			ctx->chroma_dpb_size + ctx->me_buffer_size));
 		ctx->bank2.size = 0;
 		break;
+	case S5P_FIMV_CODEC_VP9_ENC:
+		mfc_debug(2, "Use min scratch buffer size\n");
+		ctx->me_buffer_size =
+			ALIGN(ENC_V120_VP9_ME_SIZE(lcu_width, lcu_height), 16);
+		ctx->scratch_buf_size = ALIGN(ctx->scratch_buf_size, 256);
+		ctx->bank1.size =
+			ctx->scratch_buf_size + ctx->tmv_buffer_size +
+			(ctx->pb_count * (ctx->luma_dpb_size +
+			ctx->chroma_dpb_size + ctx->me_buffer_size));
+		ctx->bank2.size = 0;
+		break;
 	default:
 		break;
 	}
@@ -418,6 +429,7 @@ static int s5p_mfc_alloc_instance_buffer_v6(struct s5p_mfc_ctx *ctx)
 	case S5P_MFC_CODEC_MPEG4_ENC:
 	case S5P_MFC_CODEC_H263_ENC:
 	case S5P_MFC_CODEC_VP8_ENC:
+	case S5P_FIMV_CODEC_VP9_ENC:
 		ctx->ctx.size = buf_size->other_enc_ctx;
 		break;
 	default:
@@ -1652,6 +1664,102 @@ static int s5p_mfc_set_enc_params_hevc(struct s5p_mfc_ctx *ctx)
 	return 0;
 }
 
+int s5p_mfc_set_enc_params_vp9(struct s5p_mfc_ctx *ctx)
+{
+	struct s5p_mfc_dev *dev = ctx->dev;
+	const struct s5p_mfc_regs *mfc_regs = dev->mfc_regs;
+	struct s5p_mfc_enc_params *p = &ctx->enc_params;
+	struct s5p_mfc_vp9_enc_params *p_vp9 = &p->codec.vp9;
+	unsigned int reg = 0;
+	int i;
+
+	mfc_debug_enter();
+
+	s5p_mfc_set_enc_params(ctx);
+
+	/* profile*/
+	reg = 0;
+	reg |= (p_vp9->vp9_profile);
+	writel(reg, mfc_regs->e_picture_profile);
+
+	reg = 0;
+	reg |= ((p_vp9->ivf_header & 0x1) << 12);
+	reg |= ((p_vp9->hier_qp_enable & 0x1) << 11);
+	reg |= (p_vp9->max_partition_depth & 0x1) << 3;
+	reg |= (p_vp9->intra_pu_split_disable & 0x1) << 1;
+	reg |= (p_vp9->num_refs_for_p - 1) & 0x1;
+	writel(reg, mfc_regs->e_vp9_options);
+
+	reg = 0;
+	reg |= (p_vp9->vp9_goldenframesel & 0x1);
+	reg |= (p_vp9->vp9_gfrefreshperiod & 0xffff) << 1;
+	writel(reg, mfc_regs->e_vp9_golden_frame_option);
+
+	reg = 0;
+	if (p_vp9->num_hier_layer) {
+		reg |= p_vp9->num_hier_layer & 0x3;
+		writel(reg, mfc_regs->e_num_t_layer);
+		/* QP value for each layer */
+		if (p_vp9->hier_qp_enable) {
+			for (i = 0; i < (p_vp9->num_hier_layer & 0x3); i++)
+				writel(p_vp9->hier_qp_layer[i],
+						mfc_regs->e_hier_qp_layer0
+						+ i * 4);
+		}
+		if (p_vp9->hier_rc_enable) {
+			for (i = 0; i < (p_vp9->num_hier_layer & 0x3); i++)
+				writel(p_vp9->hier_bit_layer[i],
+						mfc_regs->e_hier_bit_rate_layer0
+						+ i * 4);
+		}
+	}
+	/* number of coding layer should be zero when hierarchical is disable */
+	reg |= p_vp9->num_hier_layer;
+	writel(reg, mfc_regs->e_num_t_layer);
+
+	/* qp */
+	writel(0x0, mfc_regs->e_fixed_picture_qp);
+	if (!p->rc_frame && !p->rc_mb) {
+		reg = 0;
+		reg &= ~(0xff << 8);
+		reg |= (p_vp9->rc_p_frame_qp << 8);
+		reg &= ~(0xff);
+		reg |= p_vp9->rc_frame_qp;
+		writel(reg, mfc_regs->e_fixed_picture_qp);
+	}
+
+	/* frame rate */
+	if (p->rc_frame) {
+		reg = 0;
+		reg &= ~(0xffff << 16);
+		reg |= ((p_vp9->rc_framerate * FRAME_DELTA_DEFAULT) << 16);
+		reg &= ~(0xffff);
+		reg |= FRAME_DELTA_DEFAULT;
+		writel(reg, mfc_regs->e_rc_frame_rate);
+	}
+
+	/* rate control config. */
+	reg = readl(mfc_regs->e_rc_config);
+	/** macroblock level rate control */
+	reg &= ~(0x1 << 8);
+	reg |= ((p->rc_mb & 0x1) << 8);
+	writel(reg, mfc_regs->e_rc_config);
+
+	/* max & min value of QP */
+	reg = 0;
+	/** max QP */
+	reg &= ~(0xFF << 8);
+	reg |= (p_vp9->rc_max_qp << 8);
+	/** min QP */
+	reg &= ~(0xFF);
+	reg |= p_vp9->rc_min_qp;
+	writel(reg, mfc_regs->e_rc_qp_bound);
+
+	mfc_debug_leave();
+
+	return 0;
+}
+
 /* Initialize decoding */
 static int s5p_mfc_init_decode_v6(struct s5p_mfc_ctx *ctx)
 {
@@ -1773,6 +1881,8 @@ static int s5p_mfc_init_encode_v6(struct s5p_mfc_ctx *ctx)
 		s5p_mfc_set_enc_params_vp8(ctx);
 	else if (ctx->codec_mode == S5P_FIMV_CODEC_HEVC_ENC)
 		s5p_mfc_set_enc_params_hevc(ctx);
+	else if (ctx->codec_mode == S5P_FIMV_CODEC_VP9_ENC)
+		s5p_mfc_set_enc_params_vp9(ctx);
 	else {
 		mfc_err("Unknown codec for encoding (%x).\n",
 			ctx->codec_mode);
@@ -2536,6 +2646,17 @@ const struct s5p_mfc_regs *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
 	R(e_hevc_lf_tc_offset_div2, S5P_FIMV_E_HEVC_LF_TC_OFFSET_DIV2_V10);
 	R(e_hevc_nal_control, S5P_FIMV_E_HEVC_NAL_CONTROL_V10);
 
+	if (!IS_MFCV12(dev))
+		goto done;
+
+	/* Initialize registers used in MFC v10 only.
+	 * Also, over-write the registers which have
+	 * a different offset for MFC v10.
+	 */
+
+	R(e_vp9_options, S5P_FIMV_E_VP9_OPTION_V12);
+	R(e_vp9_golden_frame_option, S5P_FIMV_E_VP9_GOLDEN_FRAME_OPTION_V12);
+
 done:
 	return &mfc_regs;
 #undef S5P_MFC_REG_ADDR
-- 
2.17.1

