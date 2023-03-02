Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD116A7D3A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCBJCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCBJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:02:06 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED900392BC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:01:53 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230302090150epoutp03f2291fc2fa2d3e0a0f5f4245d27d8dd0~Ijqdr0ZQ71834118341epoutp03C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:01:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230302090150epoutp03f2291fc2fa2d3e0a0f5f4245d27d8dd0~Ijqdr0ZQ71834118341epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677747710;
        bh=TTV8W6gw3S+wohmFfLikBMFap7zij34yNhu2CdJ/iUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gFRFreqs7bwfIEIuiMASUp0JQE0cHPyRGjFF8BA7VTuxyGGjxLp54Rsj5gpilj2nr
         d6Zp09bqI4Li55WRyBl7uH+jTBss0pWdhZ+vx6Kj8lWhOOlg5uA068eOSBbEO8ZbKg
         1nbXzNFi0m7bOxUusPJSW2QYb7trnjUKNek8/+C0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230302090150epcas1p492366bcc11166555e3d78b5cc1a92058~IjqdQeeje2943429434epcas1p4K;
        Thu,  2 Mar 2023 09:01:50 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.227]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PS4q15t1Vz4x9Q3; Thu,  2 Mar
        2023 09:01:49 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.7D.55531.DF560046; Thu,  2 Mar 2023 18:01:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230302090149epcas1p35d6a66bf8b29ef159ecee93441560c58~IjqcXJ4Dg0383503835epcas1p3O;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302090149epsmtrp1ca2a7433e87756c9a25bc2cc70b71ccb~IjqcWaJl-0666306663epsmtrp1u;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
X-AuditID: b6c32a35-00ffd7000000d8eb-10-640065fd207c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.4E.18071.DF560046; Thu,  2 Mar 2023 18:01:49 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230302090149epsmtip2db19be2dd5a7a1369d989fcf200909c1~IjqcMogOs0725107251epsmtip2F;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v4 1/4] extcon: Removed redundant null checking for class
Date:   Thu,  2 Mar 2023 18:01:40 +0900
Message-Id: <20230302090143.46678-2-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230302090143.46678-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmge7fVIYUg9/vdCxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGes+vWIq+MdZsf35K9YGxmkcXYycHBICJhJfTp9n
        72Lk4hAS2MEoseDPPUYI5xOjxO1/OxlBqoQEvjFKnP7IBNPx98kWqKK9jBL32uewQTi/GCUO
        n73BAlLFJqAhsediA1CCg0NEoFDicH82SJhZQE3iwaqN7CC2sICnROfr92A2i4CqxISP28Fa
        eQWsJOY/WMUKsUxeovvfH7A4p4C1xJvJXVA1ghInZz5hgZgpL9G8dTYzyA0SAtvYJU4928QI
        sldCwEXi2SQbiDnCEq+Ob2GHsKUkXva3QdnpEiuv3IGycyRe329nhLCNJd69XcsMMoZZQFNi
        /S59iLCixM7fcxkh1vJJvPvawwqxiVeio00IokRZovvBC2hQSUosfnoH6hgPiXM/PSAB1cco
        saPnF+MERoVZSJ6ZheSZWQiLFzAyr2IUSy0ozk1PLTYsMIRHb3J+7iZGcKrTMt3BOPHtB71D
        jEwcjIcYJTiYlUR4F97+kyzEm5JYWZValB9fVJqTWnyI0RQY1BOZpUST84HJNq8k3tDE0sDE
        zMjEwtjS2ExJnFfc9mSykEB6YklqdmpqQWoRTB8TB6dUA9Pl3Rya9TP3f5W+tJQ95na+iFPc
        h+U3xGOuZQR9XdggMTVIee1KsQkOJk4s/x+lMHC2vXkVWtlf+3Hld0UJsU1unz2+S9VPmRfW
        eNeed/6vGalb13Sw7XgTlztjxp4uHsGsR/E+0/tK/PbP+6+9uCVgYV55QbHVZptXD/MiVeKl
        qm90+H1+f6N0j93bu6nL+VSSAlOjnQ/46RsfXqpXfiLG3ntdxzm1vHX/P30Lq3pSY7f7/XRR
        xX8BZbvzfMqtNdNKZl5ym8XbWR90RK1IYMX3vdm3T/bX+aSGxN3KVQ2vE7i+8VTOupiTc5Zs
        WPr0llpJwaneewX3Qy3/O30OVPV84ZN+M6C4a+UMxgorISWW4oxEQy3mouJEADGkX03+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvO7fVIYUg/+npSxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZ6z69Yir4x1mx/fkr1gbG
        aRxdjJwcEgImEn+fbGHsYuTiEBLYzSixZd4TdoiEpMTZ5Y+AbA4gW1ji8OFiiJofjBK3zvxl
        A6lhE9CQ2HOxAcwWESiWuHBgMQuIzSygJvFg1UawOcICnhKdr9+D2SwCqhITPm4Hq+EVsJKY
        /2AVK8QueYnuf3/A4pwC1hJvJneB2UJANdNf7YOqF5Q4OfMJ1Hx5ieats5knMArMQpKahSS1
        gJFpFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcGBqae5g3L7qg94hRiYOxkOMEhzM
        SiK8C2//SRbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qB
        aU8K44+ptVelDnjUFAdcPC5keKLigVPEZyfT8Hn7I340nFo8w5tRiDvodP+fi3cCHYOaO60O
        /notrzZDo+7urVNGwrscOru2PNsTZ+e/69SaulvP2SLTIx9+MKja2+clW9b7f6/vh+Vim7Yo
        pQswvglxqfhmdk4scd6OuwpH5nmVz1l4MSWs+KCFA+fGXtlt2W9mfDi9lG/G28erNvLy73Jh
        2/Yyt/Fg4t3Co3xRM93CQqPP7KzR5/TYy+e03/T8vz/7J8eLLGKrtuH+8axDUPS6o8qd/NSW
        gCP9JntZ9Nsi1EQzMzUWHlj0QNI93eDI9JY1H/kEwm433N+p0uzmtsiPUXiGQ97Gb9d5Ay9P
        UmIpzkg01GIuKk4EAIGkyFW7AgAA
X-CMS-MailID: 20230302090149epcas1p35d6a66bf8b29ef159ecee93441560c58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230302090149epcas1p35d6a66bf8b29ef159ecee93441560c58
References: <20230302090143.46678-1-bw365.lee@samsung.com>
        <CGME20230302090149epcas1p35d6a66bf8b29ef159ecee93441560c58@epcas1p3.samsung.com>
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

