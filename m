Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC2629104
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 05:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiKOEB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 23:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiKOEBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 23:01:24 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703CB15A38
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 20:01:19 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221115040115epoutp02715b8fc384e183c4c186057f1788adee~npieAoTJJ3196831968epoutp02_
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:01:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221115040115epoutp02715b8fc384e183c4c186057f1788adee~npieAoTJJ3196831968epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668484875;
        bh=d8Xl6EjuL+PS10RNXALSyi8Let8EDmXKT2SZQyPLmDA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=OoeuTyiuAv9Bgzt2AePPLDJM6URkaXh0Z++uBWvDqtbgC46ZgBAdCm2ovSS0uXkhs
         XREz5VGYSpwGXYxpNKlWaA4XUkOBTFhZgQksDCyUxDRxseFMTSOpcOhVJnR23xxUhv
         V1qTves+g1E4khcF0efWvrk7jH5eKAycj9Zj3AUs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221115040114epcas5p24cc22620272232357f8d6202602e8d09~npiddgC1O1038710387epcas5p21;
        Tue, 15 Nov 2022 04:01:14 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NBCCY1gX6z4x9Pt; Tue, 15 Nov
        2022 04:01:13 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.ED.56352.90F03736; Tue, 15 Nov 2022 13:01:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221114114402epcas5p31aade118059c242bd77835da5470afdb~ncNP_sYL72215322153epcas5p38;
        Mon, 14 Nov 2022 11:44:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221114114402epsmtrp1402c33dc60c117c3ec601360f4b52379~ncNP9Zmkc0315803158epsmtrp1I;
        Mon, 14 Nov 2022 11:44:02 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-10-63730f09ab4a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.E4.14392.20A22736; Mon, 14 Nov 2022 20:44:02 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221114114359epsmtip24f545f59093f0b032ad0b234b7628ba3~ncNM1cUKo1393413934epsmtip2E;
        Mon, 14 Nov 2022 11:43:59 +0000 (GMT)
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
Subject: [Patch v5 0/3] Add new compatible for Exynos3250
Date:   Mon, 14 Nov 2022 17:20:21 +0530
Message-Id: <20221114115024.69591-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTfVSTVRzuvu8+XvBM31CPN5KkFRoEuMmYdyXaUfK8YhEn//AcqkNzvAxi
        X+4dYRwLOIXmlCmpmciXfGgBogwGS7ADYwYRSiQNAlHkayw5oQw4BpFtDOq/5/c8v9/9Pee5
        9xK4TyfHl0hS6WitSqrgc7xZdS2BgSFeqxiZIEdPoFHzeTYaLKjjoJIndgzdL3GykKXGxEW1
        3RdwdLm1iY0KrbfZqL55iIWqx11q1/kBFrIXVgHkyL3HQYbxBzgyDtvY6M71PA46cc3ERles
        A1xU1tOFoUvGvzFUbJrmoqwbVi4aaKwD6IsjVuwNSFUWVALKPFAKqJ7SKZz6PneAS5U0OjDK
        WH6MQ921NXKomtJ0KuvmHIsy1JYDSm/t4VBO4wtU+4yTG8OLTd6WSEvjaa0/rZKp45NU8gj+
        3n1xu+LCxQJhiFCCtvL9VVIlHcGPfCsmZHeSwhUB3/9jqSLFRcVIGYa/efs2rTpFR/snqhld
        BJ/WxCs0Ik0oI1UyKSp5qIrWvSYUCLaEuxo/TE402CeB5qtVh5onirkZYH6FHngRkBTBvgwb
        rgfehA/ZAOD44Bm2p5gC8LvOsyxPMQtgpu0KWB6ZN9zieIQbAOb/amK7BR8yC4PFHQo9IAgO
        GQJv1Svc9BoyE8DhL3XufpzMYcF+wzjuFlaTEpj/y+ziLIsMgD+2/MNxYx4ZATOy7Lhn2QZY
        ca1p0R8kJwj408VLXI8QCU/lHl9ytBr+0Vq7xPtCx8kjS1gGh4sdSwcp4NXGMywP3gGbuvNY
        bqM4GQivXt/sof3g2fYqzI1xciXMnh/BPDwPmguW8UaYd/cJ24PXw5aKsiULFJw2zWCeHD6A
        T52T3FPAL/f/DUUAlIPnaA2jlNNMuCZMRaf+d1EytdIIFl920F4zGBp8FGoBGAEsABI4fw2v
        YL1a5sOLl36SRmvVcdoUBc1YQLgrsxzcd61M7foaKl2cUCQRiMRisUgSJhby1/FKvgmS+ZBy
        qY5OpmkNrV2ewwgv3wyM0vc+3NEbdaDo0djBkYVuMvpOV2Uw23Tg3oa1HeYH9ORfQ7qnQ45N
        jPVQiVzUFx31+ruO0iJlRerjb2teudl+7OW6TbOnVZb7xzPPRZUzO0/KF8RhR8V9rS/68lco
        33EWBnVaJ8Y74UjqQn/+55MSQazfY+Oe38dA9/73f/A+ePGlPetqX3VWR2VPXC6LDQto69ha
        bx77LMEYPHoUPDzcnO39aQxf8lFwQFWjIdiecCL6GZNt+znNnyYKL33PuOv216NzdSMzh6tl
        pp/hm7ExDc/vbks4/Zu9t7ufaN+fOT81/Xb6SiBKS7dFNnHntqA0nSXIC2WxTAvahiPDFwRt
        z+7byGcxiVJhEK5lpP8CJfgjVGIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvC6TVlGywYVnyhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzaLvxUNmi02Pr7FaXN41h82iZ8NWVou1R+6yWyy9fpHJYtmmP0wWi7Z+Ybdo3XuE3eLu
        nm2MFi1tR5gcJDzWzFvD6LHj7hJGj+tLPjF77Jx1l91j8Z6XTB6bVnWyedy5tofNY/OSeo/W
        o79YPPq2rGL06Dpync3j8yY5j1NfP7MH8EZx2aSk5mSWpRbp2yVwZfQ9f89YMIm/4uCbRewN
        jL+5uxg5OSQETCR+951l62Lk4hAS2M0ocW/TB2aIhIzE/7Zj7BC2sMTKf8/ZIYqamSQ2n+5n
        7WLk4GAT0JU4uz0HJC4i0MoocX1lJxOIwyywkkXi9sYeJpBuYQFLibkXvrGC2CwCqhLHDv9j
        A7F5BWwlGlqfQ22Tl1i94QDzBEaeBYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcx
        giNIS3MH4/ZVH/QOMTJxMB5ilOBgVhLhnSeTnyzEm5JYWZValB9fVJqTWnyIUZqDRUmc90LX
        yXghgfTEktTs1NSC1CKYLBMHp1QDk77vgv2aHyZ/kjtwz2brW8Zo5ii9Pt+iWxNOTpoRMcvD
        gZ013/vYDmPF3OCCcg+u5VoZzL0bN4feXLon+IT5sq1XIy4X5p9dkVz0PZDNcL65x/ZfV7V5
        Fq78c0bbNSX4oa98u7Xxn5D5p/zThRUaz59/fXN54atNHJrHvzSq3SneYdHB8mmpreIhb3vx
        DQcOn9Oos/SumHKQ8cDvrapBsVt9rv6/qvP94SHr6aerHV9Nldm35FFA8Jd32xR3RNfclCwK
        fbhqtns4++uyzIl7RAOYBFb0yUbvnTv7yped+579Wf2j0Lhww7OtajpRMyb9VeaNWPFD6vb8
        vYq3PU48z507jS9Bq76P0+PZrXMSE9cosRRnJBpqMRcVJwIA9YUXxA8DAAA=
X-CMS-MailID: 20221114114402epcas5p31aade118059c242bd77835da5470afdb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221114114402epcas5p31aade118059c242bd77835da5470afdb
References: <CGME20221114114402epcas5p31aade118059c242bd77835da5470afdb@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since MFC v7 support was added for Exynos5420 and Exynos3250
SoC with same compatible string "samsung,mfc-v7". As both SoCs
having different hardware properties and having same compatible
string for both SoCs doesn't seems to be correct.
Add a new compatible to differentiate the two SoC's MFC IP, at 
the same time to keep git bisect happy, add a fallback to mfc-v7
for Exynos3250.

Changes since v4:
 - Addressed review comments from Krzysztof Kozlowski.
   - Fixed syntax in commit body,dropped quotes and corrected proper
     commit title as per submitting-patches.rst.

Changes since v3:
 - Addressed review comments from Krzysztof Kozlowski.
   - Added new compatible string for Exynos3250 followed by mfc-v7 fallback.

Changes since v2:
 - Addressed review comments from Krzysztof Kozlowski.
   - Changed subject prefixes matching the subsystem.

Changes since v1:
 - Addressed review comments from Marek Szyprowski.
   - Changed subject prefix from arm64 to arm.

 - Addressed review comments from Krzysztof Kozlowski.
   - Changed subject prefixes matching the subsystem.
   - Added new compatible string for Exynos3250 followed by mfc-v7 fallback.
   - Removed checkpatch warnings from s5p_mfc.c.Sent separate patch
     series for the same.

 - Addressed review comments from Tommaso Merciai.
   - Change in commit message body from used to use in Patch-2.

Aakarsh Jain (3):
  media: dt-bindings: s5p-mfc: Add new compatible string for Exynos3250
    SoC
  media: s5p-mfc: Add variant data for MFC v7 hardware for Exynos 3250
    SoC
  ARM: dts: exynos: Add new SoC specific compatible string for
    Exynos3250 SoC

 .../devicetree/bindings/media/s5p-mfc.txt       | 10 ++++++----
 arch/arm/boot/dts/exynos3250.dtsi               |  2 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c    | 17 +++++++++++++++--
 3 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.17.1

