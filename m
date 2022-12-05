Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D520A64212D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 02:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiLEBoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 20:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLEBoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 20:44:54 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B4BD5F91;
        Sun,  4 Dec 2022 17:44:51 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxuPESTY1jjiwDAA--.7267S3;
        Mon, 05 Dec 2022 09:44:50 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHuIOTY1jsK8lAA--.27845S3;
        Mon, 05 Dec 2022 09:44:46 +0800 (CST)
Subject: Re: [PATCH 0/2] Update links of LoongArch ISA Vol1 and ELF psABI
To:     Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>
References: <1669892345-7763-1-git-send-email-yangtiezhu@loongson.cn>
 <87h6ycoist.fsf@meer.lwn.net>
Cc:     loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <aea656cb-f3ad-8668-9131-f294235f78da@loongson.cn>
Date:   Mon, 5 Dec 2022 09:44:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <87h6ycoist.fsf@meer.lwn.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxHuIOTY1jsK8lAA--.27845S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7CFyDCF45CF4kAr17ZF48Crg_yoW8WF1fpF
        yS9FyagF1vyr47uw1kK345WF4FvFWfGayxJF4Utw15WwnxAw1DCFyFqrs8tFZrZ3yfJFWF
        qryFkws5J3W8A3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/2022 06:58 PM, Jonathan Corbet wrote:
> Tiezhu Yang <yangtiezhu@loongson.cn> writes:
>
>> Tiezhu Yang (2):
>>   docs/LoongArch: Update links of LoongArch ISA Vol1 and ELF psABI
>>   docs/zh_CN/LoongArch: Update links of LoongArch ISA Vol1 and ELF psABI
>>
>>  Documentation/loongarch/introduction.rst                    | 8 ++++----
>>  Documentation/translations/zh_CN/loongarch/introduction.rst | 8 ++++----
>>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> I've applied these - working links are better than broken ones.  I
> assume, though, that the new URLs, too, will break the next time the
> manual is updated?  Is there any chance Loongson could provide a stable
> URL for the current version of this manual instead?
>
> Thanks,
>
> jon
>

Here are my thoughts:

(1) Just use the release link without file name, simple and timeless.

https://github.com/loongson/LoongArch-Documentation/releases

(2) Use the online html links, but the Chinese html version of ISA
Vol1 is unavailable now.

https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-CN.html 
(unavailable now)
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html

https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-CN.html
https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html

(3) As Ruoyao said, use a link with tag name instead of "latest",
may be outdated but always valid.

https://github.com/loongson/LoongArch-Documentation/releases/download/2022.08.12/LoongArch-Vol1-v1.02-CN.pdf

Thanks,
Tiezhu

