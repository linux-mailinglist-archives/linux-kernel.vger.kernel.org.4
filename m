Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B0C647E3B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLIHEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiLIHEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:04:13 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFACA2C13A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 23:02:21 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx7+t73ZJjxloEAA--.10242S3;
        Fri, 09 Dec 2022 15:02:19 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxr+B43ZJjXAUpAA--.35622S3;
        Fri, 09 Dec 2022 15:02:16 +0800 (CST)
Subject: Re: [PATCH v9 2/4] LoongArch: Add kprobe support
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1670506868-15771-1-git-send-email-yangtiezhu@loongson.cn>
 <1670506868-15771-3-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H54yruHAe7ey8L9hHPonryEWEd8nt-iS6s7-odrDdrutw@mail.gmail.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <37bc5ab5-ced8-cae9-9025-180154af0b11@loongson.cn>
Date:   Fri, 9 Dec 2022 15:02:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H54yruHAe7ey8L9hHPonryEWEd8nt-iS6s7-odrDdrutw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dxr+B43ZJjXAUpAA--.35622S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW7GFWxAF15JrWrCrykGr1Utrb_yoWxKFcEgr
        18Wr4kC34q9ry3Ka1UKa1rXFWUWryUWrWUKw1kCry3Aa4fK3s7XF4rK3sYyF4rJry0krsx
        AFW2grsayFyjqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        k7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7
        xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I
        3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
        WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
        cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
        vjxU2DUUUUUUU
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/2022 10:22 AM, Huacai Chen wrote:
>   cas
>
> On Thu, Dec 8, 2022 at 9:41 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Kprobes allows you to trap at almost any kernel address and
>> execute a callback function, this commit adds kprobe support
>> for LoongArch.

...

>> +       case KPROBE_HIT_ACTIVE:
>> +       case KPROBE_HIT_SSDONE:
>> +               /*
>> +                * In case the user-specified fault handler returned
>> +                * zero, try to fix up.
>> +                */
>> +               if (fixup_exception(regs))
>> +                       return true;
> Does here need to enable preemption too?
>

No need, because in this two case, after call fixup_exception() or
do_page_fault(), the original process will continue, preemption will
be enabled in the original process.

Thanks,
Tiezhu

