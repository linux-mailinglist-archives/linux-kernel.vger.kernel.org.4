Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0688F68CD28
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBGDOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBGDOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:14:41 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C73813DFA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:14:39 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxDesewuFjMGUPAA--.30238S3;
        Tue, 07 Feb 2023 11:14:38 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx6r0cwuFjzzUrAA--.17348S3;
        Tue, 07 Feb 2023 11:14:38 +0800 (CST)
Subject: Re: [PATCH v12 0/5] Add kprobe and kretprobe support for LoongArch
To:     Jeff Xie <xiehuan09@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
References: <1674007261-9198-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4aTd6_cSy45KKjv-KrLTiwT4iG6+fkb84KfCrL3Y+hpg@mail.gmail.com>
 <CAAhV-H5WN5E=0Z9wpbXDc6VO7Nc+j7PGvnyAAGOmCRMJkdwSYw@mail.gmail.com>
 <CAEr6+ECO-=jfhzHrcdKGx0MsjMBMiN6wsBPCfv7CaXo_amAWWg@mail.gmail.com>
 <02806f85-bc09-d316-f058-3947353cb190@loongson.cn>
 <CAEr6+EBYF2xqZWEuZaz5un5FF3Jb-rSAQp3s3uojsovm9RcUYA@mail.gmail.com>
 <CAAhV-H5dJGrL3kEwzC-XwMqJTCsYHq-YVDTDRntGcYg9RMz02w@mail.gmail.com>
 <CAEr6+EDvaqpfvyJhe9TpDbhzrgu9aPPtePi2Vp=vAB5xgMNhXQ@mail.gmail.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8f306f68-7517-7c45-b2ef-668af9cf5f6a@loongson.cn>
Date:   Tue, 7 Feb 2023 11:14:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAEr6+EDvaqpfvyJhe9TpDbhzrgu9aPPtePi2Vp=vAB5xgMNhXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dx6r0cwuFjzzUrAA--.17348S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WFWxGr4fAFWxCw48XrW5Jrb_yoW5JFyfpF
        yDZrZ5CF4kX34DAw1q93WUXw4rtasrAa4I9FZxJF1Yyr1qvr17Jw10qr47ZF1Utr4Fkr1S
        q3sxtw1YvF1UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI4
        8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
        8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/06/2023 08:48 PM, Jeff Xie wrote:
> On Mon, Feb 6, 2023 at 8:13 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>>
>> Hi, Jeff,
>>
>> Now I add kprobes on ftrace support in
>> https://github.com/loongson/linux/commits/loongarch-next, please test
>> again. Thank you.
>>
>
> When using the kprobe example module kprobe_example.ko, I haven't seen
> any errors.
>
> But when using the ftrace to probe the symbol + offset, the kernel will panic:
> e.g. probe the scheduler_tick+4 is fine, but when probe the
> scheduler_tick+5, the kernel will panic.
>

Thanks for your test.

We can see that the instruction address is 4-byte alignment,
this is because the instruction length is 32-bit on LoongArch.

$ objdump -d vmlinux > dump.txt
$ grep -A 20 scheduler_tick dump.txt | head -21
9000000000279fc8 <scheduler_tick>:
9000000000279fc8:	03400000 	andi        	$zero, $zero, 0x0
9000000000279fcc:	03400000 	andi        	$zero, $zero, 0x0
9000000000279fd0:	02ff4063 	addi.d      	$sp, $sp, -48(0xfd0)
9000000000279fd4:	29c08077 	st.d        	$s0, $sp, 32(0x20)
9000000000279fd8:	29c06078 	st.d        	$s1, $sp, 24(0x18)
9000000000279fdc:	29c04079 	st.d        	$s2, $sp, 16(0x10)
9000000000279fe0:	29c0207a 	st.d        	$s3, $sp, 8(0x8)
9000000000279fe4:	29c0a061 	st.d        	$ra, $sp, 40(0x28)
9000000000279fe8:	2700007b 	stptr.d     	$s4, $sp, 0
9000000000279fec:	24001844 	ldptr.w     	$a0, $tp, 24(0x18)
9000000000279ff0:	1a02edd9 	pcalau12i   	$s2, 5998(0x176e)
9000000000279ff4:	1a034bac 	pcalau12i   	$t0, 6749(0x1a5d)
9000000000279ff8:	02f56339 	addi.d      	$s2, $s2, -680(0xd58)
9000000000279ffc:	00410c9a 	slli.d      	$s3, $a0, 0x3
900000000027a000:	28aae18d 	ld.w        	$t1, $t0, -1352(0xab8)
900000000027a004:	380c6b2e 	ldx.d       	$t2, $s2, $s3
900000000027a008:	1a022fcc 	pcalau12i   	$t0, 4478(0x117e)
900000000027a00c:	02f20198 	addi.d      	$s1, $t0, -896(0xc80)
900000000027a010:	00150317 	move        	$s0, $s1
900000000027a014:	004081ac 	slli.w      	$t0, $t1, 0x0

So we should check the probe address at the beginning of
arch_prepare_kprobe(), some other archs do the same thing.

$ git diff
diff --git a/arch/loongarch/kernel/kprobes.c 
b/arch/loongarch/kernel/kprobes.c
index bdab707b6edf..56c8c4b09a42 100644
--- a/arch/loongarch/kernel/kprobes.c
+++ b/arch/loongarch/kernel/kprobes.c
@@ -79,6 +79,9 @@ NOKPROBE_SYMBOL(arch_prepare_simulate);

  int arch_prepare_kprobe(struct kprobe *p)
  {
+       if ((unsigned long)p->addr & 0x3)
+               return -EILSEQ;
+
         /* copy instruction */
         p->opcode = *p->addr;


Thanks,
Tiezhu

