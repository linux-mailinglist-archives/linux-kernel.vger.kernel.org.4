Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7466FC09C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjEIHnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjEIHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:43:51 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 322EA7DA3;
        Tue,  9 May 2023 00:43:49 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxZPCz+VlkBOIGAA--.11453S3;
        Tue, 09 May 2023 15:43:47 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axo8Cx+Vlkz0ZSAA--.16904S3;
        Tue, 09 May 2023 15:43:46 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Select HAVE_DEBUG_KMEMLEAK to support kmemleak
To:     Youling Tang <tangyouling@loongson.cn>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <1683614971-10744-1-git-send-email-yangtiezhu@loongson.cn>
 <68984bbb-4ccc-51f8-7d4b-b1ae08a43c52@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d1256c93-1c70-c3ff-de71-42405d336cac@loongson.cn>
Date:   Tue, 9 May 2023 15:43:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <68984bbb-4ccc-51f8-7d4b-b1ae08a43c52@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Axo8Cx+Vlkz0ZSAA--.16904S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxuF1rZFy3Xr4UCFy8ZFy7Jrb_yoW5Cryrpa
        4v93Zxtr4rJr1UAayvqFyUXF47JF93GayIgFy5C3WUGFyDCF93Ar4SqFZ5uFn8C3yrXFW8
        WF40gryYyr4UZ3JanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Jonathan Corbet <corbet@lwn.net>
     linux-doc@vger.kernel.org

On 05/09/2023 03:13 PM, Youling Tang wrote:
> Hi, Tiezhu
>
> On 05/09/2023 02:49 PM, Tiezhu Yang wrote:
>> We can see that DEBUG_KMEMLEAK depends on HAVE_DEBUG_KMEMLEAK after
>> commit b69ec42b1b19 ("Kconfig: clean up the long arch list for the
>> DEBUG_KMEMLEAK config option"), just select HAVE_DEBUG_KMEMLEAK to
>> support kmemleak on LoongArch.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>
>> This is based on 6.4-rc1
>>
>>  arch/loongarch/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index d38b066..1e64edd 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -90,6 +90,7 @@ config LOONGARCH
>>      select HAVE_ASM_MODVERSIONS
>>      select HAVE_CONTEXT_TRACKING_USER
>>      select HAVE_C_RECORDMCOUNT
>> +    select HAVE_DEBUG_KMEMLEAK
>>      select HAVE_DEBUG_STACKOVERFLOW
>>      select HAVE_DMA_CONTIGUOUS
>>      select HAVE_DYNAMIC_FTRACE
>>
>
> At the same time, you need to modify the loongarch in arch-support.txt
> to ok.
>
> BTW, we can submit a separate patch to modify the features already
> supported by LoongArch.
>
> The following features are already supported in LoongArch.
>
> diff --git
> a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
...
> diff --git a/Documentation/features/debug/kprobes/arch-support.txt
> b/Documentation/features/debug/kprobes/arch-support.txt
> index 8a77d62a42c5..aad83b57587a 100644
> --- a/Documentation/features/debug/kprobes/arch-support.txt
> +++ b/Documentation/features/debug/kprobes/arch-support.txt
...
> diff --git a/Documentation/features/debug/kretprobes/arch-support.txt
> b/Documentation/features/debug/kretprobes/arch-support.txt
> index cf4723c5ac55..61380010a4a7 100644
> --- a/Documentation/features/debug/kretprobes/arch-support.txt
> +++ b/Documentation/features/debug/kretprobes/arch-support.txt
...
> diff --git
> a/Documentation/features/debug/stackprotector/arch-support.txt
> b/Documentation/features/debug/stackprotector/arch-support.txt
> index 71cd4ba18f7d..4c64c5d596f7 100644
> --- a/Documentation/features/debug/stackprotector/arch-support.txt
> +++ b/Documentation/features/debug/stackprotector/arch-support.txt

Thank you, I have already prepared a patch to update the docs,
but some more features will be added on LoongArch in the following
merge window, I am not sure what is the proper time to send the
following patch, maybe two months later, or right away, maybe
Jonathan can give some suggestions.

Documentation/features: Refresh LoongArch support files

Run the refresh script [1] to document the recent feature additions
on LoongArch.

[1] Documentation/features/scripts/features-refresh.sh

Thanks,
Tiezhu

