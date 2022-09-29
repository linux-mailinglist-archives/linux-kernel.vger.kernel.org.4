Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048CD5EF2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiI2KBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiI2KBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:01:09 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B55D13791D;
        Thu, 29 Sep 2022 03:01:06 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmvdbDVjQrsjAA--.56357S3;
        Thu, 29 Sep 2022 18:01:02 +0800 (CST)
Subject: Re: [PATCH] docs, kprobes: Fix the wrong location of Kprobes
To:     Steven Rostedt <rostedt@goodmis.org>
References: <1663322106-12178-1-git-send-email-yangtiezhu@loongson.cn>
 <20220926142218.100e0d9b@gandalf.local.home>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <75c28f07-4bc7-6094-d264-d7657c40ba88@loongson.cn>
Date:   Thu, 29 Sep 2022 18:01:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220926142218.100e0d9b@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxvmvdbDVjQrsjAA--.56357S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1UZrWUtrW8XF1kZr4xWFg_yoW8XF48pF
        1kJa4S9F1kJ348JrW7Zr1xWryIkFn7uay7GF1kta4rJ3WDZwn7Crn2gr4agFyfursayay7
        Za4kKFyj9w1av37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU8XJ55UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/27/2022 02:22 AM, Steven Rostedt wrote:
> On Fri, 16 Sep 2022 17:55:06 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>> After commit 22471e1313f2 ("kconfig: use a menu in arch/Kconfig to reduce
>> clutter"), the location of Kprobes is under "General architecture-dependent
>> options" rather than "General setup".
>>
>
> Probably add a "Fixes:" tag for the above mentioned commit.
>
> Anyway, Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>


Thank you.

Do you know which tree this patch will go through?
Is it necessary to send v2 with "Fixes:" tag?

Thanks,
Tiezhu

>
> -- Steve
>
>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  Documentation/trace/kprobes.rst | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
>> index f318bce..48cf778 100644
>> --- a/Documentation/trace/kprobes.rst
>> +++ b/Documentation/trace/kprobes.rst
>> @@ -328,8 +328,8 @@ Configuring Kprobes
>>  ===================
>>
>>  When configuring the kernel using make menuconfig/xconfig/oldconfig,
>> -ensure that CONFIG_KPROBES is set to "y". Under "General setup", look
>> -for "Kprobes".
>> +ensure that CONFIG_KPROBES is set to "y", look for "Kprobes" under
>> +"General architecture-dependent options".
>>
>>  So that you can load and unload Kprobes-based instrumentation modules,
>>  make sure "Loadable module support" (CONFIG_MODULES) and "Module

