Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38EB5F82CC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 05:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJHDbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 23:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJHDbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 23:31:18 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6075C9E690
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 20:31:16 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axy2rz7kBjyyUoAA--.12271S3;
        Sat, 08 Oct 2022 11:31:00 +0800 (CST)
Subject: Re: [PATCH] entry: Remove has_signal comment of
 arch_do_signal_or_restart() prototype
References: <1662090106-5545-1-git-send-email-yangtiezhu@loongson.cn>
 <202209021610.80DCFC7A@keescook>
 <c9f6ab17-153e-23a7-a55a-37bd3d71b399@loongson.cn>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
To:     Andrew Morton <akpm@linux-foundation.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <50fcaf69-0db7-fc13-0be1-718067b17486@loongson.cn>
Date:   Sat, 8 Oct 2022 11:30:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <c9f6ab17-153e-23a7-a55a-37bd3d71b399@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Axy2rz7kBjyyUoAA--.12271S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1xur1DWFWkGFW8WF1xKrg_yoWfAFbEkF
        WIkrZ5Kw15JrsrC3Z8K3W3X397G34rJF4rJr90gay7Cw1Fy3yUGFsrJr9Yg3yfGFWkuFnr
        XFs0vwsxCr10kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU8ymh7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/29/2022 05:58 PM, Tiezhu Yang wrote:
>
>
> On 09/03/2022 07:10 AM, Kees Cook wrote:
>> On Fri, Sep 02, 2022 at 11:41:46AM +0800, Tiezhu Yang wrote:
>>> The argument has_signal of arch_do_signal_or_restart() has been removed
>>> in commit 8ba62d37949e ("task_work: Call tracehook_notify_signal from
>>> get_signal on all architectures"), let us remove the related comment.
>>>
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>
>> Fixes: 8ba62d37949e ("task_work: Call tracehook_notify_signal from
>> get_signal on all architectures")
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>
> Hi all,
>
> Do you know which tree this patch will go through?
>
> Thanks,
> Tiezhu

Hi Andrew,

Could you please pick it up via your tree in this merge window?

https://lore.kernel.org/lkml/1662090106-5545-1-git-send-email-yangtiezhu@loongson.cn/

Thanks,
Tiezhu

