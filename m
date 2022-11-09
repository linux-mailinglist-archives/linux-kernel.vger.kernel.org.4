Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4D6222CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiKIDt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiKIDts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:49:48 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845CE167E2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:49:45 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221109034943epoutp01bca6aecb7d6ac3493507e6cdabf3f671~lzgrcTJtM0405404054epoutp015
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:49:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221109034943epoutp01bca6aecb7d6ac3493507e6cdabf3f671~lzgrcTJtM0405404054epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667965783;
        bh=GkhT6RY6YD4XjFuK0VX93E/Md1fw2SF4cPwN2Vx5Qzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UnNr4vwLq780+oxjduuK2CEmEAHlYu1KndBip9tjcTCRJ/swZe3SXWiQPygxCFGjB
         UBCNjXEghDGyjyuJ+PmcosgGDKbBiSYfqjJHWgRCN3WFjo9WfIpwxEXU/xpE1OyYou
         BRdfm2xFTkpGImVs4Clm057I5br8zkQmV3w4HLPs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221109034941epcas5p11c5fa83092159838158fe7a3fc0f0c0d~lzgqVcwy30819608196epcas5p1z;
        Wed,  9 Nov 2022 03:49:41 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N6WDz2g4gz4x9Pv; Wed,  9 Nov
        2022 03:49:39 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.84.39477.3532B636; Wed,  9 Nov 2022 12:49:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221109034707epcas5p10df6f7f537faa31309060e9409809ef3~lzeaQgZEN2328123281epcas5p1K;
        Wed,  9 Nov 2022 03:47:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221109034707epsmtrp26a449a64134bd3ee59c941822b46a525~lzeaPaUuG1829318293epsmtrp2h;
        Wed,  9 Nov 2022 03:47:07 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-74-636b235383a3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.9F.14392.AB22B636; Wed,  9 Nov 2022 12:47:07 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221109034703epsmtip137ca0d7cb0ffd5c6d3ee9503e2cc1ac2~lzeWnblP30103001030epsmtip1w;
        Wed,  9 Nov 2022 03:47:03 +0000 (GMT)
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
Subject: [PATCH 3/3] media: s5p-mfc: Optimisation of code to remove error
 message
Date:   Wed,  9 Nov 2022 09:23:48 +0530
Message-Id: <20221109035348.69026-3-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109035348.69026-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfUxTVxjGc+69vS1uxTuUeMY27cpgEwO0UsqBADolepkzw6EZM1ngrtzw
        0dJ2bWGM/SEkfIchXcRMIOUbIyBC+WbF8TVBNzVQLAmjFYQJuE2MyCTKPloK23+/93nfJ+fJ
        e87h4W4zpAcvSaljNUpGISR3EF3D+9/zjfaUy0SG66+hX3sucdCsoYtEteuLGLpfu0qgofZO
        LuqYLMfR5dEBDqocucNB3YMPCNS2ZO+OX7ISaLGyBaDlMhuJipfmcGSct3CQua+CREWtnRx0
        dcTKRfVT4xhqMG5gqKbzGRfl9I9wkdXUBVB27gh2GNLNhmZA91jrAD1V9xSne8usXLrWtIzR
        xsYCkp6xmEi6ve4cnfPjC4Iu7mgEdOHIFEmvGvfSt9ZWuVH8s/LQRJaJZzUCVilTxScpE8KE
        J6Jjj8YGSkViX3EwChIKlEwKGyaM+DDK91iSwr4CoSCNUaTapShGqxX6h4dqVKk6VpCo0urC
        hKw6XqGWqP20TIo2VZngp2R1IWKR6GCgfTBOnli91oKpW3npeQ3d3ExQzy0ELjxISWDlxjTp
        YDfqewArbB8Vgh12fgrgmKGN4yz+BLD6p4vktmN5op9wNvoBtNS95DqLHAw+L7qPFQIej6R8
        4e1uhcOwm8oCcD5f55jBKT0Bfylewh2NXVQ0/Nl2l3AwQXnB0cu/cxzMp8Kgvrl1K98+2NQ6
        sDnvQoXDrO6uzcMg9Q8PLk6sA+dQBOy9sbIVbxd8NNqxZfaAq4/7t3QZnK9Zxp2sgNdMFwgn
        H4IDkxWEIzRO7YfX+vyd8luw9FYL5mCccoXfvFzAnDof9hi22RtWzKxznPwmHG6q34pDQ/Ns
        M3AuRQ/gxHoeXgL2lv1/RBUAjeB1Vq1NSWC1geqDSvbL/25Npkoxgs1n7vNBD5ibfeI3BDAe
        GAKQhwt385tbkmVu/HjmqwxWo4rVpCpY7RAItC9Qj3u4y1T2f6LUxYolwSKJVCqVBAdIxcI9
        /NrvfGRuVAKjY+Usq2Y12z6M5+KRiamy186EdPzmP+Yqzf/kjYiHVz5dPCAvbfxB59W5EPr3
        Um2Rq6/t/KMOS8RGFnYv7nB56de5cXH68I+DLvxhHUyLOyPpbnzn/ZM79xy1cCbTcsbyJJk+
        9RdzXAtWwbsZO8vlVdXJAcnebuPV+8zHbyadNZbePCdo6OzRa83LR942DV8djImOUQS2zfNL
        nv0V2h8TIu6tN60w7l9kfl4yZitIFQRlfvu88npVDWw4lv1iRT39WeRdfCL/vGede9D5pvjH
        Xqdt3k9Octsllju4WZBxinpwJYQ4zjkkGhgKOD39anrMvcjIVvOpA6/wbRvRXWm3TywYxmxV
        hvS5G338h+VH3D1zhYQ2kRH74Bot8y/1n1b6bwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnO5upexkg9/fmCye7pjJavFg3jY2
        i8U/njNZ3F/8mcXi0Oat7BZbrsxmtlh+/ACrxfwj51gtth98xGKx8QVQ9uLMuywWz+evY7R4
        Oesem0Xfi4fMFpseX2O1uLxrDptFz4atrBZrj9xlt1h6/SKTxbJNf5gsFm39wm7RuvcIu8Xd
        PdsYLVrajjA5SHismbeG0WPH3SWMHteXfGL22DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R6t
        R3+xePRtWcXo0XXkOpvH501yHqe+fmYP4I3isklJzcksSy3St0vgylj4dR1TwQaOivZl29kb
        GJeydzFyckgImEi8vLSXpYuRi0NIYDejxIujs5ggEjIS/9uOQRUJS6z895wdoqiZSeLz179A
        RRwcbAK6Eme354DERQRaGSWur+xkAnGYBVaySNze2AM2SVggUGL3l8OsIDaLgKrE8eVvwGxe
        AVuJiWs2QG2Ql1i94QAziM0pYCfRuH0bWFwIqGbXwUusExj5FjAyrGKUTC0ozk3PLTYsMMxL
        LdcrTswtLs1L10vOz93ECI44Lc0djNtXfdA7xMjEwXiIUYKDWUmEd826rGQh3pTEyqrUovz4
        otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamFYWPzix7CxvXc3X2+Lbjm2y
        C26YMEFBwkH2+1YJO954yykHt6uv2Rpa+rK56tC5rnjneI1XDHsUSh5q5Ku9rMjhM4h/Zbs0
        XepalYbW2VM34tj5Mv235YotPz6tsEhU6Owjvluat091ePG7P1FLlPH/NM9EZNrnxQJOjxxl
        36zfteZcas38jMYZO1yEyudnuf9pai3ZueQxA8vMP1v/CwXxNoaFbLD52mzvFc8SfDqPIzDJ
        rEG9LzjasTTx3gK3iyZdXdwnDEuyfJe9n/ZM5sN69nWzpzBwbH+4lj050GPCBdXaG5Kn1gkY
        23cWLs2YZfS/T8XR3++92++GKRkRCmeOv3453W9qqPfj/hvOSizFGYmGWsxFxYkAnZRJ6CcD
        AAA=
X-CMS-MailID: 20221109034707epcas5p10df6f7f537faa31309060e9409809ef3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221109034707epcas5p10df6f7f537faa31309060e9409809ef3
References: <20221109035348.69026-1-aakarsh.jain@samsung.com>
        <CGME20221109034707epcas5p10df6f7f537faa31309060e9409809ef3@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Already error number provision is present for block failing, while 
requesting for DMA consistent memory allocation.
So removing error message line from the block as recommended
by scripts/checkpatch.pl.

Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index e857f974bb98..19a9b54ff761 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1164,7 +1164,6 @@ static int s5p_mfc_configure_2port_memory(struct s5p_mfc_dev *mfc_dev)
 	bank2_virt = dma_alloc_coherent(mfc_dev->mem_dev[BANK_R_CTX],
 				       align_size, &bank2_dma_addr, GFP_KERNEL);
 	if (!bank2_virt) {
-		mfc_err("Allocating bank2 base failed\n");
 		s5p_mfc_release_firmware(mfc_dev);
 		device_unregister(mfc_dev->mem_dev[BANK_R_CTX]);
 		device_unregister(mfc_dev->mem_dev[BANK_L_CTX]);
-- 
2.17.1

