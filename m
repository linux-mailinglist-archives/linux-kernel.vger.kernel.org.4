Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73C969A756
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjBQIsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBQIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:48:09 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238003251D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:48:06 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230217084804epoutp033ea714901e8c32b97571f5dea603f23d~EkFuqZ6ZH1811718117epoutp03V
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:48:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230217084804epoutp033ea714901e8c32b97571f5dea603f23d~EkFuqZ6ZH1811718117epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676623684;
        bh=D4c96abBnqAEnbKACGW2gCIF8B2km59E2gdY/W+0IM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yd/TCprUr4zbgP0+SsAjbD2hSQYZlxf+7x5DFnqIhXfGm/w0eDXtVy2NlGrAyarMt
         cqUHZB54u2B5ILdO5ZGg5uJJ0FWqX0XvtZkEsUSsVNq3bpwWrxmi10tRgp3T/B/Aq8
         mkyGEa6zoN/nfd+u0VtDrf2A8fexeAk0+3MzoelM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230217084804epcas1p2f27e10c4f6d45d0f6f2f49b31208c512~EkFub3YAu0793207932epcas1p2v;
        Fri, 17 Feb 2023 08:48:04 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.242]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PJ5775QGBz4x9Q1; Fri, 17 Feb
        2023 08:48:03 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.26.54823.34F3FE36; Fri, 17 Feb 2023 17:48:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230217084803epcas1p12b708d8119263cef2233d652062ba3d1~EkFtjoQ6V1479114791epcas1p1G;
        Fri, 17 Feb 2023 08:48:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230217084803epsmtrp225e9da445e547008dc7f8469ecce56f1~EkFti7BwD3026830268epsmtrp2Q;
        Fri, 17 Feb 2023 08:48:03 +0000 (GMT)
X-AuditID: b6c32a39-d01fc7000000d627-9e-63ef3f43183a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.55.05839.34F3FE36; Fri, 17 Feb 2023 17:48:03 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230217084803epsmtip298a82d811f33b1349c1ecb38fdd5af92~EkFtXa-S-2511925119epsmtip2N;
        Fri, 17 Feb 2023 08:48:03 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH 1/4] extcon: remove redundant null checking for class
Date:   Fri, 17 Feb 2023 17:46:10 +0900
Message-Id: <20230217084613.25359-2-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230217084613.25359-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmnq6z/ftkg28TtC1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGU3959kL/nFWzJzfydTAOI2ji5GTQ0LARGL5qy62
        LkYuDiGBHYwSD/5OZ4ZwPjFKLL84HSrzjVFi7qupzDAtN3peM0Ek9jJKbPo3AarqF6PEmo7H
        jCBVbAIaEnsuNgAlODhEBAolDvdng4SZBdQkHqzayA5iCwu4Stzc/QVsKIuAqsTntYdYQWxe
        ASuJA1MfskIsk5fo/veHBcTmFLCW+Lv3JlSNoMTJmU9YIGbKSzRvnQ12toTAPnaJMyt2skA0
        u0gsuzCLCcIWlnh1fAs7hC0l8fndXjYIO11i5ZU7UPEcidf32xkhbGOJd2/XMoPczyygKbF+
        lz5EWFFi5++5jBB7+STefe1hBSmREOCV6GgTgihRluh+8AJqq6TE4qd3oCZ6SEy8/BAsLiTQ
        xyix6qLKBEaFWUi+mYXkm1kIixcwMq9iFEstKM5NTy02LDCFR3Byfu4mRnC607LcwTj97Qe9
        Q4xMHIyHGCU4mJVEeDfdfJMsxJuSWFmVWpQfX1Sak1p8iNEUGNYTmaVEk/OBCTevJN7QxNLA
        xMzIxMLY0thMSZxX3PZkspBAemJJanZqakFqEUwfEwenVAOT4R2fTOtr0bXPHz/n+D7lt9y/
        zKUMjRwqrz0PGR3VvfRtntp/7dUR1eWGSU8FHPsm7PnxMHl+XfPdG26VSqnnjv84eNpgoUm3
        oFBUzapaTrfrEv/afH31XLoLi345pV/36vqhzqz27nOEkleV9BWNqAjzLQ1Gd6UKmxVV+n+d
        i8iJ2F924g8DQ1qu0ZPbwQtC+5aGLPQK5mp9vXZ/ue2RjSerXczeGW8IVNSyfPxp+5+LLWa7
        DPI+Gpg92MS559vcvAOTfl+/d/WTzp0fhzKl10p9sv10JHPqZKZTRoUTzl1MrpZj4XUszOPN
        V/pY/NpLVdN50vPO+JoKm5gPB3bL/RD/6mNTJbPlQ5hdX7sSS3FGoqEWc1FxIgCQyxNkAAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSvK6z/ftkg2/NEhYn1ixisrj+5Tmr
        xeVdc9gsbjeuYHNg8ejbsorR4/MmuQCmKC6blNSczLLUIn27BK6Mpv7z7AX/OCtmzu9kamCc
        xtHFyMkhIWAicaPnNVMXIxeHkMBuRolve26xQSQkJc4uf8TexcgBZAtLHD5cDFHzg1Fi9YKD
        LCA1bAIaEnsuNoDViwgUS1w4sBgsziygJvFg1UZ2EFtYwFXi5u4vzCA2i4CqxOe1h1hBbF4B
        K4kDUx+yQuySl+j+9wesl1PAWuLv3pusIHuFgGpOT+KGKBeUODnzCdR4eYnmrbOZJzAKzEKS
        moUktYCRaRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnBYamnuYNy+6oPeIUYmDsZD
        jBIczEoivJtuvkkW4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJ
        g1OqgYkhKOHshqgTz953sF9dNHdWgOj8iPSW73KTb9k3RgZNDtf88W+JveXlbxE10SbX6i9w
        Jayt6Y57siN80qcS/WrrA8unPM/8b37+x709Zyy/BpzYzBOnntFdmqU22bxx/xKl2cn33k0v
        mDVhwfanKzYfb2Xy6mR+nf9065qfVd8Xn746tVbNY4r/lQze6WmXVpa16j9yyk7edf/TXrHZ
        XYeqzs8/2SbzrWjbijo5XaH7YUtPqxwUbGU+/WXXvge/rX2OzZyj847tyAH7HqGdF0zOBDu5
        2oqJ3og32d1Uui1xRsXaA6avV93f49TWs2fCsnSF8ralYpfN1skqHfpZni216HgAy4ojauZP
        1fLvaHIJKbEUZyQaajEXFScCAKTnGLq6AgAA
X-CMS-MailID: 20230217084803epcas1p12b708d8119263cef2233d652062ba3d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230217084803epcas1p12b708d8119263cef2233d652062ba3d1
References: <20230217084613.25359-1-bw365.lee@samsung.com>
        <CGME20230217084803epcas1p12b708d8119263cef2233d652062ba3d1@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create_extcon_class() is already Null checking.

Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
---
 drivers/extcon/extcon.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e1c71359b605..adcf01132f70 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1012,12 +1012,13 @@ ATTRIBUTE_GROUPS(extcon);
 
 static int create_extcon_class(void)
 {
-	if (!extcon_class) {
-		extcon_class = class_create(THIS_MODULE, "extcon");
-		if (IS_ERR(extcon_class))
-			return PTR_ERR(extcon_class);
-		extcon_class->dev_groups = extcon_groups;
-	}
+	if (extcon_class)
+		return 0;
+
+	extcon_class = class_create(THIS_MODULE, "extcon");
+	if (IS_ERR(extcon_class))
+		return PTR_ERR(extcon_class);
+	extcon_class->dev_groups = extcon_groups;
 
 	return 0;
 }
@@ -1088,11 +1089,9 @@ int extcon_dev_register(struct extcon_dev *edev)
 	int ret, index = 0;
 	static atomic_t edev_no = ATOMIC_INIT(-1);
 
-	if (!extcon_class) {
-		ret = create_extcon_class();
-		if (ret < 0)
-			return ret;
-	}
+	ret = create_extcon_class();
+	if (ret < 0)
+		return ret;
 
 	if (!edev || !edev->supported_cable)
 		return -EINVAL;
-- 
2.35.1

