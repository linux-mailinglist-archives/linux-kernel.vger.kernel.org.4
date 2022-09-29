Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FEF5EF0B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiI2Ij4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiI2Ijr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:39:47 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 393261A236
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:39:45 -0700 (PDT)
Received: from [10.20.42.32] (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxReLPWTVjQbEjAA--.2638S3;
        Thu, 29 Sep 2022 16:39:44 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Fix cpu name after s3/s4
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20220929073623.7604-1-lvjianmin@loongson.cn>
 <CAAhV-H4qJROB+EXORsbc9Y0i_Myp543-3PmDsA=GQAtTu4v9Mw@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <45b252d1-2f8d-2c7c-8d62-a990dbbcf6bf@loongson.cn>
Date:   Thu, 29 Sep 2022 16:39:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4qJROB+EXORsbc9Y0i_Myp543-3PmDsA=GQAtTu4v9Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxReLPWTVjQbEjAA--.2638S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1DAry3ury5WrW8WrWxZwb_yoW5uFyrpF
        4vkF4DAFsFgr9xKasxtr1UGrWDXrnrGw12g3Z5tayrZF4UXF1DXr18trs8WF15u3WxWrWF
        qFZ3WasrtFW7Ja7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
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
        73UjIFyTuYvjxU2rcTDUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good idea, agree, I'll change it, thanks.

On 2022/9/29 下午4:31, Huacai Chen wrote:
> Hi, Jianmin,
> 
> How about do it like this?
> 
> diff --git a/arch/loongarch/kernel/cpu-probe.c
> b/arch/loongarch/kernel/cpu-probe.c
> index 1bc9fec4e474..1734362d1fa9 100644
> --- a/arch/loongarch/kernel/cpu-probe.c
> +++ b/arch/loongarch/kernel/cpu-probe.c
> @@ -265,7 +265,9 @@ static inline void cpu_probe_loongson(struct
> cpuinfo_loongarch *c, unsigned int
>          uint64_t *vendor = (void *)(&cpu_full_name[VENDOR_OFFSET]);
>          uint64_t *cpuname = (void *)(&cpu_full_name[CPUNAME_OFFSET]);
> 
> -       __cpu_full_name[cpu] = cpu_full_name;
> +       if (!__cpu_full_name[cpu])
> +               __cpu_full_name[cpu] = cpu_full_name;
> +
>          *vendor = iocsr_read64(LOONGARCH_IOCSR_VENDOR);
>          *cpuname = iocsr_read64(LOONGARCH_IOCSR_CPUNAME);
> 
> Huacai
> 
> On Thu, Sep 29, 2022 at 3:36 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> On coming back from s3/s4, the cpu name will be overwritten
>> in cpu_probe path of seconary cpu, so we adjust the postion
>> of using cpu name existed in cpu hardware register, and only
>> use it while failing to get cpu name from SMBIOS.
>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>
>> diff --git a/arch/loongarch/include/asm/cpu-info.h b/arch/loongarch/include/asm/cpu-info.h
>> index b6c4f96079df..937dce2a930a 100644
>> --- a/arch/loongarch/include/asm/cpu-info.h
>> +++ b/arch/loongarch/include/asm/cpu-info.h
>> @@ -64,6 +64,7 @@ extern void cpu_probe(void);
>>
>>   extern const char *__cpu_family[];
>>   extern const char *__cpu_full_name[];
>> +extern char cpu_full_name[];
>>   #define cpu_family_string()    __cpu_family[raw_smp_processor_id()]
>>   #define cpu_full_name_string() __cpu_full_name[raw_smp_processor_id()]
>>
>> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
>> index 529ab8f44ec6..a548b2197224 100644
>> --- a/arch/loongarch/kernel/cpu-probe.c
>> +++ b/arch/loongarch/kernel/cpu-probe.c
>> @@ -180,14 +180,13 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
>>   #define VENDOR_OFFSET  0
>>   #define CPUNAME_OFFSET 9
>>
>> -static char cpu_full_name[MAX_NAME_LEN] = "        -        ";
>> +char cpu_full_name[MAX_NAME_LEN] = "        -        ";
>>
>>   static inline void cpu_probe_loongson(struct cpuinfo_loongarch *c, unsigned int cpu)
>>   {
>>          uint64_t *vendor = (void *)(&cpu_full_name[VENDOR_OFFSET]);
>>          uint64_t *cpuname = (void *)(&cpu_full_name[CPUNAME_OFFSET]);
>>
>> -       __cpu_full_name[cpu] = cpu_full_name;
>>          *vendor = iocsr_read64(LOONGARCH_IOCSR_VENDOR);
>>          *cpuname = iocsr_read64(LOONGARCH_IOCSR_CPUNAME);
>>
>> diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
>> index 82b478a5c665..955d82aa298e 100644
>> --- a/arch/loongarch/kernel/env.c
>> +++ b/arch/loongarch/kernel/env.c
>> @@ -44,6 +44,9 @@ static int __init init_cpu_fullname(void)
>>          if (loongson_sysconf.cpuname && !strncmp(loongson_sysconf.cpuname, "Loongson", 8)) {
>>                  for (cpu = 0; cpu < NR_CPUS; cpu++)
>>                          __cpu_full_name[cpu] = loongson_sysconf.cpuname;
>> +       } else {
>> +               for (cpu = 0; cpu < NR_CPUS; cpu++)
>> +                       __cpu_full_name[cpu] = cpu_full_name;
>>          }
>>          return 0;
>>   }
>> --
>> 2.31.1
>>

