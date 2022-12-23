Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246B3654BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLWEDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLWEDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:03:43 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB381C916
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 20:03:41 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221223040336epoutp01b893edd27232c984ff2dcb9ae6c002eb~zUFXqiFsW0244702447epoutp01G
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:03:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221223040336epoutp01b893edd27232c984ff2dcb9ae6c002eb~zUFXqiFsW0244702447epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671768216;
        bh=OUo7XqUBNxxTZmDVqphH51Eqptd1EgIhPFysmBbWXf4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QrWpLhIw1DLFgF4G/LsNcck6NLafdb9pewj/6uBxvAV3tugpGg3txpPfJnp7eQ8K5
         bgLTOLubfb6LBpik5WvwJ9/z4unXYf2IqaHyKbG16uzrVR4zX0V5grpYdNN7ls/ASU
         Xek7QoAMtlWBz7BEXLzlW+hie4WJWPmd+yIDFPo4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20221223040336epcas1p38c0cd0afa5590dabddb2345ecbb3788e~zUFXWvCGx2690226902epcas1p3k;
        Fri, 23 Dec 2022 04:03:36 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.226]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NdYSl6VbCz4x9Q2; Fri, 23 Dec
        2022 04:03:35 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.AF.41504.79825A36; Fri, 23 Dec 2022 13:03:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20221223040335epcas1p45bda0013a3a42f176fa137e0597fd7c9~zUFWrQ9dQ2778927789epcas1p4f;
        Fri, 23 Dec 2022 04:03:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221223040335epsmtrp2aaa763281fc627a9b468a2d1bef247ff~zUFWqnSV62533725337epsmtrp2k;
        Fri, 23 Dec 2022 04:03:35 +0000 (GMT)
X-AuditID: b6c32a39-24bfd7000001a220-7f-63a5289760ff
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.CB.02211.79825A36; Fri, 23 Dec 2022 13:03:35 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221223040335epsmtip2e31261bfcad3528a7af9efd65a648a1f~zUFWcuLPX0434204342epsmtip2Q;
        Fri, 23 Dec 2022 04:03:35 +0000 (GMT)
From:   JeongHyeon Lee <jhs2.lee@samsung.com>
To:     senozhatsky@chromium.org
Cc:     minchan@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, JeongHyeon Lee <jhs2.lee@samsung.com>
Subject: [PATCH] zram: fix typos in comments
Date:   Fri, 23 Dec 2022 13:03:31 +0900
Message-Id: <20221223040331.4194-1-jhs2.lee@samsung.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmnu50jaXJBv0f9S1W3+1ns7h0/w6r
        xd5b2haXd81hs1j29T27xe6Ni9gc2DxmN1xk8bh8ttRj06pONo++LasYPT5vkgtgjcq2yUhN
        TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHar6RQlphTChQK
        SCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fLSy2xMjQwMDIFKkzIzmhfv5qt
        YBlnxevGFawNjLfZuxg5OSQETCTONx1j7WLk4hAS2MEoceHDTCYI5xOjxO8H56Gcb4wSt9+0
        sMC0rFm+mREisZdRYv3Jy1DOF0aJ9qlv2UCq2AS0JW63bAJbIiIgI9H77w0jiM0s0M0o8X+Z
        EIgtLKAjcWrpBbAaFgFVif99+4BqODh4BSwkjh90gVgmL/H78T6wxbwCghInZz5hgRgjL9G8
        dTYzyF4JgWPsEsfX7oG6zkWice0yVghbWOLV8S1Qj0pJfH63lw3Czpa4vuEQVH2JxPd1jcwg
        eyUE7CXeX7IAMZkFNCXW79KHqFCU2Pl7LtT1fBLvvvawQlTzSnS0CUGUKEms+HcNaqCExIbD
        3VCLPCQmLngIFhcSiJXYcW4K+wRG+VlInpmF5JlZCIsXMDKvYhRLLSjOTU8tNiwwhcdpcn7u
        JkZwCtSy3ME4/e0HvUOMTByMhxglOJiVRHi3PF6cLMSbklhZlVqUH19UmpNafIjRFBi6E5ml
        RJPzgUk4ryTe0MTSwMTMyMTC2NLYTEmcN3//omQhgfTEktTs1NSC1CKYPiYOTqkGJuuLa5eu
        P3w5cEKpwbsTJo8F3m+YMLfvb0GsSfXKNpvlZ6a93svnIFNx0Cm+nZttk67PgxmFAqpVZQHH
        zrZds1jKnP9srn3Rq96wG6zzz7k8u3drex/jh13XS85WlTO9Ox0br73TeYLUrsqY+cUiPQvm
        v3s989Vi6b8c237rLn/b4NooeamZ5bxPUPrLh12XHtQ66P3b7vPySHD2gl7PYz1LHC8/6Dnw
        ekvpWqFCrqZT7LWuaTM1w89pfMyKjz8QP+94Spo97/Wb8cvslTZMVQiOUeA9dmsX573srzKv
        4nhCri9iZLmSq1XAnTfzwhz+gxJhJzQXe8atKz0b+H7h+vNpJS8WX7KIZbrktZP5TL4SS3FG
        oqEWc1FxIgAROq3PCgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSvO50jaXJBi27pS1W3+1ns7h0/w6r
        xd5b2haXd81hs1j29T27xe6Ni9gc2DxmN1xk8bh8ttRj06pONo++LasYPT5vkgtgjeKySUnN
        ySxLLdK3S+DKaF+/mq1gGWfF68YVrA2Mt9m7GDk5JARMJNYs38zYxcjFISSwm1Fi1p8TrBAJ
        CYkNm9YCFXEA2cIShw8Xg4SFBD4xShx4WA5iswloS9xu2QQ2R0RARqL33xtGEJtZYCKjxL2d
        IiC2sICOxKmlF8BqWARUJf737WMEGckrYCFx/KALxCZ5id+P97GA2LwCghInZz5hgRgjL9G8
        dTbzBEa+WUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA5JLc0djNtX
        fdA7xMjEwXiIUYKDWUmEd8vjxclCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnN
        Tk0tSC2CyTJxcEo1MAU2izHHaTSrbCvSdW1V3Zzxlr01c/2X7KXW3cYKUTJyzfHOpd/WpNnk
        tvwrXdZ35FNaT/mTvUEWNoaGC7iPWB17aJ4VcU7lRqLG5NiSDU4Zq61/3mvbsmC9aqVSfXv0
        pvua0kmFsirdE76btvq7xLCcZX0eUOTx8+Mj8XLfgoAytagb+6Y0y6wPtzkuvvCvszxHzgMG
        Ic2H9jdbL3TtyPu80awpYmlStfXGJc+r53xLFd5+24/tjOCbO6KF6is0X115v0U9znSlEUPG
        3q9bs37tOudZvaZqFVOEyrxpbD3C1zZVx2VFWd9esrt88+7k1zK72qW3pVqzZJ/Z9ejpRj07
        vsmHz5z6rf6mZXeNEktxRqKhFnNRcSIAA3enyLgCAAA=
X-CMS-MailID: 20221223040335epcas1p45bda0013a3a42f176fa137e0597fd7c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221223040335epcas1p45bda0013a3a42f176fa137e0597fd7c9
References: <CGME20221223040335epcas1p45bda0013a3a42f176fa137e0597fd7c9@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- The double `range` is duplicated in comment, remove one.
 - change `syfs` to `sysfs`

Signed-off-by: JeongHyeon Lee <jhs2.lee@samsung.com>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e290d6d97047..7becd5448791 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -190,7 +190,7 @@ static inline bool valid_io_request(struct zram *zram,
 
 	end = start + (size >> SECTOR_SHIFT);
 	bound = zram->disksize >> SECTOR_SHIFT;
-	/* out of range range */
+	/* out of range */
 	if (unlikely(start >= bound || end > bound || start > end))
 		return false;
 
@@ -2385,7 +2385,7 @@ static int zram_add(void)
 	zram->disk->private_data = zram;
 	snprintf(zram->disk->disk_name, 16, "zram%d", device_id);
 
-	/* Actual capacity set using syfs (/sys/block/zram<id>/disksize */
+	/* Actual capacity set using sysfs (/sys/block/zram<id>/disksize */
 	set_capacity(zram->disk, 0);
 	/* zram devices sort of resembles non-rotational disks */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, zram->disk->queue);
-- 
2.38.1

