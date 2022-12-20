Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDE2652156
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiLTNSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiLTNRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:17:55 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897C815801
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:17:51 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221220131748euoutp02c492254591c352264f52c18612600d18~ygtZIZBuL2499324993euoutp02I
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 13:17:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221220131748euoutp02c492254591c352264f52c18612600d18~ygtZIZBuL2499324993euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671542268;
        bh=u2hyIB3smLwmi6kwcSyaoYQCVkNank/KtH++oPh4kP8=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=KSP3/NyAF43MANXpCEpINbfqKgSu1+PtWxN0VVFcyFbZ/hXIPSerfCIeOWk9+ctL9
         cHPmHFWsj2d1kHRDBdubwcjPO9kiLt8ML094XRiXZMQlt0hJdNpyrGzWiyEWpxggMZ
         RvtGQhn/NLoMnus9kmP/KRusNxGpJZlWyvy98QA8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221220131748eucas1p1f117294690fd197a1ae6e40bf5de8a37~ygtYwmpC-1191611916eucas1p1u;
        Tue, 20 Dec 2022 13:17:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 70.F4.09561.BF5B1A36; Tue, 20
        Dec 2022 13:17:48 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221220131747eucas1p1411947fee7d65825ccedad8f8a12a4df~ygtYKJhsS1994719947eucas1p1T;
        Tue, 20 Dec 2022 13:17:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221220131747eusmtrp2ea4681a8a9ee666a49138c67e0371292~ygtYJV0iQ1727317273eusmtrp2D;
        Tue, 20 Dec 2022 13:17:47 +0000 (GMT)
X-AuditID: cbfec7f2-0c9ff70000002559-6b-63a1b5fb6569
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0C.BE.08916.BF5B1A36; Tue, 20
        Dec 2022 13:17:47 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221220131746eusmtip2e8257ea3f10f0857b21bc9eb4b354b55~ygtXVHqrd1217112171eusmtip26;
        Tue, 20 Dec 2022 13:17:46 +0000 (GMT)
Message-ID: <206f30df-4833-3909-2d01-472fcfa2baa6@samsung.com>
Date:   Tue, 20 Dec 2022 14:17:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.0
Subject: Re: next: kernel BUG at drivers/virtio/virtio.c:122!
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        virtualization@lists.linux-foundation.org, dmitry.fomichev@wdc.com
Content-Language: en-US
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20221220054938-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djPc7p/ti5MNvj6i8mi40EDo8WtKb+Z
        LPbPe85u8XfSMXaLte3dbBbLLn1msri8aw6bxcGFbYwWW+9NY7f4/+sVq8WtT/wWG992sFuc
        XzuL1WL52XlsFteaLBz4PX7/msTosXjPSyaPq6/2s3rcubaHzWPnQ0uP2/8eM3tMvrGc0ePF
        5pmMHu/3XWXz+LxJzqP9QDdTAHcUl01Kak5mWWqRvl0CV8amz8tYCxbaVvRsesvUwHjeqIuR
        k0NCwETi0bedbF2MXBxCAisYJXoWHWOBcL4wSuzeuIIRwvnMKHGwbzVQhgOsZfbTWIj4ckaJ
        t53n2EFGCQl8ZJR4dkoGxOYVsJNYOfcqG4jNIqAqcfzXR1aIuKDEyZlPWEBsUYEUiVVvlzGD
        2MICthJPzzQwgdgiAsESt1v3gvUyC/SzSNw77gthi0vcejIfrIZNwFCi620XWA2ngI3E+utL
        GSFq5CW2v53DDPHaYU6JB5uCIWwXiSurnjFB2MISr45vYYewZST+7wSZyQVktzNKLPh9H8qZ
        wCjR8PwWI0SVtcSdc7/YQL5nFtCUWL9LHyLsKHH/1kRGSKDwSdx4KwhxA5/EpG3TmSHCvBId
        bUIQ1WoSs46vg1t78MIl5gmMSrOQQmUWki9nIflmFsLeBYwsqxjFU0uLc9NTiw3zUsv1ihNz
        i0vz0vWS83M3MQLT4Ol/xz/tYJz76qPeIUYmDsZDjBIczEoivL9uzksW4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkzjtj6/xkIYH0xJLU7NTUgtQimCwTB6dUA5NY1Kd1baJbZnl/dlU5dL7rq492
        yj+Rw46P3m5cuNPG6Knf8kOSj81W+H9/taT0PCOX6Ir3Kncnucx9OX1Z5gw3BgslL8m4yM3b
        l9tYRpuEnfrP1/HiaNtpBuOjhx10ZBy+Ti577/Q9PHJe22Pvd6krXW8utT97fXVhgM+t7Xb6
        Gg3L5e7UPHuX3HPSLas34OONpZ77zb2C19531Q9tlr9XUuRzdtNvnQvLuu54qYYXcc3Xeukc
        mvyV8958nmTzh02vj3v7PV1/oEylMi35yZWw2283SVmekAiXdJ2g9v79n4CrWknBdotkw+96
        3j/ZoH90v6Bnlv39s01Gv7p37/tRc4zvWG15iMH3O+Veq12VWIozEg21mIuKEwFx6HIH8gMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsVy+t/xe7q/ty5MNvh7RMyi40EDo8WtKb+Z
        LPbPe85u8XfSMXaLte3dbBbLLn1msri8aw6bxcGFbYwWW+9NY7f4/+sVq8WtT/wWG992sFuc
        XzuL1WL52XlsFteaLBz4PX7/msTosXjPSyaPq6/2s3rcubaHzWPnQ0uP2/8eM3tMvrGc0ePF
        5pmMHu/3XWXz+LxJzqP9QDdTAHeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWR
        qZK+nU1Kak5mWWqRvl2CXsamz8tYCxbaVvRsesvUwHjeqIuRg0NCwERi9tPYLkYuDiGBpYwS
        L2Z0s3cxcgLFZSROTmtghbCFJf5c62KDKHrPKHH5zT5GkASvgJ3EyrlX2UBsFgFVieO/PrJC
        xAUlTs58wgJiiwqkSLy83AJmCwvYSjw908AEYosIBEv0LbvJBDKUWWAii8SJQzuZIDZsY5R4
        /HsmWAezgLjErSfzwTrYBAwlut52gW3jFLCRWH99KSNEjZlE19YuKFteYvvbOcwTGIVmITlk
        FpJRs5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg9G879nPzDsZ5rz7qHWJk
        4mA8xCjBwawkwvvr5rxkId6UxMqq1KL8+KLSnNTiQ4ymwNCYyCwlmpwPTD95JfGGZgamhiZm
        lgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MIiGKes/KeDsZ7r6TuaXOGzonUmWK
        8Ja9qpPShQSq2J8YL2d7dmbv5DsyAnJ7g38mnb9QcPS+Kfsm15ebz314faz1aMU3hYvF/I3K
        ojEOrW4zmIW2a/woeWGoarb26fMLHjHfTQ81xHKLnD9S2telkD+R+RvLxjlz187ea+rde6hA
        eIq0m80vhpVNk/y2z0+Zw64sofMq9PqqsncHDG0rwxLeL9+/xuff9CflFreqTgq8Frswdam/
        18nJvxKPrLvIYrFE7Pdnlv8b7JmvTGhpOBKYlvv2Q3ylnrRyfLaK/OM58gzez5JY/xztDP6h
        J8/A7zxPdgbXtzsrLtdLHj+o1bt3urw2688OlcdV1Uf1lFiKMxINtZiLihMB818O/ocDAAA=
X-CMS-MailID: 20221220131747eucas1p1411947fee7d65825ccedad8f8a12a4df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221220131747eucas1p1411947fee7d65825ccedad8f8a12a4df
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221220131747eucas1p1411947fee7d65825ccedad8f8a12a4df
References: <CA+G9fYvz1eNS5fw1Wg5f4HqwdWPNg3EQyrGZVEOJ=OQzYzZ_YQ@mail.gmail.com>
        <1671532079.1159124-1-xuanzhuo@linux.alibaba.com>
        <20221220054938-mutt-send-email-mst@kernel.org>
        <CGME20221220131747eucas1p1411947fee7d65825ccedad8f8a12a4df@eucas1p1.samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.2022 11:54, Michael S. Tsirkin wrote:
> On Tue, Dec 20, 2022 at 06:27:59PM +0800, Xuan Zhuo wrote:
>> On Tue, 20 Dec 2022 14:51:54 +0530, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>> The qemu-x86_64 and qemu-arm64 boot failed with Linux next-20221220 tag.
>>> It is always reproducible with gcc-11/ gcc-12 and clang tool chains.
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
>>> <5>[    0.000000] Linux version 6.1.0-next-20221220 (tuxmake@tuxmake)
>>> (Debian clang version 16.0.0
>>> (++20221218072110+9c1b82599dac-1~exp1~20221218072217.501), Debian LLD
>>> 16.0.0) #1 SMP PREEMPT @1671498176
>>> <5>[    0.000000] random: crng init done
>>> <6>[    0.000000] Machine model: linux,dummy-virt
>>> ....
>>> <6>[    3.571098] loop: module loaded
>>> <6>[    3.573410] virtio_blk virtio0: 1/0/0 default/read/poll queues
>>> <5>[    3.578816] virtio_blk virtio0: [vda] 2816420 512-byte logical
>>> blocks (1.44 GB/1.34 GiB)
>>> <4>[    3.581234] ------------[ cut here ]------------
>>> <2>[    3.581595] kernel BUG at drivers/virtio/virtio.c:122!
>>> <0>[    3.582906] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>>> <4>[    3.583672] Modules linked in:
>>> <4>[    3.584905] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>>> 6.1.0-next-20221220 #1
>>> <4>[    3.585801] Hardware name: linux,dummy-virt (DT)
>>> <4>[    3.586591] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT
>>> -SSBS BTYPE=--)
>>> <4>[    3.587349] pc : virtio_check_driver_offered_feature+0x60/0x6c
>>> <4>[    3.588613] lr : virtblk_probe+0x7cc/0x8f0
>>> <4>[    3.588915] sp : ffff80000802b840
>>> <4>[    3.589314] x29: ffff80000802b850 x28: 0000000000000000 x27:
>>> 0000000000000001
>>> <4>[    3.590509] x26: 0000000000000001 x25: 0000000000000200 x24:
>>> ffff0000c1699b00
>>> <4>[    3.590832] x23: 00000000000000fe x22: ffff0000c0313c30 x21:
>>> ffff0000c0313c00
>>> <4>[    3.591568] x20: ffff0000c02f4080 x19: 0000000000000000 x18:
>>> ffffffffffffffff
>>> <4>[    3.592056] x17: 00000000ffffffea x16: 00000000fffffffe x15:
>>> 0000000000000004
>>> <4>[    3.592632] x14: 0000000000000fff x13: ffff800008028000 x12:
>>> ffff80000802c000
>>> <4>[    3.593157] x11: 000000000000000f x10: 000000000000000f x9 :
>>> ffffae66eee314d8
>>> <4>[    3.594048] x8 : 0000000000000000 x7 : 3631383837352e33 x6 :
>>> 202020205b3e353c
>>> <4>[    3.594429] x5 : 0000000000000001 x4 : 0000000000000000 x3 :
>>> ffff80000802b780
>>> <4>[    3.594956] x2 : ffff80000802b6f8 x1 : 0000000000000011 x0 :
>>> ffff0000c02f4080
>>> <4>[    3.595811] Call trace:
>>> <4>[    3.596120]  virtio_check_driver_offered_feature+0x60/0x6c
>>> <4>[    3.596632]  virtio_dev_probe+0x274/0x320
>>> <4>[    3.597064]  really_probe+0x178/0x418
>>> <4>[    3.597547]  __driver_probe_device+0x120/0x188
>>> <4>[    3.597820]  driver_probe_device+0x48/0x22c
>>> <4>[    3.598189]  __driver_attach+0xf8/0x250
>>> <4>[    3.598656]  bus_for_each_dev+0x8c/0xd8
>>> <4>[    3.599151]  driver_attach+0x30/0x3c
>>> <4>[    3.599321]  bus_add_driver+0x11c/0x22c
>>> <4>[    3.599684]  driver_register+0x84/0x120
>>> <4>[    3.600175]  register_virtio_driver+0x38/0x48
>>> <4>[    3.600575]  virtio_blk_init+0x6c/0xb4
>>> <4>[    3.600759]  do_one_initcall+0xe0/0x2f8
>>> <4>[    3.601197]  do_initcall_level+0xa8/0x150
>>> <4>[    3.601703]  do_initcalls+0x60/0xa0
>>> <4>[    3.601892]  do_basic_setup+0x28/0x34
>>> <4>[    3.602229]  kernel_init_freeable+0x100/0x178
>>> <4>[    3.602706]  kernel_init+0x2c/0x1b4
>>> <4>[    3.603162]  ret_from_fork+0x10/0x20
>>> <0>[    3.604398] Code: 540000a0 91001129 f1000508 54ffff61 (d4210000)
>>> <4>[    3.606108] ---[ end trace 0000000000000000 ]---
>>> <6>[    3.606714] note: swapper/0[1] exited with preempt_count 1
>>> <0>[    3.608155] Kernel panic - not syncing: Attempted to kill init!
>>> exitcode=0x0000000b
>>> <2>[    3.609173] SMP: stopping secondary CPUs
>>> <0>[    3.610506] Kernel Offset: 0x2e66e4800000 from 0xffff800008000000
>>> <0>[    3.610970] PHYS_OFFSET: 0x40000000
>>> <0>[    3.611428] CPU features: 0x00000,003a612f,cd22773f
>>> <0>[    3.612277] Memory Limit: none
>>> <0>[    3.613192] ---[ end Kernel panic - not syncing: Attempted to
>>> kill init! exitcode=0x0000000b ]---
>>>
>>> Ref Links,
>>> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221220/testrun/13764099/suite/log-parser-test/test/check-kernel-bug/details/
>>> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221220/testrun/13766814/suite/boot/test/clang-nightly-lkftconfig/details/
>>> https://storage.tuxsuite.com/public/linaro/lkft/builds/2J9l3qxSBmPWVa1S2uWn0Xuwl1J/config
>>>
>>
>> I think there is a bug, VIRTIO_BLK_F_ZONED depends the CONFIG_BLK_DEV_ZONE, but
>> checking its code in virtblk_probe does not depend on this config.
>>
>> This option in your config file is indeed not opened.
>>
>>
>> static int virtblk_probe(struct virtio_device *vdev){
>> .....
>> 	virtblk_update_capacity(vblk, false);
>> 	virtio_device_ready(vdev);
>>
>> 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
>> 		err = virtblk_probe_zoned_device(vdev, vblk, q);
>> 		if (err)
>> 			goto out_cleanup_disk;
>> 	}
>>
>> 	dev_info(&vdev->dev, "blk config size: %zu\n",
>> 		sizeof(struct virtio_blk_config));
>>
>> ....
>>
>> static unsigned int features[] = {
>> 	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
>> 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>> 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>> 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
>> 	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
>> #ifdef CONFIG_BLK_DEV_ZONED
>> 	VIRTIO_BLK_F_ZONED,
>> #endif /* CONFIG_BLK_DEV_ZONED */
>> }
>>
>>
>> Thanks.
> Oh you are right, I wanted to test it so of course I enabled it.
>
> Testing this fixup now:
>
> commit f9503d0fd839b59e0f48b00c20635437c41420ed
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Tue Dec 20 05:53:41 2022 -0500
>
>      fixup! virtio-blk: add support for zoned block devices

I also confirm that this patch fixes the issue with broken virtio block 
device observed on QEMU arm/arm64 'virt' machines and linux 
next-20221220. Thanks for the fix!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index ff49052e26f7..d8cdaeb51d1c 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -775,6 +775,10 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
>   	return ret;
>   }
>   
> +static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
> +{
> +	return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
> +}
>   #else
>   
>   /*
> @@ -790,6 +794,11 @@ static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
>   {
>   	return -EOPNOTSUPP;
>   }
> +
> +static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
> +{
> +	return false;
> +}
>   #endif /* CONFIG_BLK_DEV_ZONED */
>   
>   /* return id (s/n) string for *disk to *id_str
> @@ -1576,11 +1585,11 @@ static int virtblk_probe(struct virtio_device *vdev)
>   		else
>   			q->limits.discard_granularity = blk_size;
>   	}
>   
>   	virtblk_update_capacity(vblk, false);
>   	virtio_device_ready(vdev);
>   
> -	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> +	if (virtblk_has_zoned_feature(vdev)) {
>   		err = virtblk_probe_zoned_device(vdev, vblk, q);
>   		if (err)
>   			goto out_cleanup_disk;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

