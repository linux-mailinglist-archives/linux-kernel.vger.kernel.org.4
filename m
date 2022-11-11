Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BB56252A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiKKEe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiKKEeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:34:14 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AA725C57
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:34:11 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221111043410epoutp01fbabdf6df92ba4d588f4189801f71ba6~mbaEQjbdg3061030610epoutp01b
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:34:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221111043410epoutp01fbabdf6df92ba4d588f4189801f71ba6~mbaEQjbdg3061030610epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668141250;
        bh=FtNonu142mw8UcQV9QErqFMq965U9ZP4d9RK4tcsloo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQtohO75lF/6HRimZnRh4g2MXJ6sxOwpdt3gxVb4Pb+8L63MR+KUKJTwAOYZNi8Ly
         +WAKTVjxiroPwgue/WapotzkKcwGZaTyH2JXIMQsOpS8YxSJX6G2E6/UhEAuD6+9Iu
         oWWXdiZLV3k7aPzmN9SdcY6UkL9by6lb8JzgCumY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221111043409epcas5p2511a062ba72e2ce5a774f930b2fca950~mbaDeKivZ1812118121epcas5p2N;
        Fri, 11 Nov 2022 04:34:09 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4N7m7M2q19z4x9Pt; Fri, 11 Nov
        2022 04:34:07 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.CD.39477.FB0DD636; Fri, 11 Nov 2022 13:34:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221111031714epcas5p3f29880e7aa8be5616132edb94a70d715~maW5PwqTx1781417814epcas5p3X;
        Fri, 11 Nov 2022 03:17:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221111031714epsmtrp2d2de81dae8fc6d3a8ca37e36909bd50f~maW5OgLNL1701017010epsmtrp2Y;
        Fri, 11 Nov 2022 03:17:14 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-13-636dd0bf7d0c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.2C.18644.ABEBD636; Fri, 11 Nov 2022 12:17:14 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221111031711epsmtip1298cb31b94eb39b1f4f1d9fd3075cf03~maW2MRJHI2869928699epsmtip1i;
        Fri, 11 Nov 2022 03:17:11 +0000 (GMT)
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
Subject: [Patch v3 2/3] media: s5p-mfc: Add variant data for MFC v7 hardware
 for Exynos 3250 SoC
Date:   Fri, 11 Nov 2022 08:53:36 +0530
Message-Id: <20221111032337.79219-3-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111032337.79219-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTa0xTZxjed0572uqKZxS2j06R1eG4yNW2fkXRLQN3mJfBjC5ZwthZOaFI
        b7Zl7pIpbjKVKKPJRhS5LFwkg3IrLVQugqWMDQPhJmjWOhhTYBPi6FjMcGaFwvbveZ/3efI+
        ed/v4+K+TkLIzVQbGJ2aVoqIDayWntCQiK4hlTza3PUcum+7wkaTpS0Eqng8g6GfK9wsZG+2
        cpBl7CqOqvu62ajMMchGrTd/YaGmWU93+IqLhWbK6gGaK7pHoPzZKRyZp8fZaLStmEAXG61s
        VOdwcVDVxDCGrpmfYKjc+icH5XY6OMjV0QLQ2S8d2KuQMpWaAGVzVQJqonIRp64XuThURccc
        RplrLhCUc7yDoJorT1O5vX+zqHxLDaDyHBME5TYHUv1Lbk4y/92sPQqGTmd0QYxarknPVGfE
        iw4cSXs9TSKNjomIkaFdoiA1rWLiRQkHkyP2Zyo9KxAFfUgrsz1UMq3Xi6L27tFpsg1MkEKj
        N8SLGG26UivWRupplT5bnRGpZgxxMdHRsRKP8P0sxYhzgKPt9PnIWt6M5YCFjXmAx4WkGA5c
        crPywAauL9kO4NOhm2vFIoC9d0oIb+EGsHtwnrNumbIvsr2NNgB/HDWuWXIxeP7JX56CyyXI
        CDjQqlwx+JFnAJw+b1jR4KSRBX/Kn8VXGgLyA9g8b8RWMIsMhtcst7EVL5+Mh4umbd5hW2Ft
        Y/eqnEfuhZPVDauzIHmOB7ty/2F7RQnwztMxwosF8Lc+y1pSIXQvdK7xcjhdPod7sRI2dHzN
        8uJ9sHuseDUzTobChrYoL70FftNfvxoNJ33gpeVfMS/Ph7bSdbwdFjsfr0XYDHtqq4AXU/D3
        ul7g3YkRwHHHGLsABBb9P+JbAGpAAKPVqzIYvUQbq2ZO/nc1uUZlBqvPPOxNG5iafBRpBxgX
        2AHk4iI//saQLLkvP53++BNGp0nTZSsZvR1IPPsz4kJ/ucbzT9SGtBixLFoslUrFsp3SGNEL
        /IrLYXJfMoM2MFkMo2V06z6MyxPmYJv2vSJ3XW4aYNBI6P6UZzFl+MOHb5ecEbwzaHtZm8+P
        +6yBdyBnG5vYeeqQolwoM1pfkygt8za/RKeY9fzBrwZPcyXvNdlb6w9tPSrYferz9NpEHf+w
        tHb5RDj9A+/Eyfbet+7e6ArMqhL61x3dTjuHiqzdgt1X2+8+6g/xOdz0xYPlW4U7UrZoXix/
        aWyhqzDtiJ2RMVFYAPFH7I3G68HHJdaA1L68ssKLitTNIfdMS0vfJZz7NOP7Udczm9iNxyTD
        dlPDclLVQOpCxP3KY0n8maSps3EBi8fFD0JVt00sWailpzY40Vqw64326saW3h0Tt8IL/FME
        rgUqoCS4fqQwgSNi6RV0TBiu09P/Ass/Le5vBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnO6ufbnJBp13xSye7pjJavFg3jY2
        i8U/njNZ3F/8mcXi0Oat7BZbrsxmtlh+/ACrxfwj51gtth98xGKx8QVQ9uLMuywWz+evY7R4
        Oesem0Xfi4fMFpseX2O1uLxrDptFz4atrBZrj9xlt1h6/SKTxbJNf5gsFm39wm7RuvcIu8Xd
        PdsYLVrajjA5SHismbeG0WPH3SWMHteXfGL22DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R6t
        R3+xePRtWcXo0XXkOpvH501yHqe+fmYP4I3isklJzcksSy3St0vgyrh05yx7wV6+iq2LNjM1
        ML7j7mLk5JAQMJF4eOgTaxcjF4eQwA5GifZnuxghEjIS/9uOsUPYwhIr/z1nhyhqZpKYe3c/
        WxcjBwebgK7E2e05IHERgVZGiesrO5lAHGaBlSwStzf2MIF0CwskSPRfmMEGYrMIqEos23KV
        CaSZV8BW4tMaZYgF8hKrNxxgBrE5BewkHixfzwJSIgRU0v5XawIj3wJGhlWMkqkFxbnpucWG
        BUZ5qeV6xYm5xaV56XrJ+bmbGMHRpqW1g3HPqg96hxiZOBgPMUpwMCuJ8HJrZCcL8aYkVlal
        FuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwDTlmVhkaqLL4zfF+m+K
        dG8J9/qfCzeZE66VZvNzjebTu8JzzrFNe5qnWLvCbJXU5zkSru5PA6f2fF5SPn/tFou7ktI+
        lSteduuo/6jXm5dQm3juNdek1VeN1gQ4dAu/S7WYc2bJXqZ03jP/l1at3f7jfuKDx8cuyKmy
        CfyQCb4XumeF9bH19vnVGjqSFau2P5T7ubnUZ9Ju9QO5Js1/P9xKk9ljrjnFi/2UZaxeSUrd
        36sOdRczXv9c66bs7exjtu6r/7Kqm19dPEsaavi0Dj5fOq0sV9cwffbvcBm9X4dfbDpq8E+z
        On3xvB+3rvtyTj1dYZq1rCK7ze2dRmfEG6+Py12XR/E9C4pdtVSp11uJpTgj0VCLuag4EQAk
        oY3kJQMAAA==
X-CMS-MailID: 20221111031714epcas5p3f29880e7aa8be5616132edb94a70d715
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221111031714epcas5p3f29880e7aa8be5616132edb94a70d715
References: <20221111032337.79219-1-aakarsh.jain@samsung.com>
        <CGME20221111031714epcas5p3f29880e7aa8be5616132edb94a70d715@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

