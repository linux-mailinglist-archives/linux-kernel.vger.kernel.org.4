Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D342E638ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiKYRGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiKYRGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:06:25 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F2D4A585
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:06:22 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221125170620epoutp024b7c8bc2a6c87c0bfa90998585c35326~q4sygaOY41107811078epoutp02j
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 17:06:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221125170620epoutp024b7c8bc2a6c87c0bfa90998585c35326~q4sygaOY41107811078epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669395980;
        bh=UwapI9OthlksRJi2FwYT+/KKNo8M9WoKBftxl2Kdtr0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=t9rlZUxGS6R0BcHXUrhk6rqhX2f9AGH2ludSdnWRhoQFAWAOKsMhKzLbgXvO2lZOO
         E/TBbQCnREnJPK01kPXCWIxEOS1FynamBQHCQ2Lzc3Q+P+dvHpxEy0XrLeF7KcIFJR
         lTuvcEJkHp+gyMtEmUNqjS0D7NZC/X8EAwqsIrs4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221125170619epcas5p3863f4efbbb1fd31560d67d34638d4726~q4sx6vj3m1918719187epcas5p3O;
        Fri, 25 Nov 2022 17:06:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NJh8n2DqSz4x9Pp; Fri, 25 Nov
        2022 17:06:17 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.EC.01710.906F0836; Sat, 26 Nov 2022 02:06:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221125170616epcas5p1332ef3efaf016ea0f68b6029d12d8aa4~q4svSej-O2148521485epcas5p1_;
        Fri, 25 Nov 2022 17:06:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221125170616epsmtrp2de4b243d3cadd0302533923249f85b65~q4svRqPNj1441514415epsmtrp2Q;
        Fri, 25 Nov 2022 17:06:16 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-7d-6380f6092a85
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.F0.14392.806F0836; Sat, 26 Nov 2022 02:06:16 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221125170615epsmtip147618a693283b729660d79467d650131~q4stqlOER2498024980epsmtip1X;
        Fri, 25 Nov 2022 17:06:15 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Lee Jones'" <lee@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Cc:     "'Sriranjani P'" <sriranjani.p@samsung.com>,
        "'Chanho Park'" <chanho61.park@samsung.com>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>
In-Reply-To: <20221125112201.240178-3-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos5433
Date:   Fri, 25 Nov 2022 22:36:14 +0530
Message-ID: <01a901d900f0$3b025560$b1070020$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIt87tfTwup8v8WQwS48SHvnyDBrAJkhWlJAeCcxQetg8+qEA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmhi7nt4ZkgytPeC0u79e2mH/kHKtF
        34uHzBZ7X29lt9jRtpDFYtPja6wWl3fNYbOYcX4fk0Xr3iPsFs/7gKzbb9axOnB7bFrVyeZx
        59oeNo/NS+o9+rasYvT4vEkugDUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJc
        SSEvMTfVVsnFJ0DXLTMH6DAlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5x
        Ym5xaV66Xl5qiZWhgYGRKVBhQnbG/C3rGAsWCVf8ORDVwLiNv4uRk0NCwETiy6O5TCC2kMBu
        RokJPxy7GLmA7E+MErt272KGcL4xSmxru8sC03Hr8C12iI69jBKfu/Ugil4ySiyeM4kZJMEm
        oCuxY3EbG0hCROASk8S7txNYQRxmgT5GiVWvF4GN4hRwlWg49RCog4NDWKBY4t4RaZAwi4Cq
        xPauFWAbeAUsJU4t7mWGsAUlTs58AtbKLCAvsf3tHGaIixQkfj5dxgoRF5d4efQIWK+IgJPE
        l/kvmED2Sgjs4JBYdHs5VIOLRMfZ7WwQtrDEq+Nb2CFsKYnP7/aygdwjIeAhseiPFEQ4Q+Lt
        8vWMELa9xIErc1hASpgFNCXW79KHWMsn0fv7CRNEJ69ER5sQRLWqRPO7q9Bwk5aY2N3NCmF7
        SPSe6WadwKg4C8ljs5A8NgvJM7MQli1gZFnFKJlaUJybnlpsWmCYl1oOj+3k/NxNjOBEq+W5
        g/Hugw96hxiZOBgPMUpwMCuJ8CYcb0gW4k1JrKxKLcqPLyrNSS0+xGgKDO2JzFKiyfnAVJ9X
        Em9oYmlgYmZmZmJpbGaoJM67eIZWspBAemJJanZqakFqEUwfEwenVAOT6D9OPabqpRvcM6tm
        3Xh4+JLP+SNnrRaIfrU/vmFrSJzpmm/NAtPeuPD7n+B4axn3s2mOp4nFsbbHdV2x28tXTczq
        afu/KK6h/8yVnc/NKnR+fb/Erz1Rrilp0Tcxt1beDPWXt58WnBJ5NFvzetGrsDLGf6sOCahc
        EzOrZTWYPEXh162GjedPaP3IvsHf57zNXl18ScuN8gg/hQ/ue688r57mL9EtXd/RsfzihQfM
        jktl05ae8g1r/Fa5SlRH70kJR/ecE7tLT73+u7qnrKj8zJfOuMQpWy9teafYaqTB/uTeW9Gl
        v3oDzPefmXtN+Jb6suNr2T7ui0nvPH4mNOJE+9Sjmz6sFt9zo0F4G1PVayWW4oxEQy3mouJE
        AGZ1A+I9BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnC7Ht4Zkgz1fdS0u79e2mH/kHKtF
        34uHzBZ7X29lt9jRtpDFYtPja6wWl3fNYbOYcX4fk0Xr3iPsFs/7gKzbb9axOnB7bFrVyeZx
        59oeNo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK2P+lnWMBYuEK/4ciGpg3MbfxcjJ
        ISFgInHr8C32LkYuDiGB3YwSqy88Y4FISEtc3ziBHcIWllj57zlU0XNGiaPfm5hAEmwCuhI7
        FrexgSREBG4wScxec4sFxGEWmMAosW3BR0aIlvOMEvNnnQRr4RRwlWg49ZC5i5GDQ1igUGL6
        hySQMIuAqsT2rhVg63gFLCVOLe5lhrAFJU7OfMICUs4soCfRtpERJMwsIC+x/e0cZojrFCR+
        Pl3GChEXl3h59AjYGBEBJ4kv818wTWAUnoVk0iyESbOQTJqFpHsBI8sqRsnUguLc9NxiwwLD
        vNRyveLE3OLSvHS95PzcTYzgiNPS3MG4fdUHvUOMTByMhxglOJiVRHgTjjckC/GmJFZWpRbl
        xxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cCkz8OaxVp+gF90/+5b236q
        HeG8tEmutoLZrCbrJQPH1rfTyhtW9O1qPrN0/rWgKSsOz1TjfLDt6aZgA1ujDItbuxmOz3jO
        Peue9x4jybyKydL5nDUXTaP0tXZnVEYaF27lSal0q5MWD/A4JH1BeY3V9NC6hf5ShyOdzLqs
        Pk/1uz8j6IRZu26rj8j/NyZ++48kzaz9EDK54+6Rb2q2inGdbKYPWQWPs5xLW5gQIzxH93nF
        1MXb7l7ZNkF0evKKZz77+KWVlULUlokLaXeoBZw79vqSxj4DaeYXzse9+WdZajy74nCK1eYG
        O/vVoPj6Y905pRFei9Rfi389a/FAQdRNc9VERkGLrcs1c1rPyyixFGckGmoxFxUnAgAUCaso
        JwMAAA==
X-CMS-MailID: 20221125170616epcas5p1332ef3efaf016ea0f68b6029d12d8aa4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221125112241epcas5p1d9558a8de5bfa807ed6dc5c55635c900
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
        <CGME20221125112241epcas5p1d9558a8de5bfa807ed6dc5c55635c900@epcas5p1.samsung.com>
        <20221125112201.240178-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Friday, November 25, 2022 4:52 PM
>To: Lee Jones <lee@kernel.org>; Rob Herring <robh+dt@kernel.org>;
>Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Sriranjani P
><sriranjani.p@samsung.com>; Chanho Park <chanho61.park@samsung.com>;
>Sam Protsenko <semen.protsenko@linaro.org>
>Subject: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
dedicated
>SYSREG compatibles to Exynos5433
>
>Exynos5433 has several different SYSREGs, so use dedicated compatibles for
>them.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>---
>
>Cc: Sriranjani P <sriranjani.p@samsung.com>
>Cc: Chanho Park <chanho61.park@samsung.com>
>Cc: Sam Protsenko <semen.protsenko@linaro.org>
>---
> .../bindings/soc/samsung/samsung,exynos-sysreg.yaml | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>
>diff --git
>a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>index 68064a5e339c..42357466005e 100644
>--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysre
>+++ g.yaml
>@@ -17,10 +17,21 @@ properties:
>               - samsung,exynos3-sysreg
>               - samsung,exynos4-sysreg
>               - samsung,exynos5-sysreg
>-              - samsung,exynos5433-sysreg
>               - samsung,exynos850-sysreg
>               - samsung,exynosautov9-sysreg
>           - const: syscon
>+      - items:
>+          - enum:
>+              - samsung,exynos5433-cam0-sysreg
>+              - samsung,exynos5433-cam1-sysreg
>+              - samsung,exynos5433-disp-sysreg
>+              - samsung,exynos5433-fsys-sysreg
>+          - const: samsung,exynos5433-sysreg
>+          - const: syscon
>+      - items:
>+          - const: samsung,exynos5433-sysreg
>+          - const: syscon
>+        deprecated: true
Any reason to add "deprecated: true" here for above compatible?

>
>   reg:
>     maxItems: 1
>--
>2.34.1


