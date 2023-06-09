Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F386B729CF3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbjFIOd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjFIOdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:33:24 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BC030F8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:33:21 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230609143317epoutp03e5c6cc978b8a71b093746c45b4593fd6~nBDHn0JA02994029940epoutp03F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:33:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230609143317epoutp03e5c6cc978b8a71b093746c45b4593fd6~nBDHn0JA02994029940epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686321197;
        bh=me+rLSB/b9GJujJAu0CxdDXUqp8gKCsUQo7RBcotCvU=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=c1Njslau/uUZ4+VH3HULWeK1O6V8EHLK2Iv+aPrdj3Oc501HsSB/T8M5bKdLy6y2l
         P4/Cb/2DOefmyNQSlQI7zVUkJgCmOxUPDs/e/ghmcwJwHz7r3CB+9QdwgZdmysn5UM
         vZ87RsjGjDfGQnQNl7zm72BEjQa8cDOwoYZqY6eY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230609143316epcas5p33ad45ed9c8971f82e327789259db5671~nBDGOQmll2770927709epcas5p3N;
        Fri,  9 Jun 2023 14:33:16 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Qd3Tk5Q5Dz4x9Pp; Fri,  9 Jun
        2023 14:33:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.95.04567.A2833846; Fri,  9 Jun 2023 23:33:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230609143314epcas5p10b58341bcfc6c4beba80f9260efc37df~nBDEKzFjc1099610996epcas5p1R;
        Fri,  9 Jun 2023 14:33:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230609143314epsmtrp154e5d8efd48e5f965618d24077296bf8~nBDEHrbSQ2364323643epsmtrp1T;
        Fri,  9 Jun 2023 14:33:14 +0000 (GMT)
X-AuditID: b6c32a49-943ff700000011d7-92-6483382adb43
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.37.28392.92833846; Fri,  9 Jun 2023 23:33:14 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230609143312epsmtip2db4e030b83f2545c23689acb258fcf0b~nBDCiMLnf1736317363epsmtip28;
        Fri,  9 Jun 2023 14:33:12 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Avri Altman'" <avri.altman@wdc.com>,
        "'Bart Van Assche'" <bvanassche@acm.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20230609140651.64488-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] dt-bindings: ufs: samsung,exynos: drop unneeded quotes
Date:   Fri, 9 Jun 2023 20:03:10 +0530
Message-ID: <1efd01d99adf$5289fe20$f79dfa60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ2GdCv8AveMME/ypslsmkvG38IjAO0j+NfrivkBWA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmhq6WRXOKwbVFGhYvf15ls5j24Sez
        xZq955gs5h85x2rR9+Ihs8Xe11vZLTY9vsZqcXnXHDaLGef3MVl0X9/BZtG69wi7A7fH5Sve
        HptWdbJ53Lm2h81j85J6j8+b5DzaD3QzBbBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZ
        GOoaWlqYKynkJeam2iq5+AToumXmAF2npFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1I
        ySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO6N93mqngHV9F99r1bA2M+3m6GDk5JARMJPa/
        e8rUxcjFISSwm1Fi2/XX7BDOJ0aJiVcb2UCqhAQ+M0rcXKLZxcgB1vH6sQhEzS5GiXv3W1kh
        nJeMEg8P7GcHaWAT0JXYsbiNDSQhInCWWeLXiVNgCU4BF4lLq2cwg9jCAt4SvV8WMILYLAIq
        EgfnNYPFeQUsJWb86mWDsAUlTs58wgJiMwvIS2x/O4cZ4m4FiZ9Pl7GC2CICVhJrN91mhqgR
        l3h59Ag7RM0WDon7G0IhbBeJlnaIXRICwhKvjm+BqpGSeNnfxg7xmYfEoj9SEOEMibfL10OV
        20scuDKHBaSEWUBTYv0ufYhNfBK9v58wQXTySnS0CUFUq0o0v7vKAmFLS0zs7maFsD0k3s8+
        zQYJqumMEouuv2KbwKgwC8mTs5A8OQvJM7MQNi9gZFnFKJlaUJybnlpsWmCYl1oOj+7k/NxN
        jOCkq+W5g/Hugw96hxiZOBgPMUpwMCuJ8GqbNKcI8aYkVlalFuXHF5XmpBYfYjQFhvxEZinR
        5Hxg2s8riTc0sTQwMTMzM7E0NjNUEudVtz2ZLCSQnliSmp2aWpBaBNPHxMEp1cA0ycL7o+n5
        2rOspqJvGqQOP72iGdeQkty7zGXvGy29X575iW2dhbE3evRyv/8/rfTj0NxS2xPeebN8299U
        RM/d5sYQLKukazbXOPH4/5P6amFnbRUEXpZnyNTeX3Nkavf5bw8n+1cvPsTOPVldNf3buQYh
        rXWi7pu/HdpY8N0g59l/gbvnghZU3EzWZqxoWszwxP/iliXu9qrvdfXPpeiK+2wTWhhoY3yy
        IlShMvJbpdWb0hNbtskZKkx6+2dCWHyuFVvg3ecL7T0Mljq79qYePZyopfphYarAhIeHt7M2
        zE64+lpirbRak5Li/N1ly9mObwj4+ltQuC1+K5/a40cVEzsDV9i9vWem8fiARKwSS3FGoqEW
        c1FxIgDHGrboQwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXlfLojnF4MwyRouXP6+yWUz78JPZ
        Ys3ec0wW84+cY7Xoe/GQ2WLv663sFpseX2O1uLxrDpvFjPP7mCy6r+9gs2jde4Tdgdvj8hVv
        j02rOtk87lzbw+axeUm9x+dNch7tB7qZAtiiuGxSUnMyy1KL9O0SuDL6951mKnjHV9G9dj1b
        A+N+ni5GDg4JAROJ149Fuhi5OIQEdjBKHPj5gqWLkRMoLi1xfeMEdghbWGLlv+fsEEXPGSWO
        HF3MCJJgE9CV2LG4jQ0kISJwlVniy+/JjBBVUxklbv9uBqviFHCRuLR6BjOILSzgLdH7ZQFY
        nEVAReLgvGawOK+ApcSMX71sELagxMmZT1hAzmMW0JNo2whWziwgL7H97RxmiIsUJH4+XcYK
        YosIWEms3XSbGaJGXOLl0SPsExiFZiGZNAth0iwkk2Yh6VjAyLKKUTK1oDg3PbfYsMAoL7Vc
        rzgxt7g0L10vOT93EyM4xrS0djDuWfVB7xAjEwfjIUYJDmYlEV5tk+YUId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpiWW+x6J7dzheXOJQK/fs+9Okns
        aIBt//UtTMv0Tx9te2sk/OPMlzpZv+3vWmU5Hge5/C3r+SAnttNxuiGfY+TJSW+zZddPf7lF
        xULifGdtYk/ZtHbl7pYwl90/zHK3fV6mXyD89NHtb3+4MwxPnt944Pq1LSWTijU9Mn+zK+sF
        GblrMBXIhgv21Ko9V83zMV8/R8q4KrXkTP1lb7UZgml1L2eG+r+5NYH3ZP2dnbt041auFl3s
        msB/9d/zpQXvL9dEXWCNe2BfLJewoNqufNW995MXbSgWbElU3Ot7L9dn56U5LPZ7koS7dqqZ
        P/iW1X/AmtVq+v9GBuvtv6e7lC1teboi69My4aI5un7af9SUWIozEg21mIuKEwErhDYfIAMA
        AA==
X-CMS-MailID: 20230609143314epcas5p10b58341bcfc6c4beba80f9260efc37df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230609140700epcas5p39500e13a887cbbcf0f79f7b3a5b3789d
References: <CGME20230609140700epcas5p39500e13a887cbbcf0f79f7b3a5b3789d@epcas5p3.samsung.com>
        <20230609140651.64488-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, June 9, 2023 7:37 PM
> To: Alim Akhtar <alim.akhtar@samsung.com>; Avri Altman
> <avri.altman@wdc.com>; Bart Van Assche <bvanassche@acm.org>; Rob
> Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; linux-scsi@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH] dt-bindings: ufs: samsung,exynos: drop unneeded quotes
> 
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Thanks!

Acked-by: Alim Akhtar <alim.akhtar@samsung.com>

>  Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-
> ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-
> ufs.yaml
> index a9988798898d..88cc1e3a0c88 100644
> --- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> @@ -54,7 +54,7 @@ properties:
>      const: ufs-phy
> 
>    samsung,sysreg:
> -    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: Should be phandle/offset pair. The phandle to the syscon
> node
>                   which indicates the FSYSx sysreg interface and the
offset of
>                   the control register for UFS io coherency setting.
> --
> 2.34.1


