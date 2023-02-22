Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0163569F2EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjBVKtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBVKtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:49:03 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8431B298C5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:49:01 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230222104858epoutp027bfeb087056ed6afeab28581cf9d0397~GH9uDKrqU0585105851epoutp02j
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:48:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230222104858epoutp027bfeb087056ed6afeab28581cf9d0397~GH9uDKrqU0585105851epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677062938;
        bh=pRgejRgp2h9MwzsdDiQ+JxCVBcLZteTvsHs1NmTE+Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMWmlLkrgkUny/SzV3uMzU+FFmFWvMtqePcf/WqunhYVakOrVNg0nzEGdUdnYIQFd
         c+CdbIs3sHMu/zNn2nqmBSHwol4Q8bV/P5hyxiB5Gliz8ivvQDiSsbtQ/ypUziZkDC
         q51jN6xqyY4/NcL2+0TkqF5J1VHVYKwnjEF8DmCA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230222104857epcas1p389039952ee873d0970fb677ecb28e0a8~GH9s2TgG22477424774epcas1p3C;
        Wed, 22 Feb 2023 10:48:57 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.223]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PMCZK1nmmz4x9Py; Wed, 22 Feb
        2023 10:48:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.21.54823.913F5F36; Wed, 22 Feb 2023 19:48:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230222104856epcas1p3a6ff45f90292df33ef5fd8216b812f64~GH9r8IRc62477424774epcas1p3B;
        Wed, 22 Feb 2023 10:48:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230222104856epsmtrp2370ad8213ebc46dbd470f5bfbba89fe0~GH9r7Xd8l1340413404epsmtrp2j;
        Wed, 22 Feb 2023 10:48:56 +0000 (GMT)
X-AuditID: b6c32a39-a97ff7000000d627-9f-63f5f3190e72
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.1A.17995.813F5F36; Wed, 22 Feb 2023 19:48:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230222104856epsmtip16341801507df126bb1eb25fca0cfcbde~GH9rtThTr2855228552epsmtip1P;
        Wed, 22 Feb 2023 10:48:56 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     bagasdotme@gmail.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, Sangmoon Kim <sangmoon.kim@samsung.com>
Subject: [PATCH v2] docs: kbuild: remove description of KBUILD_LDS_MODULE
Date:   Wed, 22 Feb 2023 19:47:19 +0900
Message-Id: <20230222104719.16374-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1666a6a9-4757-0e1d-f807-618c95e0b6ae@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmrq7k56/JBgfmsVtMbWS0eHKgndFi
        YdsSFos/u3YwWVzeNYfN4uGDG6wW7Sufsll8mPCfyeLZ3hOsFrceNLI4cHnsOrSZzWPnrLvs
        Hgs2lXpsWtXJ5rG4bzKrR9+WVYwenzfJBbBHZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZ
        GOoaWlqYKynkJeam2iq5+AToumXmAF2npFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1I
        ySkwK9ArTswtLs1L18tLLbEyNDAwMgUqTMjOmHSkl7lgJ0fFiQOVDYx/2boYOTkkBEwkFv85
        zdzFyMUhJLCDUWLytDlQzidGiVXvXkE5nxklfu/9zQrTsv3aShaIxC5GiTfzVzOBJIQEvjBK
        7L6RAGKzCehKfJl3mRHEFhGQkNi47yPYJGaBt4wSH75eZQFJCAt4Sty7chbMZhFQlXi29Ch7
        FyMHB6+ArcTkVn6IZfISqzccYAaxOYHCp3Y3s4HMkRB4yy5xpq+DCaLIRWJ9/xxGCFtY4tXx
        LewQtpTE53d7oRr6GSVOdXexQCSmMErMvaYJYRtL9PZcYAZZzCygKbF+lz5EWFFi5++5YDOZ
        Bfgk3n3tYQUpkRDglehoE4IoUZN4/Oou1FoZif4786Gme0hc+z+bHRJAE4DBeGkz0wRGuVkI
        GxYwMq5iFEstKM5NTy02LDCFx1hyfu4mRnDq07LcwTj97Qe9Q4xMHIyHGCU4mJVEeP/zfk4W
        4k1JrKxKLcqPLyrNSS0+xGgKDLyJzFKiyfnA5JtXEm9oYmlgYmZkYmFsaWymJM4rbnsyWUgg
        PbEkNTs1tSC1CKaPiYNTqoFJhWOx7u0/q07+0m5NEhYrMjnPdFwpPNejNtY42e662cUdN1JF
        tXfuevVC5ccq5wub3y2QFJR4vDbVQPoVv/eBqk+xiXNvbcs6dVKy4dqmxH2TL05cuWfy6SV9
        lyX8jL5YF7EuLk3yjZlcdFNf/eeT6OR0xV2m72OOLBcUnhWrP+dG49+CVuZFlQ4uDkeWVAUe
        /2v3bVJaIs9T88uiIUfiSs5HsFd2F3TenC20XGPz29+nPyT1fnLL65H9ds6tL/Ani8TOU+qG
        JrG3xZWYcg9xc4glmvr8ObbK4WLlF1+NIP/fIUnHuFq3tHzdXnKpQYPnhsldBtfdyetf/vB2
        PuYq3fTzj2B8dudrq9MZ3JpKLMUZiYZazEXFiQAvfyM5BgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSnK7E56/JBlM7FC2mNjJaPDnQzmix
        sG0Ji8WfXTuYLC7vmsNm8fDBDVaL9pVP2Sw+TPjPZPFs7wlWi1sPGlkcuDx2HdrM5rFz1l12
        jwWbSj02repk81jcN5nVo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDImHellLtjJUXHiQGUD
        41+2LkZODgkBE4nt11aydDFycAgJ7GCU2BkHEZaR2HlxMxNIWEJAWOLw4eIuRi6gik+MEu/n
        PmMEqWET0JX4Mu8ymC0iICGxcd9HZpAiZoHvjBItU66AzRcW8JS4d+UsC4jNIqAq8WzpUXaQ
        obwCthKTW/khdslLrN5wgBnE5gQKn9rdDNYqJGAj0TP9B9sERr4FjAyrGCVTC4pz03OLDQuM
        8lLL9YoTc4tL89L1kvNzNzGCg1NLawfjnlUf9A4xMnEwHmKU4GBWEuH9z/s5WYg3JbGyKrUo
        P76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYm113LNn9PVHYIVGJetuOS
        wbZjkUEbDvXOOHd+TlKT99Nc0e1TvNnbdmUeDvtnzrxISObdigSzo8XNIZbT+Y+fYfGWdnv9
        4bLp6QvF11VkLi59Pe+yn8nzWyGnb3YnnkrsNyn5Jzxh7VrObUfX7/P9uNTy6c5Fj4x8OR6G
        bdpXV+Q9Y+JEw08hv2PURF3NJhtOZ6ne6OzSrJSgz3dxEavHHl0/e57pCckvBHQOu2x7FZA0
        +5P1TiOfdfyfTbj/qdyrMbN1CpQ3Xv/hXlXWnO7XgvXpdw636VzdfEUuSdww63vb1Wu9PunO
        q852zq+csP/iWQvBNQv8HbYwbnp7Kaby/47q3ENnA+Jml3Bd3j2RW4mlOCPRUIu5qDgRAEDc
        thS9AgAA
X-CMS-MailID: 20230222104856epcas1p3a6ff45f90292df33ef5fd8216b812f64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230222104856epcas1p3a6ff45f90292df33ef5fd8216b812f64
References: <1666a6a9-4757-0e1d-f807-618c95e0b6ae@gmail.com>
        <CGME20230222104856epcas1p3a6ff45f90292df33ef5fd8216b812f64@epcas1p3.samsung.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 596b0474d3d9 ("kbuild: preprocess module linker script")
removes KBUILD_LDS_MODULE, yet the variable is still mentioned in
kbuild documentation. Remove the reference to the now-nonexistent
variable.

Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
---
Thank you for your review.

Changes in v2:
 - Update the commit message.

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

