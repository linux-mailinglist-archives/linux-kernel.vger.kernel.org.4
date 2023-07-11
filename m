Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3685B74F312
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjGKPKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGKPKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:10:49 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B61170A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:10:33 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230711151029euoutp0246004263f8484be31a091a906496a228~w2Muowz6i2470624706euoutp02E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:10:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230711151029euoutp0246004263f8484be31a091a906496a228~w2Muowz6i2470624706euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689088229;
        bh=PR6/oisp6C6D0XMxyINuZwhMGfLjoew2gWfv7sDpXvY=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=aM8UbV4I3GoUpyt6vodDYo4g72CJT+T9ndhpNwgxhG/TUpGU/oBGxFFrGAvgfcExk
         K+rKiHMKjfKT527KeYUIvyGhzVAY7No+Vx1N04FgzFc9A63YC/ZeO+Kh4izcorbpw3
         v8cDfqTluAYhANgLq5qSABm8G+LW/u2lH8c7kv44=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230711151029eucas1p2a55cd6bb5a717d5489414afea00c4e47~w2MuQes3H1781617816eucas1p2t;
        Tue, 11 Jul 2023 15:10:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F1.91.11320.4E07DA46; Tue, 11
        Jul 2023 16:10:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230711151028eucas1p2c290e05e2df325ff16d53fea88ab8877~w2Mt7hyN80061100611eucas1p2K;
        Tue, 11 Jul 2023 15:10:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230711151028eusmtrp19bb25444389ec29dd674e3a370201f05~w2Mt6nYIy0196201962eusmtrp1E;
        Tue, 11 Jul 2023 15:10:28 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-05-64ad70e41771
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 14.63.10549.4E07DA46; Tue, 11
        Jul 2023 16:10:28 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230711151028eusmtip1a4ab5c8ae0daf7e045928ff55aa7449b~w2MtSFwzI0116901169eusmtip1K;
        Tue, 11 Jul 2023 15:10:27 +0000 (GMT)
Message-ID: <f33bb13a-b4dc-4011-1c59-3454d54c3606@samsung.com>
Date:   Tue, 11 Jul 2023 17:10:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 11/18] soc: samsung: Move power-domain driver to the
 genpd dir
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230711142148.751712-1-ulf.hansson@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmO+d4PFutPqeyNwuFkUFZahFxuidZ7V83IhKshh5M07k21w0i
        G1ZzXhpqNVfpWpaizkyXlWQXK5cZ3SwLEzUyreUg2yyWabUdK/897/M+z/s+78fHkOIqvxAm
        WZHBqRTyVCktpBpaPE/nfVBaE6Nd+QTbW9JAs6MFLf5s0+er/mzd+w4/tr3xLM268u4j1vj0
        FsE+eu2iWbt16yqBbORHAZJ1ddykZfVlh2UvH2r9ZPm2SiRz1YVuoOOEyxK51OS9nCpqxU7h
        rtLqPFppDdrfoftEZKI7WI8EDOCF8MTyivJiMa5AcFsn0SPhH+xGcNJiI/jChaDu4hfyr8Pm
        qSD5RjmCtpbecdUQgt6hC/5elQivgE7HIO3FFA6HErOR4PkAaC3u8+0Lxhxcf2vw0yOGCcRb
        oajVZyWxBDr7Sn3yIJwCN1ostHc+ifsRWH/m+Lw0ng96p943X4CXw2hp07g5DK45z/rSAXYz
        8DPvhD8fOxaqdcMUjwPBYbeN8zOgrTCX4g3HEZhHegi+MCDIHOhEvGopdD35QXujkng2XG6M
        4ukYeF10hvLSgKfAG2cAH2IKFDScJnlaBLpjYl49C0z2mn9r7z57QRqQ1DThWUwT7jdNOMf0
        f68ZUZVIwmnUaUmceoGC2xeplqepNYqkyIT0tDr05z+1jdnd11G5YyiyGREMakbAkNIgkfJu
        ZaJYlCg/cJBTpe9QaVI5dTOazlBSiShieWuCGCfJM7jdHKfkVH+7BCMIySRkyCCMdVdldw9r
        N+rnvguZWlPkaY9/EHvnY7ykuLw4dGzRmPHK7dE1wnPy/ARbT56+uyfTMRxRq1hbX6CJbhrr
        TpmWk6y4ZN7clNXfHzZQeqD6lGu6c/LittyRgdD2L579qPP+JMfM3Oys3I9drU6z/qu1Pc2S
        P+vbPXt2yZajDWLpobK96l+OwObtSaKY749MgsL0EsHnY8cdjeVZcc/iA1ZqDRkmbfDuQgve
        8rzWUy1yvxiJitHVUisjHh7psGwwrl6yJ+5Dij26cumpI4O/6JxNazcPldGHtmmV9TZxz2Nx
        aO3pvjfB19yDmsfGmq7zwzPWn1gXbry0/cKqMM3qIiml3iWfP4dUqeW/AbMMF1C+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xu7pPCtamGGzfp2HxYN42Nou/k46x
        W+x9vZXdYtPja6wWl3fNYbP43HuE0WLG+X1MFqeuf2azOL423IHT4/evSYwed67tYfPYvKTe
        48qJJlaPvi2rGD0+b5ILYIvSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQy5i/ppetYK1IxbWOl0wNjAcEuhg5OSQETCS2/FzB3MXIxSEksJRR4u6t
        y0wQCRmJk9MaWCFsYYk/17rYIIreM0oc2v6HESTBK2AncevVGzYQm0VAVWLeghlMEHFBiZMz
        n7CA2KICqRK/GnYBDeLgEBYIl5hykh0kzCwgLnHryXywchGBLIkbvY+YQOYzCzxjlFh4czUT
        xLIJjBJTVx1gBqliEzCU6HrbBbaMU8BW4u/8vVCTzCS6tnYxQtjyEtvfzmGewCg0C8kds5As
        nIWkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI3LbsZ+bdzDOe/VR7xAjEwfj
        IUYJDmYlEd6Cg6tShHhTEiurUovy44tKc1KLDzGaAgNjIrOUaHI+MCXklcQbmhmYGpqYWRqY
        WpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwVfsvO5zjO/fc6o+dUVt2VAcJKyz30xJX
        qeNYvvDj2gPv3jX3uLwMuyHabPK8bM3qyX+W7301m4HrXfL6okr+zaHH3/x8o7VVtVisaO/Z
        PSHvzi2RVez8ahv69Ub2vOvRfRz5p6SflZ03/KQ+h/FQd/Uv9sC/q6t+Bn9VCpWUdzy7K1tn
        irjahiqm59nhF5jYn6q+zjs69YLgmxTLlPfPJR/pHftnLLbI9/nLP/b7fRotheIiZZXP7xFY
        cIr/P7vSG8vX0wo7ZW9G3F8Ye06S92NI/1lX2U6JUyKhP3I2pB2S37pn5gdjD2t+194KthNq
        uu+O+K6aZvBMKOLxPcfvP/vDr/F8n7vqhu/fi2zp85RYijMSDbWYi4oTATh0F6tRAwAA
X-CMS-MailID: 20230711151028eucas1p2c290e05e2df325ff16d53fea88ab8877
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230711142243eucas1p24e278e48ee335a68d7c68690fa00306a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230711142243eucas1p24e278e48ee335a68d7c68690fa00306a
References: <CGME20230711142243eucas1p24e278e48ee335a68d7c68690fa00306a@eucas1p2.samsung.com>
        <20230711142148.751712-1-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.2023 16:21, Ulf Hansson wrote:
> To simplify with maintenance let's move the samsung power-domain driver to
> the new genpd directory. Going forward, patches are intended to be managed
> through a separate git tree, according to MAINTAINERS.
>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: <linux-samsung-soc@vger.kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
>   drivers/genpd/Makefile                                          | 1 +
>   drivers/genpd/samsung/Makefile                                  | 2 ++
>   .../samsung/pm_domains.c => genpd/samsung/exynos-pm-domains.c}  | 0
>   drivers/soc/samsung/Makefile                                    | 1 -
>   4 files changed, 3 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/genpd/samsung/Makefile
>   rename drivers/{soc/samsung/pm_domains.c => genpd/samsung/exynos-pm-domains.c} (100%)
>
> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> index c178421e0cbc..1cf0ff26a44f 100644
> --- a/drivers/genpd/Makefile
> +++ b/drivers/genpd/Makefile
> @@ -7,3 +7,4 @@ obj-y					+= mediatek/
>   obj-y					+= qcom/
>   obj-y					+= renesas/
>   obj-y					+= rockchip/
> +obj-y					+= samsung/
> diff --git a/drivers/genpd/samsung/Makefile b/drivers/genpd/samsung/Makefile
> new file mode 100644
> index 000000000000..397aa5908c1d
> --- /dev/null
> +++ b/drivers/genpd/samsung/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_EXYNOS_PM_DOMAINS)		+= exynos-pm-domains.o
> diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/genpd/samsung/exynos-pm-domains.c
> similarity index 100%
> rename from drivers/soc/samsung/pm_domains.c
> rename to drivers/genpd/samsung/exynos-pm-domains.c
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index d35270fc6b2b..248a33d7754a 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -10,7 +10,6 @@ obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
>   
>   obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
>   					exynos5250-pmu.o exynos5420-pmu.o
> -obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
>   obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o
>   
>   obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= s3c-pm-check.o

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

