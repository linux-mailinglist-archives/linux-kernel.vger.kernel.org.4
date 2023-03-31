Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D831B6D29A0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjCaUsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCaUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:48:21 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A114448B;
        Fri, 31 Mar 2023 13:48:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id D66E460515;
        Fri, 31 Mar 2023 22:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680295696; bh=fS91/3cPwJF5+zHbhFgdBHeVwCJg8/LbQ5WlJ+kivfo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NfYm271B/pt548o24aZ69dE9AIVPcZRO4vmTJPFlndsqFIFQoJfhl/20yhLdBoM0b
         LQGhMSU6jq5PkO0YDMnBYtIrHmhcTXB4Tj6c4BHi3Y9BjeofmiqxEjbjvYiAhv2OND
         i2GDtNS0tSm3Blt9xi1uoRh9f5fo52QgHQsIG9rE4HqjuNYsidrdS7YdXvYOkLcqBE
         +XwDZyVhqsv0it3tjcRw8ERvvEngIeJV+QlWPB3XwTZaGLBf6wTFPW3LTkj8Zq5YHH
         IIzT6Q2jzkHGNMRwsZwIlIZEI2vR1C4Xq7vSCpJFQ05G8OodMwrFDcF1Ys9zSTmklv
         Psne/w2WU7cjQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id heKpXYI2-ECE; Fri, 31 Mar 2023 22:48:13 +0200 (CEST)
Received: from [192.168.1.4] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id D2D1D60514;
        Fri, 31 Mar 2023 22:48:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680295693; bh=fS91/3cPwJF5+zHbhFgdBHeVwCJg8/LbQ5WlJ+kivfo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G/nkr3megpThabjOXE9WWbUIYSCqZmc81iy2AZVGjVmdeBEuK9eB8/FBw1TefXFkU
         lOQuCdv2L8Hd9/DdiFgKVSup410flZwusVXLowPWKIrytot9b74RWyBQ1vbtzHcbHE
         srfxjvqMYfUrwnEmhPT9UwYUNC5paCzyxwqV+cL75CDdmDQdyyid0iqs3Po9vqBISl
         6ZKsy+xzMvd+OYy4wlrcvCGz9bm/mZ8cwp/GdFgN8LgZU7e3GnuRLAwtjERwIB6yl0
         FDx2+dw4IJAfkQY6WFflQpUuGj7CCrG+HBA7PD84B7TKnRhA8uwpvaSuUkn2GodGKA
         WqGx75ACQkSWQ==
Message-ID: <d0d9ac65-a692-4e4e-d721-2ea709e9d4ae@alu.unizg.hr>
Date:   Fri, 31 Mar 2023 22:48:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: BUG FIX: [PATCH RFC v2] memstick_check() memleak in kernel 6.1.0+
 introduced pre 4.17
Content-Language: en-US, hr
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hannes Reinecke <hare@suse.de>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>, linux-mmc@vger.kernel.org
References: <7d873dd3-9bab-175b-8158-c458b61a7122@alu.unizg.hr>
 <f74219a7-1607-deb4-a6ae-7b73e2467ac7@alu.unizg.hr>
 <df560535-2a8e-de21-d45d-805159d70954@alu.unizg.hr>
 <2023033124-causing-cassette-4d96@gregkh>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023033124-causing-cassette-4d96@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 03. 2023. 18:32, Greg KH wrote:
> On Fri, Mar 31, 2023 at 04:46:03PM +0200, Mirsad Goran Todorovac wrote:
>> On 29.3.2023. 19:25, Mirsad Goran Todorovac wrote:
>>> On 23.12.2022. 14:20, Mirsad Goran Todorovac wrote:
>>>> Hi all,
>>>>
>>>> When building a RPM 6.1.0-rc3 for AlmaLinux 8.6, I have enabled CONFIG_DEBUG_KMEMLEAK=y
>>>> and the result showed an unreferenced object in kworker process:
>>>>
>>>> cat /sys/kernel/debug/kmemleak
>>>> unreferenced object 0xffff888105028d80 (size 16):
>>>>    comm "kworker/u12:5", pid 359, jiffies 4294902898 (age 1620.144s)
>>>>    hex dump (first 16 bytes):
>>>>      6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00  memstick0.......
>>>>    backtrace:
>>>>      [<ffffffffb6bb5542>] slab_post_alloc_hook+0xb2/0x340
>>>>      [<ffffffffb6bbbf5f>] __kmem_cache_alloc_node+0x1bf/0x2c0
>>>>      [<ffffffffb6af8175>] __kmalloc_node_track_caller+0x55/0x160
>>>>      [<ffffffffb6ae34a6>] kstrdup+0x36/0x60
>>>>      [<ffffffffb6ae3508>] kstrdup_const+0x28/0x30
>>>>      [<ffffffffb70d0757>] kvasprintf_const+0x97/0xd0
>>>>      [<ffffffffb7c9cdf4>] kobject_set_name_vargs+0x34/0xc0
>>>>      [<ffffffffb750289b>] dev_set_name+0x9b/0xd0
>>>>      [<ffffffffc12d9201>] memstick_check+0x181/0x639 [memstick]
>>>>      [<ffffffffb676e1d6>] process_one_work+0x4e6/0x7e0
>>>>      [<ffffffffb676e556>] worker_thread+0x76/0x770
>>>>      [<ffffffffb677b468>] kthread+0x168/0x1a0
>>>>      [<ffffffffb6604c99>] ret_from_fork+0x29/0x50
>>>>
>>>> mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log
>>>> git bisect start
>>>> # bad: [f0c4d9fc9cc9462659728d168387191387e903cc] Linux 6.1-rc4
>>>> git bisect bad f0c4d9fc9cc9462659728d168387191387e903cc
>>>> # bad: [fbd56ddcecab5a3623a89c8e941fdbcc55b41045] Linux 6.0.1
>>>> git bisect bad fbd56ddcecab5a3623a89c8e941fdbcc55b41045
>>>> # bad: [7e18e42e4b280c85b76967a9106a13ca61c16179] Linux 6.0-rc4
>>>> git bisect bad 7e18e42e4b280c85b76967a9106a13ca61c16179
>>>> # bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
>>>> git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>>>> # bad: [84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d] Linux 4.19
>>>> git bisect bad 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d
>>>> # bad: [94710cac0ef4ee177a63b5227664b38c95bbf703] Linux 4.18
>>>> git bisect bad 94710cac0ef4ee177a63b5227664b38c95bbf703
>>>> # bad: [29dcea88779c856c7dc92040a0c01233263101d4] Linux 4.17
>>>> git bisect bad 29dcea88779c856c7dc92040a0c01233263101d4
>>>>
>>>> Greg asked me if I would help bisect the bug, since I failed to
>>>> reproduce it on pre 4.17 kernels, because they wouldn't boot (black
>>>> screen) on the Lenovo ALmaLinux 8.7 (CentOS fork) desktop box that
>>>> only reproduced that bug:
>>>>
>>>>      product: 10TX000VCR (LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
>>>>      vendor: LENOVO
>>>>      version: V530S-07ICB
>>>>
>>>> I would welcome any advice.
>>>>
>>>> Please find attached the lshw output and the build config from the
>>>> last kernel version that also exhibits this bug, so the conclusion
>>>> is that it is not fixed since the report on November 29th 2022:
>>>>
>>>> https://lore.kernel.org/regressions/0d9c3f6c-3948-d5d1-bcc1-baf31141beaa@alu.unizg.hr/T/#t
>>>>
>>>> With the hint of Tvrtko, I was able to extract the correct list of maintainers this time.
>>>>
>>>> The bug occurs in one kernel memory leak, and it is unobvious
>>>> whether a skilled attacker could use an abusive program to trigger
>>>> the leak of enough 16 byte slabs (and overhead) to exhaust kernel
>>>> memory and cause denial-of-service (crash of the system).
>>>>
>>>> I apologise for the first unsuccessful attempt.
>>>
>>> static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>>>
>>> calls dev_set_name(&card->dev, "%s", dev_name(&host->dev)); that
>>> calls err = kobject_set_name_vargs(&dev->kobj, fmt, vargs); that
>>> executes:
>>>
>>>      if (strchr(s, '/')) {
>>>          char *t;
>>>
>>>          t = kstrdup(s, GFP_KERNEL);
>>>          kfree_const(s);
>>>          if (!t)
>>>              return -ENOMEM;
>>>          strreplace(t, '/', '!');
>>>          s = t;
>>>      }
>>>      kfree_const(kobj->name);
>>>      kobj->name = s;
>>>
>>> so, this kobj->name was never freed in the "goto err_out" case in line 404.
>>>
>>> 380 static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>>> 381 {
>>> 382         struct memstick_dev *card = kzalloc(sizeof(struct memstick_dev),
>>> 383                                             GFP_KERNEL);
>>> 384         struct memstick_dev *old_card = host->card;
>>> 385         struct ms_id_register id_reg;
>>> 386
>>> 387         if (card) {
>>> 388                 card->host = host;
>>> 389                 dev_set_name(&card->dev, "%s", dev_name(&host->dev));
>>> 390                 card->dev.parent = &host->dev;
>>> 391                 card->dev.bus = &memstick_bus_type;
>>> 392                 card->dev.release = memstick_free_card;
>>> 393                 card->check = memstick_dummy_check;
>>> 394
>>> 395                 card->reg_addr.r_offset = offsetof(struct ms_register, id);
>>> 396                 card->reg_addr.r_length = sizeof(id_reg);
>>> 397                 card->reg_addr.w_offset = offsetof(struct ms_register, id);
>>> 398                 card->reg_addr.w_length = sizeof(id_reg);
>>> 399
>>> 400                 init_completion(&card->mrq_complete);
>>> 401
>>> 402                 host->card = card;
>>> 403                 if (memstick_set_rw_addr(card))
>>> 404                         goto err_out;
>>> 405
>>> 406                 card->next_request = h_memstick_read_dev_id;
>>> 407                 memstick_new_req(host);
>>> 408                 wait_for_completion(&card->mrq_complete);
>>> 409
>>> 410                 if (card->current_mrq.error)
>>> 411                         goto err_out;
>>> 412         }
>>> 413         host->card = old_card;
>>> 414         return card;
>>> 415 err_out:
>>> 416         host->card = old_card;
>>> 421         kfree(card);
>>> 422         return NULL;
>>> 423 }
>>>
>>> This little patch fixes it, also at the release() method.
>>>
>>> However, release() had not yet been tested, and I am not certain that in that case
>>> kobj->name would not be kfree_const()-ed automatically.
>>>
>>> Maybe it ought to be separated in two independent patches?
>>>
>>> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
>>> index bf7667845459..403ab06e3ffa 100644
>>> --- a/drivers/memstick/core/memstick.c
>>> +++ b/drivers/memstick/core/memstick.c
>>> @@ -191,6 +191,10 @@ static void memstick_free_card(struct device *dev)
>>>   {
>>>          struct memstick_dev *card = container_of(dev, struct memstick_dev,
>>>                                                   dev);
>>> +       if ((card->dev).kobj.name) {
>>> +               kfree_const((card->dev).kobj.name);
>>> +               (card->dev).kobj.name = NULL;
>>> +       }
>>>          kfree(card);
>>>   }
>>>
>>> @@ -410,6 +414,10 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>>>          return card;
>>>   err_out:
>>>          host->card = old_card;
>>> +       if ((card->dev).kobj.name) {
>>> +               kfree_const((card->dev).kobj.name);
>>> +               (card->dev).kobj.name = NULL;
>>> +       }
>>>          kfree(card);
>>>          return NULL;
>>>   }
>>>
>>> This morning I did not feel like we'd fix two memory leaks today.
>>>
>>> This one was a nag for three months :-)
>>>
>>> Of course, this requires peer review. The fact that it fixed the /sys/kernel/debug/kmemleak
>>> output doesn't mean that it wouldn't break something, does it?
>>>
>>> It is clearly the good wind of the Providence.
>>
>> This is the second version of the patch, without the paranoid parentheses.
>>
>> I am still in the process of convincing Thunderbird not to convert tabs to
>> spaces, so please use --ignore-whitespace when testing this patch. :-(
>>
>> ---
>>  drivers/memstick/core/memstick.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
>> index bf7667845459..390287c23f27 100644
>> --- a/drivers/memstick/core/memstick.c
>> +++ b/drivers/memstick/core/memstick.c
>> @@ -191,6 +191,10 @@ static void memstick_free_card(struct device *dev)
>>  {
>>         struct memstick_dev *card = container_of(dev, struct memstick_dev,
>>                                                  dev);
>> +       if (card->dev.kobj.name) {
>> +               kfree_const(card->dev.kobj.name);
> 
> Ick, no, please don't mess around with a kobject name from within a
> driver like this.  That's indicitave that something else is really
> wrong.
> 
> Yes, the nvme core code does it, but it shouldn't.
> 
> Hm, the driver core does it in two places too, that's not good, I'll
> look at fixing that up too.
> 
> This patch is implying that anyone who calls "dev_set_name()" also has
> to do this hack, which shouldn't be the case at all.
> 
> thanks,
> 
> greg k-h

Hi, Mr. Greg,

I tend to agree with you that releasing card->dev.kobj.name
should be done from the destructor method of the card object.

AFAICT, the kobj.name is allocated deep withing dev_set_name in line 385
of drivers/memstick/core/memstick.c:

376 static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
377 {
378         struct memstick_dev *card = kzalloc(sizeof(struct memstick_dev),
379                                             GFP_KERNEL);
380         struct memstick_dev *old_card = host->card;
381         struct ms_id_register id_reg;
382 
383         if (card) {
384                 card->host = host;
385                 dev_set_name(&card->dev, "%s", dev_name(&host->dev));
386                 card->dev.parent = &host->dev;
387                 card->dev.bus = &memstick_bus_type;
388                 card->dev.release = memstick_free_card;
389                 card->check = memstick_dummy_check;
390 
391                 card->reg_addr.r_offset = offsetof(struct ms_register, id);
392                 card->reg_addr.r_length = sizeof(id_reg);
393                 card->reg_addr.w_offset = offsetof(struct ms_register, id);
394                 card->reg_addr.w_length = sizeof(id_reg);
395 
396                 init_completion(&card->mrq_complete);
397 
398                 host->card = card;
399                 if (memstick_set_rw_addr(card))
400                         goto err_out;
401 
402                 card->next_request = h_memstick_read_dev_id;
403                 memstick_new_req(host);
404                 wait_for_completion(&card->mrq_complete);
405 
406                 if (card->current_mrq.error)
407                         goto err_out;
408         }
409         host->card = old_card;
410         return card;
411 err_out:
412         host->card = old_card;
413         if (card->dev.kobj.name) {
414                 kfree_const(card->dev.kobj.name);
415                 card->dev.kobj.name = NULL;
416         }
417         kfree(card);
418         return NULL;
419 }

I am not certain what is semantically right thing to do in this case, I also 
see there is another kfree(card) in memstick_check():

431 static void memstick_check(struct work_struct *work)
432 {
433         struct memstick_host *host = container_of(work, struct memstick_host,
434                                                   media_checker);
435         struct memstick_dev *card;
436 
437         dev_dbg(&host->dev, "memstick_check started\n");
438         pm_runtime_get_noresume(host->dev.parent);
439         mutex_lock(&host->lock);
440         if (!host->card) {
441                 if (memstick_power_on(host))
442                         goto out_power_off;
443         } else if (host->card->stop)
444                 host->card->stop(host->card);
445 
446         if (host->removing)
447                 goto out_power_off;
448 
449         card = memstick_alloc_card(host);
450 
451         if (!card) {
452                 if (host->card) {
453                         device_unregister(&host->card->dev);
454                         host->card = NULL;
455                 }
456         } else {
457                 dev_dbg(&host->dev, "new card %02x, %02x, %02x\n",
458                         card->id.type, card->id.category, card->id.class);
459                 if (host->card) {
460                         if (memstick_set_rw_addr(host->card)
461                             || !memstick_dev_match(host->card, &card->id)
462                             || !(host->card->check(host->card))) {
463                                 device_unregister(&host->card->dev);
464                                 host->card = NULL;
465                         } else if (host->card->start)
466                                 host->card->start(host->card);
467                 }
468 
469                 if (!host->card) {
470                         host->card = card;
471                         if (device_register(&card->dev)) {
472                                 put_device(&card->dev);
473                                 host->card = NULL;
474                         }
475                 } else
476                         kfree(card);
477         }
478 
479 out_power_off:
480         if (!host->card)
481                 host->set_param(host, MEMSTICK_POWER, MEMSTICK_POWER_OFF);
482 
483         mutex_unlock(&host->lock);
484         pm_runtime_put(host->dev.parent);
485         dev_dbg(&host->dev, "memstick_check finished\n");
486 }

Frankly, I was happy to remove /sys/kernel/debug/kmemleak report of the leak,
and this is still in pre-alpha stage.

This fix was not a formal patch but a PoC - once the blame is located at the
line 385 in memstick_alloc_card() and on dev_set_name(), I see there are other
places where the driver could leak memory safe for the initial patched fix.

It seems obvious that the card->dev.kobj.name has to be released and freed or
it will leak memory. I do not have sufficient insight into the Source to
do that. I think you will do a better job at it, having the advantage of seeing
the forest and not just the tree.

Thanks,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

