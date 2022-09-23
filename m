Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D122A5E7C85
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiIWOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiIWOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:09:07 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB7113F283
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:09:05 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220923140904euoutp0285c2478e3c0c42fa1eac522e7c509ec7~XgpBrzf1W1149311493euoutp02W
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 14:09:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220923140904euoutp0285c2478e3c0c42fa1eac522e7c509ec7~XgpBrzf1W1149311493euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663942144;
        bh=lQSn8l24IYNJD7eLxVdJcmUxxS+Un9kRAvFcHMkoUME=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=pg6Ri2+UXwO3+0wou8ftnFe0/nVMqXskBWi0wI0vVv0OLOcScPQSgnoz4st6v06ji
         eBGoyjXAoIQVrmTfvm2eLol+b7UGzU/WLvHj2KH94mkZcyouFktWdzk9RuQY6XvwBI
         KvC1NBYuIgUPSKOnCQfKWnL4XXEhWCfLkYKeOoEA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220923140903eucas1p1e34813b42ffdb039d6bf577873312b00~XgpBes59x0569105691eucas1p1e;
        Fri, 23 Sep 2022 14:09:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A8.5E.19378.FFDBD236; Fri, 23
        Sep 2022 15:09:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220923140903eucas1p180002df0deb308d5148cc6004aef7efe~XgpA86H5Y1614516145eucas1p1p;
        Fri, 23 Sep 2022 14:09:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220923140903eusmtrp16c73bcfd918e5d9631e10148c3479bfc~XgpA8EQ-P1053310533eusmtrp1Z;
        Fri, 23 Sep 2022 14:09:03 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-30-632dbdffafc7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.57.07473.FFDBD236; Fri, 23
        Sep 2022 15:09:03 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220923140902eusmtip26fc602160856b219e347381b00729c0d~XgpASuhRb0777607776eusmtip2B;
        Fri, 23 Sep 2022 14:09:02 +0000 (GMT)
Message-ID: <bc3a5137-b2be-0bfe-003a-db201a7a50e8@samsung.com>
Date:   Fri, 23 Sep 2022 16:09:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v4 10/30] thermal/drivers/exynos: Replace
 of_thermal_is_trip_valid() by thermal_zone_get_trip()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220921094244.606948-11-daniel.lezcano@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djP87r/9+omGxzdbWzxYN42NovD8yss
        vm+5zmQx77Osxd7XW9ktNj2+xmpxedccNovPvUcYLWac38dkMffLVGaLJw/72By4PXbOusvu
        sXjPSyaPTas62TzuXNvD5rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZazd3sZasEmj
        Yv3pVYwNjPcUuxg5OSQETCRW7frO3MXIxSEksIJRom3FZhYI5wujxIdv+6Aynxklnt3YyQrT
        cvjnCqiq5YwSjZfeMUE4Hxklpm+fxARSxStgJ7Hr3m4WEJtFQFXiyLwb7BBxQYmTM5+AxUUF
        kiVmHTvGCGILC5RKzL24mhnEZhYQl7j1ZD7YHBEBR4kvfxexgyxgFtjLLHGg/wJYM5uAoUTX
        2y62LkYODk6gopdPtCB65SWat84GO1tCoJ1TYu+BecwQZ7tINK7uZoKwhSVeHd/CDmHLSJye
        3MMC1cAoseD3fSYIZwKjRMPzW4wQVdYSd879AtvGLKApsX6XPkTYUWLynvnsIGEJAT6JG28F
        IY7gk5i0bTozRJhXoqNNCKJaTWLW8XVwaw9euMQ8gVFpFlKwzELy/iwk78xC2LuAkWUVo3hq
        aXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYPI6/e/41x2MK1591DvEyMTBeIhRgoNZSYR39h3N
        ZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8bDO0koUE0hNLUrNTUwtSi2CyTBycUg1Mm0/senO2
        peROcvjMPqmAvpoHlXe3vvAsVd/mWZg1yfZRS7b02/O1NfW/SxYHqLM9mT8/RXJHwIrzf+J3
        Wq2eeMdtqdu9jdseSp5aGsqgXjXbWss08e1yN3VhgfJ8oeRZWfoT/utX+cROmzr77b2GMuPE
        PZcvLKx2uvDoR6/0p3j3xYW3OqbePs2dv3CDoz+3uc32kiw+DpvP9dIhf5mat0k2NB30/S//
        4fjk2eI/wl5mLWE5v+/27DsRfi/XXe+6zrrzxe6K4IsGM2c33VrD/3s57/dX2Qyiu9j2itba
        fHeOePWKeZt+sejamU2906+2X9imovVU0l702m6Wyvpzx0X2O4XbcsdffKzHHXrmkBJLcUai
        oRZzUXEiAPluUezNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7r/9+omGzy4z23xYN42NovD8yss
        vm+5zmQx77Osxd7XW9ktNj2+xmpxedccNovPvUcYLWac38dkMffLVGaLJw/72By4PXbOusvu
        sXjPSyaPTas62TzuXNvD5rF5Sb1H35ZVjB6fN8kFsEfp2RTll5akKmTkF5fYKkUbWhjpGVpa
        6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZazd3sZasEmjYv3pVYwNjPcUuxg5OSQETCQO
        /1zB0sXIxSEksJRRouXLAyaIhIzEyWkNrBC2sMSfa11sEEXvGSXeNp9hB0nwCthJ7Lq3mwXE
        ZhFQlTgy7wZUXFDi5MwnYHFRgWSJJQ33wQYJC5RKzL24mhnEZhYQl7j1ZD7YMhEBR4kvfxex
        gyxgFtjLLNHzvB2oiANoW5nE9E8yIDVsAoYSXW9BjuDg4ASqf/lEC2KMmUTX1i5GCFteonnr
        bOYJjEKzkFwxC8m2WUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwUrcd+7l5
        B+O8Vx/1DjEycTAeYpTgYFYS4Z19RzNZiDclsbIqtSg/vqg0J7X4EKMpMCgmMkuJJucDU0Ve
        SbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOTcd79b0aCFk5VU73e
        3JGYGuy8UTPt9CkTlWslFwT/KFytvNtpeML/pstl/YNbt5YtY7dp/Xq5cO5c9R0uXJPZU+cn
        PXu3sULfvdtTeV0dD29BVUfVGWmGeslV7qWH2PUOeuv9nTn7tlyU0Yq8yAytX79Niu69nrxR
        N2FnC29hj8DTkvKlBgK/S8Xv/e75e/p22wO5n2uX+C4MCHKf7xxZ2szn5vm5ndcjsu6bTdBN
        qZ/3U45wnnmiHPGpPPvs3dJGrrln/hfM3rmo7VWE5buK3J15QVEHFHbJPJ1n1VnQ+De/c0lc
        N2/ZIh02Hd7CpNz7S8sfygi8ecm3stO69utcRTVGzqxvrt1th/fuM1RiKc5INNRiLipOBAD2
        1GJkXQMAAA==
X-CMS-MailID: 20220923140903eucas1p180002df0deb308d5148cc6004aef7efe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923140903eucas1p180002df0deb308d5148cc6004aef7efe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923140903eucas1p180002df0deb308d5148cc6004aef7efe
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
        <20220921094244.606948-11-daniel.lezcano@linaro.org>
        <CGME20220923140903eucas1p180002df0deb308d5148cc6004aef7efe@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 21.09.2022 11:42, Daniel Lezcano wrote:
> The thermal_zone_get_trip() does the same check as
> of_thermal_is_trip_valid(). Replace the call to
> of_thermal_is_trip_valid() by thermal_zone_get_trip().
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

This patch landed in linux next-20220923 as commit 4a71bb8005ba 
("thermal/drivers/exynos: Replace of_thermal_is_trip_valid() by 
thermal_zone_get_trip()"). Unfortunately it causes deadlock on all 
Exynos based board:

============================================
WARNING: possible recursive locking detected
6.0.0-rc1-00062-g4a71bb8005ba #12855 Not tainted
--------------------------------------------
swapper/0/1 is trying to acquire lock:
c263c394 (&tz->lock){+.+.}-{3:3}, at: 
thermal_zone_device_update.part.0+0x114/0x538

but task is already holding lock:
c263c394 (&tz->lock){+.+.}-{3:3}, at: 
thermal_zone_device_update.part.0+0x3c/0x538

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&tz->lock);
   lock(&tz->lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

2 locks held by swapper/0/1:
  #0: c1d5248c (&dev->mutex){....}-{3:3}, at: __driver_attach+0xe4/0x1f0
  #1: c263c394 (&tz->lock){+.+.}-{3:3}, at: 
thermal_zone_device_update.part.0+0x3c/0x538

stack backtrace:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-00062-g4a71bb8005ba 
#12855
Hardware name: Samsung Exynos (Flattened Device Tree)
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from __lock_acquire+0x146c/0x2a7c
  __lock_acquire from lock_acquire+0x124/0x3e4
  lock_acquire from __mutex_lock+0x90/0x948
  __mutex_lock from mutex_lock_nested+0x1c/0x24
  mutex_lock_nested from thermal_zone_device_update.part.0+0x114/0x538
  thermal_zone_device_update.part.0 from 
thermal_zone_device_set_mode+0x70/0x98
  thermal_zone_device_set_mode from thermal_of_zone_register+0x424/0x69c
  thermal_of_zone_register from devm_thermal_of_zone_register+0x58/0x94
  devm_thermal_of_zone_register from exynos_tmu_probe+0x29c/0x728
  exynos_tmu_probe from platform_probe+0x5c/0xb8
  platform_probe from really_probe+0xe0/0x414
  really_probe from __driver_probe_device+0xa0/0x208
  __driver_probe_device from driver_probe_device+0x30/0xc0
  driver_probe_device from __driver_attach+0xf0/0x1f0
  __driver_attach from bus_for_each_dev+0x70/0xb0
  bus_for_each_dev from bus_add_driver+0x174/0x218
  bus_add_driver from driver_register+0x88/0x11c
  driver_register from do_one_initcall+0x64/0x380
  do_one_initcall from kernel_init_freeable+0x1c0/0x224
  kernel_init_freeable from kernel_init+0x18/0x12c
  kernel_init from ret_from_fork+0x14/0x2c
Exception stack(0xf082dfb0 to 0xf082dff8)

[deadlock]

Something is wrong in locking in the functions from the above stacktrace.


>   drivers/thermal/samsung/exynos_tmu.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 91e6860b5ec4..34b460092308 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -554,13 +554,14 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
>   {
>   	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>   	struct thermal_zone_device *tz = data->tzd;
> +	struct thermal_trip trip;
>   	unsigned int con, interrupt_en = 0, i;
>   
>   	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
>   
>   	if (on) {
>   		for (i = 0; i < data->ntrip; i++) {
> -			if (!of_thermal_is_trip_valid(tz, i))
> +			if (thermal_zone_get_trip(tz, i, &trip))
>   				continue;
>   
>   			interrupt_en |=
> @@ -584,13 +585,14 @@ static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
>   {
>   	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>   	struct thermal_zone_device *tz = data->tzd;
> +	struct thermal_trip trip;
>   	unsigned int con, interrupt_en = 0, pd_det_en, i;
>   
>   	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
>   
>   	if (on) {
>   		for (i = 0; i < data->ntrip; i++) {
> -			if (!of_thermal_is_trip_valid(tz, i))
> +			if (thermal_zone_get_trip(tz, i, &trip))
>   				continue;
>   
>   			interrupt_en |=
> @@ -615,13 +617,14 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
>   {
>   	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>   	struct thermal_zone_device *tz = data->tzd;
> +	struct thermal_trip trip;
>   	unsigned int con, interrupt_en = 0, i;
>   
>   	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
>   
>   	if (on) {
>   		for (i = 0; i < data->ntrip; i++) {
> -			if (!of_thermal_is_trip_valid(tz, i))
> +			if (thermal_zone_get_trip(tz, i, &trip))
>   				continue;
>   
>   			interrupt_en |=

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

