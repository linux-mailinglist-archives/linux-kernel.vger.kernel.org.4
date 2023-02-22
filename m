Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5224F69EC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBVAqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBVAqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:46:19 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26103303DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 16:46:16 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230222004611epoutp03f05c69b5d0a890ce0401d126cb647279~F-vabWWTa0041900419epoutp03V
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:46:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230222004611epoutp03f05c69b5d0a890ce0401d126cb647279~F-vabWWTa0041900419epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677026771;
        bh=4o1G4rjzTPoOxlN0OqGx7SQZHq24foL1Mi1d7sljn5g=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Gs+JtecCgK4Lx5PhrDIgEOR8bkH4uOSQ4rRy5PqVULLw3nu6Yucua6p4LjSrGo2/J
         HD+bUzDj7XDgbpld9Il0OKIMWNgLCtvpDF2TG+vuXUtmrQmVhrDtJ186E8K3rh59nS
         haxKE0Ugu1Rb3jpXU4/YBo9cTVXkJEsLHUqbzGXc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230222004610epcas1p1dd664250d55a01aad2c6178e2a7f1c19~F-vZshZqe0338203382epcas1p12;
        Wed, 22 Feb 2023 00:46:10 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.247]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PLyBp1K0bz4x9Q1; Wed, 22 Feb
        2023 00:46:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.77.37890.1D565F36; Wed, 22 Feb 2023 09:46:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230222004609epcas1p2eb7e213b2b3503d018fcd6d58b9497b2~F-vYowJNz3040030400epcas1p2o;
        Wed, 22 Feb 2023 00:46:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230222004609epsmtrp259e3ce8f42d124124b2d376ffb35d598~F-vYn8PUg1275312753epsmtrp2B;
        Wed, 22 Feb 2023 00:46:09 +0000 (GMT)
X-AuditID: b6c32a38-5fbfa70000029402-89-63f565d12e23
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.82.05839.1D565F36; Wed, 22 Feb 2023 09:46:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230222004609epsmtip1803a756a45c287954adadcc8cb4934c7~F-vYWZczY1964919649epsmtip1P;
        Wed, 22 Feb 2023 00:46:09 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Sangmoon Kim <sangmoon.kim@samsung.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: kbuild: remove description of KBUILD_LDS_MODULE
Date:   Wed, 22 Feb 2023 09:45:50 +0900
Message-Id: <20230222004550.13469-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmru7F1K/JBo93Gls8OdDOaLGwbQmL
        xZ9dO5gsLu+aw2bx8MENVov2lU/ZLD5M+M9k8WzvCVaLWw8aWRw4PXYd2szmsWBTqcemVZ1s
        Hov7JrN69G1ZxejxeZNcAFtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
        Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKzAr3ixNzi
        0rx0vbzUEitDAwMjU6DChOyMDT+Wsxa8ZK/4dmg5YwPjfrYuRg4OCQETiZO7groYuTiEBHYw
        SixadoMZwvnEKHHg1X8o5xujxNuF+1m6GDnBOrbc+M0KYgsJ7GWU6NhTAlH0hVGiqWcyI0iC
        TUBX4su8y2C2iICPxOlfn5lAipgF/jNKTJhzlh0kISzgJjGv4xDYVBYBVYmHv0+BNfAK2ErM
        uDuREWKbvMTqDQfAzpAQOMUusXzvU6gzXCRe/ZoJZQtLvDq+hR3ClpL4/G4vG0RDP6PEqe4u
        qKIpjBJzr2lC2MYSvT0XmEEhwCygKbF+lz5EWFFi5++5YIuZBfgk3n3tYYUEEq9ER5sQRIma
        xONXd6Fuk5HovzMfarqHxNUHn5ghoRIr8fP9O9YJjLKzEBYsYGRcxSiWWlCcm55abFhgAo+l
        5PzcTYzghKZlsYNx7tsPeocYmTgYDzFKcDArifD+5/2cLMSbklhZlVqUH19UmpNafIjRFBhg
        E5mlRJPzgSk1ryTe0MTSwMTMyMTC2NLYTEmcV9z2ZLKQQHpiSWp2ampBahFMHxMHp1QDU3pi
        ZFNfxSznYNHVF8871fg5B/cKdyXdl9+fa6fVIOM6c1nIGRP2ezuq/qzckhN8Yufho/mTm/2l
        9ntve5X1V/aaiLUXz50uY+WY0nfbt3/9azAvNzV36x7e76LfffpylO8LHXJanOaleD/r8YTb
        sgeV025KTHePlb4XHc54Q8A9+uadf/MFEvY8OuCRuqpqMUPic25fDj/J2fwuy9RTcoNXVe9j
        kFp8jynO6LHRj/enDNUy+iZcP576+e8sq7CWltJLRjOPx/wy36GYXLwrfInx3s/ZOw7zf7md
        tXaDBcPMLQJVWkWfzGe2a7+VmjaZXW7W/208zbzdnOkHndyPathXFZ6a8CtIqb/b/MUFJZbi
        jERDLeai4kQAgYSUKfEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LZdlhJTvdi6tdkg8mHBC2eHGhntFjYtoTF
        4s+uHUwWl3fNYbN4+OAGq0X7yqdsFh8m/GeyeLb3BKvFrQeNLA6cHrsObWbzWLCp1GPTqk42
        j8V9k1k9+rasYvT4vEkugC2KyyYlNSezLLVI3y6BK2PDj+WsBS/ZK74dWs7YwLifrYuRk0NC
        wERiy43frF2MXBxCArsZJbq/f2eHSMhI7Ly4mamLkQPIFpY4fLgYouYTo0TH1F5mkBo2AV2J
        L/MuM4LYIgJ+Eo+XnGUBKWIWaGWSeHvxINgGYQE3iXkdh1hAbBYBVYmHv0+BNfAK2ErMuDuR
        EWKZvMTqDQeYJzDyLGBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERxiWpo7GLev
        +qB3iJGJg/EQowQHs5II73/ez8lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnN
        Tk0tSC2CyTJxcEo1MEXtleXuqJIMnbPd40+DS9byXIWrf7dcsfwmuelFj93BZRvZ/I5tOmwv
        fS3TudXL6pGuYaFK4EX7p6+zL338mLp8eYlR+c45dudm1m28fJT/aY9H88xMVuf1h+fMuJbS
        3SbwpGdTPc/xZz8v5ctWhN1km/625VNJhF1oJYvtzF8rz/D+5V5+cce2y3fmxHQYqHvsr/kz
        ubxEzFRkIe+NH7+re6fNY3BRMLu9JnLFPfXcnyFMito+b5u26H1mP6A1/U5FofOOgzqv+215
        rkxKnbfcm5dtn9s0LvXy3fuesVomvj5vabP7XNHUTV4CB6R/qQruvClyVGTXNPej1q8ung03
        XP2ynkenNs37+/Ok4nwlluKMREMt5qLiRABepp6boAIAAA==
X-CMS-MailID: 20230222004609epcas1p2eb7e213b2b3503d018fcd6d58b9497b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230222004609epcas1p2eb7e213b2b3503d018fcd6d58b9497b2
References: <CGME20230222004609epcas1p2eb7e213b2b3503d018fcd6d58b9497b2@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 596b0474d3d9 ("kbuild: preprocess module linker script")
has removed KBUILD_LDS_MODULE variable.

The KBUILD_LDS_MODULE variable is no longer available, so this patch
removes it from the document.

Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
---
 Documentation/kbuild/makefiles.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 38bc74eaa547..468e7830c1c3 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -1250,11 +1250,6 @@ When kbuild executes, the following steps are followed (roughly):
 
 	The linker script with full path. Assigned by the top-level Makefile.
 
-    KBUILD_LDS_MODULE
-
-	The module linker script with full path. Assigned by the top-level
-	Makefile and additionally by the arch Makefile.
-
     KBUILD_VMLINUX_OBJS
 
 	All object files for vmlinux. They are linked to vmlinux in the same
-- 
2.17.1

