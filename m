Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103175EF19D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiI2JOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbiI2JOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:14:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 879328276A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:14:23 -0700 (PDT)
Received: from [10.20.42.32] (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmvtYTVjv7QjAA--.56279S3;
        Thu, 29 Sep 2022 17:14:22 +0800 (CST)
Subject: Re: [PATCH V3] LoongArch: Fix cpu name after s3/s4
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20220929085530.8742-1-lvjianmin@loongson.cn>
 <1776fe36-b954-b2c9-a2c1-157363f25ce2@xen0n.name>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <05fcc572-8b58-629c-db9f-4c540c7b4f21@loongson.cn>
Date:   Thu, 29 Sep 2022 17:14:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1776fe36-b954-b2c9-a2c1-157363f25ce2@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxvmvtYTVjv7QjAA--.56279S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr15JFy7GFy3Xw1xKry8Xwb_yoW8XFW8pF
        n2yan8CrZF9r95Gasxtr13JryUZrn7G347Xas5J3W8ZF4UZr1qgryUXw4qgF15Aa1xKr40
        vF4Dua92vFW7XaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
        v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK
        82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUqEoXUUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/29 下午5:06, WANG Xuerui wrote:
> On 9/29/22 16:55, Jianmin Lv wrote:
>> On coming back from s3/s4, the cpu name will be overwritten
>> in cpu_probe path of seconary cpu, so we don't overwrite it
>> if it has been initialized.
> 
> The sentences are confusing, first "the CPU name will be overwritten" 
> then "don't overwrite it if initialized" -- seems the CPU name will get 
> overwritten despite the patch's clear intent.
> 
> Better to keep it simple: "Don't overwrite the CPU name on coming back 
> from S3/S4 if it is already initialized."
> 

Thanks, Xuerui, let me change it.

>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>
>> diff --git a/arch/loongarch/kernel/cpu-probe.c 
>> b/arch/loongarch/kernel/cpu-probe.c
>> index 529ab8f44ec6..255a09876ef2 100644
>> --- a/arch/loongarch/kernel/cpu-probe.c
>> +++ b/arch/loongarch/kernel/cpu-probe.c
>> @@ -187,7 +187,9 @@ static inline void cpu_probe_loongson(struct 
>> cpuinfo_loongarch *c, unsigned int
>>       uint64_t *vendor = (void *)(&cpu_full_name[VENDOR_OFFSET]);
>>       uint64_t *cpuname = (void *)(&cpu_full_name[CPUNAME_OFFSET]);
>> -    __cpu_full_name[cpu] = cpu_full_name;
>> +    if (!__cpu_full_name[cpu])
>> +        __cpu_full_name[cpu] = cpu_full_name;
>> +
>>       *vendor = iocsr_read64(LOONGARCH_IOCSR_VENDOR);
>>       *cpuname = iocsr_read64(LOONGARCH_IOCSR_CPUNAME);
> 
> Otherwise LGTM.
> 
> Reviewed-by: WANG Xuerui <git@xen0n.name>
> 

