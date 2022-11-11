Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07E36252A0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiKKEeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbiKKEeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:34:12 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5033C6E5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:34:10 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221111043407epoutp029b664eba83bfa6c1afbe896d5da98db5~mbaBmyrxl1356313563epoutp02D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:34:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221111043407epoutp029b664eba83bfa6c1afbe896d5da98db5~mbaBmyrxl1356313563epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668141247;
        bh=rlp+qXaLAX0ZIbta6kqClM45VmPJd4TFz1poBktpQjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8Z7o6Wt4JP8nZwCDFgOztRiT3zPCsIIFMz88ulTooPXFctAgKYJFD3dHWVU0x6OY
         YK/vmh+aldTatLZoC3VN2GW8cwyePne+vGApyV9OZLLQEVxHEMUWCKsROjF4mx7QFQ
         FrQXd4d+pIgz6iYM0tEApqo3zrhVCTQbSxoAG1ns=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221111043406epcas5p1699317108e48da8bbbef0c50d8a838ab~mbaA4RNpu2678526785epcas5p1y;
        Fri, 11 Nov 2022 04:34:06 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4N7m7J4Ll6z4x9Q0; Fri, 11 Nov
        2022 04:34:04 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.58.01710.AB0DD636; Fri, 11 Nov 2022 13:34:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221111031711epcas5p45191dacb108498b920e5cf876f9d0c16~maW2NANnn0949709497epcas5p42;
        Fri, 11 Nov 2022 03:17:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221111031711epsmtrp232cffed872e16fdcb29f07fdec48dfcd~maW2L5_dT1692316923epsmtrp2E;
        Fri, 11 Nov 2022 03:17:11 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-76-636dd0badd95
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.92.14392.6BEBD636; Fri, 11 Nov 2022 12:17:11 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221111031707epsmtip1898dbd38ddc9d5a8041dfa3eef9122bb~maWzDTrSi2155921559epsmtip1K;
        Fri, 11 Nov 2022 03:17:07 +0000 (GMT)
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
Subject: [Patch v3 1/3] media: dt-bindings: s5p-mfc: Add new compatible
 string for Exynos3250 SoC.
Date:   Fri, 11 Nov 2022 08:53:35 +0530
Message-Id: <20221111032337.79219-2-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111032337.79219-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHd+69vS2PmhuQ7Yyhq42gshVabLsDWl2CLtdsbDC3LHEzrGnv
        APtMW2SDPwQBp2RjYthQ5KG8UytIoaVjMBCKGJNNyYhkQBVkA7qA2XiPEVxL6/bf5/c9398j
        v3MOBw8ZI8M5GVoTY9DK1XwykLD379sj6HygUQgHGneg3x1XWGiiyk6i2rUZDD2uXSRQX5uN
        jdqHr+KocbCXhaqdP7NQx+0nBGqd9ZwOXXERaKa6GSB3+SMSFc9O4sg69ZCFfumsINFXt2ws
        dNPpYqP6kSEMNVg3MFRjW2Kjwm4nG7m67AAVnHNib0LaUmUBtMNVB+iRugWc/r7cxaZru9wY
        bTVfIOnxh10k3VZ3hi4cWCfo4nYzoIucIyS9aN1J31teZCdzT6gOpjNyJWPgMVqFTpmhTZPx
        3z6empgqkQpFAlE8eoPP08o1jIx/5J1kwVsZas8K+LzTcnWmR0qWG4382EMHDbpME8NL1xlN
        Mj6jV6r1Yn2MUa4xZmrTYrSMKUEkFMZJPMZPVemD0yf1DdTn7lULkQvc3CIQwIGUGH5nb2EV
        gUBOCPUDgM25bn+wAOA3649xX7ACYKUzH3+eYq7uBr6DbgDL5qyYLyjE4Lzd7HFxOCQlgD91
        qL0J26k8AKfOm7wenCoh4Fjx7FalUEoJm66OYV4/QUXCifEPvDKXksHRiw5/s1fhjVu9WxxA
        HYITjS2Etw6knnHg9a5Gls90BE52lrJ9HAr/GGz3czhcfNpN+lgBp2rc/qJq2NJVSvj4MOwd
        riC8M+DUPtjSGeuTd8Bv7zVjXsapbfDrf37DfDoXOqqecxSsGF/zjxAB+2/UAx/TsDJv2r+T
        EgDv2mysi2Bn+f8trgFgBi8zeqMmjTFK9CItk/XfpSl0GivYeuXRxxzANfFnTB/AOKAPQA7O
        384N2qtShHCV8i+yGYMu1ZCpZox9QOLZXwkeHqbQeb6J1pQqEscLxVKpVBy/Xyriv8StvRyt
        CKHS5CZGxTB6xvA8D+MEhOdi9UD37ERrpzDpZtbG/IP8ggL5ub1j2Ztn13+N78GTLnXkNCyf
        1w5dyPqoNuXDv+8Mr/KbxwRNS5t/XW9duuv48rAw6nXr2fDI/GMxqqKkpRSJ5lThuyiRWh0v
        aorYLazPyw96bYWHD22Mnvpx4uPL7zctkMo+itllkTTk2+8YmGCxZb5xV8qLL2gSJksLrvFi
        01x7ZG0hJ+1P2f2J2Z/1tNi613ZXJgHuQNm4ILBmuidoebQ14UD85nuvRJnKYFxxcFhYpD44
        QmZRBc3tx2bESdvuN8Q9IqZzFGHS2wfmZ4rnjj5hxKejPhGQoRuu+1m9pfD4ytGBsqiBnNbE
        M+YeB58wpstF0bjBKP8XXYgh+G4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnO72fbnJBhcPMlo83TGT1eLBvG1s
        Fot/PGeyuL/4M4vFoc1b2S22XJnNbLH8+AFWi/lHzrFabD/4iMVi4wug7MWZd1ksns9fx2jx
        ctY9Nou+Fw+ZLTY9vsZqcXnXHDaLng1bWS3WHrnLbrH0+kUmi2Wb/jBZLNr6hd2ide8Rdou7
        e7YxWrS0HWFykPBYM28No8eOu0sYPa4v+cTssXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j1a
        j/5i8ejbsorRo+vIdTaPz5vkPE59/cwewBvFZZOSmpNZllqkb5fAlXH8WWzBMoGKl9/XsDQw
        vuTtYuTkkBAwkVg1fy9jFyMXh5DAbkaJtfe/sEEkZCT+tx1jh7CFJVb+e84OUdTMJLH1+zkg
        h4ODTUBX4uz2HJC4iEAro8T1lZ1MIA6zwEoWidsbe5hAuoUFkiSubpzABNLAIqAq8eBOCEiY
        V8BW4taEHcwQC+QlVm84AGZzCthJPFi+ngWkXAiopv2v1gRGvgWMDKsYJVMLinPTc4sNCwzz
        Usv1ihNzi0vz0vWS83M3MYJjTUtzB+P2VR/0DjEycTAeYpTgYFYS4eXWyE4W4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oqgams//S9jb6xtR0pt0+0iV60
        WXtpXb/W+0oea95/F5N37xISPd/Ip8qW+/XUzb1eWcoOtqo8zcdmtVzicNDYZXR75lG9eW+/
        JzKaLb+bIfPWfNcjdnZ+YVfBW/rv717X4QtRmOj2kVeOyUhie8ktjonqj7KF/bjZHbRENtx8
        U8O5T9x3iUeknaNNksK1gn8us5ZPk820kjc0+nA0iuGeY+qGoD/TY7Q/FU0w4u//NiXxE+vh
        d6VWnIvbjjHf7JruFJ8kXarDdCO5M2ndI4+9uZ+b+PLdXxZMqVu08lCs0YSfjjzvXk9+K6yg
        qLHEKGxnS76l1Yv5/IU8YhZMSi8ep+Rffp8dV95o3Tbxseg3JZbijERDLeai4kQAhtuudiQD
        AAA=
X-CMS-MailID: 20221111031711epcas5p45191dacb108498b920e5cf876f9d0c16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221111031711epcas5p45191dacb108498b920e5cf876f9d0c16
References: <20221111032337.79219-1-aakarsh.jain@samsung.com>
        <CGME20221111031711epcas5p45191dacb108498b920e5cf876f9d0c16@epcas5p4.samsung.com>
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

