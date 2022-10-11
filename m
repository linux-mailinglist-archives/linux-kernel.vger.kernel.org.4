Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508D15FBFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJLDuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJLDtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:49:31 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0741ABD4F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:48:22 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221012034820epoutp0445f3c43d1ea53807626f03d3edc22b50~dNbfbhZoa0497304973epoutp04K
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:48:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221012034820epoutp0445f3c43d1ea53807626f03d3edc22b50~dNbfbhZoa0497304973epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546501;
        bh=+fx2B4you5BE2FTxznvyQLDtQFyqq/F6+43cr6r8YNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kFZl059CbTrOKYJRWE7fei/3pQXZ+irevgsAh2GHHn+z7Dfk1ZNJKsNtL+XgcmbXW
         o0bszr8Ww46UDrpDK+ouw62k1sHOvqpkqn/XBNLLe9JmqxNQDxoIezvr/i9ziQGX8R
         PhwYBbUhQLGlFLH7WfBbCgj8kzfdh8sGizDOeGxk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221012034819epcas5p2be9d81cba2840d6ebbbdf2814b3d653a~dNbeIctYo1883318833epcas5p20;
        Wed, 12 Oct 2022 03:48:19 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MnJXJ5rq5z4x9Q8; Wed, 12 Oct
        2022 03:48:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.1C.39477.CF836436; Wed, 12 Oct 2022 12:48:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221011125219epcas5p22aa56f46aa326c8d643bfbb076c0062c~dBNJ44KCq1500615006epcas5p27;
        Tue, 11 Oct 2022 12:52:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221011125219epsmtrp20c14976087be1872d76070ecea0558fa~dBNJ3uBTZ1820318203epsmtrp2H;
        Tue, 11 Oct 2022 12:52:19 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-c8-634638fc3251
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.94.18644.30765436; Tue, 11 Oct 2022 21:52:19 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125215epsmtip1500fb54b3a3c857d9d68ed8a049b593b~dBNGz2ZbB2675826758epsmtip1J;
        Tue, 11 Oct 2022 12:52:15 +0000 (GMT)
From:   aakarsh jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v3 12/15] media: s5p-mfc: Set context for valid case before
 calling try_run
Date:   Tue, 11 Oct 2022 17:55:13 +0530
Message-Id: <20221011122516.32135-13-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xTVxTHc/va15YM81JZdmmQsadzAlKpa7uLAUYE3WOIkhF1bhmsK48f
        0l/2h7KZOCaCYnSMBQQ6BAYUJ6Bg+WEtGArU4cziRiVgkDoYIiCLGxQdCixrKWz/fc4533O/
        J+fey8F4Yzifk6HU0RqlVE7iXsz23sAtIUtotyx0aiIQTZjLWGi0oh1HNQuTDPRbjZOJelra
        2Kh14DsMXeqzslCl7S4LXe/+nYmuTbmq/WUOJpqsvArQtOEhjkzjgyw09uQgumcpx9G55jYW
        umJzsJFxqJ+B6kxLDFTdNs9GuTdtbOTobAfoVJ6NEQWpxopGQJkdtYAaqp3DqBsGB5uq6Zxm
        UKb6fJwaGezEqZbaL6ncWy+Z1Net9YD65+RFNnXWNoRTTpM/deeZk52w7qPM8HRamkJrAmil
        TJWSoUyLIOMSk6OTxZJQYYgwDL1DBiilCjqCjNmTELI7Q+5aAxlwVCrXu1IJUq2W3BYZrlHp
        dXRAukqriyBpdYpcLVILtFKFVq9MEyhp3Q5haOh2sUv4aWb690u1mPoZN6vF0MTMBmbOWcDl
        QEIEl2Z+YZ0FXhwe0QHgNWMX5gnmAOx4YGV7AieA1TPNjLWWhQI75mYeYQHw5I0ojyiXAfMq
        /mS7CzgRAruMVtzNPsRXAI6f0blFGJHDhI6fF1dE64lPoPGRCbiZSbwJrXXnVxy8iUiY3d+7
        6vY6bGi2rrhxXflZ44+4+yBInObCX9vyWB5RDPw2//Qqr4dP+lrZHuZD59ObuIdlcLx6GvOw
        HDZ1FjE9/C60DpS7mOOaLhA2WbZ50htg8Z2rKzNgxDp4fvHR6jze0Fyxxpth+cjCqq0f7G0w
        Ag9TsNpiWV1qIYBXGq5j3wB/w/8WVQDUA19arVWk0VqxeruSPvbftclUChNYeetB75vB2Ohf
        gh7A4IAeADkY6eMNKnfKeN4p0s+/oDWqZI1eTmt7gNi1wEKM/6pM5fosSl2yUBQWKpJIJKKw
        tyVC8jXvmtIgGY9Ik+roTJpW05q1PgaHy89m8At37G3el3QkadpPV1B8qGzoYnSyorZ39sUr
        B6sG8xVDso4+X0UsdeBYXMy5+DP2BzP7/8gB6cF7lrPMl59eqoyS77rcOpL5/HBPqsKLyytN
        lZB/z26uihR5KZxRtxbtvoG+G51+cYmT1MPituMfD5fs3f8iflTgW3/7uF/D4QL/TQn8gWre
        bf1i9Jalu2kf0L25hmF7d9d8zoGtR7tH5OEnGp9/thOjwML9ugsf5s+lToUoN6kbl/PfmzAI
        Nk6g5V3Db/xUwlx+HNAd3Hninu3IoRa7uCihSBX8gz6pdIzc99jeTb8sbrRc2DCTX5M4Pxib
        JYhVxndtLbl/yqe54i2DmGRq06XCIEyjlf4LFQshRXQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG+59zds7RmB1nl+MFhZGllpZR+ZfKQtIO0U3BoqLamMcZeRmb
        ZvklrYwcphEpbPPapmPzks1LK8yWroUiphaui9NpmVpS2bTMzGpK337P+3vg+fCSKE+BeZFn
        U9JYaYowiY+7Ys3tfN9gVBwl2vy2gANHjQoOtJc241A9O4bAIbUDg20NTQRsfKlCofaZiQPL
        zN0ceP/JCAbvjf+zvQobBsfK6gCcUA7i0PCunwOHPx6DLx4W4zCvvokDa802AlZaexFYZZhH
        4J2maQLmPDIT0NbSDODVa2ZkD83UlNYAxmjTAMaq+YYyD5Q2glG3TCCMQZ+LMwP9LTjToLnE
        5Dydw5j8Rj1gFi6XEIzcbMUZh8GX6ZxxEEfcTrjujGeTzp5npZsiBK6JFfMaVDLjcqFBeRfL
        AkZSDlxImtpKzxb0oXLgSvIoI6C/D3WiS8KH/nPNQiyxB61bGCOWSlcQ+o+jETgFTgXTjytN
        uFOspHIAbdXlIs6AUiqMnr1l4jhbHtRJeubH90XGKH/aVHUDcTKXiqCzetuRpQk/urretDjt
        8u8+VWnBncyjdtHZXwqRm8CtHCzTA09WIksWJ8tCJVtS2IwQmTBZlp4iDhGlJhvA4veCgoyg
        Rf81pA0gJGgDNInyV3JBWaSIx40XXsxkpalnpOlJrKwNeJMYfw23R95xhkeJhWnsOZaVsNL/
        FiFdvLKQ6qtBGyux0tWHYyvs7saOrm47dehFhQDqhrmeg+pz2q5tg30xe5MmDzKPnwa6/47z
        68F57W7e5e7eoh1ftar1pxTT2V3W5YeU0/H7swSWmQ3LM5/7i8J/jqRJuJbyfqR2yivn94DP
        wHR0nMomCMj9VZJuyxglI3YWTR7fOJ73ShglbW3w/ZDPj5VpZr3rtPfXjkV/jgyw+ie0hgGd
        PS4yM2/z5blVCchHuzKMud566UChx5vTC5G7b8YGB1i0E44nC8X7ftVnfKoPXXcgNda9Kez2
        KfFqPgh+vcJTIuQJYqJbVYnVirg0bDLsaLZp+26zV7j6PbbllpwMLMrwGeVjskRhaBAqlQn/
        Aj+xlWMsAwAA
X-CMS-MailID: 20221011125219epcas5p22aa56f46aa326c8d643bfbb076c0062c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125219epcas5p22aa56f46aa326c8d643bfbb076c0062c
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125219epcas5p22aa56f46aa326c8d643bfbb076c0062c@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Smitha T Murthy <smitha.t@samsung.com>

Context bit is set for hardware execution if there is a buffer in
source and destination queue before calling try_run in the
init_buffers function. Now there will be a new context created and
hardware will be invoked for the buffer queued instead of waiting for
another buffer to be queued from userspace to set this context bit for
hw execution.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index ad04ec68921b..7e6fd130f7d4 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -589,6 +589,8 @@ static void s5p_mfc_handle_init_buffers(struct s5p_mfc_ctx *ctx,
 		s5p_mfc_clock_off();
 
 		wake_up(&ctx->queue);
+		if (ctx->src_queue_cnt >= 1 && ctx->dst_queue_cnt >= 1)
+			set_work_bit_irqsave(ctx);
 		s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 	} else {
 		WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
-- 
2.17.1

