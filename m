Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58F762910D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 05:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiKOECI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 23:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbiKOEBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 23:01:53 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452321C40F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 20:01:41 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221115040140epoutp02f9f837f6eb17eb71a5ec1e5f73455937~npi0zx2kA3196831968epoutp02K
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:01:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221115040140epoutp02f9f837f6eb17eb71a5ec1e5f73455937~npi0zx2kA3196831968epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668484900;
        bh=4Q5OQv6ek20SCDHutwu88UaXFb56EuVL8bwNMJ3r/eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PIBrx5YoPz3PrFVzbQk/yNPkfyOhu8I+Vcxn68YCdP/nl3YqQxHKeKpnRWYTZKZ6n
         xKVRuAyzVcE8vs7sKW7bQe59ya17qCOdAvKr9z+Ad5id7rKm34j25wYTYO4zo9eeAs
         PMDolj4W8reNsnyo29rWNDtiyeVausM4ikKBq4xM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221115040138epcas5p11ede79a041ca797f039232c8076e47dd~npizpQy5N0913709137epcas5p18;
        Tue, 15 Nov 2022 04:01:38 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NBCD10hy6z4x9Pv; Tue, 15 Nov
        2022 04:01:37 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.0E.56352.02F03736; Tue, 15 Nov 2022 13:01:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221114114412epcas5p43350b596e52a98eb69406574b4a16171~ncNZTqLUx0954209542epcas5p4B;
        Mon, 14 Nov 2022 11:44:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221114114412epsmtrp2dfab1581fcfc90883516c1d65bfcae17~ncNZR16uR0788507885epsmtrp2t;
        Mon, 14 Nov 2022 11:44:12 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-7b-63730f207faa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.E4.14392.C0A22736; Mon, 14 Nov 2022 20:44:12 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221114114409epsmtip2ec50e17d83fb8bd28910d3118d833d2e~ncNWPvCIM1393413934epsmtip2G;
        Mon, 14 Nov 2022 11:44:09 +0000 (GMT)
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
Subject: [Patch v5 3/3] ARM: dts: exynos: Add new SoC specific compatible
 string for Exynos3250 SoC
Date:   Mon, 14 Nov 2022 17:20:24 +0530
Message-Id: <20221114115024.69591-4-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114115024.69591-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe0xTZxTfd+/t7a2h81Lc+CQ+mgZNwACtUvaV8dgy4m7m/iBzc0ZmuqZc
        C1Lapg98sVhEGKBrhKgZjKHhtQDyKlAYKwYrD0EYMhxkApaXARxRhMkIY8taCtt/v3PO73fO
        ye98H4ULnpB+VKLGyOo1CrWI3EbY7gcEBAm3G5Ti5pfh6FlLPgdNFNlIVLI6iyFnyTKBHA1N
        XNT4+Dsc/dDdzkG3On7moOZ7UwSqn3NVB/PHCTR7qwag+YKnJLLMTeLIOj3MQUOthSS6WtfE
        QdUd41xUNjKIoXLrOoaKm/7gooy2Di4at9sAupzZgb0HmTtFdwDTMl4KmJHSJZz5sWCcy5TY
        5zHGWplNMmPDdpJpKL3IZHSuEYylsRIwOR0jJLNs3cP0vl7mxvJPJEUksIp4Vi9kNUptfKJG
        FSk6clT+gVwaJpYESWToHZFQo0hmI0UxH8cGHU5UuywQCVMUapMrFaswGEQhURF6rcnIChO0
        BmOkiNXFq3WhumCDItlg0qiCNawxXCIWH5S6iF8mJdRZ03FdJ+/s9zM2jhlcpnIAj4J0KFx/
        dInMAdsoAf0TgGuVV7meYAnA285czBOsAGi2LYItyd3e0U1JG4B9ji6OuyCgMzBYbP08B1AU
        SQfB/ma1O72DTgNwOsvo5uN0LgFHLXO4u+BDs9BZV0C4MUHvgzWdrZhby6cj4T/VmGfWXlhV
        175B59FRsP/eIuHuA+l0Huyx/AncfEjHwKVunofvA593N3I92A8uv2gjPVgJp4vncQ9Ww1r7
        dcKDo2H740LC3QanA2Bta4gnvRve6K3ZWAGn34Tf/DWzuQ4fthRt4f2wcGyV48G74P2qsk17
        GDj5KJ/w2JMLYG72EHkN7Cn4f8RtACrBTlZnSFaxBqnukIY989/NlNpkK9h45IFHWsDUxGKw
        A2AUcABI4aId/KJdWqWAH684d57Va+V6k5o1OIDUZV8u7veWUuv6JRqjXBIqE4eGhYWFyg6F
        SUS+/JJvA5UCWqUwskksq2P1WzqM4vmZMXZBqtTWVzyr2j3l2H9FIqt8hU3lvP8KTzpe3RWi
        n3jx0fWok+UH08gV7s5Th8sCL+U9SOh7O3y774DWwnS1qOb/Xjjt/zJG9Zv3+deCT6JP9c1k
        2zIx5qFQVtG12mnKz1q0RN80V5zI+uyYPEXe5iz2+lq2EDdkSbWmGfF3qaGzsQN7LQcG7/bY
        tekXlPwGs/fY+fqVAyl5A6mc7iveo/79+8p+yS73Zx6OfJU6LKWfpD8VpzjizOe+KAk5GvmG
        7HTFRK3vujP5Yn0T1TNkz7z2oLfBqFw+7kX+mkc+95G2xp38ffbD/KI0Is+r0BQx37ByrFdY
        F7F2oWrFOfPp5M0zIsKQoJAE4nqD4l+S+mDYbQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa1BMYRzGveecPee0LMeu4XVJM2uMLlNkMO8YGuMDxy1mGDU+4NhOMfaS
        c1xiDI22Ne24hBmjsEmrpl2yrbbCMlvtipKKtENWSs1aRNnQpEGr8e33/J/nmf+Hh8blF4gZ
        9B7tfl7QcmolKSUq65QRsROiBdWCzIFI1FudJ0HvTJUkKhryY6izKEig2jsOClW0XcZRSb1L
        ggrczySoqqabQOUfRt3WPB+B/AVlAAXy35LozIcuHNnft0vQi3tXSHTK5pCgW24fhW54WzFU
        bB/B0HXHIIWyH7gp5HNWAqQ3uLEVkL1pugnYap8ZsF7zN5y9m++j2CJnAGPtlhySfdPuJNk7
        5uNstmeYYM9UWABrdHtJNmifzTZ8D1KbZNuky1J49Z6DvDA/Yad0t82ehad7wjKu9lRKMoGe
        NoIwGjKL4MOGDtIIpLScuQ9gu7kMjBmz4B/DI2qMFbD0t58aC2VhsNx2e1TQNMnEwqYqdeg+
        hckG0Fuag4UEzpQSsKP8FBZqKxgVzHKZ/zHBzIVlnntYqCxjlsPft7CxBxHQanPhIQ5jEmBT
        TT8RYvlo5MujPjIXTLwGxlnAdD5d1KRpxPj0eC1/KE7kNOIBbVqcSqexg3+7RUdVgypLf1wt
        wGhQCyCNK6fITLN0KrkshTt8hBd0O4QDal6sBTNpQjlN1mJ8skPOpHH7+b08n84L/12MDpuR
        idUX/9RLW1bmwrWFaWt+uQzhP5o+akvWPW14/V21MDv8FaSjUxu7VfNySONgb7PM2lLSve5E
        4rOrwuqJq0dMTkVrTMvBqSkDkc3tRwNusd7XtzRjhPxBi+N6FhXqzq5PjHrsSS0wPLEubPAn
        vd9X+Py5xcOdretqTGnzJ3QutYbn9c5JjmosztPp3+q8WxOd1xPvc6QrmdpufTgwbDi54FxQ
        t+XY9M/N5xVTNzs+KZICX1+MD8Zk0LDJ/Up9cvBcxeTcHptNNpTPHUlVdXmEVZckJRczNjiT
        hzta++5OTioLHIrsd2j6vpEbhzpf7lry0jYt62nE6bZPa9ab7JP0i5WEuJuLj8YFkfsL/ucI
        NiYDAAA=
X-CMS-MailID: 20221114114412epcas5p43350b596e52a98eb69406574b4a16171
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221114114412epcas5p43350b596e52a98eb69406574b4a16171
References: <20221114115024.69591-1-aakarsh.jain@samsung.com>
        <CGME20221114114412epcas5p43350b596e52a98eb69406574b4a16171@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 752d3a23d1f68de ("ARM: dts: add MFC codec device node for
exynos3250") which adds MFC codec device node for exynos3250 SoC.
Since exynos3250.dtsi and exynos5420.dtsi are using same compatible
string as "samsung,mfc-v7" but their node properties are different.
As both SoCs have MFC v7 hardware module but with different clock 
hierarchy and complexity.
Add new compatible string followed by mfc-v7 fallback for Exynos3250
SoC.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 326b9e0ed8d3..a2d6ee7fff08 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -485,7 +485,7 @@
 		};
 
 		mfc: codec@13400000 {
-			compatible = "samsung,mfc-v7";
+			compatible = "samsung,exynos3250-mfc", "samsung,mfc-v7";
 			reg = <0x13400000 0x10000>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "mfc", "sclk_mfc";
-- 
2.17.1

