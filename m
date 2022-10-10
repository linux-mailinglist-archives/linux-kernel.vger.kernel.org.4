Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E641E5FA2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJJRwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJJRwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:52:20 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE4613E14
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:52:18 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221010175216euoutp02fe4ffa80e216fcd06be3df524a124de6~cxpwkFLhl2316623166euoutp02b
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:52:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221010175216euoutp02fe4ffa80e216fcd06be3df524a124de6~cxpwkFLhl2316623166euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665424336;
        bh=MdQD08xXlpdoBtRP1gu2WmQT1UySLplZCdNoBPfuxYk=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=ZnZX1wu0aWymXbCQT0pPjrhS19lEs9hY49STGD6uSmv9RWWJW2XmhSey383vp4+N5
         Rd5N3M0hHnFmEfAMUagrmBke0tSGf0+fJbZNTxkwcKirnavqj03b5zXthBA2X1k5Lf
         KUaxj/YzmHYt4daiFp8wFqdVTgdoBHuilBnvI0LM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221010175215eucas1p225eb073b7ce20426c7a7e66eb622e86c~cxpwZLitl1498714987eucas1p2i;
        Mon, 10 Oct 2022 17:52:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C2.83.19378.FCB54436; Mon, 10
        Oct 2022 18:52:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221010175215eucas1p181c1a56d7d040b42d88e9fdb67f88403~cxpv-rzW_2630726307eucas1p1e;
        Mon, 10 Oct 2022 17:52:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221010175215eusmtrp21fc8045c52754b1d8924b9ca7fa50804~cxpv-Bg0Q1895818958eusmtrp2p;
        Mon, 10 Oct 2022 17:52:15 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-b3-63445bcf7b77
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 68.DB.10862.FCB54436; Mon, 10
        Oct 2022 18:52:15 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221010175215eusmtip14a4519e4b1744d309d3e54eceedcfa46~cxpvpNBcv0405704057eusmtip1e;
        Mon, 10 Oct 2022 17:52:15 +0000 (GMT)
Message-ID: <0481695f-a1b6-1814-06ea-b6bb75a5487b@samsung.com>
Date:   Mon, 10 Oct 2022 19:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH 0/2] clk: More Range Fixes
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20221010-rpi-clk-fixes-again-v1-0-d87ba82ac404@cerno.tech>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87rno12SDa78N7SY+vAJm8XHnnus
        Fpd3zWGzmPHjH6PFxVOuFv+ubWRxYPN4f6OV3ePOufNsHptWdbJ5fN4kF8ASxWWTkpqTWZZa
        pG+XwJVxd9N35oLlvBWvN39ka2Cczt3FyMEhIWAisXOeQBcjF4eQwApGiY0LprBDOF8YJSZO
        +80K4XxmlFjZcJERpqP7EFCcEyi+nFFi3wJ+iJqPjBJHmlYygiR4Bewkdt3YyQ5iswioSsxr
        mc0GEReUODnzCQuILSqQInH05WF2kJnCAnoSey5ng4SZBcQlbj2ZzwRiiwiUSqw694IJIh4n
        8eRoI5jNJmAo0fW2C2wkp4CHxLlrqxghauQltr+dwwxyj4TACQ6JSX+fgd0gIeAi8aHjCCOE
        LSzx6vgWqLiMxP+dIMtAGtoZJRb8vg/lTGCUaHh+C6rDWuLOuV9sIJcyC2hKrN+lDxF2lJg8
        7R40UPgkbrwVhDiCT2LStunMEGFeiY42IYhqNYlZx9fBrT144RLzBEalWUihMgvJ+7OQvDML
        Ye8CRpZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgYnm9L/jX3cwrnj1Ue8QIxMH4yFG
        CQ5mJRFexvlOyUK8KYmVValF+fFFpTmpxYcYpTlYlMR52WZoJQsJpCeWpGanphakFsFkmTg4
        pRqYZm3XKtbW15morbyJ+71agvOsitrTukd8exK31HG/Yqx7otcpJhLKwvTte3p5lL9r2g0W
        nW9C26q/5Ci83qey/MX9sJSdOhl5MpefGy25dsqB6ZFrzOw+JyYnlY0/NiSxXUm3UHFXdHnU
        Y/XfikWo79btn30v/qg8KFoY/fprrNcZXnmWkw8mGYt92jC/XUTs5lzm8ms5LRyZBZpHVb6t
        c7D5NCXi9BoL6Zrv4myszN7VZoH+PG8eB8mkNdm8Sz+ssfv+xPynYX7hSUdFD5jdOq2zLT24
        IiGv5Gbi8skqW9cULO7tsV9dckTY4MnzCZMK09convjhM+FeC8Nf+/ntmX1tzhH+H6/YuK9T
        yVBiKc5INNRiLipOBAB1up1nowMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7rno12SDb7ekbWY+vAJm8XHnnus
        Fpd3zWGzmPHjH6PFxVOuFv+ubWRxYPN4f6OV3ePOufNsHptWdbJ5fN4kF8ASpWdTlF9akqqQ
        kV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdxd9N35oLlvBWvN39k
        a2Cczt3FyMEhIWAi0X2ItYuRi0NIYCmjxP23r4AcTqC4jMTJaQ1QtrDEn2tdbBBF7xklbh1p
        AkvwCthJ7Lqxkx3EZhFQlZjXMpsNIi4ocXLmExaQBaICKRJnrwiCmMICehJ7LmeDVDALiEvc
        ejKfCcQWESiVOP19DStEPE7i251r7BCrZjNKfPv9EGwkm4ChRNfbLjCbU8BD4ty1VYwQDWYS
        XVu7oGx5ie1v5zBPYBSaheSKWUj2zULSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5
        mxiBsbXt2M8tOxhXvvqod4iRiYPxEKMEB7OSCC/jfKdkId6UxMqq1KL8+KLSnNTiQ4ymwKCY
        yCwlmpwPjO68knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQam/DyB
        ANcYh3q9b4eapsT2HOBJOne/Ku+ATcidZ5/ONP3V/cHpuno6H/eKzxfDDeeflLznKiHYWdNk
        /21Lx9Pdp7b0NrzW946+9CPF40zelCKJk0qLay7IMNruPzE9/OzhPg/dmckJD21Xyh670v99
        YXFywulP0+Z275t+oO7rvmNZaU7vZ1Y6NK997zb7Sc+eaR9mKVssfaS9Xits9r+DqqfqVR+c
        /1H//kb155eWAYpe3BUrhESmJ76b+nyipdm8TAPhAn+1i5/VjzSqi0q01FhOlNkbWHBeSZTr
        lMLm406nm4+cS573YGIkXzabusb9/JhfzaXSvDvZ1tz0LJj95G9Cfd3q85U7O9W149ZLK7EU
        ZyQaajEXFScCAHvl5jo2AwAA
X-CMS-MailID: 20221010175215eucas1p181c1a56d7d040b42d88e9fdb67f88403
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221010144751eucas1p2edac1b98fa130f6664ece3465f8bd5fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221010144751eucas1p2edac1b98fa130f6664ece3465f8bd5fb
References: <CGME20221010144751eucas1p2edac1b98fa130f6664ece3465f8bd5fb@eucas1p2.samsung.com>
        <20221010-rpi-clk-fixes-again-v1-0-d87ba82ac404@cerno.tech>
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 10.10.2022 16:47, Maxime Ripard wrote:
> Here are patches that might address the issues reported by Marek and Mark,
> according to Stephen's intuition :)
>
> Either way, it's still fixing and adding test coverage for a regression
> introduced by my recent work.
>
> If it's easier for you to test, this series is also pushed here:
> https://protect2.fireeye.com/v1/url?k=e4440f7a-bbdf3663-e4458435-000babff3793-bdf960866cc2289b&q=1&e=179d765b-8652-488e-977d-8f404e45f6c8&u=https%3A%2F%2Fgithub.com%2Fmripard%2Flinux%2Ftree%2Frpi%2Fclk-fixes-again
>
> Maxime
>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

It looks it fixes the issue I've reported here: 
https://lore.kernel.org/all/8cdd1927-da38-c23e-fa75-384694724b1c@samsung.com/

All my Amlogic Meson G12A/B based boards work fine after applying those 
fixes.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> Maxime Ripard (2):
>        clk: Update req_rate on __clk_recalc_rates()
>        clk: tests: Add tests for notifiers
>
>   drivers/clk/clk.c      |  39 ++++---------
>   drivers/clk/clk_test.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 167 insertions(+), 28 deletions(-)
> ---
> base-commit: cd9fd78f5c11b5e165d9317ef11e613f4aef4dd1
> change-id: 20221010-rpi-clk-fixes-again-a95180ef0108
>
> Best regards,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

