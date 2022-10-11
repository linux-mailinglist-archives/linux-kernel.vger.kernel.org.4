Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEA15FBFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJLDuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJLDs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:48:56 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEE7AA3CB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:48:12 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221012034810epoutp04d5a60932b8f44637558c90a59c5f8179~dNbVv3iLe0566605666epoutp043
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:48:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221012034810epoutp04d5a60932b8f44637558c90a59c5f8179~dNbVv3iLe0566605666epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546490;
        bh=chpvPs1wVCLEiyOjSmKubsXXcJUSnABUBYGI4mNvtZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P02NzfV00THoVTk+QZ6IWlhdJ6hBA0xkv/Yby+yELrMB1jbaT82q3SdsApawvP/LS
         eTDjeL69EDVCBeqSkMJxejuHdKYr16SyMr3Yj6mmGiP/bYwpW+BALpZvjSWlWlxH8l
         1udvrE15FebMYy/ptXMZ0RUaKYL/VkpwvX20pGLs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221012034809epcas5p1e25c3ac184dba31acfc1b235d7e03d0b~dNbU7b1240055500555epcas5p1f;
        Wed, 12 Oct 2022 03:48:09 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MnJX53q4Dz4x9Pv; Wed, 12 Oct
        2022 03:48:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.2E.26992.5F836436; Wed, 12 Oct 2022 12:48:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125215epcas5p1021a37aff1bc8956191ff435474e1503~dBNGtzl-U3163231632epcas5p1-;
        Tue, 11 Oct 2022 12:52:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221011125215epsmtrp1618467a7515266d81d8f8246bf757414~dBNGsyAvV2654526545epsmtrp1L;
        Tue, 11 Oct 2022 12:52:15 +0000 (GMT)
X-AuditID: b6c32a49-0c7ff70000016970-86-634638f5a614
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.94.18644.FF665436; Tue, 11 Oct 2022 21:52:15 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125212epsmtip10ce56d162cae548afeecd030a875f51d~dBNDrDPlt2145321453epsmtip1M;
        Tue, 11 Oct 2022 12:52:12 +0000 (GMT)
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
Subject: [Patch v3 11/15] media: s5p-mfc: Add support for DMABUF for encoder
Date:   Tue, 11 Oct 2022 17:55:12 +0530
Message-Id: <20221011122516.32135-12-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1DTZRzHe77f7buBDb4h5OMuaazDgpMfq20+dICdcuObGUd01dld4tq+
        AbKNtQ1LuUsNh4IgwkGLQcP4ZYDAGj8CRkYwRYEjMXJWDjVaOK87cVOOg35tbdR/r8/7eX/u
        8+N5HjYeNk9w2XkqHa1RSRV8IpgxMB7zbNwjJJEl1jkhcg7WMdFt0wCBmlcWMXSr2cNAY739
        LNQ3V4+jcxOjTNRom2Gir779hYG+vOs9na1zMNBiYzdALuM8gSwL15nozr230PfDDQQqN/cz
        UZfNwUKt9lkMtVn+wFBT/0MW0n9tYyHHyABAx0ts2EuQOm86D6hBRwug7C1unBoyOlhU84gL
        oywdpQR18/oIQfW2HKH0F1cZ1Om+DkD99fFnLKrMZicojyWSmnzkYWWGvJ2fnEtL5bSGR6tk
        BfI8VU4K/5XXs3dli8SJgjhBEtrO56mkSjqFn7YnM06Sp/Cugc87KFUUeqVMqVbLT0hN1hQU
        6mheboFWl8Kn1XKFWqiO10qV2kJVTryK1r0oSEx8XuQ17s/PvVt1DlMPbv5w6oLqKLgfXgaC
        2JAUwvmfXMwyEMwOI60A3p9zAX/gBtBV2UL4Aw+AE8faGespekNfwDUMYMV0O+YP9Bic7V1i
        +VwEGQe/aR0lfBxOHgNw4aTOZ8LJYgZ0TK95TWz2RnIPvDj0mg8ZZDQs9Rzy2TlkKvzOdIrp
        L/Y07DSP4j4O8uoPWi8Rfv1EEKwZfcLPaXDaWhnQN8J7E30sP3O9E5QEWAYXmly4nxWwZ6Qm
        MMwOODrXwPC1gJMxsGc4wS9vgbWT3ZiPcTIEVqz9ivl1Dhw0rfNW2HBzJdDmU3C8sxX4mYI/
        D/0Z2E8VgHpzK34GRBr/L3EWgA6wmVZrlTm0VqQWqOgP/rszWYHSAv596LEvDwLH7aX4MYCx
        wRiAbJwfzgGNO2VhHLn00GFaU5CtKVTQ2jEg8q6vCudGyAq8P0WlyxYIkxKFYrFYmPSCWMDf
        xGn+NFYWRuZIdXQ+TatpzXoexg7iHsU2fGQiEk6lxaZvATHbon/bN5SpXos48aBrSP9J1hsG
        s7kyvaHpBthlUVnLJJ4n+7urnWM7hFe2lq+8J5XYkdm5k6yt/Twnavd4hNtTdPzNH0uXotyX
        a5Sdy9XvTBqvOX5QXqrAo/5+GNqTXC/PszZvm8rI+v2q+CIeVv4ua7gp/2To3OV4mXEx8jBX
        wuI5JasH9i8zyGwm+6yzzTOSdgEGG0TW1eJi8rGiK6mltht2UfvpzC+eubb3DsoydBVVP759
        bkN0rX361plloynS3SjXvBp3kHkgwxlTErJv5jlOJ7dYaHj/6rA13b27Z5PG0DZT38c7ItwL
        VuQlGTPzoVN8hjZXKojFNVrpP5dZrSBxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRf1CLcRzHfZ89z7OnXeW51fEdzo+duoxizp0vV3Hu4stxfhwhUY96SrQ1
        WyH/IHLX/KoUJ7W51UJKWWvGFTNrpfwourrdmfKz4hwZtcMV0/nv9fm87v35/PFmBOJicgqT
        pszk1UouXUqLSMtD6fTwsZSYpAXa+rnovfUShfp0FhqVe/sJ1FvuIZG9vkGIzF2XBehqi41C
        esdTCt1+8IZEtwb+2s5LbhL1628CNFjyikamt90Uev1xK3pxt5RGp+saKFTjcAuRsaeTQJWm
        3wQyNHwXotwmhxC5Gy0AnTjpIJZDXK2rBtjqrgC4p+KbAN8pcQtxeeMggU1VeTR+2d1I4/qK
        Izi3+SeJz5qrAB7NKRNiraOHxh7TdNz2wyPcEBgnikzm09MO8Or50YmiPQMFVwmVVXKo/Z7y
        KPgSrAV+DGQXwdyLZqAFIkbMWgH8UJZDj4tpcOykUzjOQfD6aP8/FrPHCdhRsNrHNBsO7xtt
        tC8czOYC2HM9j/ANAvYyCb2FNkoLGCaIXQub72z0IcmGwDxPti8bwEbDZ7pT1Pj9GfBGnU3g
        Y7+/+yGjkx7/FQWPfSkm8kHgFTChCkh4lUaRqtDIVQuV/MEIDafQZClTI5IyFCbwrzmZzAoa
        q75G2AHBADuAjEAaHAD0K5LEAclc9mFenZGgzkrnNXYwlSGlkwM6tI8SxGwql8nv43kVr/5v
        CcZvylECHG+xP/p0f8FmGDtzSad8+ExUymjsE2ogOzrHsG3S50rz6QPn2vb+Xhk4yDmNu1qd
        Xgvf5OjrPr9l1ONSPDDuSHPHyB8n4t6oC5beljPxp0qK9uc5fw1Hh75qxi50saEteU5cSNjk
        kc0xYbU3txqyJLL0wn2hFZKxhP7n/t3GkhC9N7+2/Z1jt8tWMxtntA4Z1tVFlu1sru1aPC2+
        QLcu5efAlqilb4tqJ8JJqqG5a7o+lRZfy3Dp5EHrN3VYkvQhI0XbA7mIUrmCX6XfudLfe2TZ
        rF+yl/eovtAbBq8oKz7x4MTKE+LEEYn5zcJ8urfQ1cq1J7wm4uetintWoAqVkpo9nFwmUGu4
        P9qofV4oAwAA
X-CMS-MailID: 20221011125215epcas5p1021a37aff1bc8956191ff435474e1503
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125215epcas5p1021a37aff1bc8956191ff435474e1503
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125215epcas5p1021a37aff1bc8956191ff435474e1503@epcas5p1.samsung.com>
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

Add dmabuf support for mfc encoder

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  4 ++--
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 21 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index fe07112f013f..ad04ec68921b 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -850,7 +850,7 @@ static int s5p_mfc_open(struct file *file)
 		q->io_modes = VB2_MMAP;
 		q->ops = get_dec_queue_ops();
 	} else if (vdev == dev->vfd_enc) {
-		q->io_modes = VB2_MMAP | VB2_USERPTR;
+		q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 		q->ops = get_enc_queue_ops();
 	} else {
 		ret = -ENOENT;
@@ -877,7 +877,7 @@ static int s5p_mfc_open(struct file *file)
 		q->io_modes = VB2_MMAP;
 		q->ops = get_dec_queue_ops();
 	} else if (vdev == dev->vfd_enc) {
-		q->io_modes = VB2_MMAP | VB2_USERPTR;
+		q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 		q->ops = get_enc_queue_ops();
 	} else {
 		ret = -ENOENT;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index f953a3ed7f20..22f6ebc28e40 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1705,9 +1705,10 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
 	int ret = 0;
 
-	/* if memory is not mmp or userptr return error */
+	/* if memory is not mmp or userptr or dmabuf return error */
 	if ((reqbufs->memory != V4L2_MEMORY_MMAP) &&
-		(reqbufs->memory != V4L2_MEMORY_USERPTR))
+		(reqbufs->memory != V4L2_MEMORY_USERPTR) &&
+		(reqbufs->memory != V4L2_MEMORY_DMABUF))
 		return -EINVAL;
 	if (reqbufs->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		if (reqbufs->count == 0) {
@@ -1784,9 +1785,10 @@ static int vidioc_querybuf(struct file *file, void *priv,
 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
 	int ret = 0;
 
-	/* if memory is not mmp or userptr return error */
+	/* if memory is not mmp or userptr or dmabuf return error */
 	if ((buf->memory != V4L2_MEMORY_MMAP) &&
-		(buf->memory != V4L2_MEMORY_USERPTR))
+		(buf->memory != V4L2_MEMORY_USERPTR) &&
+		(buf->memory != V4L2_MEMORY_DMABUF))
 		return -EINVAL;
 	if (buf->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		if (ctx->state != MFCINST_GOT_INST) {
@@ -2842,11 +2844,12 @@ static int s5p_mfc_start_streaming(struct vb2_queue *q, unsigned int count)
 						S5P_MFC_R2H_CMD_SEQ_DONE_RET,
 						0);
 		}
-
-		if (ctx->src_bufs_cnt < ctx->pb_count) {
-			mfc_err("Need minimum %d OUTPUT buffers\n",
-					ctx->pb_count);
-			return -ENOBUFS;
+		if (q->memory != V4L2_MEMORY_DMABUF) {
+			if (ctx->src_bufs_cnt < ctx->pb_count) {
+				mfc_err("Need minimum %d OUTPUT buffers\n",
+						ctx->pb_count);
+				return -ENOBUFS;
+			}
 		}
 	}
 
-- 
2.17.1

