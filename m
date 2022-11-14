Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6475A628217
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiKNOK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbiKNOKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:10:24 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBBDDECB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:10:21 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id d3so13347336ljl.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2+SnyYb9w1A47HblbxnZ451UEd8FYwse9lGeC9APAQ=;
        b=cFFhslt4x+TI+fB7/1OSSCnEyatVRx3mUWuKPZINS3zuAroWUSX0oar87m+ClCb51T
         oPK787j+PUmUdmUC6oaPGyNbj8MbQUXSQ7grBL7SpTlJv/zmSY+XrgGpQZBu0tOjOJ8E
         QLOlJxardsYMgbBpXB9cLl5Qy7ecELhIoYTPEyu6JvkZQwUsQSFr8gH26lGZ+R5ZGDzr
         gBhM8Kf7v5MgRWpRWOl01caNxNskXRaTdP9M+rHI/BzO6ozc6ump/uiSonLxi7rN9+3O
         u37yfHkNiIw1KCXc9EkFdUjz7kTpKzZoGl1Cxcf+VXvYt4xbHQS//rS9goDSj0SH95qZ
         WW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2+SnyYb9w1A47HblbxnZ451UEd8FYwse9lGeC9APAQ=;
        b=E64RnIE5DBHECSk3uLWqY9TNi3PUFoFsSwctE6FrMDn7MjaQe1KdGfyPllrpzI8crL
         u1sPW5sWRUlYhJuNceRNex4SvyEYqtYFY619hSz8MeLZrc4S2AppVUwg1jhDoW9n68Nf
         PaKU103TI+17XxN/hmLy0o9OqXRuPBH0+UGHx2fU+dIfgJlSLZxiffG8A35YNrcTRk/6
         T0rklKGu9XXWg/AqoKh0DdI9LsNGIJoS/zmviHIJ0F4nBHITcVkQ4nlPuW8L5/RABuPg
         h+czihsARqtcSNXG5wcjDRHuYkeQnaOKgNojrux/fyIKIG8NkXYH9Er2IlJ+VWQjT68X
         AqfA==
X-Gm-Message-State: ANoB5plyxdAzoznsFGWd2MNJMwQKulU5d96ObAwlN0J9Wg4vig9jSKFp
        1a06lc/qW75EpubEikNF/oI=
X-Google-Smtp-Source: AA0mqf5EfE9zdGhyJyNB9LnqlnCvfYtxSfqYCZhBJMgqkZVlNFxTqwdeWieOlvWSl/s0c4wb6yxufA==
X-Received: by 2002:a2e:b16d:0:b0:26d:d603:8df2 with SMTP id a13-20020a2eb16d000000b0026dd6038df2mr3840546ljm.189.1668435020281;
        Mon, 14 Nov 2022 06:10:20 -0800 (PST)
Received: from ?IPV6:2a02:6b8:0:107:3e85:844d:5b1d:60a? ([2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by smtp.gmail.com with ESMTPSA id u12-20020ac258cc000000b0049f87fb416dsm1848415lfo.12.2022.11.14.06.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 06:10:19 -0800 (PST)
Message-ID: <21c89067-7112-dc62-6fb3-d83e265eebd5@gmail.com>
Date:   Mon, 14 Nov 2022 17:10:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/5] x86/mm: Populate KASAN shadow for entire per-CPU
 range of CPU entry area
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
References: <20221110203504.1985010-1-seanjc@google.com>
 <20221110203504.1985010-3-seanjc@google.com>
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20221110203504.1985010-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/22 23:35, Sean Christopherson wrote:
> Populate a KASAN shadow for the entire possible per-CPU range of the CPU
> entry area instead of requiring that each individual chunk map a shadow.
> Mapping shadows individually is error prone, e.g. the per-CPU GDT mapping
> was left behind, which can lead to not-present page faults during KASAN
> validation if the kernel performs a software lookup into the GDT.  The DS
> buffer is also likely affected.
> 
> The motivation for mapping the per-CPU areas on-demand was to avoid
> mapping the entire 512GiB range that's reserved for the CPU entry area,
> shaving a few bytes by not creating shadows for potentially unused memory
> was not a goal.
> 
> The bug is most easily reproduced by doing a sigreturn with a garbage
> CS in the sigcontext, e.g.
> 
>   int main(void)
>   {
>     struct sigcontext regs;
> 
>     syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>     syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
>     syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> 
>     memset(&regs, 0, sizeof(regs));
>     regs.cs = 0x1d0;
>     syscall(__NR_rt_sigreturn);
>     return 0;
>   }
> 
> to coerce the kernel into doing a GDT lookup to compute CS.base when
> reading the instruction bytes on the subsequent #GP to determine whether
> or not the #GP is something the kernel should handle, e.g. to fixup UMIP
> violations or to emulate CLI/STI for IOPL=3 applications.
> 
>   BUG: unable to handle page fault for address: fffffbc8379ace00
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 16c03a067 P4D 16c03a067 PUD 15b990067 PMD 15b98f067 PTE 0
>   Oops: 0000 [#1] PREEMPT SMP KASAN
>   CPU: 3 PID: 851 Comm: r2 Not tainted 6.1.0-rc3-next-20221103+ #432
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:kasan_check_range+0xdf/0x190
>   Call Trace:
>    <TASK>
>    get_desc+0xb0/0x1d0
>    insn_get_seg_base+0x104/0x270
>    insn_fetch_from_user+0x66/0x80
>    fixup_umip_exception+0xb1/0x530
>    exc_general_protection+0x181/0x210
>    asm_exc_general_protection+0x22/0x30
>   RIP: 0003:0x0
>   Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>   RSP: 0003:0000000000000000 EFLAGS: 00000202
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000001d0
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>   RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>   R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>    </TASK>
> 
> Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
> Reported-by: syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com
> Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/mm/cpu_entry_area.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
