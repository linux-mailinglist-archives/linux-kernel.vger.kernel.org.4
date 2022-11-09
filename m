Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522156222D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKIDuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiKIDtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:49:51 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDAF15A02
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:49:50 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221109034948epoutp01a7a277841fa34041967691e7cb10abaa~lzgw3oCNv0516505165epoutp01V
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:49:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221109034948epoutp01a7a277841fa34041967691e7cb10abaa~lzgw3oCNv0516505165epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667965788;
        bh=FtNonu142mw8UcQV9QErqFMq965U9ZP4d9RK4tcsloo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d93l2GjHL2Y83nrqIaOcQg27A1SEK+oQ0XqqhHXNqTw+IcoafmpzkNjMK6jS5jxUJ
         44Uv5DQpLoAI2NoMeUsonh8V4ojIhixcjdq8ApnzXYJnq+5isQVbzmHY4SgFr/5uk0
         J4OPsjUdG88+jHYxB6TChH1MrO/WBzJ4jhqZpAGw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221109034947epcas5p47b7c3c4a6990d77c4fc9285d618d6db3~lzgwAozRx0918409184epcas5p4O;
        Wed,  9 Nov 2022 03:49:47 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4N6WF54W0Bz4x9Pp; Wed,  9 Nov
        2022 03:49:45 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.0A.01710.9532B636; Wed,  9 Nov 2022 12:49:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221109034807epcas5p2eae5872bb8fb3e970c1bade98dd171c5~lzfSES6q12343923439epcas5p2k;
        Wed,  9 Nov 2022 03:48:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221109034807epsmtrp1917e77c1d9ca089a967bc2ce185e4d4c~lzfSDJ_i31103811038epsmtrp1_;
        Wed,  9 Nov 2022 03:48:07 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-e3-636b2359687f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.AF.14392.6F22B636; Wed,  9 Nov 2022 12:48:06 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221109034803epsmtip125c02760fc78da77fa3a1cb17e081af3~lzfOeoH4W0103001030epsmtip17;
        Wed,  9 Nov 2022 03:48:03 +0000 (GMT)
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
Subject: [Patch v2 2/3] media: s5p-mfc:Add variant data for MFC v7 hardware
 for Exynos 3250 SoC
Date:   Wed,  9 Nov 2022 09:25:06 +0530
Message-Id: <20221109035507.69086-2-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109035507.69086-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe0xbVRz23NveXmaKN7DHGbKNdE6ECGuxsMNSHosTL+qUOJ3DxdS7cuXR
        0tY+hm5RYRndJAypcYYyBqQFnBQotsA6BpFHJwsRzDqEbFIesglMpzwcMqfRlhb97/v9vu87
        v8c5h8RDPEQYmavUsRoloxAQGzgd/VFRMZk75TJhqUGA7jhNXDRV3UEgy+oshiYtyxzU52jn
        obaR8zj6YqCHi2pcw1x0qfdHDvpqzsteN3k4aLamBaD5ygkClc1N48g+M8pFNzqrCFTa2s5F
        zS4PD9WPXcdQg/0vDJnbf+eh4m4XD3m6OgA6ZXBhqZBuqm4CtNNTB+ixuiWcvlzp4dGWrnmM
        tjd+TNDjo10E7aj7iC6++ieHLmtrBHSJa4ygl+3b6cH7y7wM/ptySQ7LZLGaCFYpU2XlKrOT
        BC8elD4rjU8QimJEiWiPIELJ5LNJgv0vZcSk5Sq8KxBEHGMUem8qg9FqBbuTJRqVXsdG5Ki0
        uiQBq85SqMXqWC2Tr9Urs2OVrG6vSCiMi/cK35bnuMeHeOru4PfazQ6sEPz6aAkIIiElhoYr
        A1gJ2ECGUFcAvDu5yPEHSwBa3c0BZgXAz/94gK1bar5xAT/RDeCXD67h/qAYg6bSFS9DkgQV
        A4cuKXyGjVQRgDNndD4NThk58IeyOdxHhFIMLLp2j+PDHGoXdBrLCB/mU0mwdOV7nr/aDmht
        7VnTB1HJcOB+H+E7CFL/kNB60477RfvhaYuV48eh8O5AW8AcBuc/MQSwDM6Y5wN6BbR1fRbQ
        p8CekSqOr2mcioK2zt3+9DZ4brBlbWKcCoZnH94OTM+Hzup1/CSsGl/l+nE47LfWAz+mof1M
        dWCPRgBNqxasHGyv/L9ELQCNYCur1uZns9p4tUjJFvx3bTJVvh2svfPodCfwTC3E9gGMBH0A
        krhgI7+pJU8Wws9i3j/OalRSjV7BavtAvHeBRjxsk0zl/ShKnVQkThSKExISxInPJIgEW/iW
        imhZCJXN6Fg5y6pZzboPI4PCCjGiQqx2n2vYN3tx88uvhMcIX1VHPv+I2KE/u2P/BYmnwBI3
        RQ+hnXKuLerW1/HW1/NC63B2umjLz4PvmqUdrpapbFH5yp3Mm4vh5N/lbdteO2BrmLDhObxM
        5rD+8ar6YHdJx6fOE98aCzUt5uTT0ydUm154qtzcu68yLeO8CU0mNuve2VU7fGghUng4/bJQ
        KmvE+9PTTWScIuXG0XBJcG/B0XGnYXNIysOTbzw26q4a7zfmHThmi0w1SEK3rqSOwcbhiZOO
        4xdvf3D1LVvXSNvT8qIPl2rdC7+0SioqF5U/ZR18rnjv6Nw9VeKR5YwLR/Y8YfzuFAt+O+Tg
        paWUTnfeEioFHG0OI4rGNVrmXwONBr1wBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG+59zds7R2Dhtk/6uMhgUJLiUgv6JdsE+HKGw+mBa5Bp2UMvp
        2nKZQVpelkO2zAhnpaGzcJpt06nVUpur7GJ4yYbluptKV/NSiWgu69vveZ735X3gpXFhCSGh
        U9KOcuo0RaqU9CeaOqRBIVPSw4mhuq5wNNRi4qE35U0kqvo1jKHXVeMEcjU4KNT47CKOrj1o
        56EK91Mear77jkC2kfm0x+Ql0HBFPUCjZa9IZBh5iyP7++c81HfrEomKrA4euu72Uqja04Oh
        q/YZDFU6JiiUf8dNIa+zCaC8Aje2BbJ15XWAbfGaAesx/8DZm2Veiq1yjmKs3VJIsoPPnSTb
        YM5m8+9NE6yh0QJYvdtDsuP2IPbR5Di1k7/XP+Igl5qi5dRrNx3wT+4d7KJUdwSZjsoGLAd8
        XawHfjRk1sOK+27gYyFzG8D+3G0L/nI4V3CfWmARrJkdnmf/+ZlcDD7RO0k9oGmSCYFdzak+
        X8zkA+ipKcR8AmdqCPjSVoT5tkWMHJ6f+vyXCWYVbCk2kD7mM5GwaKr/34WVsNbajvvYj9kE
        H0y6yIVGkTDvtJM6CwRXwCILCORUGmWSUhOmCkvjjsk0CqUmIy1JlpiutIO/fwte0wKaLd9l
        LoDRwAUgjUvF/Lr6Q4lC/kHF8SxOnS5XZ6RyGhdYRhPSpfxu/UO5kElSHOUOc5yKU/9PMdpP
        koO1aQvFy6Tix2OsNr4aZG5lHkr4ip4BgentSZ0j7tPa5O6JLS+1/R3B2lmd7mN1VLlYE5E9
        WPzlw2iskAuIi7JYXmAqa21r4yPPZQk/bLXx3ZpmaIxpfXwqBt1+wYgGtw6kZwT+xD4KPneG
        bPeesJETR1I6Q0urlvQHbdSVJgQzu8+Etuvavw3BPYK5Bq81PKpCmZtsyrfdkv8cqL0hu26I
        7YsU9B7fkVW3qOB3NmH0BogM5oFp4/Is54fYoZiAfaJz2TegLEO2IsH4ZfP7yG7cfK7k/Gx8
        ycgxWh5lbI2WSHZ1bqg2RLdFr9tYsj9g7LQsvMeUXnzh4kxcU5GU0CQrwoJxtUbxB2Icqh8m
        AwAA
X-CMS-MailID: 20221109034807epcas5p2eae5872bb8fb3e970c1bade98dd171c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221109034807epcas5p2eae5872bb8fb3e970c1bade98dd171c5
References: <20221109035507.69086-1-aakarsh.jain@samsung.com>
        <CGME20221109034807epcas5p2eae5872bb8fb3e970c1bade98dd171c5@epcas5p2.samsung.com>
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

