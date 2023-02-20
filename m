Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD5569C50C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjBTFpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBTFpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:45:51 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27697BDFA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:45:49 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230220054546epoutp04c603bd23a143b6bbc94000aed2753c90~Fcia9BiUp0260502605epoutp04m
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:45:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230220054546epoutp04c603bd23a143b6bbc94000aed2753c90~Fcia9BiUp0260502605epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676871947;
        bh=TTV8W6gw3S+wohmFfLikBMFap7zij34yNhu2CdJ/iUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iO6x0/i2RZgBnOb00qpwkhnmJs25DkKdtmY7UQsqM9rD8tTpeKBGwJ8bDWnXaD3gC
         RL7HVNrzeVHOsnJmeCD4CyvYAi4Riwp1vt7513PJXYaxEveHWhdxZ3rUyyTQ0h7kXs
         wrd41SVI9+NL6F1pfykSprzEx02L3a6A7WGmtDKw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230220054546epcas1p30dee9ef5a8819d341351c0405e0fb67a~FciaqA3ml1540715407epcas1p3r;
        Mon, 20 Feb 2023 05:45:46 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.224]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PKrxQ03Lkz4x9Q3; Mon, 20 Feb
        2023 05:45:46 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.D9.52037.90903F36; Mon, 20 Feb 2023 14:45:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230220054545epcas1p31abd5e19a4e4825c6f7a4be2139ddaed~FciZztUqi1540115401epcas1p37;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220054545epsmtrp2db5862a4cbeadb1a66309914dc8ac8d8~FciZzDH-b0986209862epsmtrp2B;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
X-AuditID: b6c32a37-d6eb8a800001cb45-19-63f309091d85
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.77.17995.90903F36; Mon, 20 Feb 2023 14:45:45 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230220054545epsmtip177169cb1b9e420a7bc37b0dccce00975~FciZmS1gn2598325983epsmtip1o;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v2 1/4] extcon: Removed redundant null checking for class
Date:   Mon, 20 Feb 2023 14:45:10 +0900
Message-Id: <20230220054513.27385-2-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230220054513.27385-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmni4n5+dkg99/LS1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGes+vWIq+MdZsf35K9YGxmkcXYycHBICJhIbLm9h
        7GLk4hAS2MEocXzxNTYI5xOjxL6u00wQzmdGiZbd25hgWjqeLISq2sUosfbdCSjnF6PE5obb
        bCBVbAIaEnsuNgDZHBwiAoUSh/uzQcLMAmoSD1ZtZAexhQU8JW4/2cwIYrMIqEq8efaCFcTm
        FbCSOHXvPDPEMnmJ7n9/WEBsTgFriX/PF7FB1AhKnJz5hAViprxE89bZzCA3SAjsY5fYtucP
        VLOLxOP5S6GuFpZ4dXwLO4QtJfH53V42CDtdYuWVO1DxHInX99sZIWxjiXdv1zKD3M8soCmx
        fpc+RFhRYufvuYwQe/kk3n3tYQUpkRDglehoE4IoUZbofvACaqukxOKnd6AmekjM2NjNDgmq
        PkaJ3cePsU9gVJiF5J1ZSN6ZhbB5ASPzKkax1ILi3PTUYsMCY3gMJ+fnbmIEJzwt8x2M095+
        0DvEyMTBeIhRgoNZSYRX+tCHZCHelMTKqtSi/Pii0pzU4kOMpsDAnsgsJZqcD0y5eSXxhiaW
        BiZmRiYWxpbGZkrivOK2J5OFBNITS1KzU1MLUotg+pg4OKUamGQrHl2b+U506+oOp/fCxYd8
        jK7oiE3q9f6/7MZCjn0rVPzObqiXs5i4TfDjo63hXV0bvhf+EbzqVMOs11rx5LHGsq3PG0/+
        XWOR71F4btmDlIgrQVMm6H4JFbC7zuWlodzr8TVR+7r5n2c7nVatrHhoyzm1f1Hg3alRe9+k
        T1nTllmxKC1Z8p232DKZHmmORXaF+ovPuU7u2mO/q8RoxZSdDg0LA+4tKnDI21D06sbVTcy6
        Hw5ZKL1p58nTvNQj+e6jX/OnjRpemxdLvTO93VTmfHK58a7dulPYz2hP/BXJVeSw/U7+a3Xv
        qTcU56ztujuPJT34tMMcPyMbzt+Fr+fN9Oz9ZbUpw6ns9sd15/4qsRRnJBpqMRcVJwIAnNv+
        DQEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnC4n5+dkg1vL1S1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZ6z69Yir4x1mx/fkr1gbG
        aRxdjJwcEgImEh1PFrJ1MXJxCAnsYJQ4uXsiC0RCUuLs8kfsXYwcQLawxOHDxRA1Pxglzl7Z
        D1bDJqAhsediAxuILSJQLHHhwGKwOLOAmsSDVRvZQWxhAU+J2082M4LYLAKqEm+evWAFsXkF
        rCRO3TvPDLFLXqL73x+wXk4Ba4l/zxeBzRQCqmmbPJkZol5Q4uTMJ1Dz5SWat85mnsAoMAtJ
        ahaS1AJGplWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMGBqaW1g3HPqg96hxiZOBgP
        MUpwMCuJ8Eof+pAsxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwT
        B6dUAxNHxOLzbsnT9ZjOfDyYeW3m5BBVa43tIgGbnEzz/RKNs06ZsJ/JPzfftujdo9gab701
        K3yXlvet/le7afLEv0stNAxZz/zqKzjueDwnYl7KKr7uy2ejfPv03BY9TcoPMZ15M7f6lNW0
        +/OuGWt+jZ1keeB14rynWXPl7kWI2y+wvHIiubSU01BVfbp3oWzmTVZl6ae7lgeyOWt8lmoW
        OL4v+Yfdz/UZ13W3Jzyc/KpbrcT0atmyz1Iyau+lv2h4nsy698VPRbX2Y9nEtQaOD9b9Tdpp
        /zph3bPr93sWHvRz+eu+9kFux9w1ctyvfMr1JxhOrA4LlFkh9dOr05F/P9uqDxfNz7QUtHpE
        KWf+f6jEUpyRaKjFXFScCACQ1KiYuwIAAA==
X-CMS-MailID: 20230220054545epcas1p31abd5e19a4e4825c6f7a4be2139ddaed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220054545epcas1p31abd5e19a4e4825c6f7a4be2139ddaed
References: <20230220054513.27385-1-bw365.lee@samsung.com>
        <CGME20230220054545epcas1p31abd5e19a4e4825c6f7a4be2139ddaed@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_extcon_class() is already Null checking.

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

