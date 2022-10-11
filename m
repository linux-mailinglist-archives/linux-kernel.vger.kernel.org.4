Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE55FBFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJLDv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJLDuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:50:46 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEA779A79
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:48:56 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221012034854epoutp03b901bb464c78aa3ba1b2a3861b527685~dNb_vUSGC2834128341epoutp038
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:48:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221012034854epoutp03b901bb464c78aa3ba1b2a3861b527685~dNb_vUSGC2834128341epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546534;
        bh=86XWZgyf4bLUQ6hTi85Z0TENv90n/4TCwhXXF+cdNjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCzOuxq/Tv5PrDmkMcVxGJheeBtYmG82iUsPPqAtkSl2diHcROOzuQkjl8xRu4Y+w
         q3qXEHRjE5dx9lTF8CyhGS8D3qKPi+wUxBi4jNMzUyVZTlnWsCSG4b4tes6L8zPXlI
         mRiUM/55wV2FKDqDx2IP9s/f4I4Xm//u0OUfyWOQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221012034853epcas5p178f3498eb1e358d65cc973b53e1ac922~dNb_DUtzX2005220052epcas5p1A;
        Wed, 12 Oct 2022 03:48:53 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MnJXz1Lxqz4x9QC; Wed, 12 Oct
        2022 03:48:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.3C.39477.02936436; Wed, 12 Oct 2022 12:48:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125225epcas5p1b3504009ef4519a24dd44ba205606fe4~dBNQNAIGG0252702527epcas5p1h;
        Tue, 11 Oct 2022 12:52:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221011125225epsmtrp124d33f618f76af0101417aa27f082076~dBNQL8jdM2656926569epsmtrp1G;
        Tue, 11 Oct 2022 12:52:25 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-34-63463920aa7d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.1D.14392.90765436; Tue, 11 Oct 2022 21:52:25 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125222epsmtip13cf750c0ca431f1594dffaf426c9d395~dBNNFkVMh2344423444epsmtip1Y;
        Tue, 11 Oct 2022 12:52:22 +0000 (GMT)
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
Subject: [Patch v3 14/15] media: s5p-mfc: DPB Count Independent of
 VIDIOC_REQBUF
Date:   Tue, 11 Oct 2022 17:55:15 +0530
Message-Id: <20221011122516.32135-15-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTfUxTVxzNfX3tKybgC/hxYQ6wywCJYNuV8kCoTj58mSwjcwa3RVhXnoVQ
        2q4tMoyJCJYp20RgM8IQECgMUMHyVaEolBYcoMyMgDqKFLawKhuDOmeA4VoK23/nd37n3HPv
        797LpLlbGF7MVKmKUkiFEhZjE9ret8s/yDcsVsQ2rULiV10JnZgqb2cQ1S9nEeJJtQ0lDC1t
        GNE6+h2NqBvooRMVxvt0oqN3GiVu/mbvPigxo8RsxQ1AWEsnGYR2ZoxOWJ4mED91ljGIr5rb
        6MR1oxkjNOMPEKJWu4IQVW3PMULdbcQIs74dEGfzjMh+SF4rvwZInbkGkOM1izTyVqkZI6v1
        VoTUNpxnkBNjegbZUnOaVJuWUPJCawMgV3OuYGS+cZxB2rTe5OBfNize7aO0iBRKmEwpfCmp
        SJacKhVHsg4dTopKCuGzOUGcMCKU5SsVplORrOi4+KDYVIl9DCzfE0JJhp2KFyqVrD2CCIUs
        Q0X5psiUqkgWJU+WyHnyYKUwXZkhFQdLKVU4h83mhtiFn6SllLf20eW53p8PPdOg2WAR5gMX
        JsR5sOIHG5oPNjHd8S4A5+u6EGexCOC0pYfmLF4AaHlYz9iwvFDfwZyNbrtlsWXdokagZrYe
        cagYeBC8o+lZc2zBzwA4c07lENHwXBSah5cxR8MDfx9mj39vz2AyUfxNaMoLcNCuuADmzjui
        HWk+sLHZiV3s/IKmn+FYB+K5LnDVtIw6RdGwVH95HXvApwOtmBN7QWtB3joWwZkq6/qiEtik
        /2Zdvw/2jJahjj3Q8F2wqXOPk34dfjt4Y+0sNNwNfr38C+LkXaGufAP7wbKJl3Qn3gH7GjXA
        iUk49kUR3TmUQgCL7uZiF4F36f8RlQA0AE9KrkwXU8oQOVdKZf53bSJZuhasvfXAd3TAMvVn
        sAEgTGAAkEljbXEFFQdE7q7JwqyTlEKWpMiQUEoDCLHPr5DmtVUks38WqSqJwwtj8/h8Pi/s
        LT6Htd21+nKgyB0XC1VUGkXJKcWGD2G6eGUjfqyDscUjR2pOmazv3bziVtvfz/UOX7g3dKr4
        fnfmkbgdV1/zWNKLTuwXPDoUN5zQFfpsjsefY0YExxjEQ36dtuM2/1e399VLzhW9+ngv9mVf
        L+J3ceRxb8KBY8sxuw+rK984ujC1FO2Z6W7YHJu+2PT7XR/BY61g+uj13cb+S1FnZ1wSz4SH
        NSe+jevnVtpbj8/8EXCsY+7dpaqroQHRO7dZPT9NHH649Lf85ObaUUFB1untPiCrr6iMbWHr
        SsSdBq4h53mj6VZd6Mr8ZMvWyn8GDvqvPNnZMX/JXMAt9FFzb3+4jbNXNhHlnpzRW3y+KecD
        g6zu56CewZqRxHuPYrDPftRNslBlipATSFMohf8CYe9fwHQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSnC5numuywbsXRhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJUxb8th1oJmuYrT
        r5eyNDB+kuhi5OSQEDCR+Na6n72LkYtDSGA3o8ShmQ2sEAkZif9tx9ghbGGJlf+eg9lCAs1M
        Ei+3WoLYbAK6EvuXHmADaRYRaGWUuL6ykwnEYRaYzSLxY9IBsEnCAgESKyc+BOrm4GARUJU4
        2qYBEuYVsJNofn+AGWKBvMTqDRA2J1D849JjbBDLbCUa309lmsDIt4CRYRWjZGpBcW56brFh
        gWFearlecWJucWleul5yfu4mRnDcaWnuYNy+6oPeIUYmDsZDjBIczEoivIzznZKFeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYOqaNJVJ6+OR+bpnb4l3
        tvn7tSRYOJvEbe7MVpUr+84pK3+4r3Lnwycq3Bteb+hqt3ab684aGnq7LuTwgq28jeu3t22d
        osJlWJk9vXGxebBgnpXjG3GtJZ6CByxdlHuzZx2S+6fzWCRXv0Sm4e+sRRUpXK7GP93YTLdZ
        qYso7+15kJ6gNF32F2MQ52vNvX9azyUvu7CDyXTLN4HeQ9rq3684bXyeevaTyjXT7TefW89L
        dPhy9nDJtLdzT52uuSncv/UT26YirlLL7HaJCpn6S+fvXdNQ1pRZapa16N4uDy6Zle+fZDHs
        zzg3h9dgghznkx1h6ft2iZ9c5bLjAK9R1LvpJ8MrNR4tE1kqd0DWSomlOCPRUIu5qDgRAAxo
        3yEqAwAA
X-CMS-MailID: 20221011125225epcas5p1b3504009ef4519a24dd44ba205606fe4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125225epcas5p1b3504009ef4519a24dd44ba205606fe4
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125225epcas5p1b3504009ef4519a24dd44ba205606fe4@epcas5p1.samsung.com>
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

This patch allows allocation of DPB buffers based on MFC requirement
so codec buffers allocations has been moved after state
MFCINST_HEAD_PRODUCED. It is taken care that codec buffer allocation
is performed in process context from userspace IOCTL call.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c      | 17 ++---------------
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c   |  9 ++++++++-
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 22f6ebc28e40..425dcab0cd1c 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1340,7 +1340,6 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
 	struct s5p_mfc_dev *dev = ctx->dev;
 	struct s5p_mfc_enc_params *p = &ctx->enc_params;
 	struct s5p_mfc_buf *dst_mb;
-	unsigned int enc_pb_count;
 
 	if (p->seq_hdr_mode == V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE) {
 		if (!list_empty(&ctx->dst_queue)) {
@@ -1362,10 +1361,8 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
 			set_work_bit_irqsave(ctx);
 		s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 	} else {
-		enc_pb_count = s5p_mfc_hw_call(dev->mfc_ops,
+		ctx->pb_count = s5p_mfc_hw_call(dev->mfc_ops,
 				get_enc_dpb_count, dev);
-		if (ctx->pb_count < enc_pb_count)
-			ctx->pb_count = enc_pb_count;
 		if (FW_HAS_E_MIN_SCRATCH_BUF(dev)) {
 			ctx->scratch_buf_size = s5p_mfc_hw_call(dev->mfc_ops,
 					get_e_min_scratch_buf_size, dev);
@@ -1731,14 +1728,6 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 		}
 		ctx->capture_state = QUEUE_BUFS_REQUESTED;
 
-		ret = s5p_mfc_hw_call(ctx->dev->mfc_ops,
-				alloc_codec_buffers, ctx);
-		if (ret) {
-			mfc_err("Failed to allocate encoding buffers\n");
-			reqbufs->count = 0;
-			ret = vb2_reqbufs(&ctx->vq_dst, reqbufs);
-			return -ENOMEM;
-		}
 	} else if (reqbufs->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		if (reqbufs->count == 0) {
 			mfc_debug(2, "Freeing buffers\n");
@@ -1754,15 +1743,13 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 			return -EINVAL;
 		}
 
-		if (IS_MFCV6_PLUS(dev)) {
+		if (IS_MFCV6_PLUS(dev) && (!IS_MFCV12(dev))) {
 			/* Check for min encoder buffers */
 			if (ctx->pb_count &&
 				(reqbufs->count < ctx->pb_count)) {
 				reqbufs->count = ctx->pb_count;
 				mfc_debug(2, "Minimum %d output buffers needed\n",
 						ctx->pb_count);
-			} else {
-				ctx->pb_count = reqbufs->count;
 			}
 		}
 
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index c4953419be0e..c00debe5db76 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -377,7 +377,6 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 	default:
 		break;
 	}
-
 	/* Allocate only if memory from bank 1 is necessary */
 	if (ctx->bank1.size > 0) {
 		ret = s5p_mfc_alloc_generic_buf(dev, BANK_L_CTX, &ctx->bank1);
@@ -2255,6 +2254,14 @@ static inline int s5p_mfc_run_init_enc_buffers(struct s5p_mfc_ctx *ctx)
 	struct s5p_mfc_dev *dev = ctx->dev;
 	int ret;
 
+	ret = s5p_mfc_hw_call(ctx->dev->mfc_ops,
+			alloc_codec_buffers, ctx);
+	if (ret) {
+		mfc_err("Failed to allocate encoding buffers\n");
+		return -ENOMEM;
+	}
+	mfc_debug(2, "Allocated Internal Encoding Buffers\n");
+
 	dev->curr_ctx = ctx->num;
 	ret = s5p_mfc_set_enc_ref_buffer_v6(ctx);
 	if (ret) {
-- 
2.17.1

