Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6886760CCCA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiJYM77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiJYM67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:58:59 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B955B1BFB94;
        Tue, 25 Oct 2022 05:54:11 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.239])
        by gateway (Coremail) with SMTP id _____8Bx3Nhu3FdjP2UCAA--.9536S3;
        Tue, 25 Oct 2022 20:54:06 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.239])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxn+Bq3FdjueYEAA--.19001S3;
        Tue, 25 Oct 2022 20:54:02 +0800 (CST)
Message-ID: <4123dfce-d5f9-80aa-cbba-d8dfbf197953@loongson.cn>
Date:   Tue, 25 Oct 2022 20:53:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
To:     Alex Shi <seakeel@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Akira Yokosawa <akiyks@gmail.com>, bilbao@vt.edu,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        miguel.ojeda.sandonis@gmail.com,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>
References: <20221014142454.871196-2-carlos.bilbao@amd.com>
 <48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com>
 <Y01pkubcT7FOwCjL@casper.infradead.org>
 <8e2a1da1-2914-b223-85b0-a769339d9c39@gmail.com>
 <9e65ba16-68d3-8d11-c6ac-c35c29026688@amd.com>
 <Y1aovvn7dAyo1nuW@casper.infradead.org> <87a65lfdqb.fsf@meer.lwn.net>
 <875yg9fdbm.fsf@meer.lwn.net>
 <CAJy-AmnskpBqTspQ-krCi66S960CowqqTfnrnbPeS_JnCoa2Vg@mail.gmail.com>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <CAJy-AmnskpBqTspQ-krCi66S960CowqqTfnrnbPeS_JnCoa2Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxn+Bq3FdjueYEAA--.19001S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tw1UXFWfJFyxKw1xtr1fWFg_yoW8tw1xpF
        WYgas7KFyktr92kFn2vw48XrWFqw1SyryYqr1DKr1kCwnYgFyfKr45KryYkasxur4xGr1j
        v3yYqFW3XF1qyaDanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/25 19:05, Alex Shi 写道:
> On Mon, Oct 24, 2022 at 11:31 PM Jonathan Corbet <corbet@lwn.net> wrote:
>>
>> Resending without the screwy address that my mailer decided to put in
>> for Alex, sorry for the noise.
> Thanks for having me.
> I am neutral about the change, and prefer less churn for code.
> But if we have to, zh_hant/hans is better then CN and TW to comfort
> other regions, like zh_SG, zh_HK etc.

Same here!

 >_<


Thanks,

Yanteng

>
> Thanks
> Alex
>
>> Jonathan Corbet <corbet@lwn.net> writes:
>>
>>> [Adding some of the other folks interested in translations]
>>>
>>> Matthew Wilcox <willy@infradead.org> writes:
>>>
>>>> I think we're better off following BCP 47:
>>>> https://www.rfc-editor.org/info/bcp47 rather than the libc locale format.
>>>> That will imply renaming it_IT to simply "it", ja_JP to "ja" and
>>>> ko_KR to "ko".  The two Chinese translations we have might be called
>>>> "zh-Hant" and "zh-Hans", if the distinction is purely Traditional vs
>>>> Simplified script.  If they really are region based, then they'd be
>>>> zh-CN and zh-TW.
>>>>
>>>> I think you're right to conflate all dialects of Spanish together, just
>>>> as we do all dialects of English.
>>>>
>>>> Jon, this feels like policy you should be setting.  Are you on board
>>>> with this, or do you want to retain the mandatory geography tag that
>>>> we've been using up to now?
>>> I want to go hide somewhere :)
>>>
>>> I'd kind of prefer to avoid renaming the existing translations, as that
>>> is sure to create a certain amount of short-term pain.  But I guess we
>>> could do that if the benefit somehow seems worth it.
>>>
>>> Of course, if we're thrashing things, we could also just call them
>>> "Italian" (or "Italiano"), "Chinese", and so on.  I don't *think*
>>> there's a need for the names to be machine-readable.  We should stick
>>> with ASCII for these names just to help those of us who can't type in
>>> other scripts.
>>>
>>> If asked to set a policy today, my kneejerk reaction would be to leave
>>> things as they are just to avoid a bunch of churn.  But I don't have a
>>> strong opinion on how this naming should actually be done, as long as we
>>> can pick something and be happy with it thereafter.  What do the
>>> translation maintainers think?
>>>
>>> Thanks,
>>>
>>> jon

