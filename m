Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EA76275A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 06:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiKNFo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 00:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiKNFoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 00:44:38 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6045017581
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 21:44:37 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221114054432epoutp0326c695f71d96ce641d6193239ab7f105~nXTXXt9-20084400844epoutp03h
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:44:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221114054432epoutp0326c695f71d96ce641d6193239ab7f105~nXTXXt9-20084400844epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668404672;
        bh=TQP3DaRpHbzXzrsqLoW6MWHJLueLhqW4E9H+nL21wWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMfqL4DM9yosPFY7uGXxKPjN8niNyO+KQ8EAqqHgQiPLsoAYSPo6Eyn3zbcK1AyeH
         Ffc5QAQaLLB/ZOG3FAP4QNo9tvmbtFstrzn8YsrgcpYzXs1pV5kYOgrNHfuBiH/WRm
         bIikbk6sGao2hc2aK1aIk5zya66qukwGoAIEQn8I=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221114054432epcas5p4411f90e102372e5c1aa6213a98db1ad5~nXTWtduQZ2382523825epcas5p4C;
        Mon, 14 Nov 2022 05:44:32 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N9dY94ZRpz4x9Q2; Mon, 14 Nov
        2022 05:44:29 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.8D.56352.DB5D1736; Mon, 14 Nov 2022 14:44:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221114054044epcas5p31658120e6d653d4f56177b70f5583b2a~nXQDKzf-r2669226692epcas5p3K;
        Mon, 14 Nov 2022 05:40:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221114054044epsmtrp1cc9efd9319fe8348665d6e7a3ce78636~nXQDJZ7Rp1353813538epsmtrp1u;
        Mon, 14 Nov 2022 05:40:44 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-20-6371d5bd5052
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.A6.18644.CD4D1736; Mon, 14 Nov 2022 14:40:44 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221114054040epsmtip279ae3364db1e9da4e4ab4351ba9927f9~nXP_-IsR32101621016epsmtip2b;
        Mon, 14 Nov 2022 05:40:40 +0000 (GMT)
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
Subject: [Patch v4 1/3] media: dt-bindings: s5p-mfc: Add new compatible
 string for Exynos3250 SoC
Date:   Mon, 14 Nov 2022 11:16:53 +0530
Message-Id: <20221114054655.68090-2-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114054655.68090-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbdRTH/d17+2BSvCmv3wjDehNIIIG1W1t/KGWIYG7EJTiSbZlxWMsV
        kNJ2bVGn0wHK7MioNHMqXQdkMDC86Xh0PByPElYEFAclBjoRVF7RkOE2Hlu0paD/fc453+85
        yTm/Hxfnz7BDuNkqPaNVyZUUex/RMRgZFd07dUYhnJ6i0O+2MhaaK+9go6qNRQz9UrVOoIGb
        7RzUNnkVR7XDfSxUYR9noc7+eQK1LrmrE2UuAi1WNAG0bL7HRsalX3FkXXCy0N0uCxtdamln
        oUa7i4NuTE9gqMb6GEPX2//moKJeOwe5ejoA+uyCHUuAdEN5A6BtrmpAT1ffx+lbZheHrupZ
        xmhr3UU2PevsYdM3q8/TRUNbBG1sqwN0sX2aTa9bw+iRB+ucVN6pnLgsRp7BaAWMSqHOyFZl
        yqiUtPSX0yVSoShaFIuepwQqeS4jo5JeS41+JVvpXgEleE+uzHOnUuU6HXUwPk6rztMzgiy1
        Ti+jGE2GUiPWxOjkubo8VWaMitG/IBIKD0ncwrdysgZmCjDNHPmBM99K5IOv/IqBDxeSYtj0
        dQO7GOzj8sluAAv+qSO8wX0ALd39mDdYB7B+fpW9Z7ldZtwtdAG4dufhrqUIg4W3HXgx4HLZ
        ZDQc61R6DAFkAYALBr1Hg5MmAs4Yl3BPwZ9UwKnqyztdCTIcVreWcjxeHimD89Y3vcOehfUt
        fTtyHzIezl6dxz19IPmpD7S3zBAePSSTYL3hlFfvD1eG2zheDoHLX1zYZQVcuL6Me1kJm3u+
        JLx8BPZNWnba4GQkbO466E0fgFdGmjAP46QfLNn+DfPmedBWvscR0DK7wfJyKBysvwG8TEPz
        Rt/ufkwAVo7+hZWCMPP/IyoBqAP7GY0uN5PRSTSHVcz7/x1Noc61gp1XHpViA/NzazEDAOOC
        AQC5OBXAKw9VK/i8DPnZDxmtOl2bp2R0A0DiXp8JDwlUqN3fRKVPF4ljhWKpVCqOPSwVUcG8
        qm+iFHwyU65nchhGw2j3fBjXJyQfu3tu3Xgs3nBydcEs+GlLJoPf1tq+s2yPFNxJ3q4JrG09
        PVOa6XLEjT46kViC3o4JiugdfnEZiC8+9cnx8voVVsrCwx+STo9vd/sapB2a8U1wdviJab9t
        vJDv+1zD5oE03rsBxnc0ESWHDD0vvR7aK6oadAavZDlNhZ2VI69OrlXYkjVIdbS/uUhAG4TZ
        ti5DoHR206a6ley3cqnwkSUsbpTaDn5DkppwbtW3t/Hj88UVjd8HhSfU+T9OHCxKupe2yIeL
        l4d+fFJyNCBwKCY8qPvYHwV/+jwY0wU7w6599Izk5zNXUiZMjibT09lmh19C5Ibj5GROzedH
        jvPGErdO5OqvUYQuSy6KwrU6+b+NwdNWbgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvO6dK4XJBod7TSye7pjJavFg3jY2
        i8U/njNZ3F/8mcXi0Oat7BZbrsxmtlh+/ACrxfwj51gtth98xGKx8QVQ9uLMuywWz+evY7R4
        Oesem0Xfi4fMFpseX2O1uLxrDptFz4atrBZrj9xlt1h6/SKTxbJNf5gsFm39wm7RuvcIu8Xd
        PdsYLVrajjA5SHismbeG0WPH3SWMHteXfGL22DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R6t
        R3+xePRtWcXo0XXkOpvH501yHqe+fmYP4I3isklJzcksSy3St0vgyjh0u5Gp4IFAxbWGTSwN
        jNP4uhg5OSQETCT2z+xj6mLk4hAS2MEo0X5lKjtEQkbif9sxKFtYYuW/5+wQRc1MEh+fbGDt
        YuTgYBPQlTi7PQckLiLQyihxfWUn2CRmgZUsErc39jCBdAsLJErcevSDBcRmEVCVWLJxAjtI
        M6+ArcSjTbEQC+QlVm84wAxicwrYSdyZ/QjMFgIqmXRhBcsERr4FjAyrGCVTC4pz03OLDQuM
        8lLL9YoTc4tL89L1kvNzNzGC401LawfjnlUf9A4xMnEwHmKU4GBWEuGdJ5OfLMSbklhZlVqU
        H19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAMT18wJqd6uj7+2u3868WqK
        vljY7lk32dxuiNQ1F8ye539+dtzNiScX5/XLPN4aeFzt8NxyD9b3MrczXdfFeRdwPnonM690
        /iVR77nbxZdryphwJ+xOD9/VJ1DxyHp9uEvEtC8Ze+QX/TBQOuVnnbuxRKdtw1PvqLnWMo37
        nskZGtULXirve8upvvrR9Z8zebns3yycxzv928F6jv36wpJLjI3v5FS7rNj5ZUHsA6a4o538
        Np2p1X22XxznX7jAkCeoPSm+xMf37bOH00uPf7FfuvuMdtlG25UC83VnJ1Q7GE3g49fYbCzk
        WnqC7U5olAlzWEmxelEZW+2PQzwJXCdf2yss+yfccvS5zJyYk/uUWIozEg21mIuKEwHChY53
        JgMAAA==
X-CMS-MailID: 20221114054044epcas5p31658120e6d653d4f56177b70f5583b2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221114054044epcas5p31658120e6d653d4f56177b70f5583b2a
References: <20221114054655.68090-1-aakarsh.jain@samsung.com>
        <CGME20221114054044epcas5p31658120e6d653d4f56177b70f5583b2a@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since MFC v7 support was present for both Exynos5420 and Exynos3250
SoC with same compatible string "samsung,mfc-v7". As both SoCs
having different hardware properties and having same compatible
string for both SoCs doesn't seems to be correct.
Add new compatible for Exynos3250 SoC followed by mfc-v7 fallback
which will differentiate the node properties for both SoCs which 
support MFC v7.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 Documentation/devicetree/bindings/media/s5p-mfc.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

We are already in process of converting this txt file to yaml.
https://patchwork.kernel.org/project/linux-media/patch/20221011122516.32135-2-aakarsh.jain@samsung.com/
Modifying this txt binding for completeness.

diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
index aa54c8159d9f..9b13e8c9d040 100644
--- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
+++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
@@ -10,10 +10,12 @@ Required properties:
   - compatible : value should be either one among the following
 	(a) "samsung,mfc-v5" for MFC v5 present in Exynos4 SoCs
 	(b) "samsung,mfc-v6" for MFC v6 present in Exynos5 SoCs
-	(c) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
-	(d) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
-	(e) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
-	(f) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
+	(c) "samsung,exynos3250-mfc","samsung,mfc-v7" for MFC v7
+	     present in Exynos3250 SoC
+	(d) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
+	(e) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
+	(f) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
+	(g) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
 
   - reg : Physical base address of the IP registers and length of memory
 	  mapped region.
-- 
2.17.1

