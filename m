Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285CF619420
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiKDKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiKDKEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:04:54 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D2263C0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:04:51 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221104100448epoutp0375e2c56b38611b6165cf8cba5a17ad56~kWZwJcfIK3270632706epoutp03p
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:04:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221104100448epoutp0375e2c56b38611b6165cf8cba5a17ad56~kWZwJcfIK3270632706epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667556288;
        bh=6YrZb4rIVThny1YuuCHZdKWp6Aza2885Qa/dxfwyNuQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mYS9m7Ql92fYAk4lrGxoaVV+7L/HVCLztf5afuC5VK96VmVBFHwwWFl82aS7Olrm1
         cjoH0xO3gCFargwoMQRE4OPKcMRj5XE1swKd2T/wjcP877Zx9uZX1wWUrGTKBVDk2/
         bRzjjHE8ErmviPQxxemDZBZ+UR0IA2EfXwRA9uTA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221104100447epcas5p3a3cd553ac66cd4f4b0a0b6c2a7788725~kWZvcJpah3214732147epcas5p3Z;
        Fri,  4 Nov 2022 10:04:47 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4N3bp5331Bz4x9Pp; Fri,  4 Nov
        2022 10:04:45 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.4D.39477.DB3E4636; Fri,  4 Nov 2022 19:04:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221104085410epcas5p24d88f59001b739075e9e190e2c47841e~kVcEwUP0W1926119261epcas5p2v;
        Fri,  4 Nov 2022 08:54:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221104085410epsmtrp2877b16b524ac75f74d9f92dcf0b996b1~kVcEvaESi0462404624epsmtrp2P;
        Fri,  4 Nov 2022 08:54:10 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-92-6364e3bda44e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.46.18644.233D4636; Fri,  4 Nov 2022 17:54:10 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221104085407epsmtip1b37a75115cfe527d8477208458815b7d~kVcCHIU_Q3261232612epsmtip1h;
        Fri,  4 Nov 2022 08:54:07 +0000 (GMT)
From:   Inbaraj <inbaraj.e@samsung.com>
To:     krzysztof.kozlowski@linaro.org, s.nawrocki@samsung.com,
        tomasz.figa@gmail.com, cw00.choi@samsung.com,
        alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, chanho61.park@samsung.com
Cc:     linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pankaj.dubey@samsung.com,
        Inbaraj <inbaraj.e@samsung.com>
Subject: [PATCH] dt-bindings: clock: exynosautov9: fix reference to
 CMU_FSYS1 mmc card clock
Date:   Fri,  4 Nov 2022 14:30:19 +0530
Message-Id: <20221104090019.88387-1-inbaraj.e@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTQ3fv45Rkg7tfBC0ezNvGZnF5v7bF
        9S/PWS3mHznHanH3zyQ2i72vt7JbbHp8jdXiY889VovLu+awWcw4v4/J4uIpV4tFW7+wW7Tu
        PcJucfhNO6vFv2sbWSxW7frD6CDg8f5GK7vHzll32T02repk87hzbQ+bx+Yl9R59W1Yxenze
        JBfAHpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0
        upJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgU
        qDAhO6Nn9wW2ghlcFSuP72BuYDzK0cXIySEhYCKxu/sHG4gtJLCbUWJHS1gXIxeQ/YlRYubf
        e+wQzmdGiXsn9jPBdGzpuM0GkdjFKHHr8maoqlYmiaPHnoLNYhNQlTiw/RUjSEJE4CGjxP7m
        ZjCHGcS5/+Q8O0iVsECcxNlF78BsFqCO/4ungHXzClgB1VxkgdgnL7F6wwFmkGYJgUYOiVPf
        N7JCJFwk7s7pYoewhSVeHd8CZUtJfH63lw3C9pHYP+cXI4SdIXFs+3KoXnuJA1fmAC3gALpI
        U2L9Ln2IsKzE1FPrwP5kFuCT6P39BOpnXokd82BsZYmZR+5DjZeU2Hl5J9SdHhJTe75AQzJW
        Yu61z0wTGGVnIWxYwMi4ilEytaA4Nz212LTAKC+1HB5Vyfm5mxjBaVLLawfjwwcf9A4xMnEw
        HmKU4GBWEuH9tC05WYg3JbGyKrUoP76oNCe1+BCjKTDMJjJLiSbnAxN1Xkm8oYmlgYmZmZmJ
        pbGZoZI47+IZWslCAumJJanZqakFqUUwfUwcnFINTNMtPhbfu9ufOvu/sP+y1NmV+v9vTd61
        Kk3Q9FbebotXO9b7PBb6bbb6yfqU0Gr1ZYbHfZPO7q4y4trXt4vx9a+VfirKRxcdLl/96qyP
        VvSjR6uDVWKaOALDFqk17lX9N23KvJMp268tWP6p422SWmHvjmzd99Mit7Bmya9LLtDiso6S
        DuL5uZzpi/Ks+okfLHZZdC7av+i1a3nJS/eq38cmW957aOBeFNBkbektqZj5XsU0ot1wk/2N
        3PMxEdsF72/Ne97w6b7O2tIPtgsbdKoDAu+/ZSlPnXXCvO7/FudNZZ/tVS8xPlbd9KZhTQtv
        5uxSY3X9+PU+onX7O87N5WfeWFy6ZeaFvubmCw09GUosxRmJhlrMRcWJANjxpH0cBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnK7R5ZRkg51n2SwezNvGZnF5v7bF
        9S/PWS3mHznHanH3zyQ2i72vt7JbbHp8jdXiY889VovLu+awWcw4v4/J4uIpV4tFW7+wW7Tu
        PcJucfhNO6vFv2sbWSxW7frD6CDg8f5GK7vHzll32T02repk87hzbQ+bx+Yl9R59W1Yxenze
        JBfAHsVlk5Kak1mWWqRvl8CV0bP7AlvBDK6Klcd3MDcwHuXoYuTkkBAwkdjScZuti5GLQ0hg
        B6PE/qbprBAJSYnZv6ezQ9jCEiv/PWeHKGpmkvj0dTITSIJNQFXiwPZXjCAJEYHXjBL/731j
        BnGYBZ4zSlx/sYkFpEpYIEZi8cJ/YB0sQB3/F09hA7F5Bawk7j+5yAKxQl5i9YYDzBMYeRYw
        MqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgOWS2tHYx7Vn3QO8TIxMF4iFGCg1lJ
        hPfTtuRkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGphS
        ZsZsSj5QyPQnpPFOxJTS/280zdV9v1hm3XDf8fOBkdeTmh73joZuRmn/V48ubj/Tu/KX5fTj
        uWd2rH8XJVwx7ZL9D75u1s38ec03xCPXSHsUCLn/unZWUeJc0469gQt0JJdN/mxyznWd45rw
        XzlBe/TaC2cGVJy3FTX9Nuf8g/pGnyvGMY/y3Cdt++D+LbNNf5Nj5rtZ97gUgqrCw4PuSjxe
        phbCbqzyW5C/yzvMkstk45r5M8XXXDsRIGR19dPGlzHsXpfnJ3aYJl0MCs0Xnn8wb4EzWwZT
        wunfq+43/bnyymZqRrLTspfMFp2PXrIb/VYVeGI5eYPXwb03pltYdDLnKYaJfNn9RzMyy02J
        pTgj0VCLuag4EQDevkDgyAIAAA==
X-CMS-MailID: 20221104085410epcas5p24d88f59001b739075e9e190e2c47841e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221104085410epcas5p24d88f59001b739075e9e190e2c47841e
References: <CGME20221104085410epcas5p24d88f59001b739075e9e190e2c47841e@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix reference to CMU_FSYS1 mmc card clock to gout clock instead of dout.

This fixes make dtbs_check warning as shown below:

arch/arm64/boot/dts/exynos/exynosautov9-sadk.dtb: clock-controller@17040000:
clock-names:2: 'dout_clkcmu_fsys1_mmc_card' was expected
From schema: /home/inbaraj/mainline/linux/Documentation/devicetree/
bindings/clock/samsung,exynosautov9-clock.yaml

Fixes: 4b6ec8d88623 ("dt-bindings: clock: exynosautov9: add schema for cmu_fsys0/1")
Signed-off-by: Inbaraj <inbaraj.e@samsung.com>
---
 .../devicetree/bindings/clock/samsung,exynosautov9-clock.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
index 2ab4642679c0..55c4f94a14d1 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
@@ -148,7 +148,7 @@ allOf:
           items:
             - const: oscclk
             - const: dout_clkcmu_fsys1_bus
-            - const: dout_clkcmu_fsys1_mmc_card
+            - const: gout_clkcmu_fsys1_mmc_card
             - const: dout_clkcmu_fsys1_usbdrd
 
   - if:
-- 
2.17.1

