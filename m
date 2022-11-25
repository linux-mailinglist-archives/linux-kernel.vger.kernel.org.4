Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104956393E8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 05:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiKZEpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 23:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiKZEom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 23:44:42 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A12CE2E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 20:44:41 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221126044439epoutp02bdd5ed99d22a6e566e6be8d035d0e77f~rCOgT5mV41149911499epoutp02Y
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 04:44:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221126044439epoutp02bdd5ed99d22a6e566e6be8d035d0e77f~rCOgT5mV41149911499epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669437879;
        bh=klC3Ze6CsU7jU+5ImFRcxx8BOAW8fkPo2fpyuousOCo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=EL5faRLCdUxKbIEShBoiPmpI/6bA+W4vFZVS+Gw+MqDHOKr1fZtOGl8Sc/prHfa3t
         kSkUjnRjiccM9o2MQ1tGfC5cfX1jHiwg7V16fJnnketTtGhpTggkmfKilA+A/eemaZ
         +VYh66tNHfHolvUmlaFD7ZoQyd19S3KOSrGArZnU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221126044439epcas5p2b4b6de423d46f804d6bc0bee66539392~rCOfqM-yL0533105331epcas5p2B;
        Sat, 26 Nov 2022 04:44:39 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NJzfY2MMHz4x9Pv; Sat, 26 Nov
        2022 04:44:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.7E.56352.5B991836; Sat, 26 Nov 2022 13:44:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221125143359epcas5p2e3ab4843f882f3b0103fcf92ec0aac88~q2nw9gcCZ1260512605epcas5p29;
        Fri, 25 Nov 2022 14:33:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221125143359epsmtrp2d801fa3c87ffeefbb5488f0444537a9c~q2nw7ZhGA2471724717epsmtrp2S;
        Fri, 25 Nov 2022 14:33:59 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-b8-638199b5b883
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.2E.14392.652D0836; Fri, 25 Nov 2022 23:33:58 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221125143353epsmtip2ce6f90109229a5d41dd13180028f3fbc~q2nrpSkXW0641206412epsmtip2p;
        Fri, 25 Nov 2022 14:33:52 +0000 (GMT)
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
In-Reply-To: <20221125112201.240178-4-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 4/4] dt-bindings: soc: samsung: exynos-sysreg: add
 clocks for Exynos850
Date:   Fri, 25 Nov 2022 20:03:49 +0530
Message-ID: <016f01d900da$f44148d0$dcc3da70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIt87tfTwup8v8WQwS48SHvnyDBrAJHFqkaAo0HZj6tfy1NYA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmhu7WmY3JBrOW8Fg8mLeNzeLyfm2L
        +UfOsVr0vXjIbLH39VZ2ix1tC1ksNj2+xmpxedccNosZ5/cxWbTuPcJu8bxvH5MDt8emVZ1s
        Hneu7WHz2Lyk3qNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
        zJUU8hJzU22VXHwCdN0yc4AOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBTo
        FSfmFpfmpevlpZZYGRoYGJkCFSZkZ/y4JVXwX6Di9Luj7A2MZ3m7GDk5JARMJCa/+cfaxcjF
        ISSwm1Hi+On7bBDOJ0aJZ19uM0E43xgl5vz/zAzTsmBXD1TVXkaJqU/3QlU9Z5TYd3sdE0gV
        m4C+xOsV88GqRAT+M0n8/dXGApJgFkiUOH3mBFgRp4CrRMf6NUA2B4ewQKxE100vEJNFQFVi
        5jddkApeAUuJn2vfsEHYghInZz6BmiIvsf3tHKiDFCR+Pl3GCmKLCDhJdC2ZywxRIy5x9GcP
        M8gJEgJrOSQO3H/CCjJfQsBFor3NDaJXWOLV8S3sELaUxOd3e9kg7HSJzUc2s0LYORIdTc1Q
        u+wlDlyZwwIyhllAU2L9Ln2IsKzE1FMQnzML8En0/n7CBBHnldgxD8ZWk1j8qBPKlpFY++gT
        6wRGpVlIPpuF5LNZSD6YhbBtASPLKkbJ1ILi3PTUYtMC47zUcnh0J+fnbmIEp1ot7x2Mjx58
        0DvEyMTBeIhRgoNZSYQ34XhDshBvSmJlVWpRfnxRaU5q8SFGU2BoT2SWEk3OByb7vJJ4QxNL
        AxMzMzMTS2MzQyVx3sUztJKFBNITS1KzU1MLUotg+pg4OKUamHj5+ou1G3TiNwS3Jf0V+lW3
        5EbTfAd1zhRfDeES0eb1n8RXXV64L/KBqnD14wOMjtxam9NtLXczJeSd5mxambZgpXHyx32Z
        td/vmei+SPRJWs3GuHPj5s7z5xp3yocu5WtlNu0RO19kza007WNP2f2/xj+CeJqDV39516d6
        /MeiC15ZbMxW1U83PBP6POHn/2P6+7JWHovc1CVabfJpz6NDIpM/Bx44zKV4ynNxqRfXykPm
        V5YmXxcNOHisfYm4pY37htNOZ3jilgQEME1WCS658Sz2x9xzf1lazwsfXvj/YWW5u+o0se9n
        z8f3HNk5Qaziiv6P8g1JjVEJf3Y07Oi36BVbv1ei5rCfjfO0LCWW4oxEQy3mouJEAEpMazg+
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSvG7YpYZkg3XrLCwezNvGZnF5v7bF
        /CPnWC36Xjxkttj7eiu7xY62hSwWmx5fY7W4vGsOm8WM8/uYLFr3HmG3eN63j8mB22PTqk42
        jzvX9rB5bF5S79G3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZP25JFfwXqDj97ih7A+NZ3i5G
        Tg4JAROJBbt62LoYuTiEBHYzSlxe9p0NIiEjcfLBEmYIW1hi5b/n7BBFTxklXu+7xQqSYBPQ
        l3i9Yj5Yt4hAK7PEo6e3WEASzAKJEo9OvofqOM8o8X3RPLAOTgFXiY71a5hAbGGBaImzOz8C
        2RwcLAKqEjO/6YKEeQUsJX6ufcMGYQtKnJz5BGqmnsT69XMYIWx5ie1v50BdpyDx8+kysPEi
        Ak4SXUvmMkPUiEsc/dnDPIFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn
        5haX5qXrJefnbmIEx5yW5g7G7as+6B1iZOJgPMQowcGsJMKbcLwhWYg3JbGyKrUoP76oNCe1
        +BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmH4vzqpPf82pe+DFvI+veKSUeCxSY
        pddmTtuYd3sq6/ObE7/E6D7RZXgvn5gy81zCAfE58mYVqySNA90CJiasttv/7rDTZr2il+Xf
        nTXXNS9+EDGRRWH+nVeXNrvduzM37hUP6+4PtyKDf6+Vi/ndclkw7JrZFqmvJQvnldc9nb1Q
        NO7h28xL5f+F/j0Xmvau1U58Z4dM82+7/bes1MKPux+Jt5Kc+nqhaum5F0IuqnwrLn5nmrAk
        rp35TlTHLNH6VFuZe5MtZK5F3zmtcD3EbmfLepmeP1Fzpss5+W44rq/Wu1O9PeXfqot/2R8u
        vq0fON0uz+Mfk3KMsTIf8+GJxTOWai7/FFo/ZePPkNm6a5VYijMSDbWYi4oTAdhGvgooAwAA
X-CMS-MailID: 20221125143359epcas5p2e3ab4843f882f3b0103fcf92ec0aac88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221125112239epcas5p2a7c3cbe93480ea421f391730e78d8145
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
        <CGME20221125112239epcas5p2a7c3cbe93480ea421f391730e78d8145@epcas5p2.samsung.com>
        <20221125112201.240178-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> Subject: [PATCH 4/4] dt-bindings: soc: samsung: exynos-sysreg: add clocks
for
> Exynos850
> 
> Exynos850 has dedicated clock for accessing SYSREGs.  Allow it, even
though
> Linux currently does not enable them and relies on bootloader.
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

>  .../soc/samsung/samsung,exynos-sysreg.yaml        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysreg.yaml
> b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysreg.yaml
> index 42357466005e..27cea934a286 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysreg.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysre
> +++ g.yaml
> @@ -36,10 +36,25 @@ properties:
>    reg:
>      maxItems: 1
> 
> +  clocks:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> 
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - samsung,exynos850-sysreg
> +    then:
> +      properties:
> +        clocks: false
> +
>  additionalProperties: false
> 
>  examples:
> --
> 2.34.1


