Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7EF6393E4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 05:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiKZEow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 23:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiKZEoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 23:44:38 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C414C2CE20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 20:44:37 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221126044436epoutp030ce064bf4ce94460ec0514144be93a14~rCOdIF4uQ0428304283epoutp036
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 04:44:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221126044436epoutp030ce064bf4ce94460ec0514144be93a14~rCOdIF4uQ0428304283epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669437876;
        bh=myN/uIUMG8BCVsYLXXa+HcUtWLpXtnGnTNul+xFvUyQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Bwd3LO2JxgAW7vyAN4ia1JCj88kVxYPFeg70WpE5LQSOzxYoHQm9Pl1PQlcZoo3kT
         KWRKWC9SXOvHBGhUNEsME4hzqOBlazgIa98L0Xd0sn+ZHf9m+iT4tHXJYPVVFFzz/K
         U39asiJdAiLyV4pgSkDtIiT191MS0Cs08hOh2xgs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221126044435epcas5p4cb92908115b009c8a2781d0450ffa670~rCOcMgcSM0173001730epcas5p4R;
        Sat, 26 Nov 2022 04:44:35 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NJzfT4r4tz4x9Pv; Sat, 26 Nov
        2022 04:44:33 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.8A.01710.1B991836; Sat, 26 Nov 2022 13:44:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221125143313epcas5p3c22291a2740857bf7c8f82071f37808d~q2nG1KgR_0606606066epcas5p3r;
        Fri, 25 Nov 2022 14:33:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221125143313epsmtrp114caeeb27da99c7a7cf38a9262605b6d~q2nG0e6u92159421594epsmtrp1E;
        Fri, 25 Nov 2022 14:33:13 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-61-638199b172be
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.2E.14392.922D0836; Fri, 25 Nov 2022 23:33:13 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221125143312epsmtip2e0b29664e6898e24819060cec3d71ec9~q2nFOP-ic0522205222epsmtip28;
        Fri, 25 Nov 2022 14:33:11 +0000 (GMT)
From:   "Sriranjani P" <sriranjani.p@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Lee Jones'" <lee@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Cc:     "'Chanho Park'" <chanho61.park@samsung.com>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>
In-Reply-To: <20221125112201.240178-3-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos5433
Date:   Fri, 25 Nov 2022 20:03:07 +0530
Message-ID: <016e01d900da$d9441ad0$8bcc5070$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIt87tfTwup8v8WQwS48SHvnyDBrAH2hF2qAeCcxQethxUOMA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmhu7GmY3JBp8fqVg8mLeNzeLyfm2L
        +UfOsVr0vXjIbLH39VZ2ix1tC1ksNj2+xmpxedccNosZ5/cxWbTuPcJu8bxvH5MDt8emVZ1s
        Hneu7WHz2Lyk3qNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
        zJUU8hJzU22VXHwCdN0yc4AOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBTo
        FSfmFpfmpevlpZZYGRoYGJkCFSZkZ3w5vpu94IJwRc/uC2wNjCv4uxg5OSQETCT+XH7F2MXI
        xSEksJtR4u+qSywgCSGBT4wSk5/HQSS+MUo0LN3KCNPRfOkbK0RiL6PEy4u72CCc54wSl2Ze
        AatiE9CXeL1iPlhCROA/k8TfX21gc5kFEiVOnznBBGJzCrhKNJx6yNzFyMEhLFAsce+INIjJ
        IqAqcfK6F4jJK2Ap8eRLGUgxr4CgxMmZT6CGyEtsfzuHGeIeBYmfT5exgpSLCDhJTL+mDVEi
        LnH0Zw8zyAESAls4JN7cuQV1v4vEvXUgJ4PYwhKvjm9hh7ClJF72t0HZ6RKbj2xmhbBzJDqa
        mqF22UscuDKHBWQXs4CmxPpd+hBhWYmpp9YxQezlk+j9/YQJIs4rsWMejK0msfhRJ5QtI7H2
        0SfWCYxKs5B8NgvJZ7OQvDALYdsCRpZVjJKpBcW56anFpgWGeanl8NhOzs/dxAhOtFqeOxjv
        Pvigd4iRiYPxEKMEB7OSCG/C8YZkId6UxMqq1KL8+KLSnNTiQ4ymwMCeyCwlmpwPTPV5JfGG
        JpYGJmZmZiaWxmaGSuK8i2doJQsJpCeWpGanphakFsH0MXFwSjUwzYjz8+9YEKmwdtm3V1wC
        x19xz/6WkdnIPNnJ++6Kww3xFkf85d4Fd7tF/c98NP22qjjHTqlIcxG/7Vv2zolWEON9LlL7
        pOd5zpljrSc/ePncjIs3sq3L1gvxvPbE+s5Hnb5Nf2Zs/XD32LLIJV/n/6y8wizmlM5oGrtw
        UdZhdmn3t72pml8i9J3uFqx4VVzfvTzgUs3FNQ0GgmE3G1/tNJWfGDfvssjNvlVXEh5xOAWs
        2nqITzXkm9nJMw6MdcfUVm26u6v2btRM+aSv+ozlbeHb0lmiX3z+U/LohtAZw53NFwsvXv3t
        oKUx139KlsyDS8mRVt/erfy85OuOnbqa3BXFVh6G5k9+2yVbBli7K7EUZyQaajEXFScCAC5C
        cQo9BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSvK7mpYZkgyvn1S0ezNvGZnF5v7bF
        /CPnWC36Xjxkttj7eiu7xY62hSwWmx5fY7W4vGsOm8WM8/uYLFr3HmG3eN63j8mB22PTqk42
        jzvX9rB5bF5S79G3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZX47vZi+4IFzRs/sCWwPjCv4u
        Rk4OCQETieZL31i7GLk4hAR2M0rcufCfCSIhI3HywRJmCFtYYuW/5+wQRU8ZJX6fOM4IkmAT
        0Jd4vWI+G0hCRKCVWeLR01ssIAlmgUSJRyffs4PYQgLnGSVu7K0DsTkFXCUaTj0EmsrBISxQ
        KDH9QxKIySKgKnHyuheIyStgKfHkSxlIMa+AoMTJmU+gBupJrF8/hxHClpfY/nYO1GkKEj+f
        LmMFaRURcJKYfk0bokRc4ujPHuYJjMKzkEyahWTSLCSTZiFpWcDIsopRMrWgODc9t9iwwDAv
        tVyvODG3uDQvXS85P3cTIzjatDR3MG5f9UHvECMTB+MhRgkOZiUR3oTjDclCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MIkemrL4Xu2XE792vtLTObnc
        W8BqXtTz6Mbp82YHL/3gsPO/pdEDzipdQVuX7PwlQQGxy2be9ZYoDT9/YevjhBiZb1ff5N2c
        Vpu/QlzVX+UeX+MLOZXehON6p2bZ+yWq8S2o4DPRYL4+d3Nl12Xdkiz2LMnPthvUbr6/mvvC
        Nvv822ClrlmhYlMelq4wvM9VJb7wZLPelsDdnz7rlbmcc4uXiyjokXVZeu2l+NH5szbKswU6
        XRDb/Sk4dUm6xOWjNnsXXP9UyvWmWY6j0LEs9oGbWOfUuVpPF64/nXdPmqlerWbPVWuvc5dn
        WLwL6ttlZN7wY+KOdf8e/1MxMG+emN33uNd/R9yDaR3uvZIa35RYijMSDbWYi4oTAWsn1r8l
        AwAA
X-CMS-MailID: 20221125143313epcas5p3c22291a2740857bf7c8f82071f37808d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221125112240epcas5p3797c45b2fa34364040ba530d456a5ab2
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
        <CGME20221125112240epcas5p3797c45b2fa34364040ba530d456a5ab2@epcas5p3.samsung.com>
        <20221125112201.240178-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 25 November 2022 16:52
> To: Lee Jones <lee@kernel.org>; Rob Herring <robh+dt@kernel.org>;
Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
linux-samsung-
> soc@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Sriranjani P
> <sriranjani.p@samsung.com>; Chanho Park <chanho61.park@samsung.com>;
> Sam Protsenko <semen.protsenko@linaro.org>
> Subject: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
dedicated
> SYSREG compatibles to Exynos5433
> 
> Exynos5433 has several different SYSREGs, so use dedicated compatibles for
> them.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Sriranjani P <sriranjani.p@samsung.com>
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Reviewed-by: Sriranjani P <sriranjani.p@samsung.com>

>  .../bindings/soc/samsung/samsung,exynos-sysreg.yaml | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysreg.yaml
> b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysreg.yaml
> index 68064a5e339c..42357466005e 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysreg.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysre
> +++ g.yaml
> @@ -17,10 +17,21 @@ properties:
>                - samsung,exynos3-sysreg
>                - samsung,exynos4-sysreg
>                - samsung,exynos5-sysreg
> -              - samsung,exynos5433-sysreg
>                - samsung,exynos850-sysreg
>                - samsung,exynosautov9-sysreg
>            - const: syscon
> +      - items:
> +          - enum:
> +              - samsung,exynos5433-cam0-sysreg
> +              - samsung,exynos5433-cam1-sysreg
> +              - samsung,exynos5433-disp-sysreg
> +              - samsung,exynos5433-fsys-sysreg
> +          - const: samsung,exynos5433-sysreg
> +          - const: syscon
> +      - items:
> +          - const: samsung,exynos5433-sysreg
> +          - const: syscon
> +        deprecated: true
> 
>    reg:
>      maxItems: 1
> --
> 2.34.1


