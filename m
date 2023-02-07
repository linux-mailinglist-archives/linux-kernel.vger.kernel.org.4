Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EAC68CDE3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBGEDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBGEDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:03:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8119D9017
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:03:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F2ABB81690
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCF5C4339E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675742618;
        bh=H6TlQt041tJWj4E9feO8/AxydSfmcUpI09twaI6RoBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sRUr0rLLiAp/LiRY2SkyUL8JiqJo2MiOT1XxziIfmjyTy8ApBuS/iJnesrAox6ksl
         D2ZHjYUHJ+kVXuwuDL/fl7FE3uByTby/xtc8zUZtIhRkCQ2zpGTlGxmnzCiF5AAcTR
         BzLQPftPXFkYmqYWIUORMtoyF1XXFc4cfWbWVF+uNj+U6HO9csz2pZ59O8WB1z3c2l
         zoMVdosbfWXvb/EBxOW7DJCtSN2hqC9R8W5NuTXYF4xdZr1QGq4y8e2HeEr12MeoYB
         ki7C61nA+Pmi6mdUD6hrhGWD7IlmUpU+cF6wdgDF/Fhpzsq4Q9aA6s+E2Xdqp6Yvz6
         W3i9SYVbCn6CA==
Received: by mail-ed1-f45.google.com with SMTP id v10so13799185edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 20:03:38 -0800 (PST)
X-Gm-Message-State: AO0yUKWCBsj+ETvaIgrHU4IPDwoJdV3yjHD9vHgkfwDIQaIUb7BhA514
        oNiOSwb9kyjqgKpUfAWcOS0u3eeZapqqPNMrmw4=
X-Google-Smtp-Source: AK7set9WvTuWKS3heZ69IZMoBYSCJIQGsaD0cRcWYkaOQz1IzLoRpyNoArQCwrUSLYnNIGOljGXMa3+hmkJLolB4QIA=
X-Received: by 2002:a50:8a84:0:b0:4aa:a4f1:3edc with SMTP id
 j4-20020a508a84000000b004aaa4f13edcmr191069edj.7.1675742617019; Mon, 06 Feb
 2023 20:03:37 -0800 (PST)
MIME-Version: 1.0
References: <1674007261-9198-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4aTd6_cSy45KKjv-KrLTiwT4iG6+fkb84KfCrL3Y+hpg@mail.gmail.com>
 <CAAhV-H5WN5E=0Z9wpbXDc6VO7Nc+j7PGvnyAAGOmCRMJkdwSYw@mail.gmail.com>
 <CAEr6+ECO-=jfhzHrcdKGx0MsjMBMiN6wsBPCfv7CaXo_amAWWg@mail.gmail.com>
 <02806f85-bc09-d316-f058-3947353cb190@loongson.cn> <CAEr6+EBYF2xqZWEuZaz5un5FF3Jb-rSAQp3s3uojsovm9RcUYA@mail.gmail.com>
 <CAAhV-H5dJGrL3kEwzC-XwMqJTCsYHq-YVDTDRntGcYg9RMz02w@mail.gmail.com>
 <CAEr6+EDvaqpfvyJhe9TpDbhzrgu9aPPtePi2Vp=vAB5xgMNhXQ@mail.gmail.com> <8f306f68-7517-7c45-b2ef-668af9cf5f6a@loongson.cn>
In-Reply-To: <8f306f68-7517-7c45-b2ef-668af9cf5f6a@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 7 Feb 2023 12:03:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7O-R33AQvCXmZQXDb-ACjZ5MYdWULHuKXYdnvt+UPjJA@mail.gmail.com>
Message-ID: <CAAhV-H7O-R33AQvCXmZQXDb-ACjZ5MYdWULHuKXYdnvt+UPjJA@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Add kprobe and kretprobe support for LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jeff Xie <xiehuan09@gmail.com>, WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff,

The code has been updated here,
https://github.com/loongson/linux/commits/loongarch-next, you can test
again.

Huacai

On Tue, Feb 7, 2023 at 11:14 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 02/06/2023 08:48 PM, Jeff Xie wrote:
> > On Mon, Feb 6, 2023 at 8:13 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> >>
> >> Hi, Jeff,
> >>
> >> Now I add kprobes on ftrace support in
> >> https://github.com/loongson/linux/commits/loongarch-next, please test
> >> again. Thank you.
> >>
> >
> > When using the kprobe example module kprobe_example.ko, I haven't seen
> > any errors.
> >
> > But when using the ftrace to probe the symbol + offset, the kernel will panic:
> > e.g. probe the scheduler_tick+4 is fine, but when probe the
> > scheduler_tick+5, the kernel will panic.
> >
>
> Thanks for your test.
>
> We can see that the instruction address is 4-byte alignment,
> this is because the instruction length is 32-bit on LoongArch.
>
> $ objdump -d vmlinux > dump.txt
> $ grep -A 20 scheduler_tick dump.txt | head -21
> 9000000000279fc8 <scheduler_tick>:
> 9000000000279fc8:       03400000        andi            $zero, $zero, 0x0
> 9000000000279fcc:       03400000        andi            $zero, $zero, 0x0
> 9000000000279fd0:       02ff4063        addi.d          $sp, $sp, -48(0xfd0)
> 9000000000279fd4:       29c08077        st.d            $s0, $sp, 32(0x20)
> 9000000000279fd8:       29c06078        st.d            $s1, $sp, 24(0x18)
> 9000000000279fdc:       29c04079        st.d            $s2, $sp, 16(0x10)
> 9000000000279fe0:       29c0207a        st.d            $s3, $sp, 8(0x8)
> 9000000000279fe4:       29c0a061        st.d            $ra, $sp, 40(0x28)
> 9000000000279fe8:       2700007b        stptr.d         $s4, $sp, 0
> 9000000000279fec:       24001844        ldptr.w         $a0, $tp, 24(0x18)
> 9000000000279ff0:       1a02edd9        pcalau12i       $s2, 5998(0x176e)
> 9000000000279ff4:       1a034bac        pcalau12i       $t0, 6749(0x1a5d)
> 9000000000279ff8:       02f56339        addi.d          $s2, $s2, -680(0xd58)
> 9000000000279ffc:       00410c9a        slli.d          $s3, $a0, 0x3
> 900000000027a000:       28aae18d        ld.w            $t1, $t0, -1352(0xab8)
> 900000000027a004:       380c6b2e        ldx.d           $t2, $s2, $s3
> 900000000027a008:       1a022fcc        pcalau12i       $t0, 4478(0x117e)
> 900000000027a00c:       02f20198        addi.d          $s1, $t0, -896(0xc80)
> 900000000027a010:       00150317        move            $s0, $s1
> 900000000027a014:       004081ac        slli.w          $t0, $t1, 0x0
>
> So we should check the probe address at the beginning of
> arch_prepare_kprobe(), some other archs do the same thing.
>
> $ git diff
> diff --git a/arch/loongarch/kernel/kprobes.c
> b/arch/loongarch/kernel/kprobes.c
> index bdab707b6edf..56c8c4b09a42 100644
> --- a/arch/loongarch/kernel/kprobes.c
> +++ b/arch/loongarch/kernel/kprobes.c
> @@ -79,6 +79,9 @@ NOKPROBE_SYMBOL(arch_prepare_simulate);
>
>   int arch_prepare_kprobe(struct kprobe *p)
>   {
> +       if ((unsigned long)p->addr & 0x3)
> +               return -EILSEQ;
> +
>          /* copy instruction */
>          p->opcode = *p->addr;
>
>
> Thanks,
> Tiezhu
>
>
