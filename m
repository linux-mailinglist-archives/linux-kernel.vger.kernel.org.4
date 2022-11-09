Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856746222D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKIDuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiKIDtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:49:50 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF76817066
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:49:48 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221109034947epoutp022f30b902f9d56dbfa710424e36f81951~lzgvWh5gE1987319873epoutp02M
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:49:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221109034947epoutp022f30b902f9d56dbfa710424e36f81951~lzgvWh5gE1987319873epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667965787;
        bh=rlp+qXaLAX0ZIbta6kqClM45VmPJd4TFz1poBktpQjo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FI8YmAU6tTVu5FPWLjwRQdHNKHXrFs+gP8Gxb7HjccJCSOhPGKCllIZ7sLryPVO4Q
         j9MfECZQOf30REWWKc22ZLvRJV20ndDmQNcgqkuxwbY9PnOdl7eXN+U8srsykFQOcy
         RSH/8PoBLuKu9aGzZqDvSHBaZ4pwxwC51ZGe449E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221109034946epcas5p457727ccf4b42f12a3d1fea68d6f99d98~lzguMXbbQ0918409184epcas5p4L;
        Wed,  9 Nov 2022 03:49:46 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N6WF22wNKz4x9Q0; Wed,  9 Nov
        2022 03:49:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.84.39477.5532B636; Wed,  9 Nov 2022 12:49:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221109034803epcas5p26644fa402ff1837754b61c1a307b2bb8~lzfObbFFO1703417034epcas5p2r;
        Wed,  9 Nov 2022 03:48:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221109034803epsmtrp1f925d26956cf3fe42d690b9a864ed454~lzfOaB74x1103811038epsmtrp11;
        Wed,  9 Nov 2022 03:48:03 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-7a-636b2355cf0b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.AF.14392.2F22B636; Wed,  9 Nov 2022 12:48:03 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221109034759epsmtip1d7f61366e0e9d1b617963c7ee10c8ab8~lzfK7GFxD0213402134epsmtip1p;
        Wed,  9 Nov 2022 03:47:59 +0000 (GMT)
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
Subject: [Patch v2 1/3] arm: exynos: Add new compatible string for
 Exynos3250 SoC.
Date:   Wed,  9 Nov 2022 09:25:05 +0530
Message-Id: <20221109035507.69086-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTbVBUVRjHO/fevbvYrN2Q7LCh4kUoGBZYW9bDywoO6NwJMpywSc2hdbkC
        7Wu7S0Z9iCZBAkRRVAQC40VmAFdcWVgNEpctjBFmiB12Rt2CIGUtJgVD05J2uVLffud5/v/z
        POc55whw/yFSJMjTmliDVqGmyRVE90D4a+KdISplzKg7Ev1qO81DE/XdJGp6dAdDPzfNE8h+
        0cpHXc5aHLUO9vNQg2OEh3qu/kKgCzPe7OhpN4HuNJgB8tT8RKKKmUkcWabGeWjsch2Jyjut
        PHTO4eajFtcohs5a/sZQo/UBHxX1OfjI3dsN0MFiB5YMmY76DsDY3M2AcTXP4cylGjefaer1
        YIyl7UuSuTXeSzIXmz9jir57TDAVXW2AKXW4SGbespYZ+nOenyHcrUrMZRXZrCGY1Sp12Xna
        HDmd9nZWSlasLEYilsShTXSwVqFh5XRqeoZ4W57aOwI6+COFOt8bylAYjXT05kSDLt/EBufq
        jCY5zeqz1XqpPsqo0BjztTlRWtYUL4mJ2RjrFb6vyh28vVd/lvrY87CDKAQeYSnwE0BKCmtv
        jPB87E99A2DZIigFK7w8B+D3zlM8brEA4LXffiCWHYt9Yxjn6ANw4GESJyrC4PR8mdcuEJCU
        GA73qH2aAOpzAKdKTD4NTlUS8GbFDO5LrKIyodN1nfTpCSoUTphDfCik5PBJz1au1DrY3tmP
        +6yQmhbAxwv9hE8DqVToahZxmlXw7mAXn2MR9BwpfsZKONXowTlWw/O9Vc/aT4L9zrqlbXAq
        HJ6/HM2F18ATQ+alU+HUSnj4yTTGxYXQVr/MYbDu1iMex0FwoL0FcMzAHnMNwU1kL/y98xw4
        CtbU/F/hDABtIJDVGzU5rDFWv1HLHvjvjpQ6jQUsPeqIN2xgcuJelB1gAmAHUIDTAcIO8wdK
        f2G2ouAT1qDLMuSrWaMdxHoHVomLXlLqvL9Ca8qSSONipDKZTBr3ukxCvyxsqo5Q+lM5ChOr
        Ylk9a1j2YQI/USF2nElKj33VWh+UOl1uVbXcTe9tiQyyb3BQi2nkWHL8V1V/iehvHSl2oNqK
        RU0WdWZ2tP44Zq6IG55fN7GYt/mF62f2H2vOTFm9e+5C4bV7hYee7gke2bX+VOA+kaZyKlIS
        INt1cv/Oq4HSL5wiS1/8lZM23U0qYVv0yvKFVuNCbeOW0NmCUMfq7WK/6RuV1amJdIp1/aHD
        zw233591vvPPiaPmkq9v246NOoqHC8Ou7JmMzHsxet39t/7QXGog39W5XCHhUzs0QHxkw6eN
        tXIyfnaTIzQh7T0xfCpPqkp9wJtdu6/gOJMw+PwrI/qC5KCSkR0fytJ0irLxOl31QcObBzq3
        h9GEMVchicANRsW/9w7DbV0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnO5npexkg0O/GS2e7pjJavFg3jY2
        i8U/njNZ3F/8mcXi0Oat7BZbrsxmtlh+/ACrxfwj51gtth98xGKx8QVQ9uLMuywWz+evY7R4
        Oesem0Xfi4fMFpseX2O1uLxrDptFz4atrBZrj9xlt1h6/SKTxbJNf5gsFm39wm7RuvcIu8Xd
        PdsYLVrajjA5SHismbeG0WPH3SWMHteXfGL22DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R6t
        R3+xePRtWcXo0XXkOpvH501yHqe+fmYP4I3isklJzcksSy3St0vgyjj+LLZgmUDFy+9rWBoY
        X/J2MXJySAiYSPzfe5mpi5GLQ0hgN6PEl1XX2SESMhL/245B2cISK/89B7OFBJqZJE6dcOhi
        5OBgE9CVOLs9B6RXRKCVUeL6yk6wQcwCK1kkbm/sYQJpEBYIknj86yEjSAOLgKrEg3XKICav
        gK3E7+2uEOPlJVZvOMA8gZFnASPDKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4MjR
        0tzBuH3VB71DjEwcjIcYJTiYlUR416zLShbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQ
        QHpiSWp2ampBahFMlomDU6qBqX/Wu/Y+jT1JG7tut0+6f/yDX499rtD/9W9a8uJ1JfNeHbs5
        71O15Pl7T5QcXipONPA11PQqydvpy9dT/1nf/L5KBF/mp8X3TNgt3l5PaFm2SUX9lIiRU+w6
        /VXscYc/93yw3qRhtOt+ucjfvMOfZ+t8+tOz5aJa3f6ja695L32/Q+6O59sdGWXz1oT1v97w
        hbNV3VVJ6UGKdpXmq5crn29m2/Lt+4EjLItrnyhvYr1jKf+XLy3p9h69r9UScb5x+nteTT21
        /HzK7t59x0pVH73zMdRMfl38xvGubZDrMbM6pzuBDgfOXtKWd6hKnOi8LrT4Jy8P54VLnsL3
        574FpjXGZ345j/NjtI1mXEltVGIpzkg01GIuKk4EAECCGZcLAwAA
X-CMS-MailID: 20221109034803epcas5p26644fa402ff1837754b61c1a307b2bb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221109034803epcas5p26644fa402ff1837754b61c1a307b2bb8
References: <CGME20221109034803epcas5p26644fa402ff1837754b61c1a307b2bb8@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since,MFC v7 support was added for Exynos5420 and Exynos
3250 SoC with same compatible string "samsung,mfc-v7".As
both SoCs having different hardware properties and having
same compatible string for both SoCs doesn't seems to be correct.
New compatible is added for Exynos3250 SOC which will
differentiate the node properties for both SoCs which
support MFC v7.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 Documentation/devicetree/bindings/media/s5p-mfc.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

We are already in process of converting this txt file to yaml.
https://patchwork.kernel.org/project/linux-media/patch/20221011122516.32135-2-aakarsh.jain@samsung.com/
Modifying this txt binding for completeness.

diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
index aa54c8159d9f..cb166654fa81 100644
--- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
+++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
@@ -10,10 +10,11 @@ Required properties:
   - compatible : value should be either one among the following
 	(a) "samsung,mfc-v5" for MFC v5 present in Exynos4 SoCs
 	(b) "samsung,mfc-v6" for MFC v6 present in Exynos5 SoCs
-	(c) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
-	(d) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
-	(e) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
-	(f) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
+	(c) "samsung,exynos3250-mfc" for MFC v7 present in Exynos3250 SoC
+	(d) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
+	(e) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
+	(f) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
+	(g) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
 
   - reg : Physical base address of the IP registers and length of memory
 	  mapped region.
-- 
2.17.1

