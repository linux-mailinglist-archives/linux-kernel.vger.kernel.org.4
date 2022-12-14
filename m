Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E570264C34B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbiLNEsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiLNEr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:47:57 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40809222A1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:47:48 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221214044746epoutp0195d964312afe03822762842242d4da5e~wj4XVUXDZ2940629406epoutp019
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:47:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221214044746epoutp0195d964312afe03822762842242d4da5e~wj4XVUXDZ2940629406epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670993266;
        bh=9GcqwIRLASTQRFmFs7iWPdbd6ymv6PeDHaXpB4o0bUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I92i4Mt7JkrFdBnheIqKU5VLb1z2QApj63A7xWYbEWI7bmU0/5rjo3j8s5dGqg5tW
         E0ckeel3DvxyEBsbp30Ja05M19HxwHLuCwYcQKHNC9c5KSe8X5B1HTFGDqewesetgS
         7fUTpDMxyuvrHmDALgpegLG0zk+iJUbCgM8NvNKs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221214044746epcas5p22b9d42a620aa33a4d368181db98a24f6~wj4WuwN4h0552705527epcas5p2a;
        Wed, 14 Dec 2022 04:47:46 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NX2sr12SGz4x9Q8; Wed, 14 Dec
        2022 04:47:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.8F.56352.07559936; Wed, 14 Dec 2022 13:47:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221214044430epcas5p4c896fde60471fea774387bd74abe0ea5~wj1g4Pd9e0581805818epcas5p45;
        Wed, 14 Dec 2022 04:44:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221214044430epsmtrp2bb28a7d342acb5d66266ed737c142a68~wj1g3anZT2264122641epsmtrp2Z;
        Wed, 14 Dec 2022 04:44:30 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-d4-639955709e5d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.F9.18644.EA459936; Wed, 14 Dec 2022 13:44:30 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221214044429epsmtip2b0371518bc0b97ae775cacb4e0c2e055~wj1fTvsnc3158631586epsmtip2C;
        Wed, 14 Dec 2022 04:44:28 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        sathya@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v3 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynosautov9
Date:   Wed, 14 Dec 2022 10:13:41 +0530
Message-Id: <20221214044342.49766-4-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221214044342.49766-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmum5B6Mxkg4UrWC0ezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFt8OfKa0eL2m3WsDtwem1Z1
        snncubaHzWPzknqPvi2rGD0+b5ILYI3KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0
        tDBXUshLzE21VXLxCdB1y8wBukxJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BS
        oFecmFtcmpeul5daYmVoYGBkClSYkJ2xqKmw4ApvxaWHDg2Mrzi7GDk4JARMJGbezehi5OIQ
        EtjNKPH/1hNmCOcTo8SMFQ9YIJzPjBKd64+zdjFygnUsf3ycCSKxi1Gi5eNsVginlUniz+kr
        TCBVbAK6Eq3XPoNViQjsYJR4PekAmMMsMIVRovvberBZwgIlEk0r9zKC2CwCqhL717eBdfMK
        2EpcXTOXEWKfvMTqDQeYQWxOATuJeU2zmSDij9glbm4ohvjCReLVUyWIsLDEq+Nb2CFsKYnP
        7/ayQdjpEpuPbIZ6IUeio6mZGcK2lzhwZQ4LyBhmAU2J9bv0IcKyElNPrQPbxCzAJ9H7+wnU
        Vl6JHfNgbDWJxY86oWwZibWPPkGN95CY2TUPLC4kMJFRYnd7+gRGuVkIGxYwMq5ilEwtKM5N
        Ty02LTDOSy2HR1lyfu4mRnDS0/LewfjowQe9Q4xMHIyHGCU4mJVEeFU1piUL8aYkVlalFuXH
        F5XmpBYfYjQFht5EZinR5Hxg2s0riTc0sTQwMTMzM7E0NjNUEuddOqUjWUggPbEkNTs1tSC1
        CKaPiYNTqoHp9d9Z/af0BAU4lKoUKt4L3rr5cYnKjS/maz2l9rCKrEt5mK28V3hS6c41pUJr
        9mvOusry2/f9iSszD/2qmF35K6I4S9dwRorIFuaz2wp9XVYq1lZr71coeBijK1mUEpD9oH62
        8PM29s11wbI1FS2csxPnV0QWXHyZ73mycYFTc/SlmW4K81oPWt5atWJOtufrCbbpjIZc167/
        /n08yeSNQJtP4Gx103//N1y98CpuI1fwjRi9ruT4dUXmnn7rryznmbgiTXLtJmaprWmfy7cJ
        r0nevv3zT4fP3EuN9CfeLci0d+vrFZ18/eq+n7dXm6s9uvJ31bZ3S05xnmZ5sCV/h8E64SlB
        T51W8bVMc4pWUmIpzkg01GIuKk4EAAsWxX0DBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvO66kJnJBpumaFs8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gtWvceYbf4cuQ1o8XtN+tYHbg9Nq3q
        ZPO4c20Pm8fmJfUefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlbGoqbDgCm/FpYcODYyvOLsY
        OTkkBEwklj8+ztTFyMUhJLCDUeLO88OMEAkZiZMPljBD2MISK/89Z4coamaSeD7pGjtIgk1A
        V6L12mewbhGBA4wSu3uXMII4zAIzGCX+rp8DNkpYoEji8dUdrCA2i4CqxP71bUwgNq+ArcTV
        NXOh1slLrN5wAGwdp4CdxLym2WA1QkA1m57dZZ/AyLeAkWEVo2RqQXFuem6xYYFRXmq5XnFi
        bnFpXrpecn7uJkZwcGpp7WDcs+qD3iFGJg7GQ4wSHMxKIryqGtOShXhTEiurUovy44tKc1KL
        DzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDSL9YN9kh9JCKrWN2nbZja2zKt/nLj
        fwPhNfc7CjaIvM54HqcVuVpgeR/Da45zae83rFmY/mbKwWOpaS7rzv2/ddhs77zDgcZBxR3n
        tLU2de8zXdc3kYd3BeO7qb/jp207vnUZ5zXny8zptm/EQ1f8lZDcl79wvf7m+Z+vvbl1mzmo
        xLjnvaZaiuo/rTmhS5WezVx/SFbheZLv/z7u5n9czexXrafbmDz4Krmpn3XPjVLvlW8v/Tn6
        af7uJdtWVVsqnFQr5JiWnNtznqfp/0mpTxaH7BkrnTZZKLgwG//+FvHu+uOKqg1vgzWiF06d
        eVpLcuesDV4i4ZcOfZQ9EP6xY1pWxsmVtXlsmziLth+UVmIpzkg01GIuKk4EANsIvQW9AgAA
X-CMS-MailID: 20221214044430epcas5p4c896fde60471fea774387bd74abe0ea5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221214044430epcas5p4c896fde60471fea774387bd74abe0ea5
References: <20221214044342.49766-1-sriranjani.p@samsung.com>
        <CGME20221214044430epcas5p4c896fde60471fea774387bd74abe0ea5@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynosautov9 has several different SYSREGs, so use dedicated compatibles
for them and deprecate usage of generic Exynosautov9 compatible alone.

Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 .../bindings/soc/samsung/samsung,exynos-sysreg.yaml      | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index 427df05224e5..da43efb0ce80 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -17,7 +17,6 @@ properties:
               - samsung,exynos3-sysreg
               - samsung,exynos4-sysreg
               - samsung,exynos5-sysreg
-              - samsung,exynosautov9-sysreg
               - tesla,fsd-cam-sysreg
               - tesla,fsd-fsys0-sysreg
               - tesla,fsd-fsys1-sysreg
@@ -35,6 +34,7 @@ properties:
           - enum:
               - samsung,exynos5433-sysreg
               - samsung,exynos850-sysreg
+              - samsung,exynosautov9-sysreg
           - const: syscon
             deprecated: true
       - items:
@@ -43,6 +43,13 @@ properties:
               - samsung,exynos850-peri-sysreg
           - const: samsung,exynos850-sysreg
           - const: syscon
+      - items:
+          - enum:
+              - samsung,exynosautov9-fsys2-sysreg
+              - samsung,exynosautov9-peric0-sysreg
+              - samsung,exynosautov9-peric1-sysreg
+          - const: samsung,exynosautov9-sysreg
+          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.17.1

