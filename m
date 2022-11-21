Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCDF6318FA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 04:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKUDjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 22:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUDjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 22:39:09 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7730C12755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 19:39:07 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxTLba8npj3wkJAA--.13397S3;
        Mon, 21 Nov 2022 11:39:06 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxr+DY8npjEWwXAA--.61576S3;
        Mon, 21 Nov 2022 11:39:04 +0800 (CST)
Subject: Re: [PATCH] lib/vdso: use "grep -E" instead of "egrep"
To:     Greg KH <gregkh@linuxfoundation.org>
References: <ad42d19d-959c-61b4-8581-02ce0990c23f@arm.com>
 <788b5155-fef5-0e44-721a-f9183e145ae5@loongson.cn>
 <Y3dMgfPXNMm/vaG2@kroah.com>
 <337a9a23-436e-7f58-bfc5-600452779472@loongson.cn>
Cc:     vincenzo.frascino@arm.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e66712fd-bf28-08b6-8f2f-18d8a9a3a159@loongson.cn>
Date:   Mon, 21 Nov 2022 11:39:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <337a9a23-436e-7f58-bfc5-600452779472@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dxr+DY8npjEWwXAA--.61576S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrtr1DXF1ktryDZrW8Gry7Awb_yoWDCrg_uw
        48CFW5C348XF42ka1fKan0vrs8CayrAFyFqrWxKw1xX3sxA39Iqa1fGFyrZ3WDWwn7ZrZ5
        AF1Yv3s5Xr12vjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO
        n7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just FYI.

On 11/19/2022 09:54 AM, Tiezhu Yang wrote:
> Cc Andrew Morton <akpm@linux-foundation.org>
>
> On 11/18/2022 05:12 PM, Greg KH wrote:
>> On Fri, Nov 18, 2022 at 04:44:50PM +0800, Tiezhu Yang wrote:
>>> Hi,
>>>
>>> This patch can not be found in the torvalds/linux.git or
>>> next/linux-next.git tree, please take a look, thank you.
>>
>> That is because no one has applied it to their trees :(
>>
>
> Maybe Andrew can pick the following two patches sent by Greg.
>
> [PATCH] lib/vdso: use "grep -E" instead of "egrep"
> https://lore.kernel.org/lkml/20220920170633.3133829-1-gregkh@linuxfoundation.org/
>

AFAIK, this patch is not in any tree now.

>
> [PATCH] scripts: coccicheck: use "grep -E" instead of "egrep"
> https://lore.kernel.org/lkml/20220921091341.217365-1-gregkh@linuxfoundation.org/
>

This patch is in the following tree, sorry for missing that.

https://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux.git/commit/?h=for-6.1&id=2d63e6a3d971

Thanks,
Tiezhu

