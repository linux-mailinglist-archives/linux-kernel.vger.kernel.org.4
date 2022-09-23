Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9C65E77C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiIWJ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiIWJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:57:04 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACD59130BD3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:57:02 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxYOLjgi1jsZwgAA--.57742S3;
        Fri, 23 Sep 2022 17:56:53 +0800 (CST)
Subject: Re: [PATCH 1/3] LoongArch: tools: Add relocs tool support
To:     Xi Ruoyao <xry111@xry111.site>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
 <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
 <c9880165f0355fc3be3ec23153b43ad33e558b5d.camel@xry111.site>
 <4df8a26c49a35c1fce36d80c370f738fa71a2bef.camel@xry111.site>
 <f0e77716-9533-724a-2ea9-86bc5b52066c@loongson.cn>
 <78a4a6b0970c309daa336a2329e69d28df486552.camel@xry111.site>
 <fffdd2ac-4ba6-8eb3-f269-b22a3d9c32f6@loongson.cn>
 <0b2d115c42ff6cb9b8c65d852ec2f0746ca6e8d9.camel@xry111.site>
 <d852f590-95b4-3fd1-924a-68c0a6bb1b1b@loongson.cn>
 <29cd929b-185b-1c4b-f200-08f2a724b59d@loongson.cn>
 <a218373f773ef193903daa528291ec8bb384ddd2.camel@xry111.site>
 <83a7aad8-125b-29b5-715d-0061ce1b0647@loongson.cn>
 <011b5d39-e0cb-69cc-66fd-ed46afe7695e@loongson.cn>
 <750719dc-d481-6eba-05c6-50cfdceb871b@loongson.cn>
 <5e12ab67701adf81834dfb88fc3cb6fdf55f676d.camel@xry111.site>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <4c7beb51-869f-1e9e-7198-dba0f4455d91@loongson.cn>
Date:   Fri, 23 Sep 2022 17:56:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <5e12ab67701adf81834dfb88fc3cb6fdf55f676d.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxYOLjgi1jsZwgAA--.57742S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18tryUZrWDJw1DXrW5KFg_yoW8uFWkp3
        yxGFy7Can5WFyxZa1kXF4jvayYvrn3CFW5Arn8Gw1kAa45XF1agFsFqF42qFyqkrZ7K3WY
        qFWIq3sFgrs7ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
        87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUeID7DUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao

On 09/22/2022 07:19 PM, Xi Ruoyao wrote:
> On Thu, 2022-09-08 at 16:01 +0800, Youling Tang wrote:
>> After adding KBUILD_CFLAGS_KERNEL += -mdirect-extern-access, the
>> kernel
>> will not generate .got, .plt and .got.plt sections (in the new
>> toolchain), we should unexpectedly detect that the kernel has these
>> sections, maybe add similar patch [1] to detect, x86_64 has the same
>> operation.
>>
>> But when adding LDFLAGS_vmlinux += -pie (or -shared), there will be
>> .got, .plt and .got.plt sections generated, I don't know how the
>> toolchain handles it :(?
>
> Hi Youling,
>
> I've pulled your code and make some adjustments for it:
>
> https://github.com/xry111/linux/commits/xry111/la-dev/pie
>
> One adjustment is for FDT removal, another uses a static-PIE style
> LDFLAGS as the kernel is more "similar" to a static PIE than a shared
> library. In userspace, a static PIE is linked with [1]:
>
>  -static -pie --no-dynamic-linker -z text
>
> [1]: https://gcc.gnu.org/r13-2728
>
> But we have to use "-z notext" for vmlinux. I'm not an expert on kernel
> hacking, and I guess it's because the kernel doesn't really care the RWX
> permission of itself (I heard this during some discussion about a W/X
> page warning added in Binutils-2.39 which is triggered for vmlinux).
>
> With "-static -pie --no-dynamic-linker -z notext" (and GCC trunk &
> Binutils trunk), .plt and .got.plt are gone.
>
> .got is still there but it only contains one entry (8 bytes).  AFAIK
> this entry (`_GLOBAL_OFFSET_TABLE_[0]`) is set to the link-time address
> of _DYNAMIC for a userspace static PIE [2], but vmlinux does not need it
> at all.  We can tell the linker to discard it IIUC.

Yes, only .got contains one entry (8 bytes) after using LDFLAGS_vmlinux 
as above, thanks for your help.

Youling.

>
> [2]:
> https://maskray.me/blog/2021-08-29-all-about-global-offset-table#global_offset_table_0
>
> I've boot the kernel successfully and it seems KASLR is in-effect:
>
> $ sudo cat /proc/kallsyms | grep ' _printk$'
> 90000000023b28f4 T _printk
> $ grep ' _printk$' /boot/System.map-6.0.0-rc6-pie+
> 90000000009828f4 T _printk
>

