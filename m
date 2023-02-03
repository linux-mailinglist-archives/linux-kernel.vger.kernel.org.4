Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC95C689BE0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjBCOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjBCOdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:33:41 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA2901E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:33:31 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230203143329euoutp01579d96117babb57b786567d91a847a3a~AVxT7u_L80291002910euoutp01O
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:33:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230203143329euoutp01579d96117babb57b786567d91a847a3a~AVxT7u_L80291002910euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675434809;
        bh=OkEJRBh0JP6wqBS/M1cu6izGd5JAkmxdwpgVhRVYZF4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=mYF62MBQ3D/74aX+LHDVvfsemXESwTrSC4vYBqBvo2HX0guPPdpM9hTwyEee0/b4c
         Rh2rNIxB5v4GCrCOrpJJ1MIvw/lIRbzFK+zZI14G+FyAHjxV+CiMs7VJ+orPtLxt8T
         hyiYZ8Yq1hwspnmEajGNS04BTGjgQdL797Y6mGDU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230203143328eucas1p198a7b10670e5a2dd2c69e73bd5f8da17~AVxTjiH--2844028440eucas1p18;
        Fri,  3 Feb 2023 14:33:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D0.D1.13597.83B1DD36; Fri,  3
        Feb 2023 14:33:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230203143328eucas1p1b6398762544f010e641f72c05444da70~AVxTHJ4lF3241032410eucas1p12;
        Fri,  3 Feb 2023 14:33:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230203143328eusmtrp10b6f54a2e3a0023e7ea9254c880e8468~AVxTGR2_O0114901149eusmtrp1o;
        Fri,  3 Feb 2023 14:33:28 +0000 (GMT)
X-AuditID: cbfec7f4-1f1ff7000000351d-01-63dd1b3841e0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F8.86.02722.73B1DD36; Fri,  3
        Feb 2023 14:33:28 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230203143327eusmtip15cee27af968567e61317c6912703ce13~AVxSYq4GT3048330483eusmtip1B;
        Fri,  3 Feb 2023 14:33:27 +0000 (GMT)
Message-ID: <cc9734eb-4157-eea3-90a2-4f7eb36de744@samsung.com>
Date:   Fri, 3 Feb 2023 15:33:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 0/6] clk: samsung: Add PM support for ARM64 Exynos chips
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230203060924.8257-1-semen.protsenko@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djPc7oW0neTDfbfkLd4MG8bm8Xl/doW
        1788Z7XY+3oru8Wmx9dYLT723GO1uLxrDpvFjPP7mCwunnK1OPymndXi37WNLBbP+4BCp+5+
        ZrdYtesPo8Xx948ZHfg93t9oZffYOesuu8emVZ1sHneu7WHz2Lyk3qNvyypGj8+b5ALYo7hs
        UlJzMstSi/TtErgyZu6YxVRwSLqi5+McpgbGCaJdjJwcEgImErOvTmXuYuTiEBJYwSgxc+Eb
        NgjnC6NE06OjrBDOZ0aJz71XWWFa5tydxw6RWM4oMefcRSjnI6PEwfu9TCBVvAJ2EntnTWEE
        sVkEVCS+9Z1nh4gLSpyc+YSli5GDQ1QgRWLTnzKQsLCAj8SkL0/BFjALiEvcejKfCWSmiMBu
        RolXz16BHcgssJhZ4vaRNrBBbAKGEl1vu9hAbE4Be4nbW7YyQ3TLS2x/OwesQUJgMSfQRxtY
        QbZJCLhI3H6XAfGCsMSr41vYIWwZidOTe1gg6tsZJRb8vs8E4UxglGh4fosRospa4s65X2wg
        g5gFNCXW79KHCDtKfNszkR1iPp/EjbeCEDfwSUzaNp0ZIswr0dEmBFGtJjHr+Dq4tQcvXGKe
        wKg0CylYZiH5fxaSb2Yh7F3AyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMMmd/nf8
        yw7G5a8+6h1iZOJgPMQowcGsJMK7/PSdZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYnk4UE
        0hNLUrNTUwtSi2CyTBycUg1MOVO6bvPvW7qv58aMfbt2X8460bRsd7q5ayDXp3iDP3b3t/kf
        WuMRqmATw/S8ftG9GQ4sHzUE3ndEn1RyP/Mg9dzCLT28Z9LuPZ45V6lSSOdNvaU1139Ol8I1
        tgnrORrZPjHc6/i84c2RtTnPk18Fu8ZN3Hp6+/au2/Yl34SOWlRs+HdU8eL8PmPhaSzFlxke
        B1/rmXbeePWe/k0rC343Nl6xq/EQvBS6b8peh6i9Ty4fjK6Jn8bz813V0UMXpwZVSJukvUgS
        TCg8nVIo+TXFRCyuN7L9RX6zn8j5YPl5NcHXNH9PKc/3OnBlXvuK2Cd6+s/ZG9kvLtxubVp3
        xd1hlory/Z7XvywUQk9+OyYvqMRSnJFoqMVcVJwIALZnOmvhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsVy+t/xu7oW0neTDeYuYbZ4MG8bm8Xl/doW
        1788Z7XY+3oru8Wmx9dYLT723GO1uLxrDpvFjPP7mCwunnK1OPymndXi37WNLBbP+4BCp+5+
        ZrdYtesPo8Xx948ZHfg93t9oZffYOesuu8emVZ1sHneu7WHz2Lyk3qNvyypGj8+b5ALYo/Rs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyZu6YxVRw
        SLqi5+McpgbGCaJdjJwcEgImEnPuzmMHsYUEljJKfJmWBBGXkTg5rYEVwhaW+HOtiw2i5j2j
        xLm12iA2r4CdxN5ZUxhBbBYBFYlvfefZIeKCEidnPmEBsUUFUiSan58EmyMs4CMx6ctTMJtZ
        QFzi1pP5TF2MXBwiAnsZJdaseswO4jALLGWW6N65hAXEERKYxCixZP4OsBY2AUOJrrcQZ3AK
        2Evc3rKVGWKUmUTX1i5GCFteYvvbOcwTGIVmIblkFpKNs5C0zELSsoCRZRWjSGppcW56brGh
        XnFibnFpXrpecn7uJkZgVG879nPzDsZ5rz7qHWJk4mA8xCjBwawkwrv89J1kId6UxMqq1KL8
        +KLSnNTiQ4ymwOCYyCwlmpwPTCt5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWp
        RTB9TBycUg1MO9yj8yKVp8024XqunKkrvmTiKz5J9efT5Wy50p+luC08xHsuXUZXO0N154nX
        03PvWD2aMlW3oe7hBLs5dmlNi9jnlrGs3HE5j3kpqwCzmcXtSxtNHL82VnR3LNvximHtvCWP
        buW6yfMW2dp76Z/93N41rydtsXVfw5+KnOlP3DU6T6c4bPk5r9x02VvrgvzdzpGL30+V2cLu
        1lizmCPuSPMJ0y0r+2uEFt4u3bZdbQXzn3t+k2Z9KPq+j6HN5/o6tx+HpK5lnzeVuJVypUc5
        eDr/1AsP9jM5in9Klqt9w9F9zH/7TO75/7M/fHAzmZoY6h2s4iMfum5mxI2K+2J1FT23Cxku
        ejtM7HNg3p2gxFKckWioxVxUnAgAIRppmXMDAAA=
X-CMS-MailID: 20230203143328eucas1p1b6398762544f010e641f72c05444da70
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230203060905eucas1p20dc8b2dbf93ec2b0c604bd461afbae94
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230203060905eucas1p20dc8b2dbf93ec2b0c604bd461afbae94
References: <CGME20230203060905eucas1p20dc8b2dbf93ec2b0c604bd461afbae94@eucas1p2.samsung.com>
        <20230203060924.8257-1-semen.protsenko@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.2023 07:09, Sam Protsenko wrote:
> In order to prepare for PM enablement in clk-exynos850, common PM code
> was extracted from clk-exynos5433 to clk-exynos-arm64. Also some related
> cleanups were done prior to that. More specifically:
>
>    - patches #1..5: cleanups
>    - patch #6: PM code extraction
>
> During the extraction of the exynos5433_cmu_probe() content to
> exynos_arm64_register_cmu_pm() some code was reworked a bit, and also
> split into smaller functions. In particular:
>
>    - cmu_data structure now contains a pointer to ctx, which is now
>      allocated in samsung_clk_init()
>    - cmu_data structure initialization was moved into separate function
>    - code for configuring gate clocks was added (optional)
>
> Which in turn resulted in somehow modified code of probe function:
>
>    Original
>    --------
>
>      ...
>      devm_platform_ioremap_resource(...);
>      samsung_clk_init(...);
>      exynos_arm64_cmu_prepare_pm(...);
>      exynos_arm64_enable_bus_clk(...);
>      platform_set_drvdata(...);
>      ...
>
>    Modified
>    --------
>
>      ...
>      platform_set_drvdata(...);
>      exynos_arm64_cmu_prepare_pm(...);
>      exynos_arm64_enable_bus_clk(...);
>      exynos_arm64_init_clocks(...);
>      devm_platform_ioremap_resource(...);
>      samsung_clk_init(...);
>      ...
>
> That shouldn't really change the logic or mode of operation. It was
> preliminary tested on Exynos850 based board, with some extra patches on
> top of this series (will be submitted later).
>
> Marek, could you please test these patches on Exynos5433 platform, and
> also review accordingly?

I've tested and Exynos5433 still works fine after applying your changes. 
Btw, you should probably rebase your changes onto arm-soc tree (or 
recent linux-next), as there are some conflicts between your changes and 
the s3c24xx removal merged there.

Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

I will try to review the individual patches on Monday though.


> Thanks!
>
> Sam Protsenko (6):
>    clk: samsung: Don't pass reg_base to samsung_clk_register_pll()
>    clk: samsung: Remove np argument from samsung_clk_init()
>    clk: samsung: Set dev in samsung_clk_init()
>    clk: samsung: Extract clocks registration to common function
>    clk: samsung: Extract parent clock enabling to common function
>    clk: samsung: exynos5433: Extract PM support to common ARM64 layer
>
>   drivers/clk/samsung/clk-exynos-arm64.c   | 219 +++++++++++++++++++++--
>   drivers/clk/samsung/clk-exynos-arm64.h   |   3 +
>   drivers/clk/samsung/clk-exynos4.c        |   6 +-
>   drivers/clk/samsung/clk-exynos4412-isp.c |   3 +-
>   drivers/clk/samsung/clk-exynos5250.c     |   5 +-
>   drivers/clk/samsung/clk-exynos5420.c     |   5 +-
>   drivers/clk/samsung/clk-exynos5433.c     | 157 +---------------
>   drivers/clk/samsung/clk-pll.c            |  11 +-
>   drivers/clk/samsung/clk-s3c2410.c        |   6 +-
>   drivers/clk/samsung/clk-s3c2412.c        |   5 +-
>   drivers/clk/samsung/clk-s3c2443.c        |   6 +-
>   drivers/clk/samsung/clk-s3c64xx.c        |   4 +-
>   drivers/clk/samsung/clk-s5pv210.c        |   6 +-
>   drivers/clk/samsung/clk.c                |  64 ++++---
>   drivers/clk/samsung/clk.h                |  10 +-
>   15 files changed, 282 insertions(+), 228 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

