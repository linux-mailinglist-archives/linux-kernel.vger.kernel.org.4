Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262145F307C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJCMuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 08:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJCMuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:50:50 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739862ED6D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 05:50:48 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221003125043euoutp023ea52880b3f5ff7e2f53f2816639fef9~akBeQZMkD0192101921euoutp02E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:50:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221003125043euoutp023ea52880b3f5ff7e2f53f2816639fef9~akBeQZMkD0192101921euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664801443;
        bh=xxukKcIyMl6TAaYB4bWz21KJ4pChE4zLufvzZqkUPiM=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
        b=iZ4gYmGrI4/TnmZO6prPTobhWOAHjrf1Ncf3jp+fOvg5TmT/afUR7eR10b1PVJf40
         eo3iBxSRcOuu7ieVDdljXm2Qd8+/ibSQi6phYYtIA+T7eIKcSU9oXcmmdZcuLJV+gU
         0JfFMMPhlEQjMyeLyub1uU1y9BxzNLVR6cZHSck0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221003125041eucas1p1357a303d968bd0881acc30e17c2ffc51~akBdJJ1qY2618226182eucas1p1l;
        Mon,  3 Oct 2022 12:50:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 65.7D.29727.1AADA336; Mon,  3
        Oct 2022 13:50:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221003125041eucas1p2dd08002bc6becbd612d6b43d620ef26f~akBcrL-Vl0820408204eucas1p2W;
        Mon,  3 Oct 2022 12:50:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221003125041eusmtrp23bcbc52482cad86024a2622a1546795a~akBcqIT131710517105eusmtrp2T;
        Mon,  3 Oct 2022 12:50:41 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-43-633adaa1f5e5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.A8.10862.1AADA336; Mon,  3
        Oct 2022 13:50:41 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221003125040eusmtip23aadbd77d4ae0893dc5699f91bf46490~akBcFOaes2627626276eusmtip2Y;
        Mon,  3 Oct 2022 12:50:40 +0000 (GMT)
Message-ID: <4e4d873b-4a40-334a-34e7-defb0fcc4e6b@samsung.com>
Date:   Mon, 3 Oct 2022 14:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.1
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v8 19/29] thermal/of: Remove of_thermal_get_crit_temp()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org
Content-Language: en-US
In-Reply-To: <20221003092602.1323944-20-daniel.lezcano@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87oLb1klGzRvM7Z4MG8bm8X3LdeZ
        LOZ9lrXY+3oru8Wmx9dYLS7vmsNmMXtJP4vF594jjBYzzu9jsuj8MovNYu6XqcwO3B47Z91l
        99i0qpPN4861PWwem5fUe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGvPvT2AtOiFd8XPGd
        qYHxm3AXIyeHhICJxKGPF1i6GLk4hARWMEqsaHrDBuF8YZRoX7qLCcL5zChxYPlvdpiWDaua
        oKqWM0qs6mxlBkkICXxklJjzSQrE5hWwk7i95gEriM0ioCLx9mQzG0RcUOLkzCcsILaoQLLE
        z64DYHE2AUOJrrddYLawgLfEyfavYDNFBBwlvvxdxA6yjFngIpPE0/19YEXMAuISt57MZwKx
        OQWcJP51TmaHiMtLNG+dzQzSICHQzCmx5MRDZoizXSSenOlkg7CFJV4d3wL1jozE/53zmSAa
        2hklFvy+D+VMYJRoeH6LEaLKWuLOuV9A3RxAKzQl1u/Shwg7ShxZcYIFJCwhwCdx460gxBF8
        EpO2TWeGCPNKdLQJQVSrScw6vg5u7cELl5gnMCrNQgqXWUhem4XknVkIexcwsqxiFE8tLc5N
        Ty02zEst1ytOzC0uzUvXS87P3cQITFqn/x3/tINx7quPeocYmTgYDzFKcDArifBOUbRMFuJN
        SaysSi3Kjy8qzUktPsQozcGiJM7LNkMrWUggPbEkNTs1tSC1CCbLxMEp1cCUe9lyY1ab/s+s
        XxNLlm7ye5Z7ebLalsacv7qaPzmWf5WJ7858oFfEZWvXM32F3IV/84NSgtcVSfA5HNv2Ni2j
        VnruvZjA9i+7s+fdN9pX1dPmOOlS3+EllVOlvx6VOndTe4PBseMJilyS6vv+OS358XDh56fu
        xsJHX76bM+Xx5FeB2idLrJvuBQVsWGr01z+2a4PIqkUTL6b+qSizmO+ZL51x7oVL8Isk4w7R
        mU8+HTlQo170vH1x98uEuf9/XTUI2aFx2ZyF8drv2yLxJ9Lb07ca26zYyGG/r3fO5p38zZPE
        J0+5cjPC3Xu5RGS171q1+gvSl49YhEhWXttvt3D6C/Yf81rf7/u4wNK5t2J5lxJLcUaioRZz
        UXEiAHWvleDJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7oLb1klG9z5LGLxYN42NovvW64z
        Wcz7LGux9/VWdotNj6+xWlzeNYfNYvaSfhaLz71HGC1mnN/HZNH5ZRabxdwvU5kduD12zrrL
        7rFpVSebx51re9g8Ni+p9+jbsorR4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNL
        PUNj81grI1MlfTublNSczLLUIn27BL2MefensRecEK/4uOI7UwPjN+EuRk4OCQETiQ2rmthA
        bCGBpYwSDw+KQ8RlJE5Oa2CFsIUl/lzrAqrhAqp5zyixa8IVZpAEr4CdxO01D8CKWARUJN6e
        bGaDiAtKnJz5hAXEFhVIlnj5ZyI7iM0mYCjR9bYLrEZYwFviZPtXsDkiAo4SX/4uYgdZwCxw
        mUli8cUmdohtZxgl9v7dzwhSxSwgLnHryXwmEJtTwEniX+dkdoi4mUTX1i6oGnmJ5q2zmScw
        Cs1CcsgsJO2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmCUbjv2c8sOxpWv
        PuodYmTiYDzEKMHBrCTCO0XRMlmINyWxsiq1KD++qDQntfgQoykwNCYyS4km5wPTRF5JvKGZ
        gamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA9NKoamXZsVMSmJvmHP/1e/7
        Ppu+ze6RiOTU++PJ6xVZN3vKW2PZNec+pnTtC/EysPP2Mvux3ufQ0qP2/wIeHtJZvllw7Z5V
        wp8WpR9+ELmBQ8DupMQf00bhFZ5ZDwqOqFxc3CSnHe3w9o/8PxtpU8mZTu7z3yzPLX1V0nks
        /kvJTXcJaf4rzHYTXje/3bd5j+MRo56Xl+aYLo+4pFT/STVy6c7lN7JOLn5dxM0gbC+YfeDa
        RTXP4LDZkTua9px8megefPH4koa5M87NKppgMcPww7avaXJZ/kqVrUqhl0y5IzTnmfGL+6/t
        CD24WDn7oi/X2aVLS5fqS5qFbl2fnmChml3/6Hph5JuYTZufGMxUYinOSDTUYi4qTgQAlYs8
        vlsDAAA=
X-CMS-MailID: 20221003125041eucas1p2dd08002bc6becbd612d6b43d620ef26f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221003093207eucas1p1d456288f35eadbc6fcda0bf24b58e678
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221003093207eucas1p1d456288f35eadbc6fcda0bf24b58e678
References: <20221003092602.1323944-1-daniel.lezcano@linaro.org>
        <CGME20221003093207eucas1p1d456288f35eadbc6fcda0bf24b58e678@eucas1p1.samsung.com>
        <20221003092602.1323944-20-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 03.10.2022 11:25, Daniel Lezcano wrote:
> The generic version of of_thermal_get_crit_temp() can be used. Let's
> remove this ops which is pointless.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

This patch breaks Exynos thermal driver as it introduces a NULL pointer 
dereference in exynos_tmu_initialize():

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
[00000000] *pgd=00000000
Internal error: Oops: 80000005 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-00072-ge521efddb107 
#12941
Hardware name: Samsung Exynos (Flattened Device Tree)
dwc2 12480000.hsotg: new address 125
PC is at 0x0
LR is at exynos_tmu_initialize+0x4c/0x1e8
...
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
Stack: (0xf082dd78 to 0xf082e000)
...
  exynos_tmu_initialize from exynos_tmu_probe+0x2b0/0x728
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
...
Code: bad PC value
---[ end trace 0000000000000000 ]---

If there is no replacement for tzd->ops->get_crit_temp(tzd, &temp), then 
please simply remove that call in exynos_tmu_initialize() to avoid 
breaking the initialization.

> ---
> drivers/thermal/thermal_of.c | 15 ---------------
> 1 file changed, 15 deletions(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 494e9c319541..bd872183e521 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -19,20 +19,6 @@
> #include "thermal_core.h"
> -static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
> - int *temp)
> -{
> - int i;
> -
> - for (i = 0; i < tz->num_trips; i++)
> - if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
> - *temp = tz->trips[i].temperature;
> - return 0;
> - }
> -
> - return -EINVAL;
> -}
> -
> /*** functions parsing device tree nodes ***/
> static int of_find_trip_id(struct device_node *np, struct device_node 
> *trip)
> @@ -529,7 +515,6 @@ struct thermal_zone_device 
> *thermal_of_zone_register(struct device_node *sensor,
> goto out_kfree_trips;
> }
> - of_ops->get_crit_temp = of_ops->get_crit_temp ? : 
> of_thermal_get_crit_temp;
> of_ops->bind = thermal_of_bind;
> of_ops->unbind = thermal_of_unbind;

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

