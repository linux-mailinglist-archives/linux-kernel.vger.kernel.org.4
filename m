Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B16B7CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCMPwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCMPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:52:37 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8964777E13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:52:00 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230313155118euoutp0276dacf348718b52b43b06b679b707944~MBWG43kdT3273332733euoutp02i
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:51:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230313155118euoutp0276dacf348718b52b43b06b679b707944~MBWG43kdT3273332733euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678722678;
        bh=idBYdNhVWG1lAl/DSsWHGmi6Mxp52JxM2Xrj0My8wl8=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Epw1cIFc96W8DfNC22mbt1Akzwe9sMR7I/ntFaUkIZ6erCAt7hBcYgMkEfQL3KZZe
         Ifs3IJ1MgQgZTjQ7/pnjllxZuTaw44iJ0xDKH0uCr3+9kE4urd/CqKBIsA8d4PkiqG
         joawophi5m39MCc0YxvOIJmm4weGB7ZjCMcu2oxk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230313155117eucas1p25c793851df8978d362ae3e8bcd04dfd2~MBWGhwRGf0784407844eucas1p2P;
        Mon, 13 Mar 2023 15:51:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5A.8A.09966.5764F046; Mon, 13
        Mar 2023 15:51:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230313155117eucas1p2f6a1e1073dfb4c30275d85c8ddd55a04~MBWFwvcPn0785807858eucas1p2t;
        Mon, 13 Mar 2023 15:51:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230313155117eusmtrp2625f602c9dc7573e965f1b16445152b3~MBWFwDLqq1314813148eusmtrp2L;
        Mon, 13 Mar 2023 15:51:17 +0000 (GMT)
X-AuditID: cbfec7f4-d39ff700000026ee-e1-640f4675ed47
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2E.EA.09583.5764F046; Mon, 13
        Mar 2023 15:51:17 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230313155116eusmtip2f0cab9a54cc5285c2fe3b59863b1c6ca~MBWE3rDzb1543715437eusmtip2J;
        Mon, 13 Mar 2023 15:51:16 +0000 (GMT)
Message-ID: <18d8e595-837d-5f6c-2a7a-09a47cf18d2e@samsung.com>
Date:   Mon, 13 Mar 2023 16:51:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/6] iommu/exynos: Convert to a module
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Rob Herring <robh@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAGETcx9ApZFvKjEaxvvgsoHDzOq06ZiROZ5npYt+suNdE4KWDg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7qlbvwpBidWGlk8mLeNzWJCRyuT
        xa8vFhab5xRbdM7ewG6x9/VWdotNj6+xWlzeNYfNYsb5fUwW/3oPMlr837OD3eLghyesFl2H
        /rJZPO8DSpy6+5nd4vj7x4wWLXdMHQQ9nhycx+SxZt4aRo+ds+6yeyzYVOqxaVUnm8eda3vY
        PDYvqfd4sXkmo0ffllWMHp83yQVwRXHZpKTmZJalFunbJXBl7Dm9krVgvV/F/RnHmRoYW+y7
        GDk5JARMJO63PmYCsYUEVjBK9N2X7mLkArK/MEpMvdLLBOF8ZpTofvaGDabjwMozrBCJ5YwS
        q9dNZIFwPjJKbFnwjx2kilfATuJr1y0wm0VAVaKt/QYjRFxQ4uTMJywgtqhAisSO87vBaoQF
        bCVa55wAs5kFxCVuPZkPdpOIQITE+6OrmUEWMAtsY5F4sOct2BlsAoYSXW+7gGwODk6BQIlr
        V7UgeuUltr+dA1YvIXCYU+Lcs3YWiLNdJP7u2Q9lC0u8Or6FHcKWkfi/cz4TREM7o8SC3/eh
        nAmMEg3PbzFCVFlL3Dn3C2wbs4CmxPpd+hBhR4kH144ygoQlBPgkbrwVhDiCT2LStunMEGFe
        iY42IYhqNYlZx9fBrT144RLzBEalWUjBMgvJ+7OQvDMLYe8CRpZVjOKppcW56anFRnmp5XrF
        ibnFpXnpesn5uZsYgQnx9L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRHeLfw8KUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphakFsFkmTg4pRqY1lie3+Yu4Rsd2bZT2vv7BYtv
        3AEHC+Y89T4rt/Jc9qzrV39mNMceTS50F8i8MpcpU/jsxK1R/+Zkb/nPnffe/0xOz/y3yxqm
        zV74pzLzbWPxZPOJqyaoHP3wQzj9zIMdv3+f1UhZ93vzC8HvbbMeVsw+5cb0Ta/GzqJboPK9
        SUajW+r87JjMjecinu9UWqFTp2x+qHjON1GOpo+flj/q8c/dbjH/ocO+9Y6twQeKOmW6xCxk
        A1zaVsttYRCd+3HiAfML/vKmkirmlv4r3mye4av+SdqrNDbeeXUtT+zMfXuamhWC3a/u6be4
        rqK6ZMqdf7Me5Pt5yum1Od92nle1aqGU/WLFq7NnLsvvOxsyT4mlOCPRUIu5qDgRAFJeNQn3
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsVy+t/xe7qlbvwpBvOOs1o8mLeNzWJCRyuT
        xa8vFhab5xRbdM7ewG6x9/VWdotNj6+xWlzeNYfNYsb5fUwW/3oPMlr837OD3eLghyesFl2H
        /rJZPO8DSpy6+5nd4vj7x4wWLXdMHQQ9nhycx+SxZt4aRo+ds+6yeyzYVOqxaVUnm8eda3vY
        PDYvqfd4sXkmo0ffllWMHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8da
        GZkq6dvZpKTmZJalFunbJehl7Dm9krVgvV/F/RnHmRoYW+y7GDk5JARMJA6sPMPaxcjFISSw
        lFFi3qF7jBAJGYmT0xpYIWxhiT/Xutggit4zSjw4c5YFJMErYCfxtesWO4jNIqAq0dZ+gxEi
        LihxcuYToBoODlGBFInZXTogYWEBW4nWOSfAypkFxCVuPZnPBFIiIhAh8XmHAsh4ZoEdLBI7
        F/+G2tXNLNF6dRYTSAObgKFE11uQIzg4OAUCJa5d1YKYYybRtbWLEcKWl9j+dg7zBEahWUiu
        mIVk3SwkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGP/bjv3csoNx5auPeocY
        mTgYDzFKcDArifBu4edJEeJNSaysSi3Kjy8qzUktPsRoCgyKicxSosn5wASUVxJvaGZgamhi
        ZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAlMgsvWTRYk5x6YdCPs0b936qDzQL
        2ffTcvFZ5uKEb0yzc2VfHhH+8d0vcfOqpnTl7bNv8enlcSSe1FA59HKu2FeH7adqNlvfrKm0
        tQjsm7zCXWrWtqQ7HSof3eVXnH7lqt8hoLz6ZlBEd0FEjbrDqsB7YitYTq/iMOCIPKLGcWyP
        37XgR0cP5h49JBt08JbrpncaeQvZqt0/rqrJdPxwmG/b7MzNNqaJ5bN8DF4pP/oTaWU4zcPj
        tEY0O+v/1gvhVaaq6deq6y/0WASpFHY/kTqwf/m2l/V/Vuo2z/7w6NvEQI3K3D2REVJ7J+oW
        3Vk4fe2TtrJ9u8xzd9vzT5QMap3Ko9i8e3/st8qmJsVpSizFGYmGWsxFxYkAjz7NR4gDAAA=
X-CMS-MailID: 20230313155117eucas1p2f6a1e1073dfb4c30275d85c8ddd55a04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221103195201eucas1p2a6ec2df41ebac3d9ccbb0b252c2cad34
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221103195201eucas1p2a6ec2df41ebac3d9ccbb0b252c2cad34
References: <CGME20221103195201eucas1p2a6ec2df41ebac3d9ccbb0b252c2cad34@eucas1p2.samsung.com>
        <20221103195154.21495-1-semen.protsenko@linaro.org>
        <a7d9cd18-a328-209c-c89f-afdcb7db3eb0@samsung.com>
        <b7ad6444-e7d2-1150-6134-3dae8129dcdb@samsung.com>
        <CAPLW+4=Y6qZG2XjJR_BkX-ar4GWdETKO1tteJjfbxVc664e4Kg@mail.gmail.com>
        <CAGETcx9ApZFvKjEaxvvgsoHDzOq06ZiROZ5npYt+suNdE4KWDg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

I'm sorry for the delay again, but finally I managed to get back to this 
topic.

On 07.02.2023 04:32, Saravana Kannan wrote:
> On Fri, Nov 11, 2022 at 5:30 AM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
>> On Thu, 10 Nov 2022 at 15:36, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>
>> [snip]
> Hi Marek and Sam,
>
> I'm replying to both of your comments in this email.
>
>>> I've finally made Exynos IOMMU working as a module on Exynos5433 based
>>> TM2e board. It looks that this will be a bit longer journey that I've
>>> initially thought. I've posted a simple update of the fix for the driver
>>> initialization sequence, but the real problem is in the platform driver
>>> framework and OF helpers.
>>>
>>> Basically to get it working as a module I had to apply the following
>>> changes:
>>>
>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>> index 3dda62503102..f6921f5fcab6 100644
>>> --- a/drivers/base/dd.c
>>> +++ b/drivers/base/dd.c
>>> @@ -257,7 +257,7 @@ static int deferred_devs_show(struct seq_file *s,
>>> void *data)
>>>    DEFINE_SHOW_ATTRIBUTE(deferred_devs);
>>>
>>>    #ifdef CONFIG_MODULES
>>> -int driver_deferred_probe_timeout = 10;
>>> +int driver_deferred_probe_timeout = 30;
>>>    #else
>>>    int driver_deferred_probe_timeout;
>>>    #endif
>>> diff --git a/drivers/of/property.c b/drivers/of/property.c
>>> index 967f79b59016..e5df6672fee6 100644
>>> --- a/drivers/of/property.c
>>> +++ b/drivers/of/property.c
>>> @@ -1384,7 +1384,7 @@ static struct device_node *parse_interrupts(struct
>>> device_node *np,
>>>    static const struct supplier_bindings of_supplier_bindings[] = {
>>>           { .parse_prop = parse_clocks, },
>>>           { .parse_prop = parse_interconnects, },
>>> -       { .parse_prop = parse_iommus, .optional = true, },
>>> +       { .parse_prop = parse_iommus, },
>>>           { .parse_prop = parse_iommu_maps, .optional = true, },
>>>           { .parse_prop = parse_mboxes, },
>>>           { .parse_prop = parse_io_channels, },
>>>
>>> Without that a really nasty things happened.
> I have a command line option to do this without code changes. Use
> fw_devlink.strict=1. That makes all optional properties into mandatory
> ones.
>
> I sent out a series[1] that tried to make fw_devlink.strict=1 the
> default and then use the timeout behavior (more details) to handle
> cases where iommu and dmas (or any other supplier) are optional on a
> specific board. The cover letter of [1] should give some more context.

I'm for removing the optional properties or making them dependent on the 
whole subsystem availability (see my next comments).


>>> Initialization of the built-in drivers and loading modules takes time,
>>> so the default 10s deferred probe timeout is not enough to ensure that
>>> the built-in driver won't be probed before the Exynos IOMMU driver is
>>> loaded.
> The 10 second is the minimum delay from the time we hit late_initcall.
> If a driver is registered before the 10s expires, then the timer will
> be extended by another 10s. This behavior landed sometime around the
> end of May 2022. So it should have been in your tree when you tested
> this. I'm surprised this isn't sufficient for your case. Is there
> really a 10s gap in your boot sequence where no module is being loaded
> and then IOMMU modules get loaded later on? I'm kinda surprised by
> this. Is it this long because some serial UART is enabled and it's
> slowing down boot? Or something else?
>
> I'm not saying your case isn't valid or we shouldn't extend the
> timeout. I'm just trying to understand why the current timer behavior
> wasn't able to cover your case.


Well, I have almost all possible CONFIG_DEBUG_* options enabled in 
exynos_defconfig, as well as kernel messages routed to UART console, so 
all my test system are really slow, but I do this intentionally. I 
suspect that over half of the issues I've reported were found because of 
such 'unusual' config. Loading modules also takes time in such case, so 
maybe the timeout should be extended also by each loaded module?


>> Yeah, the whole time-based sync looks nasty... I remember coming
>> across the slides by Andrzej Hajda called "Deferred Problem" [1], but
>> I guess the proposed solution was never applied. Just hope that
>> increasing the timeout is upstreamable solution.
>>
>> [1] https://events19.linuxfoundation.org/wp-content/uploads/2017/12/Deferred-Problem-Issues-With-Complex-Dependencies-Between-Devices-in-Linux-Kernel-Andrzej-Hajda-Samsung.pdf
> Sam, I kinda skimmed the slides right now. Looks like it talks about
> device links and why they aren't sufficient and makes an alternate
> proposal. fw_devlink is a solution that uses device links and I think
> addresses a lot of the issues that were raised about device links.
> There's still a bunch of TODOs left, but I think the end goal is the
> same. I'm hoping to keep chipping away at it. For now, I've tried to
> make the timer a bit more smart about detecting when modules are
> getting loaded and extending the timer. fw_devlink also enables
> something called sync_state() that's invaluable on a fully modular
> system (search lore for references to that to get some idea).
>
> The slides talk about a solution that will allow devices to probe with
> limited functionality with whatever suppliers are available and then
> reprobe as more suppliers are available. I'm not sure how well that'll
> work across the board. It's going to be a bit weird if your phone
> display goes off and then comes on again because an IOMMU driver got
> loaded (and it can now do DRM playback). For now, I'm not going to
> focus on that option because there are enough existing issues/TODOs to
> work on for fw_devlink.
>
>>> The second change fixes the problem that driver core probes Exynos IOMMU
>>> controllers in parallel to probing the master devices, what results in
>>> calling exynos_iommu_of_xlate() and exynos_iommu_probe_device() even on
>>> the partially initialized IOMMU controllers or initializing the dma_ops
>>> under the already probed and working master device. This was easy to
>>> observe especially on the master devices with multiple IOMMU
>>> controllers. I wasn't able to solve this concurrency/race issues inside
>>> the Exynos IOMMU driver.
>>>
>>> Frankly speaking I don't know what is the rationale for making the
>>> 'iommus' property optional, but this simply doesn't work well with IOMMU
>>> driver being a module. CCed Saravana and Rob for this.
>>>
>> The patch which makes 'iommus' optional doesn't provide much of
>> insight on reasons in commit message either.
> This was the commit text:
>
>      Not all DT bindings are mandatory bindings. Add support for optional DT
>      bindings and mark iommus, iommu-map, dmas as optional DT bindings.
>
> I thought it was obvious enough, but I guess I could have done better.
> Geert convinced me that iommu's aren't always necessary and devices
> could work perfectly well without them or dmas. And he has a bunch of
> boards like that. So I went with adding optional and then introducing
> fw_devlink.strict.

Well, that depends heavily on the kernel config and the intentions 
behind it. Indeed one might have IOMMU driver not selected in the config 
(for various reasons, like forcing drivers to use contiguous memory 
buffers for max performance) and system should boot fine. That time one 
didn't consider the IOMMUs being compiled as modules. The main problem 
is how to distinguish between the first case (intentionally no IOMMU 
driver or even no IOMMU support) and the modularized case (driver not 
yet loaded). I assume that one can skip waiting for IOMMUs only if the 
whole IOMMU subsystem is not compiled in, otherwise the IOMMU driver can 
still come in and it cannot properly start operating if client device 
drivers already started their operation.

DMAs, although similar a bit, are imho a bit different. Drivers usually 
have some kind of fallback if DMA is not yet available, but usually 
drivers can switch their operation on-fly between PIO and DMA (and some 
even do that intentionally and use PIO for very small transfers).

> However, at this point in time, I believe none of them should be
> marked as optional because technically any property can be optional
> depending on what the firmware has set up and what the driver does. We
> should figure this out at runtime on a board level -- which is what
> [1] is trying to do. Yeah, not very pretty, but there hasn't been a
> better solution that's not "have userspace tell us it's done loading
> modules" (that's a "kernel depends on userspace to work correctly"
> thing that no one likes). I've fixed some of the issues raised in [1]
> in a fw_devlink improvement series[2] and I plan on continuing to work
> on this until hopefully [1] can land.
>
>>> Without fixing the above issues, I would add a warning that compiling
>>> the driver as a module leads to serious issues.
>>>
>> Nice catch! It doesn't reproduce on my platform, alas. Can I expect
>> you to submit those patches? If so, I'll probably just wait for those
>> to be applied, and then re-send my modularization series on top of it.
>> Does that sounds reasonable?
> For now, maybe we could add a config to enable fw_devlink.strict=1 by
> default and then select it if you make specific iommu drivers into
> modules? And then Geert won't set it for his driver, but you can set
> it for your driver?

I think the best we can do now is to either add a kconfig option to 
force strict fw_devlinks (so Exynos IOMMU can be selected as a module 
only if that one is selected) or do a runtime check during the Exynos 
IOMMU initalization - and fail with appropriate error message if 
fw_devlink.strict!=1. What do you think?


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

