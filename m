Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7865FBFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJLDtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJLDsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:48:18 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF6DA98E2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:47:55 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221012034753epoutp04e5276dd382c2b5b185871186dd697d22~dNbFfpr6U0566605666epoutp04q
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:47:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221012034753epoutp04e5276dd382c2b5b185871186dd697d22~dNbFfpr6U0566605666epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546473;
        bh=NO3l/8N67+LRHCcmkiDY0z0XWJK5GVH8GrsUrIeLNuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ub1RPf+SUFdKJNnc1OwHA0PUF5mOvLP4u9JXQrPSR7ReNgBylux/w3i3iTb7lLWck
         AZW+8DNn1vW2iSZWgRqGeKJQwTf2X6iYh/dZMjz2N/m0r7QX+uiUzk6tKfFTJnT35n
         3lB+QFBm1dt/MJ9ICqUvDR2ndAVr8Fn3DGnG5PVo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221012034751epcas5p211d6de964178e3112a95ea5b67f6fb95~dNbEZyFE00049100491epcas5p2O;
        Wed, 12 Oct 2022 03:47:51 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MnJWm3C2xz4x9Pr; Wed, 12 Oct
        2022 03:47:48 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.FB.39477.4E836436; Wed, 12 Oct 2022 12:47:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125158epcas5p14f2b333fdb1eed793e9fbf85409f5a36~dBM3BCsZi0252702527epcas5p1F;
        Tue, 11 Oct 2022 12:51:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221011125158epsmtrp18a6384d603d8c9f5358d089b53f80480~dBM2-4SZh2654526545epsmtrp1F;
        Tue, 11 Oct 2022 12:51:58 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-74-634638e44bc9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.0D.14392.EE665436; Tue, 11 Oct 2022 21:51:58 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125155epsmtip19b75ee41d1f37c2f515ed8cc37e90ea4~dBMz5fms02178321783epsmtip15;
        Tue, 11 Oct 2022 12:51:55 +0000 (GMT)
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
Subject: [Patch v3 06/15] media: v4l2: Add v4l2 control IDs for VP9 encoder.
Date:   Tue, 11 Oct 2022 17:55:07 +0530
Message-Id: <20221011122516.32135-7-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xTVxTHva+vr4VQ91JgXmAINOwHXUAqpbsslOk05IlKiFtiGFFWy0uL
        9Ff6Wsc02VCGdo3o3GQOZIAUZBQELT9EVgYURCELCZPRxFFWBMS66Rg/NjfQjVLc/vuce77n
        3nO+914ui+8mQrm5GgOt18hUAsIfb++LEcZOo1R5fOe1YDTTUcpG7op2AlmezGLoZ8sCjhwt
        bRzUOnqRhepu9bBRZf8wG13vvYejaw9WsyOlLhzNVjYB5CmbIJBtaoyNJh/uR3c6ywl0+mob
        G13pd3FQrXMEQ5dtKxiqblvkoKKufg5y2dsB+uRkP7YNUo0VjYDqcNUAylkzz6JulLk4lMXu
        wSib9VOCGh+zE1RLzcdU0c2/cepMqxVQz058zaHM/U6CWrBtpoaWFjgZG9/LS1bSshxaH0lr
        5NqcXI1CKtj9TvaO7ERJvChWlITeEERqZGpaKti5JyM2NVe1aoMg8ohMZVxdypAxjGBLSrJe
        azTQkUotY5AKaF2OSifWxTEyNWPUKOI0tOFNUXz81sRV4ft5yjOFjO6CJP/0wmO8AHRtMQM/
        LiTFcOpGN2YG/lw++S2Alj9PAF8wD+DlwlHCF/wB4ODMMtsMuGsl8wXroi4A21wP1oMiDN4t
        nsS8+xJkLOyu7SG8HEQeB3DKZPCKWGQhDl3fL3O8iUByD/xl4ibuZZx8GTa769cKeKQUPip1
        s30NRsCGqz0sL/uRKfD32oG1liB5yg86L7YQPtFOWFzm4fg4ED681brOodBz9uQ6y+FUtYfl
        YxVstp/HffwW7Bktx72jscgY2Ny5bkw4LBlqWhuGRW6ExcvTmG+dBzsqnvMrsHz8yXqfL8G+
        hlrgYwpWlVRyfK6cA7DeYSM+A5vL/j+iCgArCKF1jFpBM4m6rRr6g/9uTa5V28DaUxemdYBJ
        91ycA2Bc4ACQyxIE8UDl23I+L0f24VFar83WG1U04wCJqwaeY4UGy7Wrf0VjyBaJk+LFEolE
        nJQgEQk28SxfCeV8UiEz0Hk0raP1z+swrl9oAXZppTJC+uLtdIfVeKnPVBC2nfvb/btzE+Ek
        M7i39+ipNEnmAYtJJ82xfRG1Ia8l2l7TOJcdQN654txRtKsqIHgo4nF347Fji0ZVfqas5MAS
        5PTWk3U/JYxJ8duvZ5k7kXyaHzic5cYTY4WZPebmmX2K0tm4qPwvD9U1NcUvOrPHe19IENbs
        imk4WO9RjvzIC03rDL6XHtt+vEoezW2MPG/6aCBhe4Dh/sqzduyHtqzdik1/DRbLZ5WkPeA1
        8aPPnw5905pqDgkMS/5VY30anfldYUh6tend4aiUw5QnM2ze32FS9x4O36/e9+oFZnTbzKG9
        A0GFKUcOnrXyN1xXL/2TK8AZpUwkZOkZ2b/rjBvMcwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSnO67NNdkg3f9BhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJXR11xcMN2soufz
        O5YGxr36XYwcHBICJhKfGhi7GLk4hAR2M0qcmPOFtYuREyguI/G/7Rg7hC0ssfLfc3aIomYm
        iQfXvjOCJNgEdCX2Lz3ABpIQEWhllLi+spMJxGEWmM0i8WPSAbBRwgI+Eq/vHWUBsVkEVCXW
        P1jJBmLzCthKvJ35AGqdvMTqDQeYQWxOATuJj0uPgdUIAdU0vp/KNIGRbwEjwypGydSC4tz0
        3GLDAsO81HK94sTc4tK8dL3k/NxNjOC409Lcwbh91Qe9Q4xMHIyHGCU4mJVEeBnnOyUL8aYk
        VlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwLT0s7c0X443p1DQ
        CYvk7zwLRQ+9duJvSMzdP6cio1Ruw51PL1XWc6fWToz5wHpwouGUiRetDlz+Jv9B1Oh+QV7o
        myvWHxM2tUSmJ5wrOzzv9CR74frXt2WEmlVmppcadXHn9u9qC73NIr5aveFQ68fNttIJy5YE
        C7N8Un73MPxyGdcmabd6JimGclmPc+VSW2SNp9r47WQrrGi5t3C74ou9YlKvTbpSPy52XVhq
        vmWCcuQCQWPteSyaKxvVYqWOmz2RCfvAU/1a9EJ2Np/Y5jqxZWXFOwIOtJfcfRiedc5384NT
        68trvrX1sLSYaE9aVHdu/stZ6ZeuLL4SnbXjpvQlBdX3GSGvf+RH/wr/rcRSnJFoqMVcVJwI
        ABJtdGYqAwAA
X-CMS-MailID: 20221011125158epcas5p14f2b333fdb1eed793e9fbf85409f5a36
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125158epcas5p14f2b333fdb1eed793e9fbf85409f5a36
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125158epcas5p14f2b333fdb1eed793e9fbf85409f5a36@epcas5p1.samsung.com>
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

Add V4l2 controls for VP9 encoder

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-defs.c | 44 +++++++++++++++++++++++
 include/uapi/linux/v4l2-controls.h        | 33 +++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index e22921e7ea61..2d92e93158bd 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -577,6 +577,21 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		"Cyclic",
 		NULL,
 	};
+	static const char * const vp9_golden_framesel[] = {
+		"Use previous",
+		"Use refresh period",
+		NULL,
+	};
+	static const char * const vp9_ref_num_for_pframes[] = {
+		"1",
+		"2",
+		NULL,
+	};
+	static const char * const vp9_max_partition_depth[] = {
+	"No CU partition depth",
+	"Allow 1 CU partition depth",
+	NULL,
+	};
 
 	switch (id) {
 	case V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ:
@@ -708,6 +723,12 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		return hevc_decode_mode;
 	case V4L2_CID_STATELESS_HEVC_START_CODE:
 		return hevc_start_code;
+	case V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL:
+		return vp9_golden_framesel;
+	case V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES:
+		return vp9_ref_num_for_pframes;
+	case V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH:
+		return vp9_max_partition_depth;
 	case V4L2_CID_CAMERA_ORIENTATION:
 		return camera_orientation;
 	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE:
@@ -950,6 +971,26 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:			return "VP8 Profile";
 	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:			return "VP9 Profile";
 	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:			return "VP9 Level";
+	case V4L2_CID_CODEC_VP9_I_FRAME_QP:		return "VP9 I Frame QP Value";
+	case V4L2_CID_CODEC_VP9_P_FRAME_QP:		return "VP9 P Frame QP Value";
+	case V4L2_CID_CODEC_VP9_MAX_QP:			return "VP9 Frame QP MAX Value";
+	case V4L2_CID_CODEC_VP9_MIN_QP:			return "VP9 Frame QP MIN Value";
+	case V4L2_CID_CODEC_VP9_RC_FRAME_RATE:		return "VP9 Frame Rate";
+	case V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL:	return "VP9 Indication of Golden Frame";
+	case V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD:	return "VP9 Golden Frame Refresh Period";
+	case V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE:	return "VP9 Hierarchical QP Enable";
+	case V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES:	return "VP9 Number of Reference Pictures";
+	case V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER:return "VP9 Num of Hierarchical Layers";
+	case V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH:	return "VP9 Maximum Coding Unit Depth";
+	case V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT:	return "VP9 Disable Intra PU Split";
+	case V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE:	return "VP9 Hierarchical BitRate Enable";
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR:	return "VP9 Hierarchical Layer 0 BitRate";
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR:	return "VP9 Hierarchical Layer 1 BitRate";
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR:	return "VP9 Hierarchical Layer 2 BitRate";
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP:	return "VP9 Layer0 QP Value";
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP:	return "VP9 Layer1 QP Value";
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP:	return "VP9 Layer2 QP Value";
+	case V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER:	return "VP9 IVF header generation";
 
 	/* HEVC controls */
 	case V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP:		return "HEVC I-Frame QP Value";
@@ -1366,6 +1407,9 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE:
 	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:
 	case V4L2_CID_STATELESS_HEVC_START_CODE:
+	case V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL:
+	case V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES:
+	case V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH:
 	case V4L2_CID_STATELESS_H264_DECODE_MODE:
 	case V4L2_CID_STATELESS_H264_START_CODE:
 	case V4L2_CID_CAMERA_ORIENTATION:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index b5e7d082b8ad..a60b60bc4ad4 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -722,6 +722,38 @@ enum v4l2_mpeg_video_vp9_level {
 	V4L2_MPEG_VIDEO_VP9_LEVEL_6_1	= 12,
 	V4L2_MPEG_VIDEO_VP9_LEVEL_6_2	= 13,
 };
+#define V4L2_CID_CODEC_VP9_RC_FRAME_RATE	(V4L2_CID_CODEC_BASE+514)
+#define V4L2_CID_CODEC_VP9_MIN_QP		(V4L2_CID_CODEC_BASE+515)
+#define V4L2_CID_CODEC_VP9_MAX_QP		(V4L2_CID_CODEC_BASE+516)
+#define V4L2_CID_CODEC_VP9_I_FRAME_QP	(V4L2_CID_CODEC_BASE+517)
+#define V4L2_CID_CODEC_VP9_P_FRAME_QP	(V4L2_CID_CODEC_BASE+518)
+#define V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL	(V4L2_CID_CODEC_BASE+519)
+enum v4l2_mpeg_vp9_golden_framesel {
+	V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV           = 0,
+	V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD     = 1,
+};
+#define V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD (V4L2_CID_CODEC_BASE+520)
+#define V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE (V4L2_CID_CODEC_BASE+521)
+#define V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES (V4L2_CID_CODEC_BASE+522)
+enum v4l2_mpeg_vp9_ref_num_for_pframes {
+	V4L2_CID_CODEC_VP9_1_REF_PFRAME     = 0,
+	V4L2_CID_CODEC_VP9_2_REF_PFRAME     = 1,
+};
+#define V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER (V4L2_CID_CODEC_BASE+523)
+#define V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR	(V4L2_CID_CODEC_BASE+524)
+#define V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR	(V4L2_CID_CODEC_BASE+525)
+#define V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR	(V4L2_CID_CODEC_BASE+526)
+#define V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP	(V4L2_CID_CODEC_BASE+527)
+#define V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP	(V4L2_CID_CODEC_BASE+528)
+#define V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP	(V4L2_CID_CODEC_BASE+529)
+#define V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH	(V4L2_CID_CODEC_BASE+530)
+enum v4l2_mpeg_vp9_num_partitions {
+	V4L2_CID_CODEC_VP9_0_PARTITION     = 0,
+	V4L2_CID_CODEC_VP9_1_PARTITION	= 1,
+};
+#define V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT	(V4L2_CID_CODEC_BASE+531)
+#define V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER	(V4L2_CID_CODEC_BASE+532)
+#define V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE	(V4L2_CID_CODEC_BASE+533)
 
 /* CIDs for HEVC encoding. */
 
@@ -832,6 +864,7 @@ enum v4l2_mpeg_video_frame_skip_mode {
 #define V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY		(V4L2_CID_CODEC_BASE + 653)
 #define V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE	(V4L2_CID_CODEC_BASE + 654)
 
+
 /*  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2 */
 #define V4L2_CID_CODEC_CX2341X_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1000)
 #define V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE		(V4L2_CID_CODEC_CX2341X_BASE+0)
-- 
2.17.1

