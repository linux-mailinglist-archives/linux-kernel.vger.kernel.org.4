Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC3B6393E3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 05:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiKZEop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 23:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiKZEoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 23:44:37 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA022CE13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 20:44:35 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221126044433epoutp022734c5e92f5813eed7deb3e34a07fc6d~rCOaMCR8W1149911499epoutp02W
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 04:44:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221126044433epoutp022734c5e92f5813eed7deb3e34a07fc6d~rCOaMCR8W1149911499epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669437873;
        bh=6eoyjb5xyThRaXrfkkJP2APw2B2bW+9+8mfcxQSUseI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DY9PVTXpguc/g/1DtTovpTd3z14RuMZuwZslvZpDtygEa3pv0IYNmh+ub+Uoh1n4y
         mhByXbyUlHXxwBsKf3CIpSHD1ljHah7MxCFA5fSFcUSGnyelehrUn/Z9ON+zK01XQx
         iRteUCeizAH/j1nHULiC6SJR2wY6CAoh5pZPn+rk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221126044432epcas5p2fd8c88fc0e431c72c67015790cc89837~rCOZWxjuk0533005330epcas5p2t;
        Sat, 26 Nov 2022 04:44:32 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NJzfQ4RRrz4x9Pr; Sat, 26 Nov
        2022 04:44:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.7E.56352.EA991836; Sat, 26 Nov 2022 13:44:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221125143238epcas5p2496fc781c1de94b5e0d99ab2846f5f78~q2mmOueBE1357513575epcas5p28;
        Fri, 25 Nov 2022 14:32:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221125143238epsmtrp1ec90e2e6dddf92139054129f91b1fe57~q2mmN7qfe2159421594epsmtrp16;
        Fri, 25 Nov 2022 14:32:38 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-a8-638199aef634
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.2E.14392.602D0836; Fri, 25 Nov 2022 23:32:38 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221125143233epsmtip10c27877d2ee0731e133b60aa520b7913~q2mg4pzCz3099130991epsmtip16;
        Fri, 25 Nov 2022 14:32:32 +0000 (GMT)
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
In-Reply-To: <20221125112201.240178-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 2/4] dt-bindings: soc: samsung: exynos-sysreg: split
 from syscon
Date:   Fri, 25 Nov 2022 20:02:31 +0530
Message-ID: <016d01d900da$c46a6d80$4d3f4880$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIt87tfTwup8v8WQwS48SHvnyDBrAEBc5akAdyyr/6tjtwzQA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmlu66mY3JBlfmKVk8mLeNzeLyfm2L
        +UfOsVr0vXjIbLH39VZ2ix1tC1ksNj2+xmpxedccNosZ5/cxWbTuPcJu8bxvH5MDt8emVZ1s
        Hneu7WHz2Lyk3qNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
        zJUU8hJzU22VXHwCdN0yc4AOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBTo
        FSfmFpfmpevlpZZYGRoYGJkCFSZkZzQsO89ecEKhonvOdsYGxveSXYycHBICJhJNvRdZuxi5
        OIQEdjNK7F6xlBHC+cQoMadlPxuE841Rovf9HhaYlge/1kNV7WWUaNvZxw7hPGeUuLv4DFgV
        m4C+xOsV88HaRQT+M0n8/dUGlmAWSJQ4feYEUxcjOwengKvE/1yQqLBAmETrxm6wChYBVYlD
        +5ewgdi8ApYSx67uZISwBSVOznwCNUVeYvvbOcwQBylI/Hy6jBXEFhFwkrj9awE7RI24xNGf
        PVA1Wzgk1mx1hrBdJFqWnYOKC0u8Or6FHcKWknjZ3wZlp0tsPrKZFcLOkehoaoaqt5c4cGUO
        0A0cQPM1Jdbv0ocIy0pMPbWOCWItn0Tv7ydMEHFeiR3zYGw1icWPOqFsGYm1jz6xTmBUmoXk
        s1lIPpuF5INZCNsWMLKsYpRMLSjOTU8tNi0wzksth8d3cn7uJkZwstXy3sH46MEHvUOMTByM
        hxglOJiVRHgTjjckC/GmJFZWpRblxxeV5qQWH2I0BQb3RGYp0eR8YLrPK4k3NLE0MDEzMzOx
        NDYzVBLnXTxDK1lIID2xJDU7NbUgtQimj4mDU6qBSXrWso9LBawOfiubUjDBLJmhcc3q5ZO6
        V2sVlLh17l7upXki7Uyr3LGFfF+zmvatv5K/7vWakKc3HJQN32nnJa9MNPNXnPzFdJaIjtW5
        Y1/Ntx5sy97HUBbf4LtqZnNT7b4Kz/6UoLLw28dY1987+Wr6uRSJHZ8/96f8+CDQx/OTo1Of
        5c6GCewfknq/9ZQHF+S9OcTV9UH601OxTZ4eXM11H788cQp7OvEOZ9MvLtXfOu+/z5ouzc65
        fVrftu55kU8uvNmkG+8RbF93JHnjirk278QSy6NLMk2yrPZt7ZEudtu+9BZ7/I8Zi7N/T1pQ
        zvq715CdnWexT1B56kVvQxHdiypvU2Ym7nPpSH+7SYmlOCPRUIu5qDgRAMIKmB0/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnC7bpYZkg3e7NS0ezNvGZnF5v7bF
        /CPnWC36Xjxkttj7eiu7xY62hSwWmx5fY7W4vGsOm8WM8/uYLFr3HmG3eN63j8mB22PTqk42
        jzvX9rB5bF5S79G3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZDcvOsxecUKjonrOdsYHxvWQX
        IyeHhICJxINf6xlBbCGB3YwSBzcWQMRlJE4+WMIMYQtLrPz3nL2LkQuo5imjxK6PG1hBEmwC
        +hKvV8xnA0mICLQySzx6eosFJMEskCjx6OR7qI7zjBIN/W+ARrFzcAq4SvzPBSkRFgiRWN99
        DWwOi4CqxKH9S9hAbF4BS4ljV3cyQtiCEidnPoEaqSexfv0cRghbXmL72zlQxylI/Hy6DGyO
        iICTxO1fC9ghasQljv7sYZ7AKDwLyahZSEbNQjJqFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WK
        E3OLS/PS9ZLzczcxgiNOS3MH4/ZVH/QOMTJxMB5ilOBgVhLhTTjekCzEm5JYWZValB9fVJqT
        WnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD0/5t/562Ntr/udO7YFOdyZo/fKzr
        L1elz7xbxLtX05uRi+Hcz1/uj9YcE3zZrVDA8f3jvdtHTKMvLdGrMbP7vOnVs79HuDzP8YUu
        r91wkWOR7NbLLSssf2zYtCPBoPG847YHB+e2zfTO/BpfKzqpcv6yV77FxjVfVxR7Ti+Neq95
        Q+q4d/WRSjPeqT4s97eG5xl8bi8/mzhvbbOy0Z+ZesbXE462f9/KczdiVW2eWLVW4+9ZQZ1L
        Ns7J2nJtVz1j98upO5X9C98YeLovevd2Qo7Ld21n+RSxfz0h1b9kbPvF1A7wXXnuNseWkyng
        xrQ6twszrD4FPz7C/l321ry+pcrilVMXe70vsVnOdeFJC4cSS3FGoqEWc1FxIgBRZPbSJwMA
        AA==
X-CMS-MailID: 20221125143238epcas5p2496fc781c1de94b5e0d99ab2846f5f78
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221125112238epcas5p25b27eec809d72032216f2f8c375ea45b
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
        <CGME20221125112238epcas5p25b27eec809d72032216f2f8c375ea45b@epcas5p2.samsung.com>
        <20221125112201.240178-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
> Subject: [PATCH 2/4] dt-bindings: soc: samsung: exynos-sysreg: split from
> syscon
> 
> Split Samsung Exynos SoC SYSREG bindings to own file to narrow the
bindings
> and do not allow other parts of syscon.yaml.  This allows further
customization
> of Samsung SoC bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Sriranjani P <sriranjani.p@samsung.com>
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> ---

We agree for add separate YAML for  Samsung Exynos and hence I think we can 
go ahead and add  separate yaml for Tesla FSD.
Reviewed-by: Sriranjani P <sriranjani.p@samsung.com>

>  .../devicetree/bindings/mfd/syscon.yaml       |  6 ---
>  .../soc/samsung/samsung,exynos-sysreg.yaml    | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 6 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysreg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml
> b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 1b01bd010431..b73ba1ea08f7 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -64,12 +64,6 @@ properties:
>                - rockchip,rk3568-qos
>                - rockchip,rk3588-qos
>                - rockchip,rv1126-qos
> -              - samsung,exynos3-sysreg
> -              - samsung,exynos4-sysreg
> -              - samsung,exynos5-sysreg
> -              - samsung,exynos5433-sysreg
> -              - samsung,exynos850-sysreg
> -              - samsung,exynosautov9-sysreg
> 
>            - const: syscon
> 
> diff --git
> a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysreg.yaml
> b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysreg.yaml
> new file mode 100644
> index 000000000000..68064a5e339c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysre
> +++ g.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> +---
> +$id:
> +https://protect2.fireeye.com/v1/url?k=83e9bb90-e2921107-83e830df-
> 74fe48
> +60001d-5ef78ea8b86e70d7&q=1&e=8db037ae-b28c-44df-a71b-
> 6e7c367bb9d6&u=ht
> +tp%3A%2F%2Fdevicetree.org%2Fschemas%2Fsoc%2Fsamsung%2Fsamsung%
> 2Cexynos-
> +sysreg.yaml%23
> +$schema:
> +https://protect2.fireeye.com/v1/url?k=84a37bbf-e5d8d128-84a2f0f0-74fe48
> +60001d-bf5bdaa08b35d382&q=1&e=8db037ae-b28c-44df-a71b-
> 6e7c367bb9d6&u=ht
> +tp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> +
> +title: Samsung Exynos SoC series System Registers (SYSREG)
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - samsung,exynos3-sysreg
> +              - samsung,exynos4-sysreg
> +              - samsung,exynos5-sysreg
> +              - samsung,exynos5433-sysreg
> +              - samsung,exynos850-sysreg
> +              - samsung,exynosautov9-sysreg
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    system-controller@10010000 {
> +        compatible = "samsung,exynos4-sysreg", "syscon";
> +        reg = <0x10010000 0x400>;
> +    };
> --
> 2.34.1


