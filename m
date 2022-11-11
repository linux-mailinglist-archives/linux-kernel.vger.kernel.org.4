Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AE86253B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiKKGZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiKKGXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:23:07 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9007298C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:22:40 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221111062239epoutp02ead9b98db1369579b8d0e8862b9194c5~mc4xy2ZVG1790417904epoutp02x
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:22:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221111062239epoutp02ead9b98db1369579b8d0e8862b9194c5~mc4xy2ZVG1790417904epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668147759;
        bh=0cd+7Lq/ft2W5HNN+7DpuSMIvfuHBZKLeits1YX9l9s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=STAZag/CsQrlLTzbj+ZVT1HXAgaK1fF2F+3zO99sbz9pwrjV0yZWlGCz5t8c7345G
         +uXFz/PpytRLG+GZ72L77KbLBlD8tD057711qm/cW4/9mQdoERTmkKIatN66IffEWl
         UbAQC8yyuIrQxRSp8drHtFMzWNP8a7wZAysAATJ0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20221111062238epcas1p4c98dbc13419ee5398d5ae978a8094e7e~mc4xU5nFJ1030410304epcas1p4T;
        Fri, 11 Nov 2022 06:22:38 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.226]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4N7pXZ32Tkz4x9Pw; Fri, 11 Nov
        2022 06:22:38 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.64.20046.E2AED636; Fri, 11 Nov 2022 15:22:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20221111062238epcas1p3418881a8f028e97afbb498645704c9c5~mc4w4ZiLL2013220132epcas1p3n;
        Fri, 11 Nov 2022 06:22:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221111062238epsmtrp23f7fe336a5e0207431862d27ef00ecc2~mc4w3jC912943729437epsmtrp2L;
        Fri, 11 Nov 2022 06:22:38 +0000 (GMT)
X-AuditID: b6c32a39-5cdfd70000004e4e-a1-636dea2e8094
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.35.14392.D2AED636; Fri, 11 Nov 2022 15:22:37 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221111062237epsmtip2dd0893159d27e1af28a4cfc05466a530~mc4wlV_7A2541425414epsmtip2Q;
        Fri, 11 Nov 2022 06:22:37 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] scsi: ufs: core: Change the variable's(check_for_bkops)
 type
Date:   Fri, 11 Nov 2022 15:22:09 +0900
Message-Id: <20221111062209.7365-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmnq7eq9xkg4uXRS1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZosZp9pYLRbd2MZkcXnXHDaL7us72CyWH//H5MDlcfmKt8fiPS+Z
        PCYsOsDo8X19B5vHx6e3WDz6tqxi9Pi8Sc6j/UA3UwBHVLZNRmpiSmqRQmpecn5KZl66rZJ3
        cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCNSgpliTmlQKGAxOJiJX07m6L80pJUhYz8
        4hJbpdSClJwCswK94sTc4tK8dL281BIrQwMDI1OgwoTsjKbOaWwF8zkq/nw4wdTA+JSti5GT
        Q0LARGLqgeOsXYxcHEICOxgltn34xALhfGKUmDj9PpTzjVGiedUjdpiWxhOPoFr2Mkp8mDOD
        DcL5wigxbUYvkMPBwSagJXH7mDdIXETgIaPEuksbwBYyC2hInJz1BGySsIC/xL51ixlBbBYB
        VYmrc/+AxXkFrCQWPpkGdaC8xJ/7PcwQcUGJkzOfsEDMkZdo3jqbGWSBhMBPdom9rzpZIBpc
        JJ79/c8KYQtLvDq+BepsKYnP7/ayQTQ0A3369RIThNPBKLGx9QUjRJWxxKfPnxlBXmAW0JRY
        v0sfIqwosfP3XEaIzXwS7772sIKUSAjwSnS0CUGUqEjM6TrHBrPr443HUDd4SJx90g7WKiQQ
        K/Hn0V62CYzys5D8MwvJP7MQFi9gZF7FKJZaUJybnlpsWGAKj9fk/NxNjOCUqmW5g3H62w96
        hxiZOBgPMUpwMCuJ8HJrZCcL8aYkVlalFuXHF5XmpBYfYjQFhvBEZinR5HxgUs8riTc0sTQw
        MTMysTC2NDZTEudtmKGVLCSQnliSmp2aWpBaBNPHxMEp1cC03WyXZFGuk6nUrwfzZz/Jyin2
        Z3xSFBJ88Na2hsCuMoElx+SLtSza0kOr7z5KeedvcJVrKVvJheOLDKVO5HuIR02+//CG0PaW
        52f0tm35sT1Urk1QVXiK0+Ky9TZPD2od9lv7xtSvv1Lp6Yu99gY8uT+v83P9vKx2RJ8/qTBJ
        VLZ5fvJ5mdxjog62Litdwn/OP/XrWOWTzAC/RuMNDgZbssTVw3bx3E35LH/KuDvyYWpO3M2N
        d/6HKopF72w0YjJd/3HB1WeWe5L+J+Y7Xw9NOHLaVC/ww/y2fwc9JysIPLq6+Uh5gPx0vT3+
        6gIXU3hzgrqacj8pbNENqPh75vT7tq9e4ranNBxtdPbLpiuxFGckGmoxFxUnAgB1OnyiMgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvK7uq9xkg2WXzCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZosZp9pYLRbd2MZkcXnXHDaL7us72CyWH//H5MDlcfmKt8fiPS+Z
        PCYsOsDo8X19B5vHx6e3WDz6tqxi9Pi8Sc6j/UA3UwBHFJdNSmpOZllqkb5dAldGU+c0toL5
        HBV/PpxgamB8ytbFyMkhIWAi0XjiEWsXIxeHkMBuRonDrbOZIBJSErv3nwcq4gCyhSUOHy6G
        qPnEKDHj/kYWkDibgJbE7WPeIOUiAq8ZJa73OILYzAIaEidnPWEHsYUFfCU6V69iBbFZBFQl
        rs79AxbnFbCSWPhkGtQN8hJ/7vcwQ8QFJU7OfMICMUdeonnrbOYJjHyzkKRmIUktYGRaxSiZ
        WlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHNxamjsYt6/6oHeIkYmD8RCjBAezkggvt0Z2
        shBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MK/NetvCu
        6v5T8ZK5faaP55k7TpnJJxKKQydPUuypn1v7xHI6yxuWGWGPtxx0aP6ymc1haVH/kcQzPaX/
        NFt+60m8eHJY+r77pSPX6hmYS2WuyWrvdSphUbjg/nPpWg0Gfv+TmkvtFkjtaQ3KnDCl9tWd
        w8s55RZtr2xZ9WP3pns7Tl0xU1hpoFkw+5rwPD8Wj7WXrz77Gm3xpnLHHeG5P94wnlNzuejP
        FGu0UGpD59LkVu7GIJnQ5akhQVUzj/1cyl4pF/gpR7TyTLTrDo2f6+/nbdh/7u12ppo8zo8/
        6hw54hJrpjVaKt7bunPNh8Tvx7zVCh59FfD8tvFByHfzr0uWnyk+lW+6rbb24GvHGiWW4oxE
        Qy3mouJEAODxmADdAgAA
X-CMS-MailID: 20221111062238epcas1p3418881a8f028e97afbb498645704c9c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221111062238epcas1p3418881a8f028e97afbb498645704c9c5
References: <CGME20221111062238epcas1p3418881a8f028e97afbb498645704c9c5@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

It only checks true and false, so it can be used as a bool type.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index fdbcbcf3f9d1..a5b6d6eacf83 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8825,7 +8825,7 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 
 static int ufshcd_link_state_transition(struct ufs_hba *hba,
 					enum uic_link_state req_link_state,
-					int check_for_bkops)
+					bool check_for_bkops)
 {
 	int ret = 0;
 
@@ -8976,7 +8976,7 @@ static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba)
 static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 {
 	int ret = 0;
-	int check_for_bkops;
+	bool check_for_bkops;
 	enum ufs_pm_level pm_lvl;
 	enum ufs_dev_pwr_mode req_dev_pwr_mode;
 	enum uic_link_state req_link_state;
-- 
2.29.0

