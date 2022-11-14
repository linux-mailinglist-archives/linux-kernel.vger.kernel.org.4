Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BBD6275A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 06:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbiKNFpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 00:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiKNFox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 00:44:53 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4A3178B1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 21:44:47 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221114054445epoutp01bb1f04bd43ef8e00a65ed415634a1d5b~nXTjeFF192560625606epoutp01C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:44:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221114054445epoutp01bb1f04bd43ef8e00a65ed415634a1d5b~nXTjeFF192560625606epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668404685;
        bh=FtNonu142mw8UcQV9QErqFMq965U9ZP4d9RK4tcsloo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDu4plkHyCIZPPTYZkdT5ddOctlJiLUViWlVa7CmUtOsQUc4rwd9zlIBcqZmvC/ZP
         /7rmC+DH7mzdzpXV3llpF+VyXjShEdKvVzi4uTpPthGk4KTlF36fG2ODmKZ2RKzXGy
         zGP50/PO4jZcyzoPYN50TqnmfmX3iwZx/SQ3oxB4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221114054445epcas5p46aa8409dcef1b4898e8b33912f2d9568~nXTixnji52232022320epcas5p4R;
        Mon, 14 Nov 2022 05:44:45 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4N9dYH6G7xz4x9Q2; Mon, 14 Nov
        2022 05:44:35 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.8D.56352.3C5D1736; Mon, 14 Nov 2022 14:44:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221114054049epcas5p3f3a5ce63fd3f1ce55197d1eaaa87e90b~nXQHLTpj92436624366epcas5p33;
        Mon, 14 Nov 2022 05:40:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221114054049epsmtrp222c3d51a3c31bedc746783817efae4c9~nXQHJ0FjF2028920289epsmtrp2P;
        Mon, 14 Nov 2022 05:40:49 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-32-6371d5c39f6b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.CA.14392.1E4D1736; Mon, 14 Nov 2022 14:40:49 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221114054045epsmtip2bd24a5e26dbc224815ddda1c116614a0~nXQDWTUEE1854818548epsmtip2f;
        Mon, 14 Nov 2022 05:40:44 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com,
        aakarsh.jain@samsung.com
Subject: [Patch v4 2/3] media: s5p-mfc: Add variant data for MFC v7 hardware
 for Exynos 3250 SoC
Date:   Mon, 14 Nov 2022 11:16:54 +0530
Message-Id: <20221114054655.68090-3-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114054655.68090-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTaVBbVRSe+95LXoIN8wwwXNmkb6QCM1BiQ3rRghY7zJuhjmB1XPoDYngF
        hpDELLU4Lo2yj4XSqeyCJYQKlMWwRQQaAkJF0bYi2CHBFmoLOmXYpBSYqSEB/fedc77vfOee
        ey8PF9q4Prx0hZZVK6RymutGdA+FBIcN/faeLOJ6swj9aa7goNs13Vxk2LiPoT8MqwSydnSR
        qHOiCkeXRy0cVDv8Mwf1DM4S6Jt5R/VGhZ1A92tbAVqonOGiovk7ODLNTXLQr73VXPR5excH
        tQzbSWScuoGhBtM2huq61kiU0z9MIntfN0DZucPYS5C5UnMFMGZ7PWCm6ldw5ttKO8kY+hYw
        xtRUwGVsk31cpqP+Eybn+02CKepsAkzh8BSXWTUFMGP/rJIJgncyjqSx0hRWHcgqZMqUdEVq
        NB1/IunlpEhJhChMFIUO04EKaSYbTR87nhAWly53rIAOPC2V6xypBKlGQx+MOaJW6rRsYJpS
        o42mWVWKXCVWhWukmRqdIjVcwWqfF0VEPBfpICZnpN20jZOqfvczXXUd2Fmw+EQh4PMgJYZf
        b/1IFAI3npD6DsDN5b9JV7ACYGteA+4K1gFsNkzje5K2bP2upB/A8vqr2E5BSOVgsN0SWgh4
        PC4VBsd75DtpT0oP4Fy+doePUyUEnC6adzbyoN6Ftse9Ti1BBcHN5nPkDhZQ0fDSTw+By+xp
        2NxucfL5VAy0Vc06J4JUHh/eXKvCXKRj8N5g/67AA/412km6sA9cXeznurAMztUt7J5ADtv6
        LhIu/CK0TFQTO0PjVAhs6z3oSvvDL8Zane1xyh2e27q7ayWA5po9fABW2zY4LuwHh5qNuyMw
        cMW4yHEtqATAlssmcB4EVP5v8RUATeApVqXJTGU1kapDCvb9/25Npsw0AeczD403g9nbS+FW
        gPGAFUAeTnsKavyUMqEgRZr1AatWJql1clZjBZGOBZbgPl4ypeOfKLRJInFUhFgikYijDklE
        tLfAUB4qE1KpUi2bwbIqVr2nw3h8n7NY4wuo+MSXfaUzyeKlOO2+T3NLzaMPla3zPae8C7xj
        19JHCoo/w97SLx1PNLb5Y149TROiqwUVy9xHQcpfpspqtCML+3vzamk+q36WTw8ptrfjfNdX
        8oO2z/i5eb1y7O7jo+c3spjlB6o7Qm1xqOW63k6PkYMdwTpLwOs/4I0ev98asFr9N8nJIM8Q
        Q2JwuXEgKTPEKzlwWuPnO/CktmQ8PyV74rX6IcX6hcIO463JzouykwWx8XPXZq4t4E1mSZbp
        FL9s8eRRQizV7z99oPXNmNzSS/vYBiA5XPZqfHrXSG1LzttbjYnc3jcePcNEPvh4VZ8qdI+9
        V0l+9OHMhTRfHU1o0qSiUFytkf4LJsQTLm8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvO7DK4XJBl8Os1g83TGT1eLBvG1s
        Fot/PGeyuL/4M4vFoc1b2S22XJnNbLH8+AFWi/lHzrFabD/4iMVi4wug7MWZd1ksns9fx2jx
        ctY9Nou+Fw+ZLTY9vsZqcXnXHDaLng1bWS3WHrnLbrH0+kUmi2Wb/jBZLNr6hd2ide8Rdou7
        e7YxWrS0HWFykPBYM28No8eOu0sYPa4v+cTssXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j1a
        j/5i8ejbsorRo+vIdTaPz5vkPE59/cwewBvFZZOSmpNZllqkb5fAlXHpzln2gr18FVsXbWZq
        YHzH3cXIySEhYCKxvqWRBcQWEtjNKDHnKT9EXEbif9sxdghbWGLlv+dANhdQTTOTxOYLn5m7
        GDk42AR0Jc5uzwGJiwi0MkpcX9nJBOIwC6xkkbi9sYcJpFtYIEFi/p27jCA2i4CqxK/VvWBT
        eQVsJRae+c4IsUFeYvWGA8wgNqeAncSd2Y+YIS6ylZh0YQXLBEa+BYwMqxglUwuKc9Nziw0L
        DPNSy/WKE3OLS/PS9ZLzczcxguNNS3MH4/ZVH/QOMTJxMB5ilOBgVhLhnSeTnyzEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD064dOW7RNZfOmbZo/5Go
        ro7beizJ67bYoTtXQ59/kxQ6fujGW3uum0fmegkurz8snsehY1jSGLx0tUTU9WYj04r2v79v
        7pes2sIhUHDa6YXhrRndT05uSjp8oWvrp9kc/odmzbuoI7QoXqXV6JtVvfTVLxdV94jO5E/r
        PTotfvnJl6HbdTkymFRsE78wvbdIC9WpjVdO3VK4T/NvVERE2LznkzU/nd137Jha3DLrtRZ7
        ik8cuCCisEYwOnCS4M2lEy9Ev5PiX3fk79mVz2YViB3pevTmmdSu3xYbs7fMkLtosjLKdnOt
        0tHT7F3vuq0ap17dq2zYwJKr8MPf+plMjBXjqmbrDcGtaZ9y1jO4OyixFGckGmoxFxUnAgCn
        wIwdJgMAAA==
X-CMS-MailID: 20221114054049epcas5p3f3a5ce63fd3f1ce55197d1eaaa87e90b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221114054049epcas5p3f3a5ce63fd3f1ce55197d1eaaa87e90b
References: <20221114054655.68090-1-aakarsh.jain@samsung.com>
        <CGME20221114054049epcas5p3f3a5ce63fd3f1ce55197d1eaaa87e90b@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit "5441e9dafdfc6dc40fa" which adds mfc v7 support for
Exynos3250 and use the same compatible string as used by
Exynos5240 but both the IPs are a bit different in terms of
IP clock.
Lets add variant driver data based on the new compatible string
"samsung,exynos3250-mfc" for Exynos3250 SoC.

Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
Fixes: 5441e9dafdfc ("[media] s5p-mfc: Core support for MFC v7")
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index fca5c6405eec..007c7dbee037 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1576,8 +1576,18 @@ static struct s5p_mfc_variant mfc_drvdata_v7 = {
 	.port_num	= MFC_NUM_PORTS_V7,
 	.buf_size	= &buf_size_v7,
 	.fw_name[0]     = "s5p-mfc-v7.fw",
-	.clk_names	= {"mfc", "sclk_mfc"},
-	.num_clocks	= 2,
+	.clk_names	= {"mfc"},
+	.num_clocks	= 1,
+};
+
+static struct s5p_mfc_variant mfc_drvdata_v7_3250 = {
+	.version        = MFC_VERSION_V7,
+	.version_bit    = MFC_V7_BIT,
+	.port_num       = MFC_NUM_PORTS_V7,
+	.buf_size       = &buf_size_v7,
+	.fw_name[0]     = "s5p-mfc-v7.fw",
+	.clk_names      = {"mfc", "sclk_mfc"},
+	.num_clocks     = 2,
 };
 
 static struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
@@ -1647,6 +1657,9 @@ static const struct of_device_id exynos_mfc_match[] = {
 	}, {
 		.compatible = "samsung,mfc-v7",
 		.data = &mfc_drvdata_v7,
+	}, {
+		.compatible = "samsung,exynos3250-mfc",
+		.data = &mfc_drvdata_v7_3250,
 	}, {
 		.compatible = "samsung,mfc-v8",
 		.data = &mfc_drvdata_v8,
-- 
2.17.1

