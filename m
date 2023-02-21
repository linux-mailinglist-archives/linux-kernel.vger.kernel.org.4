Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9380969E5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjBURW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjBURWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:22:24 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476D62E0FB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:22:09 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230221172206epoutp02ac59048c9905487480c24352f3207ed8~F5rrRkqoL2248022480epoutp02n
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:22:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230221172206epoutp02ac59048c9905487480c24352f3207ed8~F5rrRkqoL2248022480epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677000126;
        bh=UbiAVM59wee6g19uTRe+lyskvMLYxlZKqXsp8xfBbqc=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=ercZAb7JC8x/z0thrnY2UqUHnZ1ZGIu3LGOwA192Q61cN2fIsjlsIzsRaOToNQMMB
         AZlnQi94Ohn/OHcTtOP0EFdL8yCaCa/ZhWT0Xyh3CynfhMF+0qSoWOAg4+pFphW0E5
         GOvGR7Q21W2miZBIKV9ipBiPoZdC/15fM0snBNAg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230221172205epcas5p2f61e9a6ffbf13e464a73910d67151677~F5rqtGuln0939609396epcas5p22;
        Tue, 21 Feb 2023 17:22:05 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PLmLM6y6pz4x9Pp; Tue, 21 Feb
        2023 17:22:03 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.87.06765.BBDF4F36; Wed, 22 Feb 2023 02:22:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230221172202epcas5p25e030d98c968d55e0f4a3754c43be66a~F5rn8Np600982309823epcas5p2p;
        Tue, 21 Feb 2023 17:22:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230221172202epsmtrp2df39e56aa8030faa67e44c3b24829744~F5rn7iVbK1052010520epsmtrp2-;
        Tue, 21 Feb 2023 17:22:02 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-34-63f4fdbbc0ef
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.07.17995.ABDF4F36; Wed, 22 Feb 2023 02:22:02 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230221172201epsmtip27c5c16ffcdfe97a80606f66aec6d9749~F5rmbhsEt1943719437epsmtip2H;
        Tue, 21 Feb 2023 17:22:00 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20230221161653.56574-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] ARM: dts: exynos: fix MCT compatible in Universal C210
Date:   Tue, 21 Feb 2023 22:51:59 +0530
Message-ID: <002d01d94619$031f7420$095e5c60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJi/D7R47zwqlSLgbm/lPVy3WSQigH7ldjwrbZcqPA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmhu7uv1+SDV60WljMP3KO1aLvxUNm
        i72vt7JbbHp8jdXi8q45bBYzzu9jsmjde4Tdgd1j06pONo871/aweWxeUu/xeZNcAEtUtk1G
        amJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0AFKCmWJOaVA
        oYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMrmtT
        2ArWcFe8/HqVqYHxPGcXIyeHhICJxLQ1s5lAbCGB3YwSHxpDuhi5gOxPjBKrZ55hgUh8ZpS4
        sz6ii5EDrGHFNkWI8C5GiY710hD2S0aJGwttQWw2AV2JHYvb2EDmiAhsYpL4sn8vO0iCU8BF
        4sGyPcwgtrCAt8SlL//A5rMIqEqcWTyLHWQ+r4ClxPHLcSBhXgFBiZMzn4CVMAvIS2x/O4cZ
        4mYFiZ9Pl7GC2CICVhLH9s1jhqgRl3h59Ag7yF4JgYkcEocmfmGCaHCRWDnpCSOELSzx6vgW
        dghbSuLzu71sEH95SCz6IwURzpB4u3w9VLm9xIErc1hASpgFNCXW79KHWMUn0fv7CRNEJ69E
        R5sQRLWqRPO7qywQtrTExO5uVgjbQ2Jv00NWSMhOZ5T4fnEm2wRGhVlIvpyF5MtZSL6ZhbB5
        ASPLKkbJ1ILi3PTUYtMC47zUcnhcJ+fnbmIEJ00t7x2Mjx580DvEyMTBeIhRgoNZSYT3P+/n
        ZCHelMTKqtSi/Pii0pzU4kOMpsCQn8gsJZqcD0zbeSXxhiaWBiZmZmYmlsZmhkrivOq2J5OF
        BNITS1KzU1MLUotg+pg4OKUamK4Jzex7dm62scThdxs0Pn0yv/Eva27S2uT2fruI1sDlD6LX
        1EVNstu9+Zes9mTH633/OYqXn5f5dTnu1usXR3IVOmP5jN6fc2pI0fpb9mjx3ilvDZbaCew/
        YFPz8LqoMcNkfT6NQ8sMp8dN1ZSsm/pk0/QDD42W8m/eajmL48wNTs4H+6aLXX2So6Wxnufa
        hzceOsVrninJKeekXe0tuR/9pkx7k+fEXKH6DZ5TbGM2u5eu6T/0/1p57fWee01ykrWzzq9Z
        zeTwQ+anlv2nvq+77u/STu3TMVmvxt76d42Hcsiljpdr406ZKYXNMZrEwRH6K+yb9qX8TI/w
        A7L/L+281Z34Zfq0XZH3UjNW//qkxFKckWioxVxUnAgAcoqX8SMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvO6uv1+SDd69U7OYf+Qcq0Xfi4fM
        Fntfb2W32PT4GqvF5V1z2CxmnN/HZNG69wi7A7vHplWdbB53ru1h89i8pN7j8ya5AJYoLpuU
        1JzMstQifbsEroyua1PYCtZwV7z8epWpgfE8ZxcjB4eEgInEim2KXYxcHEICOxglbs+6yNrF
        yAkUl5a4vnECO4QtLLHy33N2iKLnjBL7li5nA0mwCehK7FjcxgaSEBHYxiSxqvkPWEJIYCqj
        xMMVRSA2p4CLxINle5hBbGEBb4lLX/6xgNgsAqoSZxbPYge5glfAUuL45TiQMK+AoMTJmU9Y
        QMLMAnoSbRsZQcLMAvIS29/OYYa4R0Hi59NlYHeKCFhJHNs3jxmiRlzi5dEj7BMYhWYhmTQL
        YdIsJJNmIelYwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOEq0tHYw7ln1Qe8Q
        IxMH4yFGCQ5mJRHe/7yfk4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQ
        WgSTZeLglGpgOjTRcOpV5r+3k7qOipUsn8bI2Vd5Y6NJyedXDc59aczrzlzSllk5Z2ZAhCa3
        HFtQ5e2caIaNj8J9Hf692GAemHTV4fcur+SA86dPWVlqLkt9O/vfZ8WvEy4vnLCPLeZB5eWN
        adMCPqc+kmic3T4vo7vEjdHc4dTC7y83aJ/flNT/w1SBwyWiV2Gp5CbP3dmnQ4qE+7mUj2g9
        T/5VYFew4Xz1ydmyF6pbGj71v51nc+v83Z6HV0Pn8akECOx3FVt5+fKO9UWvPQMfcM07m3Iy
        40nC4ew1pieub/SY577yxfMYVrmZXMlbqi7Uqa+q1313+PuhQ6/teNnZ+YtXhgr+a17F8+PG
        pnN5XB6zlx+/JqzEUpyRaKjFXFScCAB0QNMGAQMAAA==
X-CMS-MailID: 20230221172202epcas5p25e030d98c968d55e0f4a3754c43be66a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230221161701epcas5p4dfda6ac2d5b098b6259bc647120bc22d
References: <CGME20230221161701epcas5p4dfda6ac2d5b098b6259bc647120bc22d@epcas5p4.samsung.com>
        <20230221161653.56574-1-krzysztof.kozlowski@linaro.org>
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
> Sent: Tuesday, February 21, 2023 9:47 PM
> To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH] ARM: dts: exynos: fix MCT compatible in Universal C210
> 
> When desired, nodes should be disabled instead of changing their
> compatible to a fake one:
> 
>   exynos4210-universal_c210.dtb: /soc/timer@10050000: failed to match any
> schema with compatible: ['none']
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Thanks!
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm/boot/dts/exynos4210-universal_c210.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 20840bd0d062..1acaa6dced99 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -513,7 +513,7 @@ &i2c_8 {
>  };
> 
>  &mct {
> -	compatible = "none";
> +	status = "disabled";
>  };
> 
>  &mdma1 {
> --
> 2.34.1


