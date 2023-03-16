Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DCC6BCCE0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCPKcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCPKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:32:47 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F556ABAE5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:32:38 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230316103237euoutp027139eabb8e7ea6c8c78a4761fdcf2a89~M37tynfjs1086110861euoutp02P
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:32:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230316103237euoutp027139eabb8e7ea6c8c78a4761fdcf2a89~M37tynfjs1086110861euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678962757;
        bh=MRDrFwRnTgE1AmTopF8vb9AztIKsT+/LCV4DGSlIMmk=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=AJvXnAIPUKBOLYZrdC7Z6zKRJY3Cj01O/cmYgIRGfzd+oySjfGA8osIfdMuKriBjb
         kJu6Mm3l3rJohRP75H5N+hlYhxyUkFIbADHIxMPO9SXuux/6kbn8cxMBTXzK8Tul3M
         tFMTBf4pAOjfzixZ/2nVLwgQF6iFCSI8kUX3ZnPM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230316103237eucas1p195d9c42a07c7dbf6090bd93119fe56a3~M37tnh-aK0980209802eucas1p19;
        Thu, 16 Mar 2023 10:32:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2D.6C.09503.440F2146; Thu, 16
        Mar 2023 10:32:37 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230316103236eucas1p27ed391c23a84a72c377866d28b3e12fb~M37tM2kjH3190431904eucas1p25;
        Thu, 16 Mar 2023 10:32:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230316103236eusmtrp24e8f24115e4e33a2d574ea0960586d78~M37tMKiJd3232132321eusmtrp2E;
        Thu, 16 Mar 2023 10:32:36 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-fb-6412f0441da3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A1.DD.08862.440F2146; Thu, 16
        Mar 2023 10:32:36 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230316103236eusmtip1ab38d1853b8699bff43a990a8fc8d29d~M37sm1cOI2032620326eusmtip10;
        Thu, 16 Mar 2023 10:32:35 +0000 (GMT)
Message-ID: <2e010bd3-5f7c-6866-fc11-f4bdf7d7e7bb@samsung.com>
Date:   Thu, 16 Mar 2023 11:32:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] arm64: dts: exynos: add mmc aliases
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        virag.david003@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230315212814.15908-3-henrik@grimler.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djP87quH4RSDLZdYbJ4MG8bm8X8I+dY
        Ld4u2cVo0ffiIbPFpsfXWC0u75rDZjHj/D4miwV/7Cxa9x5htzj+/jGjxebvfxkduD12zrrL
        7nH0yj1Wj02rOtk87lzbw+axeUm9x/87a9k9+rasYvT4vEkugCOKyyYlNSezLLVI3y6BK2P5
        u6/MBfeZKh4fbGNpYJzF1MXIySEhYCKxZtcpIJuLQ0hgBaPE26W9jBDOF0aJVbvXsEE4nxkl
        +j5MZ4Vpebz7FFRiOaPErcaH7BDOR0aJDS/vsoFU8QrYSRx8eZQFxGYRUJXo2/6CESIuKHFy
        5hOwuKhAisSO87vZQWxhAXuJRXOngfUyC4hL3HoyH+woEYGHTBJHL20FS7AJGEp0ve0Csjk4
        OAXMJdoXykPUy0tsfzuHGaReQqCZU+LDoRWMEKe6SExY3whlC0u8Or6FHcKWkfi/E2KBhEA7
        o8SC3/ehnAmMEg3Pb0F1WEvcOfcLbBuzgKbE+l36EGFHiQ/zVjKChCUE+CRuvBWEOIJPYtK2
        6cwQYV6JjjYhiGo1iVnH18GtPXjhEjOE7SHxf/4V9gmMirOQgmUWkvdnIXltFsINCxhZVjGK
        p5YW56anFhvmpZbrFSfmFpfmpesl5+duYgQmstP/jn/awTj31Ue9Q4xMHIyHGCU4mJVEeMNZ
        BFKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MGXWvZa8
        1bmNpbzU8Meb+Zt+/+fzdHLc83jKhA63jNhnz84nrjK2O+Y2YZ+whYjv3WIWh8cfE89Yt+z2
        lvraf1qNc2budampT7iXyYQ/XHlj8Yyy4mfVPHnBj4Xzv8pIem+zF9Tzu6Ft45zqZsz0etb6
        2Dte97XCvFweC6SLr/t550L/lh9rHTy2dSzdddVSMSI+XPoBs/2P5UfkN1XJp/WJV0zRrfBf
        uk2u9p7emrBm7x1z39nOmx2dNcfg2vKFHn7pUw9ffNEguFXa6My16UrN2vdWvPwWfGLei1OF
        b37+9J70tu9nTVaEpdvzR6vi5T+pbT7l+c3toJ7IxYthOS2H/y6zu9e660LBPJM14lJKLMUZ
        iYZazEXFiQCAG09A0wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7ouH4RSDL6+VbJ4MG8bm8X8I+dY
        Ld4u2cVo0ffiIbPFpsfXWC0u75rDZjHj/D4miwV/7Cxa9x5htzj+/jGjxebvfxkduD12zrrL
        7nH0yj1Wj02rOtk87lzbw+axeUm9x/87a9k9+rasYvT4vEkugCNKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2P5u6/MBfeZKh4fbGNpYJzF1MXI
        ySEhYCLxePcpti5GLg4hgaWMEvsfHoVKyEicnNbACmELS/y51gVV9J5R4uj2XewgCV4BO4mD
        L4+ygNgsAqoSfdtfMELEBSVOznwCFOfgEBVIkZjdpQMSFhawl1g0dxobiM0sIC5x68l8JpCZ
        IgIPmSTmf33HBLFgO6PEgwkfwBawCRhKdL0F2czBwSlgLtG+UB6i2Uyia2sXI4QtL7H97Rzm
        CYyCs5CsnoVkxywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGJ/bjv3cvINx
        3quPeocYmTgYDzFKcDArifCGswikCPGmJFZWpRblxxeV5qQWH2I0Bfp/IrOUaHI+MEHklcQb
        mhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwSXV5TGba4z3n6lmlpVnf
        DM8VGoUwTa58deobW8+2C58DNJzEO3pmqJz66pC7/gBPxUTtzcVbO1incajsU3u1krWiaYb4
        5+82K3P1WU5J1CeIqgjeVKi1qVvG4TfntUQS78WXOboLmS79KxCRKWvLWtNfHN6zYYO506I3
        uoEpZ8+Fr7Pb/rg4963fk21fHD7t5bt1163A7rzD5O6kMvn2xWxC1YHZBtWTWY7OSWpXzDWb
        8Tn7Zy/jRpuL0zlrQ7TDfpQsmCWf8O3muynTxDS2x6s8LVyhK2Fnuub+T/GWDZvOr7J6Zxal
        7Nma4vI37/iLH29vb1K2fLoh02p3Rswj8eAL27qZn5yv/czGI2qoxFKckWioxVxUnAgA6kSo
        zVgDAAA=
X-CMS-MailID: 20230316103236eucas1p27ed391c23a84a72c377866d28b3e12fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230315212840eucas1p2a5f142534bfb01d9f897d9f6d9ce6e97
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315212840eucas1p2a5f142534bfb01d9f897d9f6d9ce6e97
References: <20230315212814.15908-1-henrik@grimler.se>
        <CGME20230315212840eucas1p2a5f142534bfb01d9f897d9f6d9ce6e97@eucas1p2.samsung.com>
        <20230315212814.15908-3-henrik@grimler.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2023 22:28, Henrik Grimler wrote:
> Add aliases for eMMC and SD card where applicable, so that
> assigned mmc indeces are always the same.
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

