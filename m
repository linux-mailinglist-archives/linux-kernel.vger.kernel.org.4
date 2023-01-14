Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206C166A8AE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 03:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjANCab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 21:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjANCa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 21:30:29 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556F28CBC8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 18:30:27 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230114023025epoutp012a79fd4489d8d4d2ed8cf7f24777fc22~6DASbiwrF2716827168epoutp01N
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 02:30:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230114023025epoutp012a79fd4489d8d4d2ed8cf7f24777fc22~6DASbiwrF2716827168epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673663425;
        bh=lJ0fGN2UC71gm5oXJk1BTD+ElD1EYPw0347IjGvFUTI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YnySHmk0SiI5OXLKWcj33DI69SDxvZr53PHmP94w52zuRUP1qC3gE5p4SsRwJ+d09
         N6vu3hwMIZv3aiSYy2iaD31papuHgWTXlsbKdS48g98Y1O/X9fALyuB/0x2kh79WH4
         Le6akk4Rcinx4QFmTmZH5qeSR/ll7s0Y1uAF2yTI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230114023024epcas5p311c5a8067f4907abdeaf1dd01d0f746f~6DARkgw3M2170221702epcas5p3W;
        Sat, 14 Jan 2023 02:30:24 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Nv2M32C4Bz4x9Pr; Sat, 14 Jan
        2023 02:30:23 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.A7.02301.FB312C36; Sat, 14 Jan 2023 11:30:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230114023022epcas5p37521ca1f5a34c36e33e0d73bd0066aa8~6DAPxmoH81760517605epcas5p3w;
        Sat, 14 Jan 2023 02:30:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230114023022epsmtrp2a333e396e757c8f073105f0ad490a084~6DAPw6waP3027430274epsmtrp2i;
        Sat, 14 Jan 2023 02:30:22 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-aa-63c213bf30db
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.1E.10542.EB312C36; Sat, 14 Jan 2023 11:30:22 +0900 (KST)
Received: from FDSSW-LABPC-53.sa.corp.samsungelectronics.net (unknown
        [107.109.115.68]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230114023021epsmtip1f66c0e17557f8b31927a057b03729ec0~6DAOw6_mW1938419384epsmtip1J;
        Sat, 14 Jan 2023 02:30:21 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] scsi: MAINTAINERS: Add entry for Exynos UFS driver
Date:   Sat, 14 Jan 2023 13:32:47 +0530
Message-Id: <20230114080247.601312-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmhu5+4UPJBisP8Fk8mLeNzeLlz6ts
        FtM+/GS2uLxrDptF9/UdbBbLj/9jcmDzuHzF2+Pj01ssHn1bVjF6fN4k59F+oJspgDUq2yYj
        NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
        UEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG0Sbz
        grusFVM/XGVpYHzB0sXIySEhYCKx9c0Hxi5GLg4hgd2MEp3XT0E5nxglXkxdzQThfGaUaG/+
        DNfycN8pVojELkaJ2V+62CGcHiaJZ7M6mEGq2AS0Je5O3wLUzsEhImAj0fQNzGQWKJB4PsMC
        pEJYwFli/7eXYDNZBFQlfvc3g3XyCthKfHj3hxVil7zEzEvf2SHighInZz4Bq2cGijdvnc0M
        slZC4Bi7xNzj15ggGlwkHk6fxg5hC0u8Or4FypaS+PxuLxvIDRICHhKL/khBhDMk3i5fzwhh
        20scuDKHBeJMTYn1u/QhVvFJ9P5+wgTRySvR0SYEUa0q0fzuKjREpCUmdndDXewh0Xq5FewT
        IYFYiccN21gnMMrNQvLALCQPzEJYtoCReRWjZGpBcW56arFpgWFeajk8IpPzczcxgtOdlucO
        xrsPPugdYmTiYDzEKMHBrCTCu+fo/mQh3pTEyqrUovz4otKc1OJDjKbAUJ3ILCWanA9MuHkl
        8YYmlgYmZmZmJpbGZoZK4rypW+cnCwmkJ5akZqemFqQWwfQxcXBKNTDpntrrV1UVuTf98UUf
        KfOC/mOnGTeuzsoVFH9lZ/nVkPPLivNxn6xPtf3mClfirfK/kO1nZTN1zmp2wdM3z7rMLLJ4
        lW87+9s23p5/Yc5LZyRIp2vdUVZ5teN/7Lmf99hn/W75cPF0k5rXq8v75dNErJ0cH8zyea/O
        WKRz8fXiaJ8Ih8/3BEOvBPREVjnJH//ry1h91a934pSyUp+686tq9zzcwRP77cUlgcijR5wP
        pM8qOFQtud3Q32mS3bspqWeuqikcuPn02KW3RfP2xFxNuPJ+R8lex/mlAcwh7rVa6/jnsrw/
        MqGBe6P0D3me9ouenjl/6u/cviR8LN9q2aLrZdZP3iXG73988Yuj/9zfSizFGYmGWsxFxYkA
        /ziSJwAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnO4+4UPJBmt2SVs8mLeNzeLlz6ts
        FtM+/GS2uLxrDptF9/UdbBbLj/9jcmDzuHzF2+Pj01ssHn1bVjF6fN4k59F+oJspgDWKyyYl
        NSezLLVI3y6BK+Nok3nBXdaKqR+usjQwvmDpYuTkkBAwkXi47xRrFyMXh5DADkaJa9v/sUEk
        pCWub5zADmELS6z895wdoqiLSeLenD2sIAk2AW2Ju9O3MIHYIgJ2Eu2PrzKC2MwCJRKLvrSA
        xYUFnCX2f3sJto1FQFXid38zM4jNK2Ar8eHdH1aIBfISMy99Z4eIC0qcnPmEBWKOvETz1tnM
        Exj5ZiFJzUKSWsDItIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgwtbR2MO5Z9UHv
        ECMTB+MhRgkOZiUR3j1H9ycL8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1
        ILUIJsvEwSnVwLT7/zVjv/RpMxdFfv24/3qFlaprY9uT2au2d7+ssJl8gr187qdb3+fZtvLv
        +xL9c/Hkmz0hqz955dQu2n73Rugx5eCDL2bOzOLeOLnKwo/Bio+pa/VXbQXJ+JO7lGc3fd50
        /sR3hXONKocF9AX49889FKQU4P5bpV82I61tjsrkq0qS397Kpn60PPpTomDeys9qnId8XqqK
        CnQf2T7Xd7vsvX9RC5KFpm8VmR9RGjDvqlzmtGUJJdqxF3MikvKi4vbu2+FySaCQuVxX4c1S
        m0XaTAp5iQ86btYe/7i2YOGEKlNGC34ts/5r4QyvpDaLb2et+Xux8sdaSZF3l/rc3Niid92w
        OR8SVbLx3NcdlU5KLMUZiYZazEXFiQBtMVzCuwIAAA==
X-CMS-MailID: 20230114023022epcas5p37521ca1f5a34c36e33e0d73bd0066aa8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230114023022epcas5p37521ca1f5a34c36e33e0d73bd0066aa8
References: <CGME20230114023022epcas5p37521ca1f5a34c36e33e0d73bd0066aa8@epcas5p3.samsung.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for Exynos UFS driver.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9033d9ec7196..a960327de27f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21444,6 +21444,12 @@ L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/ufs/host/*dwc*
 
+UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER EXYNOS HOOKS
+M:	Alim Akhtar <alim.akhtar@samsung.com>
+L:	linux-scsi@vger.kernel.org
+S:	Maintained
+F:	drivers/ufs/host/ufs-exynos*
+
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER MEDIATEK HOOKS
 M:	Stanley Chu <stanley.chu@mediatek.com>
 L:	linux-scsi@vger.kernel.org
-- 
2.25.1

