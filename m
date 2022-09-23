Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1E85E85C0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiIWWTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWWTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:19:41 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697519C3D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:19:39 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220923221937euoutp0152d3035f89f7f8cc9011c06436f90d2c~XnVVs5bS30972909729euoutp01e
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:19:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220923221937euoutp0152d3035f89f7f8cc9011c06436f90d2c~XnVVs5bS30972909729euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663971577;
        bh=Y0nKIoUfaCsg/EXBd0afFa2cIruznfzPq/OchNG5aew=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=uw/fUJ+iNNxawiiNEg+cFFYZybUtoV76QYldqlOdtJaIJcKEQC8ssV7fgt02VkjS3
         RFLK+MD0oFtFmRu8uV3ceoxy4bfXDB2gypGKQ38n/ALKN5UEHT0Z16L7ICZqcxmq8H
         XDF3lPBuFNq5Vy4wLmrxU64Id72+b2kTjxFlYDek=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220923221936eucas1p242e1f6e807d036ec3872293ac6c52c24~XnVVCdF5Z1450914509eucas1p2n;
        Fri, 23 Sep 2022 22:19:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0C.8A.07817.8F03E236; Fri, 23
        Sep 2022 23:19:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220923221936eucas1p1e01148605c9aaf27d8d71969feb99144~XnVUyMwcb2541025410eucas1p1u;
        Fri, 23 Sep 2022 22:19:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220923221936eusmtrp12112bfd1533bb8855963fa0fa6589466~XnVUxje8b2319123191eusmtrp1i;
        Fri, 23 Sep 2022 22:19:36 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-af-632e30f84da1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AD.71.10862.8F03E236; Fri, 23
        Sep 2022 23:19:36 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220923221936eusmtip109eab2a655d387ee53d23b068ea14331~XnVUZMguV0727107271eusmtip1g;
        Fri, 23 Sep 2022 22:19:36 +0000 (GMT)
Message-ID: <c85a77a3-409b-3e83-08a7-ac7e1888790d@samsung.com>
Date:   Sat, 24 Sep 2022 00:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v4 01/30] thermal/core: Add a generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220921094244.606948-2-daniel.lezcano@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87o/DPSSDR5c17M4PL/CYt5nWYvL
        u+awWXzuPcJoMffLVGaLJw/72BzYPBbvecnksWlVJ5vHnWt72Dw+b5ILYInisklJzcksSy3S
        t0vgynj9Yx1zwTXJihe3XjI1ML4X6WLk5JAQMJF4OO8CYxcjF4eQwApGiYtffrFCOF8YJRb2
        drCAVAkJfGaUODElCq7j9EE2iKLljBLL989ghnA+Mko8W/0IrINXwE5iyfbd7CA2i4CqxMd/
        h9gg4oISJ2c+AasRFUiWmHXsGCOILSwQI9F8to8JxGYWEJe49WQ+mC0i4Cjx5e8idoh4scTv
        Z81gNpuAoUTX2y6wmZwCDhLrf91hhaiRl9j+dg7YQRICJzgkfjQvYoY420Viwr0JULawxKvj
        W9ghbBmJ05N7WCAa2hklFvy+zwThTGCUaHh+ixGiylrizrlfQOs4gFZoSqzfpQ8RdpR4tbgV
        LCwhwCdx460gxBF8EpO2TWeGCPNKdLQJQVSrScw6vg5u7cELl5gnMCrNQgqWWUjen4XknVkI
        excwsqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITDan/x3/soNx+auPeocYmTgYDzFK
        cDArifCmXNRNFuJNSaysSi3Kjy8qzUktPsQozcGiJM7LNkMrWUggPbEkNTs1tSC1CCbLxMEp
        1cCU6Pht7Y3ov19Z5XyXcBR8KOOp3Xf08eOA6wfzPDzk+xI4Z3KV3fqZeVzP/3bqPNvFm8MC
        L3e07rSd6OgQdUVhZf7bCuWmSAWBokxthUkS17nvy1/Sel9V5vlmf4vERm1tCcG3e9xnvWNp
        O+9b3tYZv2M1/7fDNzk1IlbHB77W/P+r+t3frRu+THyTqSrzRzvb3VXiWWjpbm72PvEpmc7f
        tYzf8c3tC/F5cvZN8Nsf0h0mF4wY56pxxEx0uSbZrPbQ8XRSuNUZ1kcCLke98ioj5be8u/3P
        5tmX5j+dJrvnHTr2fJnEnrOhMw8Vsni1ukkuS1G5y9E2sezYzKqgF4cVp0SEPp+2UVD+5vbO
        GH0lluKMREMt5qLiRACnoD7LpQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7o/DPSSDXbulLU4PL/CYt5nWYvL
        u+awWXzuPcJoMffLVGaLJw/72BzYPBbvecnksWlVJ5vHnWt72Dw+b5ILYInSsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy3j9Yx1zwTXJihe3XjI1
        ML4X6WLk5JAQMJF4ePogWxcjF4eQwFJGiT9Pr7JBJGQkTk5rYIWwhSX+XOsCiwsJvGeUuL8g
        DcTmFbCTWLJ9NzuIzSKgKvHx3yE2iLigxMmZT1hAbFGBZIklDffB5ggLxEg0n+1jArGZBcQl
        bj2ZD2aLCDhKfPm7iB0iXizR1/qeFWJXqURTfx/YHDYBQ4mutxA3cAo4SKz/dYcVot5Momtr
        FyOELS+x/e0c5gmMQrOQnDELybpZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cT
        IzC2th37uWUH48pXH/UOMTJxMB5ilOBgVhLhTbmomyzEm5JYWZValB9fVJqTWnyI0RQYFhOZ
        pUST84HRnVcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwCT++6D7
        uRwxbmnW6qs566V3LdF5uJ3h4P2kwrOHOuKmbb0Vqac3W7AxO6TlmaxyC1PFi/a/QS8PavCW
        Z5YqGQWqpppcnM9m3tp6Mvu3atz/WdWCRoubvt/gfRN78JzAJ++oh5ckRJJ8v7YcuerB/vXx
        xhkeR/OPxLdd6og4z1vLd0V54ZKrjb0zfs2Zv8BmSsDb+UKKW09Zcz2Z9GGhfLTG48KpBkVz
        MgrMf07jWnqeh7W0gPXw6vlHU55p3Si067K4FH3gw+U3WnIx/6sWNq3/u8nxs4a32S+Lmof7
        twhm3dzK2ZfGs+fCz/ly6oe4T9zJmzBtfp0k9+XEtdte5fn6Msyfv/6kxccLfof8tVcrsRRn
        JBpqMRcVJwIA3VYWuzYDAAA=
X-CMS-MailID: 20220923221936eucas1p1e01148605c9aaf27d8d71969feb99144
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923221936eucas1p1e01148605c9aaf27d8d71969feb99144
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923221936eucas1p1e01148605c9aaf27d8d71969feb99144
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
        <20220921094244.606948-2-daniel.lezcano@linaro.org>
        <CGME20220923221936eucas1p1e01148605c9aaf27d8d71969feb99144@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 21.09.2022 11:42, Daniel Lezcano wrote:
> The thermal_zone_device_ops structure defines a set of ops family,
> get_trip_temp(), get_trip_hyst(), get_trip_type(). Each of them is
> returning a property of a trip point.
>
> The result is the code is calling the ops everywhere to get a trip
> point which is supposed to be defined in the backend driver. It is a
> non-sense as a thermal trip can be generic and used by the backend
> driver to declare its trip points.
>
> Part of the thermal framework has been changed and all the OF thermal
> drivers are using the same definition for the trip point and use a
> thermal zone registration variant to pass those trip points which are
> part of the thermal zone device structure.
>
> Consequently, we can use a generic function to get the trip points
> when they are stored in the thermal zone device structure.
>
> This approach can be generalized to all the drivers and we can get rid
> of the ops->get_trip_*. That will result to a much more simpler code
> and make possible to rework how the thermal trip are handled in the
> thermal core framework as discussed previously.
>
> This change adds a function thermal_zone_get_trip() where we get the
> thermal trip point structure which contains all the properties (type,
> temp, hyst) instead of doing multiple calls to ops->get_trip_*.
>
> That opens the door for trip point extension with more attributes. For
> instance, replacing the trip points disabled bitmask with a 'disabled'
> field in the structure.
>
> Here we replace all the calls to ops->get_trip_* in the thermal core
> code with a call to the thermal_zone_get_trip() function.
>
> While at it, add the thermal_zone_get_num_trips() to encapsulate the
> code more and reduce the grip with the thermal framework internals.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

This patch landed in linux next-20220923 as commit 78ffa3e58d93 
("thermal/core: Add a generic thermal_zone_get_trip() function"). 
Unfortunately it introduces a deadlock:

thermal_zone_device_update() calls handle_thermal_trip() under the 
tz->lock, which in turn calls thermal_zone_get_trip(), which gathers 
again tz->lock. I've tried to fix this by switching 
handle_thermal_trip() to call __thermal_zone_get_trip().

This helps for fixing the issue in this change, but then I've tried to 
apply it on top of linux next-20220923. Unfortunately it fails again. It 
looks that the other changes also assumes that calling 
thermal_zone_get_trip() is possible under the tz->lock, because in my 
case it turned out that handle_non_critical_trips() called 
step_wise_throttle(), which in turn called thermal_zone_get_trip(). I 
gave up fixing this. Please re-check possible call paths and adjust 
locking to them.


> ---
>   drivers/thermal/thermal_core.c    | 87 +++++++++++++++++++++++--------
>   drivers/thermal/thermal_helpers.c | 28 +++++-----
>   drivers/thermal/thermal_netlink.c | 21 ++++----
>   drivers/thermal/thermal_sysfs.c   | 66 +++++++++--------------
>   include/linux/thermal.h           |  5 ++
>   5 files changed, 118 insertions(+), 89 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

