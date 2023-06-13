Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C433A72DE13
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbjFMJpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbjFMJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:45:37 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AE1173C;
        Tue, 13 Jun 2023 02:45:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgNvs0klWz4f3wRQ;
        Tue, 13 Jun 2023 17:45:29 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
        by APP1 (Coremail) with SMTP id cCh0CgDHIBu4OohkevjXKw--.29140S2;
        Tue, 13 Jun 2023 17:45:29 +0800 (CST)
Message-ID: <4a501c9f-245f-5ecd-46e9-dc0e71abf8a5@huaweicloud.com>
Date:   Tue, 13 Jun 2023 17:45:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pinctrl: renesas: remove checker warnings: x | !y
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, gongruiqi1@huawei.com,
        linux-sparse@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20230613021643.3330661-1-gongruiqi@huaweicloud.com>
 <CAMuHMdXGG2xu+nXJt6CSTfV6aM=U=hMW+DiDgP3RhOw8+O8y=A@mail.gmail.com>
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
In-Reply-To: <CAMuHMdXGG2xu+nXJt6CSTfV6aM=U=hMW+DiDgP3RhOw8+O8y=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHIBu4OohkevjXKw--.29140S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry8Xr4fWw1xtF4kWw18uFg_yoW8Zr4UpF
        47ta4UtFsYyF4UZFZ8t3yxWrWYyan2krWDG3WDKa4UZFZ8ZF1kt3WSgw4FvF4Durs7Aw1q
        qF4UKa4fG3W3A3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 2023/06/13 15:38, Geert Uytterhoeven wrote:
> Hi Gong,
> 
> On Tue, Jun 13, 2023 at 4:13 AM GONG, Ruiqi <gongruiqi@huaweicloud.com> wrote:
>> Eliminate the following Sparse reports when building with C=1:
>>
>> drivers/pinctrl/renesas/pinctrl-rzn1.c:187:52: warning: dubious: x | !y
>> drivers/pinctrl/renesas/pinctrl-rzn1.c:193:52: warning: dubious: x | !y
>>
>> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
> 
> Thanks for your patch!
> 
> Looks like sparse needs to be taught the "|" is not used in a boolean
> context here?

Okay after reading the source code of Sparse I think what this kind of
warnings actually means is to hint us a possible misuse of "|" instead
of "||" (i.e. misusing a binary operator in a conditional context). Here
the code is doing binary operation (i.e. to flip a bit or two), so in
this sense the warnings should be just false alarms.

However, the original code is a bit weird for me because of the sudden
appearance of a boolean operator (i.e. "!") in the middle of a binary
calculation. And I think it looks better after this change, since it
makes the expression look more "binary". So maybe we can still consider
apply this change ;)

Greetings,
Ruiqi

> 
>> --- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
>> +++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
>> @@ -184,13 +184,15 @@ static void rzn1_hw_set_lock(struct rzn1_pinctrl *ipctl, u8 lock, u8 value)
>>          * address | 1.
>>          */
>>         if (lock & LOCK_LEVEL1) {
>> -               u32 val = ipctl->lev1_protect_phys | !(value & LOCK_LEVEL1);
>> +               u32 val = ipctl->lev1_protect_phys |
>> +                       (value & LOCK_LEVEL1 ? 0 : 1);
>>
>>                 writel(val, &ipctl->lev1->status_protect);
>>         }
>>
>>         if (lock & LOCK_LEVEL2) {
>> -               u32 val = ipctl->lev2_protect_phys | !(value & LOCK_LEVEL2);
>> +               u32 val = ipctl->lev2_protect_phys |
>> +                       (value & LOCK_LEVEL2 ? 0 : 1);
>>
>>                 writel(val, &ipctl->lev2->status_protect);
>>         }
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

