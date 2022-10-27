Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD6E60F004
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiJ0GUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiJ0GUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:20:21 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5935CB18F5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:20:17 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221027062014epoutp02f9113287271d8ece50a5743087e27f9a~h2LZLpxGf0117201172epoutp02T
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:20:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221027062014epoutp02f9113287271d8ece50a5743087e27f9a~h2LZLpxGf0117201172epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666851614;
        bh=IGkRXu+rgBFTc1KQKW4ydm2jeNyJRZRNOrJVbhITZu8=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=N0gzmqWgau1Jx+hAby2ThLrcJjoAPEzfOp1gexpfK+oGXcBiYRRk1kilvjka+p7rR
         CrtB6WUPJNmhtsUuAECkHVul0ceoayuBvR5J+8zcsLOm9TtBfZYoGrhdf0zmVvkUqr
         z4U0ZK7xXBw+w1VmJ/DJDeBNbNCKYilkgImHVbxg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20221027062013epcas2p1188134b5883d74e04eb2bddd2e6f7b2f~h2LYnMCbe0347403474epcas2p1Y;
        Thu, 27 Oct 2022 06:20:13 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MybBj4QVgz4x9Pw; Thu, 27 Oct
        2022 06:20:13 +0000 (GMT)
X-AuditID: b6c32a47-ac5b870000002127-85-635a231d7611
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.20.08487.D132A536; Thu, 27 Oct 2022 15:20:13 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: core: Use 'else' in ufshcd_hba_enable()
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221027062013epcms2p7af8fbc60caaba50686233492fb3dfd93@epcms2p7>
Date:   Thu, 27 Oct 2022 15:20:13 +0900
X-CMS-MailID: 20221027062013epcms2p7af8fbc60caaba50686233492fb3dfd93
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmma6sclSywcbfChYnn6xhs3gwbxub
        xcufV9ksDj7sZLGY9uEns8XLQ5oWj24/Y7To7d/KZrHoxjYmi8u75rBZdF/fwWax/Pg/Jgce
        j8tXvD0W73nJ5DFh0QFGj+/rO9g8Pj69xeLRt2UVo8fnTXIe7Qe6mQI4orJtMlITU1KLFFLz
        kvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4COVVIoS8wpBQoFJBYXK+nb
        2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ3xfmF+wj7Vi+Zzv
        rA2Mm1m6GDk5JARMJPb1vQayuTiEBHYwSsw/OYG9i5GDg1dAUOLvDmEQU1jAWWLNRyaQciEB
        JYmuhVuZQWxhAQOJddP3gNlsAnoSU37fYQQZIyLwk1ni0vvZbBDzeSVmtD+F2iUtsX35VkYI
        W0Pix7JeZghbVOLm6rfsMPb7Y/OhakQkWu+dhaoRlHjwczdUXFKi9cxWqPn5Ek9u9kPNr5FY
        sP0zVFxf4lrHRrA4r4CvxNdlu8HmswioSixfehhql4vEqzcvWUFsZgF5ie1v5zCD/MssoCmx
        fpc+iCkhoCxx5BYLzCcNG3+zo7OZBfgkOg7/hYvvmPeECcJWk3i0YAsrhC0jcXHOOahPPCQm
        XP7GNoFRcRYinGchuWEWwg0LGJlXMYqlFhTnpqcWGxUYw2M2OT93EyM40Wq572Cc8faD3iFG
        Jg7GQ4wSHMxKIrxnb4QnC/GmJFZWpRblxxeV5qQWH2I0Bfp+IrOUaHI+MNXnlcQbmlgamJiZ
        GZobmRqYK4nzds3QShYSSE8sSc1OTS1ILYLpY+LglGpgiuCfKS5x9vb62XHrVnssevT6uOUV
        sQyGRFYNr+NzhJd+/WjXOXfy+/gzIXOP8rt42Fb/PiI8gaklP6D12KpTP7Wehwo3lfz0+5lr
        t9J6jkenacpmE7eCxW9kWKey9bT5bizZKz77slHc/4689JkX6zk7ulvEc1cbWf9tWVFc++dN
        yfVKlhmuC3JCLzOzu+ay7Fea+GxzjKCexZy5fresNsbYfeVbnGs6N6woYGdL1JTMWz80Fu4x
        lNBLs9t1/devk6e/e7XWVYrpM95OfBda97amhnG38obj1fL7d8puye5duCbXObvR7fDtP7b5
        VWruH+I2He57cPKO0xTDLWkSNQtvGiTZ+V/WMfnR0cykxFKckWioxVxUnAgA4hiLtT0EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221027062013epcms2p7af8fbc60caaba50686233492fb3dfd93
References: <CGME20221027062013epcms2p7af8fbc60caaba50686233492fb3dfd93@epcms2p7>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert if (!ret) { ... } if (ret) { ... } into
if (!ret) { ... } else { ... }.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7256e6c43ca6..3b794be53287 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4670,7 +4670,7 @@ int ufshcd_hba_enable(struct ufs_hba *hba)
 			ret = ufshcd_dme_enable(hba);
 			if (!ret)
 				ufshcd_vops_hce_enable_notify(hba, POST_CHANGE);
-			if (ret)
+			else
 				dev_err(hba->dev,
 					"Host controller enable failed with non-hce\n");
 		}
-- 
2.17.1

