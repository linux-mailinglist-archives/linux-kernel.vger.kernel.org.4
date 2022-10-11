Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB545FBFB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJLDt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiJLDsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:48:51 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A78BAA379
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:48:09 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221012034807epoutp041ed993fe55b184d6cd1e34a058944e00~dNbS6nYD70572305723epoutp04z
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:48:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221012034807epoutp041ed993fe55b184d6cd1e34a058944e00~dNbS6nYD70572305723epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546487;
        bh=FV3sAjnQj6sWCyIfuzNizpdl6TW9Ps+nD2ANc+8cLKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+mf2BDJjwNJgDbc9L7z4+JkY3p4ap1X0z+zSVO3lvvhZOTh1BY7112nStjTMxAUs
         KM6INTOlfzWxChn3K+HvlBqiPALsJao0Xs0xwgDQTjNnQ/7OWaZ2NhLhz7Wackqs//
         PyplSI1SfXcZKY0VhSpdVKLntkZ1Ww6BQQFgZyZA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221012034806epcas5p3c019b14085e0f87472b397f2c51113a1~dNbSNKxLt3241932419epcas5p3r;
        Wed, 12 Oct 2022 03:48:06 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MnJWz4xdmz4x9Q8; Wed, 12 Oct
        2022 03:47:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.82.56352.FE836436; Wed, 12 Oct 2022 12:47:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125209epcas5p1518083b1a20d015021ec5f08c832fae3~dBNActA0N3098030980epcas5p1V;
        Tue, 11 Oct 2022 12:52:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221011125209epsmtrp1816616c919f415ee30cb868d61dc2664~dBNAbkCRD2654526545epsmtrp1H;
        Tue, 11 Oct 2022 12:52:09 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-5a-634638ef1eeb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.94.18644.8F665436; Tue, 11 Oct 2022 21:52:08 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125205epsmtip14547c1b5301cedcadd47448896d0f682~dBM9ZM6dk2178621786epsmtip1t;
        Tue, 11 Oct 2022 12:52:05 +0000 (GMT)
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
Subject: [Patch v3 09/15] media: s5p-mfc: Add support for rate controls in
 MFCv12
Date:   Tue, 11 Oct 2022 17:55:10 +0530
Message-Id: <20221011122516.32135-10-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xbVRTHc/teX9vFkke3uSthwN6iMsKvOiiXCUiQsGeYBiXbdMaw2j4B
        Ka9NW5BtccAYAwpuEIQwREBKYfzYmAyQX0qBCgtR4uYoYdKxDQH5kf0ooEzItKWg/33Oud+T
        8z3n3svHRFOECz+R1TJqVqqgiB14x+ABL5/HKErmXzqyB810Xuai+5UdBNKvzXHQlH4ZRwM3
        2nmo7c5XGKofNnJRlWmUi77rf4ijb/+wnd66bMHRXNU1gObL7xGoddrMRQ8WjqNfuysIVHC9
        nYuumiw8ZBi/xUF1rRscVNO+wkPZ35t4yNLbAdD5CyZOOKSbK5sB3WmpBfR4rRWju8otPFrf
        O8+hWxvzCHrS3EvQN2rT6ewf/8bpi22NgH5+7mserTONE/Ryqxs9srrMi3E6kRSSwEjljNqD
        YWVKeSIbH0pFx8a9GRco8Rf7iINREOXBSpOZUCrySIxPVKLCtgbKI1WqSLGlYqQaDeUXFqJW
        pmgZjwSlRhtKMSq5QhWg8tVIkzUpbLwvy2gPif39Xwu0CU8mJVhm0lVXnNP6C7qIDNDjpAMC
        PiQDYENdBqYDO/gisgfAm7/kE47ACmDP4gZXB/i2YBnAtk+2C/Q3K7gOTTeAxqfrW0E2B3Zn
        ZfHsKoL0gX0GI2HnXWQmgNO5WrsII7NwaPlpfVO0k4yF1tVnm4yTL8Pbxb8BOwvJMLg0PMpx
        tHOHTdeNmJ0FtvxTw9CmPUjmCGChsY9wiCKhId/AdfBOuDDcxnOwC5y/dGGLZXC6Zh5zsAK2
        9H6JO/gNaLxTgdvHxMgDsKXbz5HeC0tGrm16wEgn+MX671t+hLCzcptfgRWTa1ttXeFgkwE4
        mIaZ1T8Dx1aKABwbM/MKgVv5/y2qAWgELzEqTXI8owlUHWSZz/67NJkyuRVsvnSv6E7w8P4T
        3wHA4YMBAPkYtUsIqiJkIqFceuo0o1bGqVMUjGYABNoWWIS57JYpbV+F1caJA4L9AyQSSUDw
        QYmY2iPUl3nJRGS8VMskMYyKUW/XcfgClwzO8Y1LXYv7PYnMR2Xo7tH43CDPs+n5g4c9V5QN
        i88/HjS6jw/lbuQg539O/akDaaNd9yhX53PfyM8UlfiZYt96tS7oblNHSHWNzu1EC5a6P3uo
        zpXNp1hq7FPXyqoPc/c1JJmLSoVls6dfr3t2MaL5UUvX29G3OydefEFgnipc/+CHEsXMyZwI
        Itx9JCjBeyLCvFpw9Z0a7+KjWPhfkWH1a/sk7qL38spSegfCZ8/zlUbrbN5K/7EHwoXS0isf
        8Wfy3Tpi9XMTgqzaqUKXJTUr6i8+Etz4+SDeB3fPHMsOtry7EeYjf5yUGmVdq146E+VtSSPZ
        mr1ph6rfDwNnpU8my+opXJMgFXthao30XxaBCU9yBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe8/OzjkKynEWvq2oWF7Aysoi3qjECuEoBSZlKEUNPfOSm7Jl
        2kW00uVMorIkb008XpeWzUvTVumczm7qslxaS7uYZWKmFmaiNaVvv+f5/fk/Hx6KJ7iBC6ko
        2XFWLhPHiAh7vL5FtGLdlMQvbIOpZhsa1OXw0cDNegJxU0MY6ucmcGSoqSNR7cs8HiozNfGR
        2tjBR/eaP+Do7pd/1pxjxdGQ+jZAX3PfEUj7sYeP3g8fRN2N+QTKrK7joyqjlUQlFjOGSrUz
        GCqqmyRR2gMjiaz6eoBSlUbMFzKVNysBo7MWA8ZSPM5jGnKtJMPpv2KMVqMimLc9eoKpKU5m
        0lqnceZSrQYws+cKSCbDaCGYCe0K5snPCTLQMdR+ezgbE3WCla/3OWofaR1Mjit3SmzObCBS
        wH3HDGBHQXoz5Nrz+RnAnhLQOgALJzp5C2I5nFO2kQvsDCtmh8iF0HkMGip750MEvQ4+Kmki
        bGIxnQagpUKF2QYenYfDqatNfFvKmd4H+8Z+z1fhtBt8kfUG2NiB9oEjpg5s4cRKeKu6ab7V
        7t/+R0kbYWMBvQOe/X4duwwcC8EiDVjKximkEVLFxjhvGZvgpRBLFfGyCK+wWKkWzD/P01MH
        9JoxLwPAKGAAkOKJFjsA9a4wgUO4+OQpVh57RB4fwyoMYBmFi1wcujIeHxHQEeLj7DGWjWPl
        /y1G2QlTMEn6p9nWU6+fmXtHx/V1S3JyhY8LvlBYb+7ZMn99AHT9XFj+KCjwjJNH61OXKnzv
        r2ivi2+chXMd+jTp5NiBCoHK9eEkiW9PLeJ2P/fNQ07uLVOgS7Lnifuhxt0hgZ4JYdyMaEap
        3hkyh+83p2p7kpUBu7g7r1IMfTnBtcHX9m2JpxMjvZM6OA8/f1N7jMr0J0utCfX2k0WeTDrv
        mx6kcePUKl9V1OBwb3epZWt/QcnrC398hkdiWeroiMvq6TVr+82Sw4GT8k53y+npnsaBmkyx
        VJU98KvZ9UqfUhD9Q9c5XhrUPjoaf27TpwcoKVvoH3Q6ZYtE/l39rTRatkqEKyLFGz15coX4
        L6Z0czkrAwAA
X-CMS-MailID: 20221011125209epcas5p1518083b1a20d015021ec5f08c832fae3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125209epcas5p1518083b1a20d015021ec5f08c832fae3
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125209epcas5p1518083b1a20d015021ec5f08c832fae3@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Smitha T Murthy <smitha.t@samsung.com>

In MFCv12, the rc configs are changed with support for CBR loose,
CBR tight and Variable Bitrate (VBR) added.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 22 +++++++++++++++----
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 27c2ada381ec..2194df7b6fbf 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1037,10 +1037,24 @@ static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
 
 	/* reaction coefficient */
 	if (p->rc_frame) {
-		if (p->rc_reaction_coeff < TIGHT_CBR_MAX) /* tight CBR */
-			writel(1, mfc_regs->e_rc_mode);
-		else					  /* loose CBR */
-			writel(2, mfc_regs->e_rc_mode);
+		if (IS_MFCV12(dev)) {
+			/* loose CBR */
+			if (p->rc_reaction_coeff < LOOSE_CBR_MAX)
+				writel(1, mfc_regs->e_rc_mode);
+			/* tight CBR */
+			else if (p->rc_reaction_coeff < TIGHT_CBR_MAX)
+				writel(0, mfc_regs->e_rc_mode);
+			/* VBR */
+			else
+				writel(2, mfc_regs->e_rc_mode);
+		} else {
+			/* tight CBR */
+			if (p->rc_reaction_coeff < TIGHT_CBR_MAX)
+				writel(1, mfc_regs->e_rc_mode);
+			/* loose CBR */
+			else
+				writel(2, mfc_regs->e_rc_mode);
+		}
 	}
 
 	/* seq header ctrl */
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
index 30269f3e68e8..24752a712fbf 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
@@ -40,6 +40,7 @@
 #define ENC_H264_LEVEL_MAX		42
 #define ENC_MPEG4_VOP_TIME_RES_MAX	((1 << 16) - 1)
 #define FRAME_DELTA_H264_H263		1
+#define LOOSE_CBR_MAX			5
 #define TIGHT_CBR_MAX			10
 #define ENC_HEVC_RC_FRAME_RATE_MAX	((1 << 16) - 1)
 #define ENC_HEVC_QP_INDEX_MIN		-12
-- 
2.17.1

