Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A1164C34E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbiLNEsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbiLNEsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:48:11 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A20724BF7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:47:59 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221214044756epoutp04e66539183e91ed5575ddebb4c6c665da~wj4gwNuIA0829808298epoutp04F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:47:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221214044756epoutp04e66539183e91ed5575ddebb4c6c665da~wj4gwNuIA0829808298epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670993276;
        bh=Snt2Sfm19TbPHC6NdC56oxXeITXd+ZYEHuxh4O0JQaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGcr9c/f9NFEK1PhkYKTY36qLH4XQXnH+axBsW2CL5Zy8zK45YnaQZmbWGzjamFA8
         gKRLxEUkiynVsK+1rVAc1Ta0Fum/abo7tAsFcDwpReejjdq7H85Gn1cY2WKwduI3L3
         /uuD9zTGX6WzTNhukLkcqStypi9EyRSnFy2yyqTg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221214044756epcas5p4f69fab7a4885aaaf88aa169dde8a277c~wj4gC-qAS1170411704epcas5p47;
        Wed, 14 Dec 2022 04:47:56 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NX2t21943z4x9Pw; Wed, 14 Dec
        2022 04:47:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.A2.01710.87559936; Wed, 14 Dec 2022 13:47:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221214044434epcas5p212735c11a8ff9f72e25742e4ac8a7794~wj1ka5Oee2146721467epcas5p2L;
        Wed, 14 Dec 2022 04:44:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221214044434epsmtrp2dd36449de582e766398ef7e7a2834942~wj1kaNC6M2264122641epsmtrp2l;
        Wed, 14 Dec 2022 04:44:34 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-f1-63995578725a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.F9.18644.2B459936; Wed, 14 Dec 2022 13:44:34 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221214044431epsmtip213b6a0d0359660fa84587f7fa0a2f3a4~wj1h25UlJ2889728897epsmtip2i;
        Wed, 14 Dec 2022 04:44:31 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        sathya@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v3 4/4] arm64: dts: exynos: add dedicated SYSREG compatibles
 to Exynosautov9
Date:   Wed, 14 Dec 2022 10:13:42 +0530
Message-Id: <20221214044342.49766-5-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221214044342.49766-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmpm5F6Mxkg+VXtS0ezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFt8OfKa0eL2m3WsDtwem1Z1
        snncubaHzWPzknqPvi2rGD0+b5ILYI3KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0
        tDBXUshLzE21VXLxCdB1y8wBukxJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BS
        oFecmFtcmpeul5daYmVoYGBkClSYkJ2xq+UPY8EEroqlR8oaGNdydDFyckgImEj8unGHGcQW
        EtjNKLFmRnEXIxeQ/YlRYkL7RkYI5zOjxKk5P1hhOg49P88CkdjFKHF661w2CKeVSeLDotVM
        IFVsAroSrdc+M4EkRAR2MEq8nnQAzGEWmMIo0f1tPdgsYYE4ibWnf7CB2CwCqhKH174Eu4RX
        wFbi95pP7BD75CVWbzgAFucUsJOY1zQbbJCEwEt2iQ39CxkhilwkTvz9zwxhC0u8Or4FqllK
        4vO7vWwQdrrE5iOboZ7Ikehoaoaqt5c4cGUO0EMcQNdpSqzfpQ8RlpWYemod2DfMAnwSvb+f
        MEHEeSV2zIOx1SQWP+qEsmUk1j76BDXeQ+LXiaXQYJnIKDH38Q6mCYxysxBWLGBkXMUomVpQ
        nJueWmxaYJiXWg6PtuT83E2M4OSn5bmD8e6DD3qHGJk4GA8xSnAwK4nwqmpMSxbiTUmsrEot
        yo8vKs1JLT7EaAoMwInMUqLJ+cD0m1cSb2hiaWBiZmZmYmlsZqgkzrt0SkeykEB6Yklqdmpq
        QWoRTB8TB6dUA9P8bt5iKYv0TLUbL1mufpN22X2GR+nFuUfaC5x6ImY9u/8+lXlP91oefbVK
        lczvJVtb/Jnenfp29s7RSS69sYXrZ3IobKvmvPHunNKBbFvJex8uuU7ZaGV991pD7om9Z+sC
        N9gXfliQmDrn/UXThfzr5/jmF35vjq2d2K31bT/Dj7v/n/hWPRZ99nzu4RDxabmLPfbLLF9d
        d7Vov9byMom2Z9v4z4iyLjxuaCjX1LJ1Ze5730+eeww/s7yY/TEmP2T5QYaKSp3kDuXGIwH1
        GzbPd9e96KjJKbvg+7niAMV2CQmFxb2RT/m+eT46G5LofHjlX9X/92xumIhIMwu3C1929jxU
        e7pyxi+nE45TL0spsRRnJBpqMRcVJwIABuvomAcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvO6mkJnJBgdvylo8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gtWvceYbf4cuQ1o8XtN+tYHbg9Nq3q
        ZPO4c20Pm8fmJfUefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlbGr5Q9jwQSuiqVHyhoY13J0
        MXJySAiYSBx6fp6li5GLQ0hgB6PE6UXzWCESMhInHyxhhrCFJVb+e84OUdTMJLG34xojSIJN
        QFei9dpnJpCEiMABRondvUsYQRxmgRmMEn/XzwFyODiEBWIkupcVgDSwCKhKHF77Emwqr4Ct
        xO81n9ghNshLrN5wACzOKWAnMa9pNhOILQRUs+nZXfYJjHwLGBlWMUqmFhTnpucWGxYY5aWW
        6xUn5haX5qXrJefnbmIEB6eW1g7GPas+6B1iZOJgPMQowcGsJMKrqjEtWYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamRZtf7y7vCJvF8OfhsxdZb9Xq
        Hpz6vEFp9duM/WeDlNZdf7Vcc+7/vX9ro3z1zuXaCItITnsX/2aWsWHgoom3utdolviviBCJ
        WqfQYZw1e3Fg8AntJ2+fqhWv8lHzPb5lzeqtdsffrPlgWehq5nl7xd6vT3QC3tX8LT9vkSV0
        5sNUFcP9d1Jszkt8se9ec11HMGrHqdNW92++NDmTvIJJQnnjarsleUZSm/6kVp/eZMKo/3nJ
        RK/8rzxfepPqs342iHhHCYSH3FXZ0yjpaBh7oD9HekuZRdblk66n2if27z8T5DRn/zK2/sj1
        9c83/1jgafqzNz3dMX9zFsOLtD6N+EVlz0RW6rT462Wmeq/jVmIpzkg01GIuKk4EAOGGvfu9
        AgAA
X-CMS-MailID: 20221214044434epcas5p212735c11a8ff9f72e25742e4ac8a7794
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221214044434epcas5p212735c11a8ff9f72e25742e4ac8a7794
References: <20221214044342.49766-1-sriranjani.p@samsung.com>
        <CGME20221214044434epcas5p212735c11a8ff9f72e25742e4ac8a7794@epcas5p2.samsung.com>
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
for them.

Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
index 5dc361734cfe..d3c5cdeff47f 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -370,17 +370,20 @@
 		};
 
 		syscon_fsys2: syscon@17c20000 {
-			compatible = "samsung,exynosautov9-sysreg", "syscon";
+			compatible = "samsung,exynosautov9-fsys2-sysreg",
+				     "samsung,exynosautov9-sysreg", "syscon";
 			reg = <0x17c20000 0x1000>;
 		};
 
 		syscon_peric0: syscon@10220000 {
-			compatible = "samsung,exynosautov9-sysreg", "syscon";
+			compatible = "samsung,exynosautov9-peric0-sysreg",
+				     "samsung,exynosautov9-sysreg", "syscon";
 			reg = <0x10220000 0x2000>;
 		};
 
 		syscon_peric1: syscon@10820000 {
-			compatible = "samsung,exynosautov9-sysreg", "syscon";
+			compatible = "samsung,exynosautov9-peric1-sysreg",
+				     "samsung,exynosautov9-sysreg", "syscon";
 			reg = <0x10820000 0x2000>;
 		};
 
-- 
2.17.1

