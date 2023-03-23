Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427E26C61C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjCWIeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjCWIdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:33:40 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56851769A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:33:33 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230323083330euoutp01ada7a16a0f4c7caac6b21f03a485fd86~O-0uD_PNR1426814268euoutp01t
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:33:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230323083330euoutp01ada7a16a0f4c7caac6b21f03a485fd86~O-0uD_PNR1426814268euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679560410;
        bh=YudGPA60bFxRDbJj3Qc3E+Wrq3F9hpMuQjBdPXmpKAo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PRhlmaiynunD/Lf64BFyTvlQ2rjTylZ2cuCD9xdli1z9wny5OOeVCn3sTS4CGk5ZU
         rAmn1sJyHuBzQ4FQoZy0zfSb4+8jkCb7bEWItJhY7BiW2cMeI5UWvsiJ21LWBZNQGQ
         DwAq0tekHwGFLHVqn8ep61VTLrVeDnzcOW7AqSt8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230323083330eucas1p19a97dfc0ce93df9ef18fa48df58faa23~O-0t2oqWn0376103761eucas1p1P;
        Thu, 23 Mar 2023 08:33:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BF.96.10014.ADE0C146; Thu, 23
        Mar 2023 08:33:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0~O-0taGy_-0377303773eucas1p1M;
        Thu, 23 Mar 2023 08:33:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230323083330eusmtrp1fd0d0ddebb0ed10535121ce630db59bf~O-0tZfgZI1498714987eusmtrp1Y;
        Thu, 23 Mar 2023 08:33:30 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-1c-641c0eda28c8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.8B.08862.ADE0C146; Thu, 23
        Mar 2023 08:33:30 +0000 (GMT)
Received: from AMDC2765.eu.corp.samsungelectronics.net (unknown
        [106.120.51.73]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230323083329eusmtip190f52998ff08829aa6a9ccae7d7e7f53~O-0s8uj8e1892518925eusmtip1O;
        Thu, 23 Mar 2023 08:33:29 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        patches@opensource.cirrus.com
Subject: [PATCH] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
Date:   Thu, 23 Mar 2023 09:33:12 +0100
Message-Id: <20230323083312.199189-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7q3+GRSDPa+lLOY+vAJm8XZZQfZ
        LL5d6WCyuLxrDpvFjPP7mCzWHrnLbvH5/X5WB3aP2Q0XWTx2zrrL7rFpVSebx/Q5/xk9+ras
        YvT4vEkugC2KyyYlNSezLLVI3y6BK+PxhI0sBd/YKk5tbGBpYPzI2sXIySEhYCJxr+klI4gt
        JLCCUWLdNI0uRi4g+wujxJurH9ghnM+MEue2zoHr6LpyAyqxnFFiybLXTBBOK5PEhI8/WECq
        2AQMJbredrGB2CICzhK3P3xjASliFjjEKLFtx012kISwgL3E3f42sAYWAVWJvg8/wQ7hFbCT
        +DHvHzPEOnmJ/QfPMkPEBSVOznwCVs8MFG/eOpsZZKiEwFIOiffnvgBt4wByXCROfBOE6BWW
        eHV8CzuELSNxenIPC0R9O6PEgt/3mSCcCYwSDc9vMUJUWUvcOfcLbBCzgKbE+l36EGFHicNd
        i5gh5vNJ3HgrCHEDn8SkbdOhwrwSHW1CENVqErOOr4Nbe/DCJahXPCSePZzKAgnrWInHu9vZ
        JjAqzELy2Swkn81CuGEBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwLRz+t/xrzsY
        V7z6qHeIkYmDERjIHMxKIrxuzBIpQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmkJ5ak
        ZqemFqQWwWSZODilGpiW+MzSO/RYSiVpwqPpB9de9Hno/PSh1cK3QR+v8m23Dlf4EvBHNOoh
        9+Lj2z/e5LoeOzOkK1Gs+a/vXT1Gycxfpy9ph+mEv9JjKlZeesjqAe/GWQ5qHOt7xZe5iP4I
        8or8tlJ6u4jrstkW26z0azdraOk93+b2/vrz/5NUwrcFmydnfwxbqrHTfqrT5NpdcYcvRxuV
        fVDU8lfON70ceLCIi+NoYrt02Otzuyf+y67kCbh8QdfeJSIiZQVfeU9JfbCAWnGE08VS1vaO
        iGansg1isxjZDgRNUjbPdwlas0LG1y3n1zddE/tkLZ39sTcWpd7K3BOffaUqtd197Q3HxXyx
        wR8/c70/+3jKnm3OvEosxRmJhlrMRcWJANuPX5WqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t/xu7q3+GRSDPoeMVtMffiEzeLssoNs
        Ft+udDBZXN41h81ixvl9TBZrj9xlt/j8fj+rA7vH7IaLLB47Z91l99i0qpPNY/qc/4wefVtW
        MXp83iQXwBalZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl/F4wkaWgm9sFac2NrA0MH5k7WLk5JAQMJHounKDvYuRi0NIYCmjxM7OG0wQCRmJk9Ma
        oIqEJf5c62KDKGpmknhy8BMjSIJNwFCi6y1IgpNDRMBVovXLDxaQImaBY4wSt5e9AOsWFrCX
        uNvfxgJiswioSvR9+AnWzCtgJ/Fj3j9miA3yEvsPnmWGiAtKnJz5BKyeGSjevHU28wRGvllI
        UrOQpBYwMq1iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIDPhtx35u3sE479VHvUOMTByMhxgl
        OJiVRHjdmCVShHhTEiurUovy44tKc1KLDzGaAt03kVlKNDkfGHN5JfGGZgamhiZmlgamlmbG
        SuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M8vv4s1ZXCd9nYTPbb28Uu+fwDKXc3EWhy0J2
        G0Y9W9j9hu/1e6sooZm96YIz+OZuubJf4/D9QqOS6acFs52enPRX6fr2Ref4qq4Z85hCzRmt
        Uidus99jFPW5XKO3STCUeZ1Jws0pswNkawJVb4nXvZhi8+zjHp51F9s2aswIT9Ge9NK98op3
        V2Rx342c0gWP29k3fn5w1kI/w3bat/R3V1O2NpjcPrxAc82bzRxzmT8nZPA3zU6791fuU8jM
        6XuWPFUy317RVlf16Z7YbeMd1ta1p3KyGTYkum35d/m1Q93lcobP0y9sV9ZamZsaeeram07J
        ij9v/theeeAwfdODl+mMKROW77zGrjpVlakqQYmlOCPRUIu5qDgRAICrdyIBAwAA
X-CMS-MailID: 20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0
References: <CGME20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0@eucas1p1.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore synchronous probing for wm8994 regulators because otherwise the
sound device is never initialized on Exynos5250-based Arndale board.

Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/wm8994-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index 8921051a00e9..2946db448aec 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -227,7 +227,7 @@ static struct platform_driver wm8994_ldo_driver = {
 	.probe = wm8994_ldo_probe,
 	.driver		= {
 		.name	= "wm8994-ldo",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 
-- 
2.34.1

