Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38E8680EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbjA3N2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjA3N2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:28:39 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374B338EA0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:28:30 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230130132828euoutp02c684918eb2bd0505fedbdc81ebcf325e~-GTafppY80995509955euoutp02S
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:28:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230130132828euoutp02c684918eb2bd0505fedbdc81ebcf325e~-GTafppY80995509955euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675085308;
        bh=bDY5A5cq8sQtqsucJOwqmtZss8qHKDPSRvKZiNaQsu8=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=hHiiu57CQgDdEz/qztj8DhAsiQ3IXCps96vU5nG2z3ihENUHjXCPy1MOaCgBI1hyg
         tKDruyCOptEblFj2wJN/LoaoCAwOZYh0WCFFmay0ooJxjUlIyNOIj20DJ74rb48r92
         x2DvQn7/gXQ3RgMevQ44ej8TMA4tTSZlr5KPFNB4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230130132828eucas1p2d59e602b4365f2bd486d993cfce0feeb~-GTZ1nVCk0790507905eucas1p2g;
        Mon, 30 Jan 2023 13:28:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 15.13.01471.BF5C7D36; Mon, 30
        Jan 2023 13:28:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230130132827eucas1p1c5eb66e9c3875e0330de6f9d4258f5c3~-GTZP77rf0789307893eucas1p1o;
        Mon, 30 Jan 2023 13:28:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230130132827eusmtrp202faae76a27818c1e1cd99881641a2a0~-GTZPDr6Y0069800698eusmtrp2O;
        Mon, 30 Jan 2023 13:28:27 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-1a-63d7c5fb4735
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C7.6A.02722.BF5C7D36; Mon, 30
        Jan 2023 13:28:27 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230130132826eusmtip19081864366da5f2af4f3a6d70d45962a~-GTYmq4Fg3198131981eusmtip1x;
        Mon, 30 Jan 2023 13:28:26 +0000 (GMT)
Message-ID: <e41a0a4c-b9c6-e396-313e-ea2990b2dd6f@samsung.com>
Date:   Mon, 30 Jan 2023 14:28:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/2] ARM: dts: add mmc aliases for Exynos devices
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230128133151.29471-1-henrik@grimler.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djP87p/jl5PNlhzjcniwbxtbBbzj5xj
        tXi7ZBejxY5LF1gt+l48ZLbY9Pgaq8XlXXPYLGac38dkce7AOmaLM/+mslgs+GNn0br3CLvF
        5u9/GR14PXbOusvucfTKPVaPTas62TzuXNvD5rF5Sb3H/ztr2T162jYxefRtWcXo8XmTXABn
        FJdNSmpOZllqkb5dAlfGjmVLWAueyVWce9nD0sC4RLyLkZNDQsBE4sr2p+xdjFwcQgIrGCX2
        LWhmgXC+MEocaOqDynxmlDi19hZbFyMHWMuaDZ4Q8eWMEgueTWODcD4yShzq+wlWxCtgJ7Fx
        HQuIySKgKvF1PSvINl4BQYmTM5+AhUUFUiQ2/SkDCQsLeEh0bGxiArGZBcQlbj2ZzwQyUURg
        MrPE1hUXmEESbAKGEl1vu9hAbE4Bc4mr19rYIRrkJba/ncMM0iAhMJ9TYsLqj+wQr7lIfHhy
        E8oWlnh1fAuULSPxfyfEBgmBdqAHft+HciYwSjQ8v8UIUWUtcefcL7BnmAU0Jdbv0od43lHi
        xV5+CJNP4sZbQYgb+CQmbZvODBHmlehoE4KYoSYx6/g6uK0HL1xihrA9JF6fvsA8gVFxFlKo
        zELy/iwkn81COGEBI8sqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwPR2+t/xTzsY5776
        qHeIkYmD8RCjBAezkghvvNm1ZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYnk4UE0hNLUrNT
        UwtSi2CyTBycUg1M9q+jbvb9nZbmrHEhP535wDI33Wme5lVd3YwGlp25x0JmPXjvuejrAUll
        r6efIt86P/F0PuBtrRiVeerdjLsfmqT3Lbbe/qZkUc82uXt+GxdemHJs0nfh/O7pN635lt16
        kzfpycmjp6ytXxdZ3mi4uEe4JrDGRcd9/n2TaCfOUO8dSxa6WIs+5Ll1/XhA0e/OwKmRx4z4
        p98Klo/N0TxeeOyPlVVhqHNhClvM/AoJnSvpMko5q1jO+j9blLlZuPDa5847axkWHlt38594
        7OvHEw8X1bSGBXb01fHVvbhbtm+as31WjUDtYS4+03XXct8uSNB4MHOq4R/GuR4yEjc/nhLp
        EmG+mFtyOOpZd9VWJZbijERDLeai4kQAdiOHsN4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7q/j15PNpixWcLiwbxtbBbzj5xj
        tXi7ZBejxY5LF1gt+l48ZLbY9Pgaq8XlXXPYLGac38dkce7AOmaLM/+mslgs+GNn0br3CLvF
        5u9/GR14PXbOusvucfTKPVaPTas62TzuXNvD5rF5Sb3H/ztr2T162jYxefRtWcXo8XmTXABn
        lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GjmVL
        WAueyVWce9nD0sC4RLyLkYNDQsBEYs0Gzy5GLg4hgaWMEtvOtjB3MXICxWUkTk5rYIWwhSX+
        XOtigyh6zyix/tQXJpBmXgE7iY3rWEBMFgFVia/rwcp5BQQlTs58wgJiiwqkSDQ/PwkWFxbw
        kOjY2MQEYjMLiEvcejKfCWSkiMBkZomXOxYzQ8zvYpR4tnIBO0gVm4ChRNdbkMWcHJwC5hJX
        r7WxQ3SbSXRt7WKEsOUltr+dwzyBUXAWkuWzkCyZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNz
        i0vz0vWS83M3MQJjd9uxn5t3MM579VHvECMTB+MhRgkOZiUR3niza8lCvCmJlVWpRfnxRaU5
        qcWHGE2BATCRWUo0OR+YPPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqY
        ODilGpjs/x11UjioOqPr64WU2D8q3MvSZVJWW7+ekmp7ZOckxt2sJ6rWGNy5P/2B/W7P9X1c
        TSnX1n4oaPS9X892IMLMsLD+zW/dmXVLUrpz59ZXTA1a4ep38Vfc6szM6yw2gr9Cpqj3zjXv
        TCrwb2I5nVhmmOy8Q+5v86402Ywf2ephX54d6KhRW/RoAf+PNdv+VN2qrIpv/Vx7kKfz2zO+
        E5WVVSd+5PV8rwq49D790Pcj75e9S8theWYv2rK8SbH8xY2NBeJL+HgYlOtbtSddPfAuf2r8
        fd4dJfe84o9zzhd7HyuinK/MIfdG9NnfrKfcAdtvPN54dRL/TsZ/UoeNLrKd4GrslJsewLT/
        3tHz814osRRnJBpqMRcVJwIAz7FGw2YDAAA=
X-CMS-MailID: 20230130132827eucas1p1c5eb66e9c3875e0330de6f9d4258f5c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230128133213eucas1p274ea3393199fe711fba8f542197e1dea
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230128133213eucas1p274ea3393199fe711fba8f542197e1dea
References: <CGME20230128133213eucas1p274ea3393199fe711fba8f542197e1dea@eucas1p2.samsung.com>
        <20230128133151.29471-1-henrik@grimler.se>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.2023 14:31, Henrik Grimler wrote:
> It is convenient to have fixed mmcblk numbering of the eMMC and sdcard
> so that assigned numbers will not change from boot-to-boot or
> depending on if storage devices are actually attached or not.
>
> Anton Bambura has done the work for the chromebooks while I have
> looked at the other devices.  On the chromebooks, mmc0 is used for
> eMMC and mmc1 for sdcard, while mmc0 is used for eMMC and mmc2 for
> sdcard on the other boards, simply because Anton and I had different
> preferences.
>
> Also remove mshc aliases, as they should not be needed after [1] as
> I understand it.

Thanks for this patchset. Long time ago I've tried to submit something 
similar, but that time it has been rejected:

https://lore.kernel.org/all/20201105114804.18326-1-m.szyprowski@samsung.com/

I hope that the mshc alias removal will help here.

BTW, similar patchset is needed for arch/arm64/boot/dts/exynos


> [1] https://lkml.kernel.org/lkml/20211124184603.3897245-1-john@metanate.com
>
> ---
>
> Changes since v1:
> * Move mshc alias cleanup to a separate commit
> * Use mmc0 and mmc1 (instead of mmc0 and mmc2) for eMMC and sdcard on
>    chromebooks
> * Address Krzysztof's review comments:
>   - Make changes per device rather than in soc dtsi
>
>
> Henrik Grimler (2):
>    ARM: dts: exynos: drop mshc aliases
>    ARM: dts: exynos: add mmc aliases
>
>   arch/arm/boot/dts/exynos3250-artik5-eval.dts        | 5 +++++
>   arch/arm/boot/dts/exynos3250-artik5.dtsi            | 5 +++++
>   arch/arm/boot/dts/exynos3250-monk.dts               | 1 +
>   arch/arm/boot/dts/exynos3250-rinato.dts             | 2 ++
>   arch/arm/boot/dts/exynos3250.dtsi                   | 3 ---
>   arch/arm/boot/dts/exynos4210-i9100.dts              | 6 ++++++
>   arch/arm/boot/dts/exynos4210-origen.dts             | 5 +++++
>   arch/arm/boot/dts/exynos4210-smdkv310.dts           | 4 ++++
>   arch/arm/boot/dts/exynos4210-trats.dts              | 6 ++++++
>   arch/arm/boot/dts/exynos4210-universal_c210.dts     | 6 ++++++
>   arch/arm/boot/dts/exynos4412-itop-elite.dts         | 5 +++++
>   arch/arm/boot/dts/exynos4412-midas.dtsi             | 3 +++
>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi     | 5 +++++
>   arch/arm/boot/dts/exynos4412-origen.dts             | 5 +++++
>   arch/arm/boot/dts/exynos4412-p4note.dtsi            | 6 ++++++
>   arch/arm/boot/dts/exynos4412-smdk4412.dts           | 4 ++++
>   arch/arm/boot/dts/exynos4412-tiny4412.dts           | 4 ++++
>   arch/arm/boot/dts/exynos4412.dtsi                   | 1 -
>   arch/arm/boot/dts/exynos5250-arndale.dts            | 5 +++++
>   arch/arm/boot/dts/exynos5250-smdk5250.dts           | 2 ++
>   arch/arm/boot/dts/exynos5250-snow-common.dtsi       | 3 +++
>   arch/arm/boot/dts/exynos5250-spring.dts             | 5 +++++
>   arch/arm/boot/dts/exynos5250.dtsi                   | 4 ----
>   arch/arm/boot/dts/exynos5260-xyref5260.dts          | 5 +++++
>   arch/arm/boot/dts/exynos5410-odroidxu.dts           | 2 ++
>   arch/arm/boot/dts/exynos5410-smdk5410.dts           | 5 +++++
>   arch/arm/boot/dts/exynos5420-arndale-octa.dts       | 5 +++++
>   arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi | 5 +++++
>   arch/arm/boot/dts/exynos5420-peach-pit.dts          | 3 +++
>   arch/arm/boot/dts/exynos5420-smdk5420.dts           | 5 +++++
>   arch/arm/boot/dts/exynos5420.dtsi                   | 3 ---
>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi       | 5 +++++
>   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 4 ++++
>   arch/arm/boot/dts/exynos5422-samsung-k3g.dts        | 4 ++++
>   arch/arm/boot/dts/exynos5800-peach-pi.dts           | 3 +++
>   35 files changed, 133 insertions(+), 11 deletions(-)
>
>
> base-commit: 9ca5a7ce492d182c25ea2e785eeb72cee1d5056b

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

