Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9660F69DB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjBUHXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjBUHXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:23:05 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969ED83DA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:23:01 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230221072258euoutp02b1dc2c6b11874f6bf4b50aabd3b1585d~FxgkP-hgf0064400644euoutp029
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:22:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230221072258euoutp02b1dc2c6b11874f6bf4b50aabd3b1585d~FxgkP-hgf0064400644euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676964178;
        bh=AXBxQ7kTv+FNoNvV/GQXtd1vUPYBJUew8GLHLp2SCgE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=qujvK1j5S+cGw6lqxx4q7MD/sx4Y6ZIO/QEJepy0PPJ853Jj1vOhPh073Ro92vY80
         AI9nyKYlK2apwSjhBJFDV23t+yN283S+NvtGbVzuZXq5Lunjb9uSxwPOuU2bxH8k2l
         CgsRJ+kuLsUT2bbT5/q5zDQ1364emRmu2GIOQwGw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230221072258eucas1p11f0431cb00b2ce79cdd67222fbbe71aa~FxgjzYjAx1967119671eucas1p1e;
        Tue, 21 Feb 2023 07:22:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 82.52.01471.15174F36; Tue, 21
        Feb 2023 07:22:57 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230221072257eucas1p19f4e879ba7ef1f0f4494ceb8921fd301~FxgjNljdw2186521865eucas1p1y;
        Tue, 21 Feb 2023 07:22:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230221072257eusmtrp27f2466142e0041d7c3e679eaf6ec338e~FxgjM6iyd1806818068eusmtrp2Y;
        Tue, 21 Feb 2023 07:22:57 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-a5-63f471513162
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 84.EA.02722.15174F36; Tue, 21
        Feb 2023 07:22:57 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230221072256eusmtip145b398df92dffab1ac6e15f20d686a1f~FxgiatzrA1627116271eusmtip1X;
        Tue, 21 Feb 2023 07:22:56 +0000 (GMT)
Message-ID: <ea0055c7-34d4-3da0-0d3a-52020a783922@samsung.com>
Date:   Tue, 21 Feb 2023 08:22:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 6/6] clk: samsung: exynos5433: Extract PM support to
 common ARM64 layer
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAPLW+4=cOV8J+Ho1t8Tkg8X_3m4npyy3FUC2zcQAYywE12uEkw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUwTdxjOr3ftHSTV46rhjbotqR8TjAUCwUMdcQtupzEGI/vQELGWsxhL
        ZT3QIUtEgqKNEYKKpaJ0xAnrnB8Vam0As2rsipONkbWMlI8FlFBBVktiLGBHe6j89zzP+z55
        nveXH4nRneIl5AFtIafTKjVySTRuffS6c+2ObydViaauFGbwilXCdN9fw3gmR8RM2/MWgrEM
        ucWM/0y/mOm210kYwx/tIqarYzPzYKxCzLxx38aZkbOzUkdfgGDM9mnEOCeG0KaF7ETPCYK9
        Z+wjWIv5tIT1ulsl7J2rx9izzWbEBiwfZhK7ozfmcpoDhzldQvre6Dyfq1NUYKa/GzUFxaWo
        YqEeRZFApUBXSzuhR9EkTTUhCDk9c2QSQZm3DhdIAEFzUyV6a/nlyVOxMGhEMPS3EROIH0HP
        +QAW3pJS6XDNFoxgnFoJ48EBkaDHgKt2GA/jxVQuPP65VRLGMmov+EcdkQSMioXe4frI/iJK
        ATdqfZFOGHULh8bQD+LwQEIlgX5cP2smyShqB1h/3Cl4P4K743WRQkBdioLqPu9c7QzwDE/j
        ApaBz9lMCHgZhO6Fw8KGCgSmqYE5UoWgdKR3zr0BvJ3BSBpGxcFNe4Igfwq2wRk8LAO1AHrG
        Y4QSC6DaehETZCmcOkkL26vA6LzxLvbXP//CqpDcOO9ZjPPON847x/g+14RwM4rlivh8Nccn
        abkjCl6Zzxdp1QrVoXwLmv1yj984X9rQZZ9f4UAiEjkQkJh8kTQkDahoaa6y+CinO5SjK9Jw
        vAMtJXF5rHTNJy4VTamVhdxBjivgdG+nIjJqSalIt/0Yt/5RcS6XyjyhPeXQMiAzUPrUQPeq
        /pLulkxPtrvcfu6huayC9ibHP93z+kjc1/CTs8b6QcZoXlyi9IUvu13N11xjC4kyOu/6vqzs
        8l2r2Q2aLZqNdxe3QmigwTTy37Z1pgvyg/jOZ1PJMoP6t4yx+pmvKln3CcPyL4pSNYlt5vrr
        9lfDr/Dgw4S00UaD43vty7SmSznaUP1SNzxL3p/WwNu+KSBKLm/3Hj7J7BFNtP9uca3r/Sz+
        fs7mtKOZsgdZx8e0E5+b/h2cOZVomSxJf9Ej7dtVndLMmiS7XUk+p3Gq7mPavvz2tE2xdlnx
        iuT+L//xq9ryO/a7tspxPk+ZFI/peOX/POePUeEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xu7qBhV+SDfb+E7B4MG8bm8Xl/doW
        1788Z7XY+3oru8Wmx9dYLT723GO1uLxrDpvFjPP7mCwunnK1OPymndXi37WNLBbP+4BCp+5+
        ZrdYtesPo8Xx948ZHfg93t9oZffYOesuu8emVZ1sHneu7WHz2Lyk3qNvyypGj8+b5ALYo/Rs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyXp08x1Sw
        Sqji5YJfrA2M7fxdjJwcEgImEmvPPmXtYuTiEBJYyijx9txWRoiEjMTJaQ2sELawxJ9rXWwQ
        Re8ZJVbvmAWW4BWwk1i24xcziM0ioCrx9td9Joi4oMTJmU9YQGxRgRSJz/fmsoPYwgIJEh9f
        HgJbwCwgLnHryXywehEBPYl1M1+xQ8S3sEi0fi2GWDaBSWLfiitgDWwChhJdb0Gu4ODgFAiU
        2LY0GKLeTKJraxfUTHmJ7W/nME9gFJqF5IxZSNbNQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5
        xaV56XrJ+bmbGIExve3Yz807GOe9+qh3iJGJg/EQowQHs5II73/ez8lCvCmJlVWpRfnxRaU5
        qcWHGE2BYTGRWUo0OR+YVPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqY
        ODilGpgCVRatXKH7RDvDktfy1Z/PPCp8L1XmB1xs+59YXv5ZY8/VLMdZR92StWffOF/fJF37
        M/pYsX5G/9Sm38rXhQTYdnUz+ZiLHtu8qVuj7rtTrlq83wH/MEvWfb/Oczl/5lr4Ov83U2Lo
        Ep5Aa6nrTnPjJszn6Km+7mKsz3RQz/p0SGFTcWH3VYbXzvnTuCco5fPZhuXLy07v+SB1KLOd
        g4G/f59soMF8r3NMP633zLnRuubKytyQYL0U9q/dW2vPiG2d80Dx6A1vqXP7dVauX5P34Lrv
        tE/cBRtmfz3/K/aoxSWPsq8Ry/T5rnhyeDWniRwMSNo7r7Ji4+pDi+L8b/pkRoh9sva90HL3
        0IWJhUosxRmJhlrMRcWJAGmusaxyAwAA
X-CMS-MailID: 20230221072257eucas1p19f4e879ba7ef1f0f4494ceb8921fd301
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230219173642eucas1p1ddff7399223df763ff9fb48c4f7fc5f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230219173642eucas1p1ddff7399223df763ff9fb48c4f7fc5f9
References: <20230208234313.23863-1-semen.protsenko@linaro.org>
        <20230208234313.23863-7-semen.protsenko@linaro.org>
        <CGME20230219173642eucas1p1ddff7399223df763ff9fb48c4f7fc5f9@eucas1p1.samsung.com>
        <CAPLW+4=cOV8J+Ho1t8Tkg8X_3m4npyy3FUC2zcQAYywE12uEkw@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.2023 18:36, Sam Protsenko wrote:
> On Wed, 8 Feb 2023 at 17:43, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>> Exynos5433 clock driver implements PM support internally, which might be
>> also useful for other Exynos clock drivers. Extract all PM related code
>> from clk-exynos5433 to common ARM64 functions.
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>> ---
>> Changes in v2:
>>    - Rebased on top of latest soc/for-next tree
>>    - Included linux/slab.h for kfree (found by kernel test robot)
>>
>>   drivers/clk/samsung/clk-exynos-arm64.c | 171 ++++++++++++++++++++++++-
>>   drivers/clk/samsung/clk-exynos-arm64.h |   3 +
>>   drivers/clk/samsung/clk-exynos5433.c   | 157 +----------------------
>>   3 files changed, 175 insertions(+), 156 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung/clk-exynos-arm64.c
>> index 2aa3f0a5644e..7ad7fd353dda 100644
>> --- a/drivers/clk/samsung/clk-exynos-arm64.c
>> +++ b/drivers/clk/samsung/clk-exynos-arm64.c
>> @@ -10,6 +10,9 @@
>>    */
> Hi Marek,
>
> It just occurred to me that as I'm pulling your code from
> clk-exynos5433.c here, I should've probably added you to this file's
> author list in the header comment. Does that sound right to you? If
> so, I can re-send v3 with fixes.

Fine for me.

> Also, could you please review this series, if possible? I'm working
> right now on PM_DOMAINS support for Exynos850, so along with this
> series that would bring the initial PM support for ARM64 Exynos chips.

Well, feel free to add:

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

to v3 (the whole patchset).

The only remark I have is not strictly related to this patchset, but the 
code that is already in drivers/clk/samsung/clk-exynos-arm64.c. Playing 
with GATE_ENABLE_HWACG/GATE_MANUAL is not strictly specific to all 
Exynos ARM64 SoCs. GATE_OFF_START/GATE_OFF_END and the enable register 
bits are something specific to recent Exynos SoCs (like 7885/850/auto9) 
and don't fit well into the generic arm64 clk PM code, but I don't have 
a good idea how to move it to the respective clk drivers and keep it simple.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

