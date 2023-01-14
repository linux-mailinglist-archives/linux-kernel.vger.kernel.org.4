Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39AC66A8A9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 03:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjANCYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 21:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjANCYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 21:24:16 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F2C8CBC7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 18:24:14 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230114022409epoutp044f7103b27acfc1dfdcd9a85bc00cb41e~6C6z74E_53211832118epoutp04U
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 02:24:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230114022409epoutp044f7103b27acfc1dfdcd9a85bc00cb41e~6C6z74E_53211832118epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673663049;
        bh=M7nDTLny6qwuEJCs3Z2LwxKMomMYxDRsSLLed5tPFuY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TXBnjnZOD2WvvFq4KvQmlWc9o3WjX5Sxvmgft5De6VPBSHTqWHw4jn2K650GHtH5p
         LPbrMFDSh+LisMxLzsv3IIgKG3GLkHbQOQ56TGAhpOw94/Ho1scI566zQwz+AY+c64
         wADY0YvlwMXVr+GVLLUhqjFkuUk2jQ/Oc9RthxI8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230114022408epcas5p4cfa350b8886d8847accb9b4f914bf4c5~6C6zLrlyx0644906449epcas5p4f;
        Sat, 14 Jan 2023 02:24:08 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Nv2Cq1HZyz4x9Pv; Sat, 14 Jan
        2023 02:24:07 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.32.62806.64212C36; Sat, 14 Jan 2023 11:24:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230114022406epcas5p4963a02aee5acb201c5e3495b6cfd44fe~6C6xHkfe60743407434epcas5p4f;
        Sat, 14 Jan 2023 02:24:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230114022406epsmtrp2ee4de19a21b18ffc1335dafcdb9472a9~6C6xG7H_D2642526425epsmtrp2r;
        Sat, 14 Jan 2023 02:24:06 +0000 (GMT)
X-AuditID: b6c32a4a-ea5fa7000000f556-be-63c21246cf51
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.E1.02211.54212C36; Sat, 14 Jan 2023 11:24:05 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230114022405epsmtip1b0b1c2703f82eeda7f0fafc657f0cbf5~6C6wIyYJt1655416554epsmtip1C;
        Sat, 14 Jan 2023 02:24:04 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] include: ufs: Remove duplicate entry
Date:   Sat, 14 Jan 2023 07:50:10 +0530
Message-Id: <20230114022010.27088-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7bCmhq670KFkgxMLmC0ezNvGZvHy51U2
        i2kffjJbXN41h82i+/oONovlx/8xObB5XL7i7fHx6S0Wj74tqxg9Pm+S82g/0M0UwBqVbZOR
        mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdICSQlliTilQ
        KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj+b5/
        zAVPWCqO/VvK1MDYwNLFyMEhIWAiMeG6ehcjF4eQwG5GiQOXD7BCOJ8YJQ5v+cMC4XxjlPi3
        9gF7FyMnWMei1kYmiMReRokf/XPYIZxmJokrX3+ygFSxCWhL3J2+hQlkh4iAjUTTNzCTWaBA
        4vkMC5AKYQFTiYP9TUwgNouAqkRn8xs2EJsXqPrP1YdMELvkJVZvOMAMMl5CYBG7xMMzH1gh
        Ei4SF24dYoSwhSVeHd8CdZyUxOd3e9kgXvOQWPRHCiKcIfF2+XqocnuJA1fmsECcoymxfpc+
        SJhZgE+i9/cTJohOXomONiGIalWJ5ndXWSBsaYmJ3d1QB3hIrDkzjxnEFhKIleh4+pxpAqPM
        LIShCxgZVzFKphYU56anFpsWGOWllsMjJjk/dxMjOB1pee1gfPjgg94hRiYOxkOMEhzMSiK8
        e47uTxbiTUmsrEotyo8vKs1JLT7EaAoMpYnMUqLJ+cCEmFcSb2hiaWBiZmZmYmlsZqgkzpu6
        dX6ykEB6YklqdmpqQWoRTB8TB6dUAxOryc6MW2L+DGJfzRe88BJscgx9xZmzIK086cycIPFj
        vz7qeEX8N9/meDqpqKH2RLduaF64x74tK4t+lj7wYDXmtI/fcMiytsrru8aEpgCWxrXMabfS
        eFwq7l4w2vTZxHbW7rYY6xqz1Qn5aWfeuvIczmR7vP4B0+mghNml7IEyTGVi8h3Tuh6Lf100
        02fVtj01v999OKN7rS3WMUdjxeUnhy4zRWp3Ltjbuiy7eD2nwNmH306s3M5jV7T2hy+Pdmm8
        y/eqSfy9l9+Iy7yu3uv5QkwlU9/+aNdu+2d3gnSbV3F9Td954+Ju9aspDDzzXiX6rPoxY12C
        1YUTC/+UR9zlya969c++zqGdIVwgX4mlOCPRUIu5qDgRAKFlOM7QAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJJMWRmVeSWpSXmKPExsWy7bCSnK6r0KFkg1enrSwezNvGZvHy51U2
        i2kffjJbXN41h82i+/oONovlx/8xObB5XL7i7fHx6S0Wj74tqxg9Pm+S82g/0M0UwBrFZZOS
        mpNZllqkb5fAlfF83z/mgicsFcf+LWVqYGxg6WLk5JAQMJFY1NrI1MXIxSEksJtRYsqUh0wQ
        CWmJ6xsnsEPYwhIr/z1nhyhqZJJ4e+4FWBGbgLbE3elbwGwRATuJ9sdXGUFsZoESiUVfWsDi
        wgKmEgf7m8BsFgFVic7mN2wgNq+AjcSfqzDL5CVWbzjAPIGRZwEjwypGydSC4tz03GLDAsO8
        1HK94sTc4tK8dL3k/NxNjODQ0dLcwbh91Qe9Q4xMHIyHGCU4mJVEePcc3Z8sxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUAxP3kn3vz1dl2DzLPBh+Qyuo
        z7/N+tvrgPd2N8682XHzqVnYyZ+ej8U6/LuWtL+ZPOPcVvOMOx/YdX8cD/k4w8p13eqZYYf+
        HONYUbyw+pxj74lrwVncYffiG70l976ffWer+hz177ttTzLFNIhW8+mmrO6rWMsiXN14zvyD
        ZbNpa8eygtwd9T33r/7Ue/bQ/tXbtcz2stzP+jqjAlLuy/awhhxda8y+pPbhpAnyGSzarKrH
        FosVFF1+pbHnxbEPkxLV1jrM/HPCRoPXJK0jylRp14a3RZ/05/Aryp+a3x66W/MOf21o8eur
        k9XunVkbbCazYcmS3UcO7a7TPeLQdKA2xGHKo9ZN11ynfe4o+t6hxFKckWioxVxUnAgA7f/Z
        rowCAAA=
X-CMS-MailID: 20230114022406epcas5p4963a02aee5acb201c5e3495b6cfd44fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230114022406epcas5p4963a02aee5acb201c5e3495b6cfd44fe
References: <CGME20230114022406epcas5p4963a02aee5acb201c5e3495b6cfd44fe@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PA_GRANULARITY is duplicated, let's delete one of the entry.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 include/ufs/unipro.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/ufs/unipro.h b/include/ufs/unipro.h
index 6c553f98fe57..dc9dd1d23f0f 100644
--- a/include/ufs/unipro.h
+++ b/include/ufs/unipro.h
@@ -141,7 +141,6 @@
 #define PA_SAVECONFIGTIME	0x15A4
 #define PA_RXHSUNTERMCAP	0x15A5
 #define PA_RXLSTERMCAP		0x15A6
-#define PA_GRANULARITY		0x15AA
 #define PA_HIBERN8TIME		0x15A7
 #define PA_LOCALVERINFO		0x15A9
 #define PA_GRANULARITY		0x15AA
-- 
2.25.1

