Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF1C629107
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 05:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiKOEBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 23:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiKOEB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 23:01:27 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398F315A39
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 20:01:25 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221115040123epoutp03f475fdc00b8986323b4666519e003360~npilqz3l13096730967epoutp030
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:01:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221115040123epoutp03f475fdc00b8986323b4666519e003360~npilqz3l13096730967epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668484883;
        bh=tWpN8q79jODLr9sW+7iEmUZwTF0pBHwISByz13Zn6hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OdbrKYcFxn/GsFNwaOC8PrtpPGAxITftRsbO2dYL/K1sruraYJxQIte+gMozsd9nM
         uQux5Kpw++YQOAXVddqRrUec4VLq1TOpgw8UkiGHayhI0OOYsuYlO59xC/PmR53VGE
         zTHSn+ehyEJy9bc0Mxx4dv7EQpkE9tOliODJlx2o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221115040122epcas5p215df7c16d7eeca8acb37b5876e06d01e~npikmUmWT1038710387epcas5p2W;
        Tue, 15 Nov 2022 04:01:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NBCCh6wxNz4x9Q0; Tue, 15 Nov
        2022 04:01:20 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.ED.56352.01F03736; Tue, 15 Nov 2022 13:01:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221114114406epcas5p20e15f3c3aafba2410eee8697159b1fd6~ncNTGOdhz1599215992epcas5p2k;
        Mon, 14 Nov 2022 11:44:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221114114406epsmtrp1abc3407b6ef4fc4cd601cee8aea7f813~ncNTFCmKd0315803158epsmtrp1K;
        Mon, 14 Nov 2022 11:44:06 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-34-63730f108fb3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.71.18644.50A22736; Mon, 14 Nov 2022 20:44:05 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221114114402epsmtip2a4d15400ea10cabc98a83de0c74d1445~ncNP_2TW11105611056epsmtip2V;
        Mon, 14 Nov 2022 11:44:02 +0000 (GMT)
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
Subject: [Patch v5 1/3] media: dt-bindings: s5p-mfc: Add new compatible
 string for Exynos3250 SoC
Date:   Mon, 14 Nov 2022 17:20:22 +0530
Message-Id: <20221114115024.69591-2-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114115024.69591-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHc3pv24usei2MHRp15DpZLAItFHZQcCwj5DKQkCnZIzPQlJtC
        KG3T2+o2Q9QpbBCBsbgMEIHRwsJD5NXKy4xHGdGNgULKEilTmeF2yRizw8hDt5bi9t/n9zvf
        3yPfcw6BiX8RSIg8rZExaJUaSrADt40dlIaTu1iVrOP56+hRXzUf3a+zCZD56RIP/Wp242i0
        xypEvbNXMPTdxDAf1dt/5qMbIw9x1MV5Tu9UO3G0VN8BkKtmQYDKuQcY6l508NHMQK0AXeq0
        8tE1u1OImubu8FBz9yYPNVr/FqKim3Yhcg7ZALpYbOclQrq9rh3QfU4LoOcsjzG6v8YppM1D
        Lh7d3VoioOcdQwK6x3KWLhpfx+ny3lZAl9rnBLS7ex99e9UtzBB9mB+fyyhzGEMIo1XpcvK0
        6gQq9XjW21kxsTJ5uDwOvUGFaJUFTAKVlJYRnpyn8VhAhZxSakyeVIaSZanIo/EGncnIhOTq
        WGMCxehzNHqFPoJVFrAmrTpCyxgPy2WyqBiPMDs/t9RVItSbd3/cNnPyHJjdWQoIApIK2Nwl
        LAU7CDE5CGBD5QjwBY8BdDRMbAduAMe+WvXI/LYqpjfbMS+LyQEAByfP+ERFPHi+ysn3thWQ
        4XDyhsarCSTPA7j4hdGrwchKHN4r57aKA0gV7C0bwb2Mkwfg8qVJ4GURmQDvLk8B37BXYVvn
        8JbejzwKJ0dWcF/+gh/ccLzm4yR4pbdjWx8Af5/o3V5UAl0VxdusgouNLszHGnh96PJ2nzfh
        8Gwt7t0ZIw/C6wORvvRe+PXtDp6XMXInLNv4jefLi2Bf3QsOhbXzT/k+3gPH2pqAz1Eatoyb
        fJZUAnizYUHwJdhX8/+EBgBaQTCjZwvUDBujj9Yyp/+7MZWuoBtsPXFpah94eH8lYhTwCDAK
        IIFRgaK6PTqVWJSj/ORTxqDLMpg0DDsKYjz2VWKSl1U6zx/RGrPkijiZIjY2VhEXHSunXhGZ
        q6QqMalWGpl8htEzhhd1PMJPco4nMfUnW8YreqJPfjCwVrhZlBnov5ZFcCUp9enrmf6Lf0xb
        xlxVY5EBUadmgxRTjlDu1nh7vNQ/7cjMOxWE/JvPH9mmZfmU+do/XDB32lanukXh6W0b6UqH
        OS3sUOrVj/CFxqpnUVwEvbzEtQzbfzjzmU4dUhVNRP/Uf5ZoLb5cQ+iOX2j+C0+Ka7OsWjWt
        zw61Z/84ZHOZ5Uf2Hs7WPpdctL6f3LJ0Yje3kuhnVbtjpgZTxV2Fq6HO0sWkznfvzUqLi9zf
        n5i/++0TTrJRmLickFzicqU0Br1ndA+nvHU1bDWiLCgsp4lay/zTZV4LPrZr//5Q8cJ60JOX
        nPao6gcUzuYq5VLMwCr/BdxAaeJrBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvC6rVlGyweoVVhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzaLvxUNmi02Pr7FaXN41h82iZ8NWVou1R+6yWyy9fpHJYtmmP0wWi7Z+Ybdo3XuE3eLu
        nm2MFi1tR5gcJDzWzFvD6LHj7hJGj+tLPjF77Jx1l91j8Z6XTB6bVnWyedy5tofNY/OSeo/W
        o79YPPq2rGL06Dpync3j8yY5j1NfP7MH8EZx2aSk5mSWpRbp2yVwZXS97GQvWCxYsfpybAPj
        Fb4uRk4OCQETiQt/1jB3MXJxCAnsYJTon76YHSIhI/G/7RiULSyx8t9zdoiiZiaJvbuvAXVw
        cLAJ6Eqc3Z4DEhcRaGWUuL6ykwnEYRZYySJxe2MPE0i3sECixOyNc9lAbBYBVYl3PWcZQWxe
        AVuJS+/OM0JskJdYveEAM4jNKWAncfbgBxYQWwio5t2xt2wTGPkWMDKsYpRMLSjOTc8tNiww
        ykst1ytOzC0uzUvXS87P3cQIjjctrR2Me1Z90DvEyMTBeIhRgoNZSYR3nkx+shBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MUfYqc+p0+FSCP8xn3Vwd
        8CnzrWSeyd4g8Wn/bEKjjq5LENSc2/hq4avz998VFt6VqtuiYLJj0/vgcM+/h9tufZu+W+hn
        663roXcy0zLK9Gb982DabLf8nOaGkG6Ob/WH1vM0ylx/6Kv+JMnqaNiX6F/zHpZn7re7c/Pc
        eiMBeWajgNbawuk6HhcdtyjJnW9xFN3qbbFR8Ribyd/6+rC5j3/EbN2e6N6erukX3u+mtbbw
        8pNAhktHymPMHL60C3D0PeF9O8v1VYC+eEpOzCXxPmbRiDYF9wvdfQcmFYh7Bs28ffVwSdEF
        rxU9uu4ajdM8HcU5v8qsP+xcuvzzW6ljp5vsijbksNtJfund8UWJpTgj0VCLuag4EQAnbORy
        JgMAAA==
X-CMS-MailID: 20221114114406epcas5p20e15f3c3aafba2410eee8697159b1fd6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221114114406epcas5p20e15f3c3aafba2410eee8697159b1fd6
References: <20221114115024.69591-1-aakarsh.jain@samsung.com>
        <CGME20221114114406epcas5p20e15f3c3aafba2410eee8697159b1fd6@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
index aa54c8159d9f..8eb90c043d5d 100644
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
+	(c) "samsung,exynos3250-mfc", "samsung,mfc-v7" for MFC v7
+	     present in Exynos3250 SoC
+	(d) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
+	(e) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
+	(f) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
+	(g) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
 
   - reg : Physical base address of the IP registers and length of memory
 	  mapped region.
-- 
2.17.1

