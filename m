Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7193569A3E4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 03:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjBQC3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 21:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQC3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 21:29:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C784FC98
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:29:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2377261290
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA54C433EF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676600940;
        bh=Ra2Kc03LZoibfd4WyHiHEUN5GcCOOJLNJsxaG6GQ8mE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AMyuDfrohAwhIOdw7MwzKcFAcgHw89CEoI46WU5F6UmpO+FNfg4IVtmbtX/q8wXAH
         SMiGXLjFbpbs3+DHwl1ovXOWMNJg/q5VYhrAzzAasX9yMwF0KrKjfxURzE91NbxbNv
         wKLyLINm2ceY9zVFzO95FAxnN96urYNT6p/S8VjjUC3ew20nIkUlmfk5dRL5DCj4DO
         7ZsTLILWRqm7DLJ6vLdiAQGeyNE/Q/N0tmqDynOuCj463YKU0nGQe5rFJf4S0YmLzd
         5bsR4TO2nW5oUgSMHeERe0zEfxn/YbLR/MprjpOSoS1eWmYYIIJdTsjE/z3W96xfgQ
         4xMyz8Rr7rIQA==
Received: by mail-ed1-f41.google.com with SMTP id v13so10145294eda.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:28:59 -0800 (PST)
X-Gm-Message-State: AO0yUKWPm3LXrGwrgWPJXaQK2unrLbCPtUivkJTVX9R+UzLt8uGNCDY1
        OpA5/mJnbE5bPUf9RS9jsp5Oo482xs7W3ds3feU=
X-Google-Smtp-Source: AK7set9dHgzJsIxZkFtFpNM0y0jTcrTO/PULnhjZIThysYzt75rjc9hkBF9wYjkdmvrhADwLvqw7MHzMcFSAYcEFXys=
X-Received: by 2002:a17:906:eb9a:b0:87b:fa21:7953 with SMTP id
 mh26-20020a170906eb9a00b0087bfa217953mr3794180ejb.8.1676600937720; Thu, 16
 Feb 2023 18:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20230126161559.1467374-1-guoren@kernel.org> <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us> <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
 <87ilgntdef.fsf@all.your.base.are.belong.to.us> <CAJF2gTTaartwjVdmtmsm1FqmYVuAq5_nGYU5zc6nkdTtCm200A@mail.gmail.com>
 <Y9jz+zUDebQ4VLlF@andrea> <CAJF2gTQsRcUpMk8nvFkEsz_fpVV+v6tpUDcPzaNjqfj+i_VvXA@mail.gmail.com>
 <878rgy3v0e.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <878rgy3v0e.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 17 Feb 2023 10:28:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTacQXg7e3s9s3dALCnPjstGGMPtk5L5SsN_MWKEov+pQ@mail.gmail.com>
Message-ID: <CAJF2gTTacQXg7e3s9s3dALCnPjstGGMPtk5L5SsN_MWKEov+pQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Changbin Du <changbin.du@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 3:54 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:
>
> Guo Ren <guoren@kernel.org> writes:
>
> > On Tue, Jan 31, 2023 at 6:57 PM Andrea Parri <parri.andrea@gmail.com> w=
rote:
> >>
> >> > > It's the concurrent modification that I was referring to (removing
> >> > > stop_machine()). You're saying "it'll always work", I'm saying "I'=
m not
> >> > > so sure". :-) E.g., writing c.ebreak on an 32b insn. Can you say t=
hat
> >> > Software must ensure write c.ebreak on the head of an 32b insn.
> >> >
> >> > That means IFU only see:
> >> >  - c.ebreak + broken/illegal insn.
> >> > or
> >> >  - origin insn
> >> >
> >> > Even in the worst case, such as IFU fetches instructions one by one:
> >> > If the IFU gets the origin insn, it will skip the broken/illegal ins=
n.
> >> > If the IFU gets the c.ebreak + broken/illegal insn, then an ebreak
> >> > exception is raised.
> >> >
> >> > Because c.ebreak would raise an exception, I don't see any problem.
> >>
> >> That's the problem, this discussion is:
> >>
> >> Reviewer: "I'm not sure, that's not written in our spec"
> >> Submitter: "I said it, it's called -accurate atomicity-"
> > I really don't see any hardware that could break the atomicity of this
> > c.ebreak scenario:
> >  - c.ebreak on the head of 32b insn
> >  - ebreak on an aligned 32b insn
> >
> > If IFU fetches with cacheline, all is atomicity.
> > If IFU fetches with 16bit one by one, the first c.ebreak would raise
> > an exception and skip the next broke/illegal instruction.
> > Even if IFU fetches without any sequence, the IDU must decode one by
> > one, right? The first half c.ebreak would protect and prevent the next
> > broke/illegal instruction. Speculative execution on broke/illegal
> > instruction won't cause any exceptions.
> >
> > It's a common issue, not a specific ISA issue.
> > 32b instruction A -> 16b ebreak + 16b broken/illegal -> 32b
> > instruction A. It's safe to transform.
>
> Waking up this thread again, now that Changbin has showed some interest
> from another thread [1].
>
> Guo, we can't really add your patches, and claim that they're generic,
> "works on all" RISC-V systems. While it might work for your I/D coherent
> system, that does not imply that it'll work on all platforms. RISC-V
> allows for implementations that are I/D incoherent, and here your
> IFU-implementations arguments do not hold. I'd really recommend to
> readup on [2].
Sorry, [2] isn't related to this patch.

This patch didn't have I/D incoherent problem because we broadcast the
IPI fence.i in patch_text_nosync.

Compared to the stop_machine version, there is a crazy nested IPI
broadcast cost.
stop_machine -> patch_text_nosync -> flush_icache_all
void flush_icache_all(void)
{
        local_flush_icache_all();

        if (IS_ENABLED(CONFIG_RISCV_SBI))
                sbi_remote_fence_i(NULL);
        else
                on_each_cpu(ipi_remote_fence_i, NULL, 1);
}
EXPORT_SYMBOL(flush_icache_all);


>
> Now how could we move on with your patches? Get it in a spec, or fold
> the patches in as a Kconfig.socs-thing for the platforms where this is
> OK. What are you thoughts on the latter?

I didn't talk about I/D incoherent/coherent; what I say is the basic
size of the instruction element.
In an I/D cache system, why couldn't LSU store-half guarantee
atomicity for I-cache fetch? How I-cache could fetch only one byte of
that Store-half value?
We've assumed this guarantee in the riscv jump_label implementation,
so why not this patch couldn't?

>
>
> Bj=C3=B6rn
>
> [1] https://lore.kernel.org/linux-riscv/20230215034532.xs726l7mp6xlnkdf@M=
910t/
> [2] https://github.com/riscv/riscv-j-extension/blob/master/id-consistency=
-proposal.pdf



--=20
Best Regards
 Guo Ren
