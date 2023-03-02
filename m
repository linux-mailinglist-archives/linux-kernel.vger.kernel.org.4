Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F66A7A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCBDhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCBDhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:37:06 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC8F3BD8E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:36:54 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230302033651epoutp04397de9bf810302d72508ffc08269ea85~IfOt4P5bN2276622766epoutp04s
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:36:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230302033651epoutp04397de9bf810302d72508ffc08269ea85~IfOt4P5bN2276622766epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677728212;
        bh=TTV8W6gw3S+wohmFfLikBMFap7zij34yNhu2CdJ/iUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RW50KQdttHWKnUVbDLpAn2Aamn9+A2dWyo+Pz8+oxb8u4ZP1gWLoCaYY1OflOwqzs
         VaUZUc4Dy6+Vd/gSDyme+HwCvxaYsiDPsm89fvNU5nfv9tRu3XW+iLXqN/Cp8jyCSC
         VaQg0E6jHbS/2sTRJphNUT/q4yNCVOZAqERf42PE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230302033651epcas1p3119e36fd81b3c182c2e73086635400e6~IfOtnF3mB2217022170epcas1p3Q;
        Thu,  2 Mar 2023 03:36:51 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.240]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PRxc301Grz4x9Q8; Thu,  2 Mar
        2023 03:36:51 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.AA.55531.2D910046; Thu,  2 Mar 2023 12:36:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230302033650epcas1p492dbeedda48fc2d18af86cfd0c1f77a6~IfOslVrBa3273032730epcas1p4e;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230302033650epsmtrp2aeaa177d0ee2fecf847c50eaf80778c6~IfOsku_BH2079320793epsmtrp2D;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
X-AuditID: b6c32a35-d9fff7000000d8eb-f9-640019d235d1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.90.05839.2D910046; Thu,  2 Mar 2023 12:36:50 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230302033650epsmtip28e209f832f4b265d527f5197ad012f0b~IfOsWWdbk2452424524epsmtip2V;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v3 1/4] extcon: Removed redundant null checking for class
Date:   Thu,  2 Mar 2023 12:36:42 +0900
Message-Id: <20230302033645.23933-2-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230302033645.23933-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmge4lSYYUg0drrCxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGes+vWIq+MdZsf35K9YGxmkcXYycHBICJhINPyYw
        dzFycQgJ7GCUeD/1JCOE84lR4ujnw+wQzjdGifOHN7HDtNxed44NIrGXUWLKuxtQLb8YJaZN
        6mADqWIT0JDYc7EByObgEBEolDjcnw0SZhZQk3iwaiPYIGEBT4kjHw4wgtgsAqoSaxZ3gtm8
        AlYSGxouMEMsk5fo/veHBcTmFLCW+Pb2BztEjaDEyZlPWCBmyks0b53NDLJKQmAbu8ROU4hW
        F4kJ3cegxghLvDq+Bep+KYnP7/ayQdjpEiuv3IGK50i8vt/OCGEbS7x7uxZsJLOApsT6XfoQ
        YUWJnb/nMkJs5ZN497WHFWIrr0RHmxBEibJE94MXTBC2pMTip3egJnpIdF64Ag3oPkaJqXuW
        sE5gVJiF5JlZSJ6ZhbB5ASPzKkax1ILi3PTUYsMCQ3j8JufnbmIEJzst0x2ME99+0DvEyMTB
        eIhRgoNZSYR34e0/yUK8KYmVValF+fFFpTmpxYcYTYFBPZFZSjQ5H5hu80riDU0sDUzMjEws
        jC2NzZTEecVtTyYLCaQnlqRmp6YWpBbB9DFxcEo1MO1bkyuT0vXrbt1Z/8yzOYePMkhcWZJ+
        KFfg12MzQ/sPGyqn994LmRLAMu/PValCg8boC6LnrzNrZK2p4RTMWN7IHWGz1WrP9ke3FlTV
        pf1ymRcTdXy+oqRnPce/GSpVf1afYpux56/fBdXPPjO8r/eEXH69/vH5jGU6EppeD+LU7s5d
        Yszp8flfn9NcVZGGzAUfuvzOzLZYX93XPm1G2gnf1JL8FX7/xP7ddjnJy6cqu6TBVLerXPlS
        fr7HLes2hj8WcoFmk48W3Fmd/XlG6h2lBJf7B5gszYNFXsV+1LEND2NSeVD6xHK7uuFUYSs1
        x93JAp3KmWz5NwwP7e1uVpS/u81FkKNP2uHJoRPcSizFGYmGWsxFxYkA8+UQe/8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvO4lSYYUgxv/pSxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZ6z69Yir4x1mx/fkr1gbG
        aRxdjJwcEgImErfXnWPrYuTiEBLYzShx48gKZoiEpMTZ5Y/Yuxg5gGxhicOHiyFqfjBKHN/S
        B1bDJqAhsediAxuILSJQLHHhwGIWEJtZQE3iwaqN7CC2sICnxJEPBxhBbBYBVYk1izvBbF4B
        K4kNDRegdslLdP/7A9bLKWAt8e3tD7BeIaCaPYt6mSHqBSVOznwCNV9eonnrbOYJjAKzkKRm
        IUktYGRaxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHJhamjsYt6/6oHeIkYmD8RCj
        BAezkgjvwtt/koV4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLg
        lGpgWnNwUQv/ghfrpqXf7eJ8pM9dszw9WcYk7s20tshHMbbs11IXMDluLjn80NeGieP63HrV
        M0bSU3I111UZmzhciLDLSRNbIVlv853X79Pebq5vT47r6EnrTRAUPGDYstSjb0mTs4q7wx/5
        mWk3jJ6fqizcUi34yNvj0YkvV+7N3BK4br5JQH/cf6Ujb5t/FVhsFZ97fNnC+I4SEYnMGhGv
        VW8DO9rF9eNV5LXCkx7/Ma2c/46XubDtgOrjfaqtRlNivWfe0rHrP2ar+G8jd9SH6Ne1ci3P
        jV5mz96+x8244x1nnORuQTnB1l/ioncMFdoWbHA1kytjku8sct1lXR6WLs0SWP01KWihn0z/
        bCWW4oxEQy3mouJEAOZGZb+7AgAA
X-CMS-MailID: 20230302033650epcas1p492dbeedda48fc2d18af86cfd0c1f77a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230302033650epcas1p492dbeedda48fc2d18af86cfd0c1f77a6
References: <20230302033645.23933-1-bw365.lee@samsung.com>
        <CGME20230302033650epcas1p492dbeedda48fc2d18af86cfd0c1f77a6@epcas1p4.samsung.com>
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

