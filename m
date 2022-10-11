Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D005FBFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJLDtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJLDst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:48:49 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22CBAA35F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:48:06 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221012034805epoutp0395dc35a351eb1af6d6bd0c073c4d98d2~dNbQusPKi2774927749epoutp03_
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:48:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221012034805epoutp0395dc35a351eb1af6d6bd0c073c4d98d2~dNbQusPKi2774927749epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546485;
        bh=HwMR3+1hStRRWuRYIIGNTqjehbkPDPwENd53xivaowQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKjR0qND2EMJcaVKz0VPUJqqKt0js3nWvpoaF8A0eKXlx1SLSR95LfqVHCgJxfj7O
         fK9t8o+N3kkwGvyGMqR/3u1XymEfIhWjxCSvpXf9Kyyxv86oLfW6uP/LDxOjw84bSI
         f3jh7UZMyj7VLb7o5sE6n1wEeSxNyr3ZMFQj03MQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221012034804epcas5p4ffd29dd8a75babe87494abf146f1aeea~dNbQEEk3p1445014450epcas5p4M;
        Wed, 12 Oct 2022 03:48:04 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MnJX16cJvz4x9Pp; Wed, 12 Oct
        2022 03:48:01 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.2E.26992.1F836436; Wed, 12 Oct 2022 12:48:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221011125212epcas5p2b39bc34805f63de7da5b4a098f10689f~dBNDoVHB-1500015000epcas5p2X;
        Tue, 11 Oct 2022 12:52:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221011125212epsmtrp2a81dc7a3681b22dfe7a95392b9d30525~dBNDmwgc61820118201epsmtrp2L;
        Tue, 11 Oct 2022 12:52:12 +0000 (GMT)
X-AuditID: b6c32a49-319fb70000016970-7d-634638f12efe
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.94.18644.CF665436; Tue, 11 Oct 2022 21:52:12 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125209epsmtip1f5d69eb6332f326b9fbbd3bba1d8c70b~dBNAiJK5G2675426754epsmtip1K;
        Tue, 11 Oct 2022 12:52:09 +0000 (GMT)
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
Subject: [Patch v3 10/15] media: s5p-mfc: Add support for UHD encoding.
Date:   Tue, 11 Oct 2022 17:55:11 +0530
Message-Id: <20221011122516.32135-11-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1STVRjHz33fd+876AxeQOnGScP3CEd3Ymw45qVALJVeT+nBQydOFq6d
        7Q2Isc1tkD86ZSlYCKZhx/FDIAZqoGATkGDqHENOSKBCYOkSQflhBw0WHY5itDGo/z7P936f
        57n3uffy8cBBMoSfrjFyeo1CzZC+RFPbamHEJEpQils6o9CD5iIeGixrIpF5ZhRDd80uAtnP
        N1Kooa8ER6c6bDxU7ujmoQtXhgj0w5h79UaRk0Cj5XUAjRf/TiLLcD8P3XuYjHpbSkmUf66R
        h846nBSqHriBoZOWWQxVNv5FoZyLDgo5rU0AHch1YOshe6bsDGCbnVWAHaiawtkfi50Ua7aO
        Y6yl5iuSvdNvJdnzVZ+xOe1PCPZwQw1g//niBMXmOQZI1mVZznZOu6hEv+0ZsWmcQsXpQzmN
        UqtK16TGMW8myTfIo2ViSYQkBq1lQjWKTC6O2fhWYkRCuto9BiY0W6HOckuJCoOBiVwXq9dm
        GbnQNK3BGMdwOpVaJ9WJDIpMQ5YmVaThjK9IxOKoaLfxg4w0W1c/ppsJ2DV338TbBw765wE+
        H9JSWGuLzgO+/EC6FcCTX3eS3mAKwCPmEsobuACsKbGCxQzbk2Cv3gLgqbpbuDfIwWDhzV/c
        gQ+fpCPg5Wob6eEl9OcADn9p9Jhwej8BnV1PKc9CEP0GnJzrAx4m6DD484PHhIcF9DroaDLN
        J0P6JVh7zjZf1MetT1Zfnd8fpA/5wLPfFWBe00Z48FEJ4eUg+LCjgfJyCHQ9urhQSAmHK8dx
        L6thvfXYgj8e2vpKCc/RcHo1rG+J9MrL4LeddfPlcdoPFjy9v9BKAJvLFjkclt6Z4Xn5RdhW
        Ww28zMKO2YqFqRwFsPK3bnAELC/+v0UFADXgBU5nyEzlDNE6iYb7+L9bU2ozLWD+qQs3NwPn
        4J8iO8D4wA4gH2eWCED568pAgUqxew+n18r1WWrOYAfR7gEexUOWKrXuv6IxyiXSGLFUJpNJ
        Y9bIJMzzArNJqAykUxVGLoPjdJx+MQ/j+4Tsw1LCLjfGDiclPvObxK5tVk1c+PXV4Lj4gC35
        bZuUKHtXQkerZizKtDY/s+fd8Eu54SPXXBsmkuPy946KWnfsXWWWBqT8ZDfXGl7eNlthufuY
        /mRZ8Yh1OmcaHOsR4Tbh+3OFal1C6jdjfwjkh+yOKyaKk5Xr5TvE8ehA0nH9UH1b3c6V3XsI
        6crICY3pvbrdg5fW7ARFwunxrYf811NbPhT63jyRH2wNuh7WI5yKPc4EFQS8s39F1qcfvV2S
        q5gqG7n3/eT1lCH17RWvJf9dtS3xOVOpP90enKTCbm/SpTsiAk8HLe2tvDrWO7a9pt1Fbs1O
        aO5qOD1AriJuZWSLfAqVzxjCkKaQCHG9QfEvNeWC1XMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnO6fNNdkg2MfRSye7pjJavFg3jY2
        i8U/njNZ3F/8mcXi0Oat7BZbrsxmtlh+/ACrxfwj51gtth98xGKx8QVQ9uLMuywWz+evY7R4
        Oesem8Wmx9dYLR6+Cre4vGsOm0XPhq2sFmuP3GW3WHr9IpPFsk1/mCwWbf3CbtG69wi7xd09
        2xgtWtqOMDlIeKyZt4bRY8fdJYwe15d8YvbYOesuu8fiPS+ZPDat6mTzuHNtD5vH5iX1Hq1H
        f7F49G1Zxejxr2kuu0fXketsHp83yXmc+vqZPYAvissmJTUnsyy1SN8ugSvjwJlrTAU/BCv+
        P5nB2sDYzt/FyMEhIWAiceCXWBcjF4eQwA5Gid33pzJ3MXICxWUk/rcdY4ewhSVW/nvODlHU
        zCTx/uhUNpAEm4CuxP6lB9hAEiICrYwS11d2MoE4zAKzWSR+TDrAClIlLOAu8fH/FUYQm0VA
        VeLs0/csIDavgJ3EkW0z2CBWyEus3nAAbDUnUPzj0mNgcSEBW4nG91OZJjDyLWBkWMUomVpQ
        nJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERx5Wlo7GPes+qB3iJGJg/EQowQHs5IIL+N8p2Qh
        3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamAzktVfPEfxy
        4/EFt87Ofxv01V/X8fvIiZ1QSJ2ofodzkuEdkVcNn1i+rcgKY21P/f75WmL72kWTlnGbfioJ
        +sX60lDKYla21T/XCatDF85t2aLiw2V2Y2HD+kiztveLr3+VrGLIspeb/W3FecEGuze9TCIy
        qzaFaKs6Vs7LVVItNFi3xCOQ1eLYBtP/E673nE/N6uzl27svKm+5/Idr/xbHFLrJaHa//v/s
        wkahh59mvH1mV7ngdJ/M6a75ZqLedryhnGezvewWTQ6SjN2sG/M4tzdhvnLN/+l7y40c5cJ5
        HQ/a7CoIZ3ntp8Q39Xr0HI3lb4O47p++2e206kmo3FTZ1X4S3GcPtF4Nf9G+XImlOCPRUIu5
        qDgRABFHIC8rAwAA
X-CMS-MailID: 20221011125212epcas5p2b39bc34805f63de7da5b4a098f10689f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125212epcas5p2b39bc34805f63de7da5b4a098f10689f
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125212epcas5p2b39bc34805f63de7da5b4a098f10689f@epcas5p2.samsung.com>
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

MFC driver had restriction on max resolution of 1080p, updated it for
UHD. Added corresponding support to set recommended profile and level
for H264 in UHD scenario.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c |  9 ++++++---
 .../media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c  | 12 ++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index b761b9a31383..f953a3ed7f20 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1628,9 +1628,12 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 			mfc_err("Unsupported format by this MFC version.\n");
 			return -EINVAL;
 		}
-
-		v4l_bound_align_image(&pix_fmt_mp->width, 8, 1920, 1,
-			&pix_fmt_mp->height, 4, 1080, 1, 0);
+		if (IS_MFCV12(dev))
+			v4l_bound_align_image(&pix_fmt_mp->width, 8, 3840, 1,
+					&pix_fmt_mp->height, 4, 2160, 1, 0);
+		else
+			v4l_bound_align_image(&pix_fmt_mp->width, 8, 1920, 1,
+					&pix_fmt_mp->height, 4, 1080, 1, 0);
 	} else {
 		mfc_err("invalid buf type\n");
 		return -EINVAL;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 2194df7b6fbf..c4953419be0e 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1116,6 +1116,18 @@ static int s5p_mfc_set_enc_params_h264(struct s5p_mfc_ctx *ctx)
 	reg |= ((p->num_b_frame & 0x3) << 16);
 	writel(reg, mfc_regs->e_gop_config);
 
+	/* UHD encoding case */
+	if ((ctx->img_width == 3840) && ctx->img_height == 2160) {
+		if (p_h264->level < 51) {
+			mfc_debug(2, "Set Level 5.1 for UHD\n");
+			p_h264->level = 51;
+		}
+		if (p_h264->profile != 0x2) {
+			mfc_debug(2, "Set High profile for UHD\n");
+			p_h264->profile = 0x2;
+		}
+	}
+
 	/* profile & level */
 	reg = 0;
 	/** level */
-- 
2.17.1

