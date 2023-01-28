Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B667F558
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 07:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjA1Gxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 01:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjA1Gxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 01:53:47 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5B577ED
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:53:42 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230128065340epoutp02c8d7818f59021eadfe56707555de346d~_ZoIp5QyA0763507635epoutp02k
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 06:53:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230128065340epoutp02c8d7818f59021eadfe56707555de346d~_ZoIp5QyA0763507635epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674888820;
        bh=5n4iboq7S91MUlbJ5yR11EbHrNTkBIoIbonSSb6/xhw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=BbtKJvgfJyQVZt+kgZzkqXqZo9vEEVnbNc2YvAluiu5tqrggw4H4v0GVrkO6jluLz
         G7oMMnSxGzKO2UWnPl2681UyDAZDBwGyhYGJ35EEHhHlNc3VIEfZWgtelhUQ2kPJeL
         PdRft5tfGq4xU63GfzbDpKUp4tmmA54sFQAw80tw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230128065339epcas5p399168ac3b550225d3edea90eb2861a70~_ZoH2-kzU1167511675epcas5p34;
        Sat, 28 Jan 2023 06:53:39 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4P3lXL1DPYz4x9Pp; Sat, 28 Jan
        2023 06:53:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.4A.55678.276C4D36; Sat, 28 Jan 2023 15:53:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230128065337epcas5p1cf180bb85a9b1fd5fb075a83e9f1fbfc~_ZoFx7gT42917629176epcas5p1D;
        Sat, 28 Jan 2023 06:53:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230128065337epsmtrp2dc54ded66d358b69bf39e16b2d515ef3~_ZoFxExiG0820808208epsmtrp2e;
        Sat, 28 Jan 2023 06:53:37 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-48-63d4c6729f2b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.70.05839.176C4D36; Sat, 28 Jan 2023 15:53:37 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230128065335epsmtip199d221183516dd2f6a07c02362bcfc53~_ZoEGLOky1987319873epsmtip1T;
        Sat, 28 Jan 2023 06:53:35 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Sam Protsenko'" <semen.protsenko@linaro.org>,
        "'Chanho Park'" <chanho61.park@samsung.com>
In-Reply-To: <20230120173116.341270-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 2/6] arm64: dts: exynos: add ADC supply on Exynos7
 Espresso
Date:   Sat, 28 Jan 2023 12:23:32 +0530
Message-ID: <001101d932e5$3f11c8d0$bd355a70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHe9LN3kxpYXwzfJTNDGvK99jO1aAK8aG7kAlPSQnquf17cIA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmum7RsSvJBlOPsFlc3q9tMf/IOVaL
        vhcPmS32vt7KbrHp8TVWi8u75rBZzDi/j8mide8RdovnffuYHDg9Nq3qZPO4c20Pm8fmJfUe
        fVtWMXp83iQXwBqVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITtj6YmrTAUreCq+/L7G3MC4iauLkZNDQsBE4vW7I2xdjFwcQgK7GSX6vv9l
        gnA+MUrM2ToRyvnGKDF7xg5WmJZ9p46xQyT2Mkr8+vUfqv8lo0T/glVMIFVsAroSOxa3gSVE
        BDYxSXzZvxeohYODWSBRouUIM0gNp4CrxIl9exhBbGGBQInjL1aAbWARUJXYPuUDG0g5r4Cl
        xKlbOiBhXgFBiZMzn7CA2MwC8hLb385hhjhIQeLn02VgrSICThIn1vxlhqgRl3h59AjYoRIC
        Kzkknr75zATR4CJxfNdjRghbWOLV8S3sELaUxOd3e8H2Sgh4SCz6IwURzpB4u3w9VLm9xIEr
        c1ggPtGUWL9LH2IVn0Tv7ydMEJ28Eh1tQhDVqhLN766yQNjSEhO7u6FB6CGx5O8RpgmMirOQ
        PDYLyWOzkDwwC2HZAkaWVYySqQXFuempxaYFRnmp5fDoTs7P3cQITqtaXjsYHz74oHeIkYmD
        8RCjBAezkgjvVsdLyUK8KYmVValF+fFFpTmpxYcYTYGBPZFZSjQ5H5jY80riDU0sDUzMzMxM
        LI3NDJXEedVtTyYLCaQnlqRmp6YWpBbB9DFxcEo1MLVm31Nhi3F/e/On/fxucfm480az5vC7
        pobNygrZ7rnszvwdvS/vprzkj+PbbsS+xpB/psvMSK/ZL+Zqvddu/3lhUotranXzyo9rNxze
        vLu9cWt06r7YR03Bs0tbCvbKrFyaqTtxgoaIh4jdrbJTGqI9i48UuiwW/HH0/f3eq4tCvs5U
        WujyQ+3MlyUL7v2Ytull3aL9z9b+Xr/ls6Sbm/iexceEFT78ylbiFvIxcb62QPzTskXC7nNW
        cTB33U2qjA2Oeb/pp8+tzKtVjy5brWKMfNrvJ+/L0nrjdJXg9dtbJ4eavHVem3BJ3Hi6jXYI
        X8J/mRY+d6XjWaolV+d+XXVFforiT+Pcd1fj/J0kbhorsRRnJBpqMRcVJwIApTk1VTQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTrfw2JVkg9t/pCwu79e2mH/kHKtF
        34uHzBZ7X29lt9j0+BqrxeVdc9gsZpzfx2TRuvcIu8Xzvn1MDpwem1Z1snncubaHzWPzknqP
        vi2rGD0+b5ILYI3isklJzcksSy3St0vgylh64ipTwQqeii+/rzE3MG7i6mLk5JAQMJHYd+oY
        excjF4eQwG5Gia61P5khEtIS1zdOYIewhSVW/nsOVfScUeLQlxusIAk2AV2JHYvb2EASIgLb
        mCRWNf9hA0kwCyRKrF3ZygjRcZ5RYuOcBSwgCU4BV4kT+/YwgtjCAv4ST/49B1vHIqAqsX3K
        B6BmDg5eAUuJU7d0QMK8AoISJ2c+YQEJMwvoSbRtZIQYLy+x/e0cqEMVJH4+XQZ2j4iAk8SJ
        NX+ZIWrEJV4ePcI+gVF4FpJJsxAmzUIyaRaSjgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz
        0vWS83M3MYKjS0tzB+P2VR/0DjEycTAeYpTgYFYS4d3qeClZiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBiaz9ANct+4mC/oYpjE22fwr3Lf0XPrOcMfL
        zi9+HW2oMnxVuGd6g6z7nDvPBS7ZrSy4bCm5fOWTFTOrpkTu/7B0I//l7dvWG2YuthMxYP15
        4PS2A24SO4xm/v11+O477TnzXty70qj8OucdU721jvmsuHqfxyYMWoW/y2SY1qTNZO+eW/ix
        Jl3hS3D7tolbVyW7L8iT6I9f8yZcyGl9/jfW7tdNeSw+ISzGd48IrLvF8yVplZ9NR+t+1TSG
        Mq6DewOZatudr8c/vlLDI60ksyG4y+nsUQueNqeDpX4vwyaEB/35sTE7LaMmYPYFx5tJ56df
        yGKU7NrRmsrcXjT3Qtwtwdl1JRXx6/99n3Ms1V2JpTgj0VCLuag4EQBBRXXQHQMAAA==
X-CMS-MailID: 20230128065337epcas5p1cf180bb85a9b1fd5fb075a83e9f1fbfc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230120173125epcas5p1c2b9e0c03f2776b8ca277919e0ba7be8
References: <20230120173116.341270-1-krzysztof.kozlowski@linaro.org>
        <CGME20230120173125epcas5p1c2b9e0c03f2776b8ca277919e0ba7be8@epcas5p1.samsung.com>
        <20230120173116.341270-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, January 20, 2023 11:01 PM
> To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Sam Protsenko <semen.protsenko@linaro.org>; Chanho Park
> <chanho61.park@samsung.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH 2/6] arm64: dts: exynos: add ADC supply on Exynos7
> Espresso
> 
> ADC requires supply and it seems LDO3 (same as on Exynos5433 TM2 boards)
> fits in voltage range of 1.8 V.  Use it to silence warning:
> 
Yes, it is LDO3 for exynos7_espresso board as well.

>   exynos7-espresso.dtb: adc@13620000: 'vdd-supply' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index 829657c9c7ca..abb3bd700d6f 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> @@ -78,6 +78,7 @@ &watchdog {
>  };
> 
>  &adc {
> +	vdd-supply = <&ldo3_reg>;
>  	status = "okay";
>  };
> 
> --
> 2.34.1


