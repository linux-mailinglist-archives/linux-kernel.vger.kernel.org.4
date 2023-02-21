Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD64269EA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjBUWnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBUWnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:43:12 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ED483FC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:43:10 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230221224306euoutp028e59084161c9a7285825b30de6887668~F_D87lbDF0334303343euoutp02Q
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 22:43:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230221224306euoutp028e59084161c9a7285825b30de6887668~F_D87lbDF0334303343euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677019386;
        bh=Iz5GQOd933SaS779t64oEsQ7jkLKnbVH/6sC9JA7sxI=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=ALEHijqcVSXl5bH2ACi8UJZvUN0GA/sCD6emHjEncDVetYL49I7MqCSZctWVQSxOm
         b1LCdAiBu7ddWKLfjoJqEuz6uiTt+axwZoeypuKVmcTkxcZrkBJUQLKWWzINC03ejT
         ZPdv3jVkqvt6UMZp3TVHUwhbuo+FngD3iuY2iFc4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230221224306eucas1p18b4c7ab15cde75614c9349642852a68f~F_D8tK45E2031020310eucas1p1j;
        Tue, 21 Feb 2023 22:43:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 04.D2.61197.AF845F36; Tue, 21
        Feb 2023 22:43:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230221224305eucas1p2cad26ee8948736d5928b27d8d9cd8d2e~F_D7lChuA1024610246eucas1p2R;
        Tue, 21 Feb 2023 22:43:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230221224305eusmtrp29c11f1c5800574d626f5fe9c3e77f15f~F_D7kfTKJ3081630816eusmtrp2G;
        Tue, 21 Feb 2023 22:43:05 +0000 (GMT)
X-AuditID: cbfec7f5-7c5ff7000000ef0d-3b-63f548fa4f1d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 46.9E.02722.9F845F36; Tue, 21
        Feb 2023 22:43:05 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230221224304eusmtip1c48a40e6e2f901d6c64483c19a0f4032~F_D7FYezL0897008970eusmtip1d;
        Tue, 21 Feb 2023 22:43:04 +0000 (GMT)
Message-ID: <f2025f4c-9be2-fdff-1448-3409cdb35c93@samsung.com>
Date:   Tue, 21 Feb 2023 23:43:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] ARM: dts: exynos: fix MCT compatible in Universal C210
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230221161653.56574-1-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87q/PL4mG9yeLWHxYN42Nov5R86x
        WvS9eMhssff1VnaLTY+vsVpc3jWHzWLG+X1MFq17j7A7cHhsWtXJ5nHn2h42j81L6j36tqxi
        9Pi8SS6ANYrLJiU1J7MstUjfLoEr41HDCqaCJ+wVRyf/Zm1g3MXWxcjJISFgIrH6yyIgm4tD
        SGAFo8SGnc9ZIZwvjBIvJt9ggnA+M0pMudjFCNPyYcMBRojEckaJvTefskA4HxklHp1/ADaY
        V8BO4tr6DSwgNouAqsTdaT0sEHFBiZMzn4DZogIpEqdX7wGq5+AQFvCWeP+qDCTMLCAucevJ
        fLDNIgJHmSSWzvjJBJJgEzCU6HrbBTafU8BF4sGyPcwQDfIS29/OYQZpkBC4wyHRPe0kM8Sp
        LhLrNs9hgbCFJV4d38IOYctI/N8JsUFCoJ1RYsHv+1DOBEaJhue3oB61lrhz7hfYecwCmhLr
        d+mDmBICjhLrlrlAmHwSN94KQtzAJzFp23RmiDCvREebEMQMNYlZx9fBbT144RLUZR4Sc2at
        ZZ/AqDgLKVRmIXl/FpLPZiGcsICRZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgMjr9
        7/jXHYwrXn3UO8TIxMF4iFGCg1lJhPc/7+dkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzatieT
        hQTSE0tSs1NTC1KLYLJMHJxSDUwMQvGJlk8yLrXd/vvhZEVsm4qsy/Vgvu1uhT9kjp9Y6yzS
        IHwy4dBBDh+vz4E9ZXKXZ01UnJEk6p6708VVN1/t7MGn7i26Zhf/WIsw6sQ/OFIuImDsOuXL
        QpfSaq/N+/p09z1VLv+gOU8i7derJv/jty9sn/j70PoV/Cn61m03pwbunnxk/eO1XoLHaqaw
        r5+6hFF4ztwojdCU1Zt62i5MfrKHKXZPxJzpK7Sf/BQ5r/zr/v7CmZe09zPwhHL+3Lnd9vC2
        nTtfRWRs7dwdZfyx+cC7Q0oT/PS3q5/3sVcw5+5fOGnyyn0TozVmqxptDGzdM2nWsgWnvEJX
        /nIR59m7UvJi5qkXW42yNv+e/eaHuRJLcUaioRZzUXEiACKmhfW1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xu7o/Pb4mGyx7wWnxYN42Nov5R86x
        WvS9eMhssff1VnaLTY+vsVpc3jWHzWLG+X1MFq17j7A7cHhsWtXJ5nHn2h42j81L6j36tqxi
        9Pi8SS6ANUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjf
        LkEv41HDCqaCJ+wVRyf/Zm1g3MXWxcjJISFgIvFhwwHGLkYuDiGBpYwS367MgkrISJyc1sAK
        YQtL/LnWxQZR9J5R4s+CFWAJXgE7iWvrN7CA2CwCqhJ3p/WwQMQFJU7OfAJmiwqkSHy+N5e9
        i5GDQ1jAW+L9qzKQMLOAuMStJ/OZQGaKCBxnkvg0aQEzxILpjBJnv59jB6liEzCU6HrbBXYR
        p4CLxINle5ghus0kurZ2MULY8hLb385hnsAoOAvJ7llIlsxC0jILScsCRpZVjCKppcW56bnF
        hnrFibnFpXnpesn5uZsYgXG27djPzTsY5736qHeIkYmD8RCjBAezkgjvf97PyUK8KYmVValF
        +fFFpTmpxYcYTYEBMJFZSjQ5HxjpeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakF
        qUUwfUwcnFINTGLVsaUiS3rX5Hxd9Lv4uXNTDlvTSq+UC9Z7vNZs+3R8Mv9nlYp2qcjFj6Zx
        pM78fuaw7oxFy25JfJgktpz1c8Kh5F1CG7XFW87N2Me7g/3ZvaxTPw9oOtUFVa8NUli93LVI
        +nW7q9Qb+cJdp2PrdovFcFxeHeDckT/BxWjKZBl9+0keLb5BPGsFHoSGOK5kq/3/nWNJxM4V
        hqez9+18IPPm+Jp0xfNvcm//3ruuIWPp1qavBr5Va9hcnA/PPRXxda8Ly6OfqpYrim4UPCiZ
        cWpTs8B9zqqpGX3LFz68MCMxtuf0g9gNYrzaDUWN7cvenFtn91J8B2fdOxneo5fsD0rbZ6bs
        6r350kC0NfX+ND0lluKMREMt5qLiRAD3ChUdPAMAAA==
X-CMS-MailID: 20230221224305eucas1p2cad26ee8948736d5928b27d8d9cd8d2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230221161703eucas1p1b1bb6725be0a846c13c5ffa84cbd6596
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230221161703eucas1p1b1bb6725be0a846c13c5ffa84cbd6596
References: <CGME20230221161703eucas1p1b1bb6725be0a846c13c5ffa84cbd6596@eucas1p1.samsung.com>
        <20230221161653.56574-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.2023 17:16, Krzysztof Kozlowski wrote:
> When desired, nodes should be disabled instead of changing their
> compatible to a fake one:
>
>    exynos4210-universal_c210.dtb: /soc/timer@10050000: failed to match any schema with compatible: ['none']
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm/boot/dts/exynos4210-universal_c210.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 20840bd0d062..1acaa6dced99 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -513,7 +513,7 @@ &i2c_8 {
>   };
>   
>   &mct {
> -	compatible = "none";
> +	status = "disabled";
>   };
>   
>   &mdma1 {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

