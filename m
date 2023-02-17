Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C662E69A753
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBQIrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBQIrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:47:39 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6B6604D4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:47:36 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230217084734epoutp0347f01471d4a8ec7694e3c8ba0389b369~EkFSmdCd71799217992epoutp03I
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:47:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230217084734epoutp0347f01471d4a8ec7694e3c8ba0389b369~EkFSmdCd71799217992epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676623654;
        bh=cvQUGuk5GXqYyDITXrO89kp2UvqyPtMCcqVXLvPhHuQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WAX9Dnkjzb1t6zmwTHCmtfAeD8yNzrhviXPloSGYpf0MvxRWuUX1FJbmpts4pTzCy
         LnPkumPNzKi/P24syePaFyeGdM5GY4PCA3L9ER05JVgCUbDTnekD5iic3HrtID/CDX
         Rd2gYkmeYFa1HqjoaoBqCB5lozdUl577SPNbWvVY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230217084734epcas1p412a9dcf69b657da3c5a55e1df432cd89~EkFSSSApJ1247912479epcas1p4j;
        Fri, 17 Feb 2023 08:47:34 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.241]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PJ56Y1GkLz4x9QB; Fri, 17 Feb
        2023 08:47:33 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.26.55531.42F3FE36; Fri, 17 Feb 2023 17:47:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230217084732epcas1p29956bd24132b13b21923afd2563bf3dd~EkFQmVZ4x0315403154epcas1p2N;
        Fri, 17 Feb 2023 08:47:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230217084732epsmtrp2f17afb37df1345e6f291f3a0fe474851~EkFQlCIE_3026830268epsmtrp22;
        Fri, 17 Feb 2023 08:47:32 +0000 (GMT)
X-AuditID: b6c32a35-d9fff7000000d8eb-3f-63ef3f24fabb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.92.17995.42F3FE36; Fri, 17 Feb 2023 17:47:32 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230217084732epsmtip282e9a406e4305cb054ed62cbc255a791~EkFQaHOzU2515925159epsmtip2E;
        Fri, 17 Feb 2023 08:47:32 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH 0/4] simplify extcon_dev_register function.
Date:   Fri, 17 Feb 2023 17:46:09 +0900
Message-Id: <20230217084613.25359-1-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmnq6q/ftkg+/aFifWLGKyuP7lOavF
        5V1z2CxuN65gc2Dx6NuyitHj8ya5AKaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11D
        SwtzJYW8xNxUWyUXnwBdt8wcoD1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKz
        Ar3ixNzi0rx0vbzUEitDAwMjU6DChOyMDf3f2AruM1fs2PKNtYGxl7mLkYNDQsBEYsdPyS5G
        Lg4hgR2MEp86XjN1MXICOZ8YJR4+TYZIfGaUOLNgCwtIAqTh7cO1zBCJXYwSm5q+MUE4vxgl
        TvRdYwapYhPQkNhzsYENZIWIQKHE4f5skDCzgJrEg1Ub2UFsYQFriRvzVrKB2CwCqhJrts9m
        BLF5Bawknn/8zAixTF6i+98fFoi4oMTJmU9YIObISzRvnQ12hITAInaJpycfsUE0uEic/XaC
        HcIWlnh1fAuULSXx+d1eqJp0iZVX7kDFcyRe32+HWmYs8e7tWnCwMAtoSqzfpQ8RVpTY+Xsu
        I8RePol3X3tYISHHK9HRJgRRoizR/eAFE4QtKbH46R2oiR4Sb7rXgENBSCBWYvV5iQmM8rOQ
        PDMLyTOzEPYuYGRexSiWWlCcm55abFhgCI/R5PzcTYzgdKZluoNx4tsPeocYmTgYDzFKcDAr
        ifBuuvkmWYg3JbGyKrUoP76oNCe1+BCjKTB4JzJLiSbnAxNqXkm8oYmlgYmZkYmFsaWxmZI4
        r7jtyWQhgfTEktTs1NSC1CKYPiYOTqkGJqXubfcP775cLrFpOaNXYb0yy0m3Y5r5vfndp1d7
        hLXdrp8vcpb5WEfOk0CRKexye6sXTt2/nk8snnuPa6bmjFUnlu+XthDK+nOcwfHmUfmtCiJb
        Uqvvx0eZ9a65EBXBYloo9Z7PtuXl5HTDyVcsVm7rVj2mc1Os2ePUFb/qS12Bj+sc73xcYDZ9
        3vNU8X2nW1r2dGaIfg3k2L2VzdtQLSvrvpdY+MpMnS/nr01Q2b/wQeeh/48M+yYKf26vDeoX
        /5j5o1zZc27lV6Wbs1I2v3uzX3f25AtdO+InL63xERLpXhhV7FuwJGxpZNsDvTPtN/TkVcuU
        LWeItHaxO+dyhZ44oa7gluE+ccbn+d+nK7EUZyQaajEXFScCAISZa/3wAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsWy7bCSvK6K/ftkg9kvBC1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZG/q/sRXcZ67YseUbawNj
        L3MXIyeHhICJxNuHa4FsLg4hgR2MEn8nLoFKSEqcXf6IvYuRA8gWljh8uBii5gejxNwVe1lA
        atgENCT2XGxgA7FFBIolLhxYDBZnFlCTeLBqIzuILSxgLXFj3kqwGhYBVYk122czgti8AlYS
        zz9+ZoTYJS/R/e8PC0RcUOLkzCdQc+QlmrfOZp7AyDcLSWoWktQCRqZVjJKpBcW56bnFhgVG
        eanlesWJucWleel6yfm5mxjBgaaltYNxz6oPeocYmTgYDzFKcDArifBuuvkmWYg3JbGyKrUo
        P76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmzTU9CyV/HDBgn7K3MdT1
        29F7k9aG3AxQDbdYy3szw22R4OUYvffXPd4dnPyWZf2XpH02rLtNXY8u1f/Q7/1kkfqTI4c9
        1av6fe9bPJ8z27Xk7OOpAoucDYwj51y96bdn1u0qV8/Ij7uvq2ovjnH2cT17ozlE846dAs+t
        4w94l3+eK7RDJ1jEx2LD6rDmB7JLmKR/bXeq/Bdxoisn1bj4ceqa5j0RogtUo3d5GkUxiKix
        nyrj05JV+v3KpIyh432Kye1w11DDWbW3P/91ituQJl10ocG6iOX9m4PRW6Rv7Fszrb2Gt8eq
        yOnYUaPghQyG9xbvWre/cEGaip64VXz55urjCQu2TS5+rFIhrXpMiaU4I9FQi7moOBEApRk2
        B6MCAAA=
X-CMS-MailID: 20230217084732epcas1p29956bd24132b13b21923afd2563bf3dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230217084732epcas1p29956bd24132b13b21923afd2563bf3dd
References: <CGME20230217084732epcas1p29956bd24132b13b21923afd2563bf3dd@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was modified to increase readability.

Bumwoo Lee (4):
  extcon: remove redundant null checking for class
  extcon: added extcon_alloc_cables to simplify extcon register function
  extcon: added extcon_alloc_muex to simplify extcon register function
  extcon: added extcon_alloc_groups to simplify extcon register function

 drivers/extcon/extcon.c | 286 ++++++++++++++++++++++------------------
 1 file changed, 160 insertions(+), 126 deletions(-)

-- 
2.35.1

