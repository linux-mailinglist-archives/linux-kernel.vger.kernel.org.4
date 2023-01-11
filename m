Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB9665306
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjAKFC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjAKFCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:02:48 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1745DB876
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 21:02:45 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230111050241epoutp04a5982ddd5b1cf31609e23f942f123ea5~5KJYcjqnW2499524995epoutp04K
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:02:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230111050241epoutp04a5982ddd5b1cf31609e23f942f123ea5~5KJYcjqnW2499524995epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673413361;
        bh=ASQJNCQR73MFntzK8bHAoy0MvrG80CNamExmJiKrdNo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=J5TtVybtc9N+lSvY5l3yCpvIK3ZZNK9PBrBFTn/Y4IibJ9Plj6z+Mt5oTkNQCGa42
         oPD/7oidtct42X8F9M4MVxKKjRgtgQSDLgEo2i11EDSJ9+lJiElejdLMu6VsoO7sh3
         74Bgq11toaWwztPdlppbPGYdpjjAcdy3EOc0TS1I=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230111050241epcas5p36598ebee0a03409fbb332b67b2687a5f~5KJYBmjKl0929009290epcas5p3v;
        Wed, 11 Jan 2023 05:02:41 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NsFt75CDwz4x9Pv; Wed, 11 Jan
        2023 05:02:39 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.84.02301.CE24EB36; Wed, 11 Jan 2023 14:02:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230111050235epcas5p2c10f5bca83bdaff524c39857641ff30b~5KJTB4Qol2292322923epcas5p2F;
        Wed, 11 Jan 2023 05:02:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230111050235epsmtrp2f28191d5d0c7f4970d7a03edf8405195~5KJTBFybk0148601486epsmtrp2x;
        Wed, 11 Jan 2023 05:02:35 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-5b-63be42ec81a1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.AE.10542.BE24EB36; Wed, 11 Jan 2023 14:02:35 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230111050234epsmtip24c43f6a70bfa2d6a6d2dba78d1bcfd3b~5KJRhRFs_0521905219epsmtip2a;
        Wed, 11 Jan 2023 05:02:34 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>,
        "'Sriranjani P'" <sriranjani.p@samsung.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Rob Herring'" <robh@kernel.org>
In-Reply-To: <20230109083948.77462-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] dt-bindings: soc: samsung: exynos-sysreg: correct
 indentation for deprecated
Date:   Wed, 11 Jan 2023 10:32:32 +0530
Message-ID: <012d01d92579$eb7febc0$c27fc340$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQGk1dzeS3ZmKDMgaeUyDyRNZDRWogDauKizrvpyCUA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmuu4bp33JBtdmiFrMP3KO1aLvxUNm
        i72vt7JbbHp8jdXi8q45bBYzzu9jsmjde4Td4v+eHewWz/uA3Ntv1rE6cHlsWtXJ5nHn2h42
        j81L6j36tqxi9Pi8SS6ANSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8x
        N9VWycUnQNctMwfoKCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFp
        XrpeXmqJlaGBgZEpUGFCdsal2d1MBbv5K9ZNfcTSwNjB28XIySEhYCKxbedMZhBbSGA3o8S+
        FbldjFxA9idGiYs777NBOJ8ZJSY2/2WE6Tj1dw1Uxy5GieVfRSGKXjJKtK/ewQaSYBPQldix
        uA2sW0RgIrPEhvYnrCAJZgFViTl/foF1cwq4SDzuOwY2VVggWeLlwVUsXYwcHCxANV/aNEHC
        vAKWEt9mvWWHsAUlTs58wgIxRl5i+9s5zBAHKUj8fLoMary4xMujR8DqRQSsJI6vOsMCcoOE
        wEoOiUfPl7NDNLhIbDn1jQ3CFpZ4dXwLVFxK4vO7vWwgN0gIeEgs+iMFEc6QeLt8PdTz9hIH
        rswBO5NZQFNi/S59iLV8Er2/nzBBdPJKdLQJQVSrSjS/u8oCYUtLTOzuZoUZvuGg0gRGxVlI
        /pqF5K9ZSH6ZhbBrASPLKkbJ1ILi3PTUYtMCw7zUcnhkJ+fnbmIEp1ctzx2Mdx980DvEyMTB
        eIhRgoNZSYR3JeeeZCHelMTKqtSi/Pii0pzU4kOMpsCwnsgsJZqcD0zweSXxhiaWBiZmZmYm
        lsZmhkrivKlb5ycLCaQnlqRmp6YWpBbB9DFxcEo1MBWWtm5WkXkdy5HTqrv9eKv+/qtWrhdV
        Lk2znPh4mYZR/plogZSaBmPvzUa7qjkOP87oi3rh0vLlzJrlfxtl4yYrG965eaExNUTr54+z
        Ame3luy8tih8+Zwss4uHjokHmuf4fsph0L//e09/0jLuRinuqv7dXPyL/3+7xLDxWvjHNRqf
        5zE/+XDlmPCyjn1Pz7zc/mSx421OlkszUh6d45h4+r5m3GfJCv4fW10WLmr1OPDQJG6XzrfC
        6fb+2XftJ0SY1ayZsyywR+fIv6syc9+djl//et7D7TNLZZ3r3t3P1o8xuVKbqJ2bmuRzZ/6a
        rv7A+ywOp/1YVD07nxkX1VyVE3c2/+76o4/5F3e13yolluKMREMt5qLiRAC3/CRVOAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvO5rp33JBvsu61nMP3KO1aLvxUNm
        i72vt7JbbHp8jdXi8q45bBYzzu9jsmjde4Td4v+eHewWz/uA3Ntv1rE6cHlsWtXJ5nHn2h42
        j81L6j36tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoEr49LsbqaC3fwV66Y+Ymlg7ODtYuTkkBAw
        kTj1dw1zFyMXh5DADkaJntcTWSAS0hLXN05gh7CFJVb+e84OUfScUWLGvrVsIAk2AV2JHYvb
        2EASIgLTmSX6l20BSzALqErM+fMLauxURokHj68zgSQ4BVwkHvcdYwSxhQUSJY7f+QrUwMHB
        AtTwpU0TJMwrYCnxbdZbdghbUOLkzCcsICXMAnoSbRsZIcbLS2x/O4cZ4jgFiZ9Pl7FCxMUl
        Xh49AtYqImAlcXzVGZYJjMKzkEyahTBpFpJJs5B0L2BkWcUomVpQnJueW2xYYJSXWq5XnJhb
        XJqXrpecn7uJERxpWlo7GPes+qB3iJGJg/EQowQHs5II70rOPclCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MAWFeX2d8aHwTUelnZxK1VS/TnHOjokM
        DflVsVnqKZ+CGeOibROz+CNbltkpPZlaNPFrm+5FBkHuuMjzx2rnBzy9WDhpj2L5wklcYadu
        rXxm+8rXbcurz2wm3AsEL7WX7+PxfeVqnqeZL7dq/8cqkWfOxbYRR45etJ/0rNqktON6XGW7
        vZuHGNNT3r3fNtyXE6vMT+r+qLFdZuGxO9XvXVnCrx/QtON99XbTTOFVL2b4RGyO37p1kqbP
        6UlLhU0da/5yTBU7u99608v6mRLNV7LC/2xYdObQhLWHsrqtW+fqeb1Vbl2X5T4lU6wkOk+k
        LkIvQ6x4gpyjwizfJ8XXVV3EXx0QSW+6/O3l3/ZKJZbijERDLeai4kQAwi5UHSMDAAA=
X-CMS-MailID: 20230111050235epcas5p2c10f5bca83bdaff524c39857641ff30b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230109083958epcas5p2a6f04cf31eda7f1de147ea49cd12117e
References: <CGME20230109083958epcas5p2a6f04cf31eda7f1de147ea49cd12117e@epcas5p2.samsung.com>
        <20230109083948.77462-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Monday, January 9, 2023 2:10 PM
>To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; Sam Protsenko
><semen.protsenko@linaro.org>; Sriranjani P <sriranjani.p@samsung.com>;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Rob Herring
><robh@kernel.org>
>Subject: [PATCH] dt-bindings: soc: samsung: exynos-sysreg: correct
>indentation for deprecated
>
>"deprecated" keyword was indentend wrong - entire list of compatibles
>starting with generic Exynos SoC compatible is deprecated.
>
>Reported-by: Rob Herring <robh@kernel.org>
>Fixes: 0a2af7bdeeb4 ("dt-bindings: soc: samsung: exynos-sysreg: add
>dedicated SYSREG compatibles to Exynos850")
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---
Thanks!
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml  | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git
>a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>index 60958dac0345..163e912e9cad 100644
>--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysre
>+++ g.yaml
>@@ -36,7 +36,7 @@ properties:
>               - samsung,exynos850-sysreg
>               - samsung,exynosautov9-sysreg
>           - const: syscon
>-            deprecated: true
>+        deprecated: true
>       - items:
>           - enum:
>               - samsung,exynos850-cmgp-sysreg
>--
>2.34.1


