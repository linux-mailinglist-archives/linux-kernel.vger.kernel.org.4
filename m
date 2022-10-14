Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14885FE6B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJNBpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJNBpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:45:43 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78CEECF18B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:45:40 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxnms+v0hjacAtAA--.17933S3;
        Fri, 14 Oct 2022 09:45:34 +0800 (CST)
Subject: Re: [PATCH] LoongArch: BPF: Avoid declare variables in switch-case
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
References: <20221013154000.3462836-1-chenhuacai@loongson.cn>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e228a9ce-7801-ae00-001e-12f4ac4d2a81@loongson.cn>
Date:   Fri, 14 Oct 2022 09:45:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20221013154000.3462836-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxnms+v0hjacAtAA--.17933S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr15uw48CryUGw47KF1kGrg_yoW8Cw1fpF
        9xArnxC3yDG347Arn2y3yrWrn8KrW8Gw17XFyaya48uanrXr18ZF1fK3s8JayDXw45Xr1f
        X3yF9rnIvayvva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbNzVUUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2022 11:40 PM, Huacai Chen wrote:
> Not all compilers support declare variables in switch-case, so move

We know that gcc 13 has no problem, it is better to point out the
compiler version explicitly in the commit message so that the users
can know how to reproduce the build errors.

> declarations to the beginning of a function. Otherwise we may get such
> build errors:

We can resolve the errors by adding a pair of curly braces around
the statements of the case, like this:

switch (...) {
case ...:
     {
         int ...;
         ...
         break;
     }
}

>
> arch/loongarch/net/bpf_jit.c: In function ‘emit_atomic’:
> arch/loongarch/net/bpf_jit.c:362:3: error: a label can only be part of a statement and a declaration is not a statement
>    u8 r0 = regmap[BPF_REG_0];
>    ^~
> arch/loongarch/net/bpf_jit.c: In function ‘build_insn’:
> arch/loongarch/net/bpf_jit.c:727:3: error: a label can only be part of a statement and a declaration is not a statement
>    u8 t7 = -1;
>    ^~
> arch/loongarch/net/bpf_jit.c:778:3: error: a label can only be part of a statement and a declaration is not a statement
>    int ret;
>    ^~~
> arch/loongarch/net/bpf_jit.c:779:3: error: expected expression before ‘u64’
>    u64 func_addr;
>    ^~~
> arch/loongarch/net/bpf_jit.c:780:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>    bool func_addr_fixed;
>    ^~~~
> arch/loongarch/net/bpf_jit.c:784:11: error: ‘func_addr’ undeclared (first use in this function); did you mean ‘in_addr’?
>           &func_addr, &func_addr_fixed);
>            ^~~~~~~~~
>            in_addr
> arch/loongarch/net/bpf_jit.c:784:11: note: each undeclared identifier is reported only once for each function it appears in
> arch/loongarch/net/bpf_jit.c:814:3: error: a label can only be part of a statement and a declaration is not a statement
>    u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
>    ^~~
>

Thanks,
Tiezhu

