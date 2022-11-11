Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311C462537C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiKKGWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKKGWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:22:04 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF38365E70
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:22:02 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221111062200epoutp027ba83405e9b84a7916f87b4e20b79d66~mc4N5PB6J1613216132epoutp02Y
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:22:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221111062200epoutp027ba83405e9b84a7916f87b4e20b79d66~mc4N5PB6J1613216132epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668147720;
        bh=QIr1dHYcDtmBCo3Pin7ZWdcXDJ3SQIMcXm90WmlaD6g=;
        h=From:To:Cc:Subject:Date:References:From;
        b=X3d3g5B3jy/OJQMJuY48NxyVL06kxeDq9RBgnSOxYDiytkwTnNCVrCXPVwb7nUGck
         2KS5g2S/oRVPwNHgY3iOQtRTVlgZ4KcQIZsIbiSdxjVBDN9IJXeQYWzpg3U67mAJLv
         qfe+66yd7U7BpRszp51akDN4SeWZGIrAmH8HfHMo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20221111062159epcas1p46fbb40f4fd9a01a5950fa83a86995915~mc4NYYfzh2517325173epcas1p4A;
        Fri, 11 Nov 2022 06:21:59 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.226]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4N7pWq2CGXz4x9Pv; Fri, 11 Nov
        2022 06:21:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.D9.07691.70AED636; Fri, 11 Nov 2022 15:21:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221111062158epcas1p1c3ef28f75c39a1c1dc4c473266462fc8~mc4MfA3fd0150001500epcas1p1w;
        Fri, 11 Nov 2022 06:21:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221111062158epsmtrp236e6d85cd2bba4769b83a9b6c0b9d18e~mc4MePXCE2890828908epsmtrp2v;
        Fri, 11 Nov 2022 06:21:58 +0000 (GMT)
X-AuditID: b6c32a38-0cdff70000021e0b-33-636dea079fac
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.6E.18644.60AED636; Fri, 11 Nov 2022 15:21:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221111062158epsmtip24fc99f873d7d7924953a34861f8e22a8~mc4MSueET2543325433epsmtip2O;
        Fri, 11 Nov 2022 06:21:58 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] scsi: ufs: core: Separate function name and message
Date:   Fri, 11 Nov 2022 15:21:26 +0900
Message-Id: <20221111062126.7307-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmni77q9xkg8dXeCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZosZp9pYLRbd2MZkcXnXHDaL7us72CyWH//H5MDlcfmKt8fiPS+Z
        PCYsOsDo8X19B5vHx6e3WDz6tqxi9Pi8Sc6j/UA3UwBHVLZNRmpiSmqRQmpecn5KZl66rZJ3
        cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCNSgpliTmlQKGAxOJiJX07m6L80pJUhYz8
        4hJbpdSClJwCswK94sTc4tK8dL281BIrQwMDI1OgwoTsjKZNRQX9whX/zrxha2Ccwd/FyMkh
        IWAisWriSfYuRi4OIYEdjBKH+qawQDifGCW+XfvKBlIlJPCZUWLR4kqYjifT+pkhinYxSjx/
        /gjK+cIosXndbMYuRg4ONgEtidvHvEHiIgIPGSXWXdoANolZQEPi5Kwn7CA1wgIuElceOoGE
        WQRUJWadXsgOYvMKWEncONbLDLFMXuLP/R5miLigxMmZT1ggxshLNG+dDbZXQuAnu8T0O5uY
        IBpcJI5vnwrVLCzx6vgWdghbSuLzu71sEA3NjBLbvl5ignA6GCU2tr5ghKgylvj0+TPYB8wC
        mhLrd+lDhBUldv6eywixmU/i3dceVpASCQFeiY42IYgSFYk5XefYYHZ9vPGYFcL2kDi+cx8z
        JBRjJTacuMQ2gVF+FpJ/ZiH5ZxbC4gWMzKsYxVILinPTU4sNC0zgkZqcn7uJEZxMtSx2MM59
        +0HvECMTB+MhRgkOZiURXm6N7GQh3pTEyqrUovz4otKc1OJDjKbAEJ7ILCWanA9M53kl8YYm
        lgYmZkYmFsaWxmZK4rwNM7SShQTSE0tSs1NTC1KLYPqYODilGpiS2kNuTLh9tebFOt90mRls
        /T8uPjrrwHPpfvbD+2GH8hRvzxJd8XTP/dBMnZ9djumX5fQPecZNypd49T2F17N4edi352Z7
        qq4HsbKob/xfvG9Hx/09855bbXv14uKpEOmPd1da25lW6wtx+rD9TAp6vezz7pS1+sGLUyNv
        7fjSMqt76p+TvD82rZoo3rnGLHDH8l9Lv8RNU3r3aerj9l0nc4U+2ee8k409lbNn836LGxW6
        c498Y3ZlnzLtH7u0bef02EiFZwvfJBzbzGDCfnb5p8Cn4t1r5HI+PI3R5A03lXsx1cnUTf5l
        R0yb77rcDu1WL3duhcSFkRxs5zp0dtVv6OOzn/C76azXfS7hjjuHlViKMxINtZiLihMBVkbU
        Ey8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvC7bq9xkg9sTzSxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZosZp9pYLRbd2MZkcXnXHDaL7us72CyWH//H5MDlcfmKt8fiPS+Z
        PCYsOsDo8X19B5vHx6e3WDz6tqxi9Pi8Sc6j/UA3UwBHFJdNSmpOZllqkb5dAldG06aign7h
        in9n3rA1MM7g72Lk5JAQMJF4Mq2fuYuRi0NIYAejRNelLjaIhJTE7v3ngWwOIFtY4vDhYoia
        T4wSGz+/YwGJswloSdw+5g1SLiLwmlHieo8jiM0soCFxctYTdpASYQEXiSsPnUDCLAKqErNO
        L2QHsXkFrCRuHOtlhtgkL/Hnfg8zRFxQ4uTMJywQY+QlmrfOZp7AyDcLSWoWktQCRqZVjJKp
        BcW56bnFhgVGeanlesWJucWleel6yfm5mxjBga2ltYNxz6oPeocYmTgYDzFKcDArifBya2Qn
        C/GmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cBUqKIx7W/E
        bce7O+9ap8kW6E/mefRvIkOykJL/l9sGLB7Tp1d6TZnzd34G17ZFe7Lap62u/7beOCn6TBnn
        tn2eXlXfV5TNCDAQ+GFZOy3YquuwUafDjphtbcbfhLObb9+RfVb58nrjhcaErKbFNv9rwuL+
        nDdjfuz3VS3oYMsf32dTP50ujtrf9iSobO3fSEfNY9t//NYV5n37q/AdX+TPXT5sd5VuT2P4
        57ZI6NABqY0d5V4zzybpXp6d93MWW5uhSNX9n7xu/hGWb4Lc3iSt9OupXrr78sRteacjjr1f
        IWhQfzN1z3L7tA8vLoa7pl5u47v1SWS1Od/6tnzXufY/LitXb55fybi9YMYax0mnlFiKMxIN
        tZiLihMB+l7FH9sCAAA=
X-CMS-MailID: 20221111062158epcas1p1c3ef28f75c39a1c1dc4c473266462fc8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221111062158epcas1p1c3ef28f75c39a1c1dc4c473266462fc8
References: <CGME20221111062158epcas1p1c3ef28f75c39a1c1dc4c473266462fc8@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

Separate the function name and message to make it easier to check the log.
Modify messages to fit the format of others.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 6 +++---
 drivers/ufs/core/ufshpb.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index e389d73765fe..fdbcbcf3f9d1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4480,7 +4480,7 @@ static int ufshcd_complete_dev_init(struct ufs_hba *hba)
 		QUERY_FLAG_IDN_FDEVICEINIT, 0, NULL);
 	if (err) {
 		dev_err(hba->dev,
-			"%s setting fDeviceInit flag failed with error %d\n",
+			"%s: setting fDeviceInit flag failed with error %d\n",
 			__func__, err);
 		goto out;
 	}
@@ -4497,11 +4497,11 @@ static int ufshcd_complete_dev_init(struct ufs_hba *hba)
 
 	if (err) {
 		dev_err(hba->dev,
-				"%s reading fDeviceInit flag failed with error %d\n",
+				"%s: reading fDeviceInit flag failed with error %d\n",
 				__func__, err);
 	} else if (flag_res) {
 		dev_err(hba->dev,
-				"%s fDeviceInit was not cleared by the device\n",
+				"%s: fDeviceInit was not cleared by the device\n",
 				__func__);
 		err = -EBUSY;
 	}
diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index b7f412d0f301..148017b2dfeb 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -2289,7 +2289,7 @@ static bool ufshpb_check_hpb_reset_query(struct ufs_hba *hba)
 	/* wait for the device to complete HPB reset query */
 	for (try = 0; try < HPB_RESET_REQ_RETRIES; try++) {
 		dev_dbg(hba->dev,
-			"%s start flag reset polling %d times\n",
+			"%s: start flag reset polling %d times\n",
 			__func__, try);
 
 		/* Poll fHpbReset flag to be cleared */
@@ -2298,7 +2298,7 @@ static bool ufshpb_check_hpb_reset_query(struct ufs_hba *hba)
 
 		if (err) {
 			dev_err(hba->dev,
-				"%s reading fHpbReset flag failed with error %d\n",
+				"%s: reading fHpbReset flag failed with error %d\n",
 				__func__, err);
 			return flag_res;
 		}
@@ -2310,7 +2310,7 @@ static bool ufshpb_check_hpb_reset_query(struct ufs_hba *hba)
 	}
 	if (flag_res) {
 		dev_err(hba->dev,
-			"%s fHpbReset was not cleared by the device\n",
+			"%s: fHpbReset was not cleared by the device\n",
 			__func__);
 	}
 out:
-- 
2.29.0

