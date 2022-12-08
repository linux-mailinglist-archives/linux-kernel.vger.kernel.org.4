Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6B86472CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiLHPYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiLHPX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:23:59 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DB85F77
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:23:56 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221208152353euoutp02aa9b55c0df3a1d154050ead07eda10ed~u2sDuUqje2610426104euoutp022
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:23:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221208152353euoutp02aa9b55c0df3a1d154050ead07eda10ed~u2sDuUqje2610426104euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670513034;
        bh=OrmxLMBie7RU7j1OkjD6kEsQUe2ELZisKr1YLfMRIpA=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
        b=fmx2v8LPOn86xzkLCKoBr4QNWoZLYInrlwr7xQivsa0IgD+4XEB4GFqtlZq0smHI5
         bqeFfevUgdSpB9FKP5xOx3jXvfd01eDF6iZR+no97AVs42/33KN3On4Mc2+QtY5RHH
         0iFrus0SRSLYAUm92XcJn4rzJn44QaMo+XEyJ7eY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221208152353eucas1p244caf6275868c624a758b3082224847e~u2sDeUbJ11300213002eucas1p2p;
        Thu,  8 Dec 2022 15:23:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EE.50.09561.98102936; Thu,  8
        Dec 2022 15:23:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221208152353eucas1p2254cd75abf694e6d6b9d830b52d7a5ed~u2sDD_9Ym1300313003eucas1p2u;
        Thu,  8 Dec 2022 15:23:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221208152353eusmtrp1bede0136ee629ea4b9e94d026f796e16~u2sDDX7N_0062700627eusmtrp1a;
        Thu,  8 Dec 2022 15:23:53 +0000 (GMT)
X-AuditID: cbfec7f2-0b3ff70000002559-3a-63920189ff86
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.11.09026.98102936; Thu,  8
        Dec 2022 15:23:53 +0000 (GMT)
Received: from [106.120.9.77] (unknown [106.120.9.77]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221208152352eusmtip17e9f8e30d9ac9af0ae84cb6a49fbca5b~u2sCe1lFF1140011400eusmtip1Q;
        Thu,  8 Dec 2022 15:23:52 +0000 (GMT)
Message-ID: <97ae8658-4eca-61af-5d5b-21b958ce1c24@samsung.com>
Date:   Thu, 8 Dec 2022 16:23:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.4.2
From:   =?UTF-8?Q?Micha=c5=82_Lach?= <michal.lach@samsung.com>
Subject: Re: [PATCH] drivers/firmware_loader: remove list entry before
 deallocation
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        russell.h.weight@intel.com, rafael@kernel.org,
        ming.lei@canonical.com, tiwai@suse.de
Content-Language: en-US
In-Reply-To: <Y5HkIl41zN9fwKV8@kroah.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87qdjJOSDf4cVrVoXryezeLyrjls
        FjcmPGW0mD1rA7vFroff2S3mfpnKbLF05gpmi5eb3zA5cHjMauhl81i85yWTx6ZVnWwe++eu
        Yffo27KK0WPz6WqPz5vkAtijuGxSUnMyy1KL9O0SuDJ+nPnKUvBLpOLitcgGxoWCXYycHBIC
        JhIPflxg7GLk4hASWMEocWj2PmYI5wujxOznG6Gcz4wSu/qOsMO0nP4xFaplOaPElJ4trBDO
        a0aJN+93M4JU8QrYSXx6fZ8FxGYRUJFYdv00K0RcUOLkzCdgcVGBKImmCz/BbDYBG4k3876A
        2cICoRIb3neBzRER0JB4efQWC8gCZoFeRokDz+aBncEsIC5x68l8pi5GDg5OAU2J091OEGF5
        ieats8HOlhD4wSHx6/suZoizXSS6PjUxQdjCEq+Ob4F6R0bi9OQeFgi7WOLOk/lsEHaNxLff
        HVC91hKrtt5gA9nFDLRr/S59iLCjxOy7/5hBwhICfBI33gpCnMAnMWnbdKgwr0RHmxBEtarE
        /8ZPUEulJfauPMQ8gVFpFlKgzELy1ywkz8xC2LuAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66
        XnJ+7iZGYHI6/e/4px2Mc1991DvEyMTBeIhRgoNZSYR32bKJyUK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5V0zpSBYSSE8sSc1OTS1ILYLJMnFwSjUw+XgnHfJyEr2RxMS67NhL231Xtl3f+LOs
        6vvKh3fZNk9V2OdsqX/9nkzL9Sdi/sneEc4Pr8aWNyrfTfvzd92du39MZu3P+3XWTnjDVFdz
        Z7/co0ef3vA+s0L5RrlWSaZciP/vN4duxExmMcl1Zphm22r1c+k7pgmR4Uf3ztN+vG+dzaq9
        vnvCe+ZE9L2XUHyw7KHkx89bn642UigSne/HveT//SVcayT+3VH/0lTS9mpp+RoW3jvStzgj
        q9U8ufSMj4sJP/jw2DH6c7SA05l5WcnnJq8++sdUafNsRe50lluLRPVdo1LiI+t8vPeueC9u
        9Hn5FT+z/G8lR1xUi/8w/Kua0FfzYqbFs6fF3DIyVkosxRmJhlrMRcWJAKDPAXe9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7qdjJOSDZauY7NoXryezeLyrjls
        FjcmPGW0mD1rA7vFroff2S3mfpnKbLF05gpmi5eb3zA5cHjMauhl81i85yWTx6ZVnWwe++eu
        Yffo27KK0WPz6WqPz5vkAtij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DJ+nPnKUvBLpOLitcgGxoWCXYycHBICJhKnf0xl7GLk4hASWMoocaVt
        NnMXIwdQQlqia540RI2wxJ9rXWwQNS8ZJe4tfMIMkuAVsJP49Po+C4jNIqAisez6aVaIuKDE
        yZlPwOKiAlESN88/ZAKx2QRsJN7M+wIWFxYIldjwvosRxBYR0JB4efQWC8gCZoFeRokZv86y
        Q2y7yyjxctEksCpmAXGJW0/mM4FcxymgKXG62wnEZBZQl1g/TwiiQl6ieets5gmMQrOQnDEL
        SfMshI5ZSDoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzFbcd+btnBuPLVR71DjEwc
        jIcYJTiYlUR4ly2bmCzEm5JYWZValB9fVJqTWnyI0RQYFBOZpUST84HJIK8k3tDMwNTQxMzS
        wNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgWmWzobprzY6Fv+tNP5akH16pdXXA5WL
        hIu6QttcNpw0sDafeu7WtMOhS64tvxXxJmjd0ZYZIbWZq0T5/q6zWnm43GV9/54FrJas2kvy
        eNW0ck55vlkw8fbBSJ8jwc7fldmjLsx6yLqq4p/ulXczvXQZlB8+5WYV+PM0bG/W1eX5F6Ru
        7p7koh/bnu0WxmDbIOVmd9X1Nq84p8ylrC+rDx068+rDhCTx10cYzT/VLHuQOrWcN3LHvTMt
        xZlBT6tiSx1nGi9O1dXn+DnFU6bmv9z8j6EWK2vmHVfYsir+veRDHr6++bM3iJtLfF/cFBz8
        R3lGTsVa/ael8ySj9UMTvl3Tv+InNa0u4rT/+9k51zKUWIozEg21mIuKEwGcTrwUTgMAAA==
X-CMS-MailID: 20221208152353eucas1p2254cd75abf694e6d6b9d830b52d7a5ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9
References: <CGME20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9@eucas1p2.samsung.com>
        <20221123111455.94972-1-michal.lach@samsung.com>
        <000901d90af2$309b7c80$91d27580$@samsung.com> <Y5HkIl41zN9fwKV8@kroah.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 14:18, Greg KH wrote:
> On Thu, Dec 08, 2022 at 11:45:28AM +0100, Michał Lach wrote:
>> Pinging
> 
> I have no context here at all.
> 
> confused,

It seems like my mail client messed up the encoding, sorry.
Below quoting the patch message:

> If CONFIG_FW_LOADER_USER_HELPER is enabled, it is possible to interrupt
> the loading process after adding pending_list to pending_fw_list.
> Subsequently, if user calls release_firmware() which deallocates the
> fw_priv structure which pending_list is a member of, the entry in the
> list is not deleted. This causes a use-after-free on further attempts
> to add an entry to the list or on list traversal.
> 
> While not problematic in most drivers since this function is mainly used
> in probe or init routines, some drivers expose firmware loading
> functionality via user-accessible functions like write() etc.
> In this case during the sysfs loading process, we can send SIGKILL to the
> thread which is then in kernel, leave the entry in the list and then free
> the structure.
> 
> Example kernel panics with CONFIG_DEBUG_LIST turned on:
> 
> kernel BUG at lib/list_debug.c:25!
> /* ... */
> Call trace:
>  __list_add_valid+0x7c/0x98
>  fw_load_sysfs_fallback+0xd4/0x334
>  fw_load_from_user_helper+0x148/0x1f8
>  firmware_fallback_sysfs+0xe0/0x17c
>  _request_firmware+0x1a0/0x470
>  request_firmware+0x50/0x78
> /* ... */
> 
> or
> 
> kernel BUG at lib/list_debug.c:56!
> /* ... */
> Call trace:
>  __list_del_entry_valid+0xa0/0xa4
>  fw_load_abort+0x38/0x64
>  fw_load_sysfs_fallback+0x354/0x468
>  fw_load_from_user_helper+0x17c/0x1c0
>  firmware_fallback_sysfs+0xc0/0x11c
>  _request_firmware+0xe0/0x4a4
>  request_firmware+0x20/0x2c
> /* ... */
> 
> Fixes: fe304143b0c3 ("firmware: Avoid deadlock of usermodehelper lock at shutdown")

On 11/29/22 20:06, Russ Weight wrote:
>> Reviewed-by: Russ Weight <russell.h.weight@intel.com>

> Signed-off-by: Michal Lach <michal.lach@samsung.com>
> ---
>  drivers/base/firmware_loader/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 7c3590fd97c2..381997c84e4f 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -209,6 +209,10 @@ static void __free_fw_priv(struct kref *ref)
>  		 __func__, fw_priv->fw_name, fw_priv, fw_priv->data,
>  		 (unsigned int)fw_priv->size);
>  
> +#ifdef CONFIG_FW_LOADER_USER_HELPER
> +	list_del(&fw_priv->pending_list);
> +#endif
> +
>  	list_del(&fw_priv->list);
>  	spin_unlock(&fwc->lock);
>  
> -- 
> 2.25.1

