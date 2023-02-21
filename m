Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF869D838
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 02:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjBUB5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 20:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjBUB5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:57:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0351CF60
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:57:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37EF6B80E6F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED755C433EF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676944632;
        bh=/ZBcMX1qAKu2yYzC+BDZcfFTGrPMHh07Ryjbq5oCRnk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mxZuFUUKcFbleMmWWxYYyCoYNwFtfS0gzIke3k41LtUbz3B6q/IcASCHL1nSfy/VA
         RnrKw7qqBLKeEVAIkuSh5CI/yO5LaDgis4E8DFdQwVcGRtWu4TduFGYhwmrsn11fYW
         LFhLKMap+AK3UymiD8vbwhHI6J+yBthllJs87CajHN9WlO1AiZQfMhXR4CJF8hsBNb
         a/M4Ue6eyWIpbQp6HYTUYGztMbYQP+SZUjTm7Y2iiLAewAPJrp7/D5mB+2dgRdsrAH
         zWKhRZeV8VeoBiEIS4AZbr/Swaa8wz34B4EB7I+snB4WoZnNJx+7SLzo9yuqbq2Pft
         u95DBE9CoNOxQ==
Received: by mail-ed1-f43.google.com with SMTP id da10so12536419edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:57:11 -0800 (PST)
X-Gm-Message-State: AO0yUKUYhaDSahQ3VkiV6RK8m7bs2/ROCawcEcNDA32rEmTegBPz/jRZ
        SRiWFUqUUBzD7KYbaL4eH35sevSruR1iKVQYwuo=
X-Google-Smtp-Source: AK7set9rQ/WzVTKn9eq+BToIr/uj+hkRyODYgBXpsZKoHS+1y/R90Lbtl2siQQ0d1Jt3pjFeGESYOLCtV3i0N3g9aMs=
X-Received: by 2002:a50:baa4:0:b0:4aa:a4f1:3edc with SMTP id
 x33-20020a50baa4000000b004aaa4f13edcmr954197ede.7.1676944630133; Mon, 20 Feb
 2023 17:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20230126161559.1467374-1-guoren@kernel.org> <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us> <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
 <87ilgntdef.fsf@all.your.base.are.belong.to.us> <CAJF2gTTaartwjVdmtmsm1FqmYVuAq5_nGYU5zc6nkdTtCm200A@mail.gmail.com>
 <Y9jz+zUDebQ4VLlF@andrea> <CAJF2gTQsRcUpMk8nvFkEsz_fpVV+v6tpUDcPzaNjqfj+i_VvXA@mail.gmail.com>
 <878rgy3v0e.fsf@all.your.base.are.belong.to.us> <CAJF2gTTacQXg7e3s9s3dALCnPjstGGMPtk5L5SsN_MWKEov+pQ@mail.gmail.com>
 <87lekwzr0h.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87lekwzr0h.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 21 Feb 2023 09:56:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTFNHB61EzRv4F1wgXQADwdYD_ocPQ1G5iPyip2+KxRMQ@mail.gmail.com>
Message-ID: <CAJF2gTTFNHB61EzRv4F1wgXQADwdYD_ocPQ1G5iPyip2+KxRMQ@mail.gmail.com>
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

On Fri, Feb 17, 2023 at 3:32 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:
>
> Guo Ren <guoren@kernel.org> writes:
>
> > On Thu, Feb 16, 2023 at 3:54 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org=
> wrote:
> >>
> >> Guo Ren <guoren@kernel.org> writes:
> >>
> >> > On Tue, Jan 31, 2023 at 6:57 PM Andrea Parri <parri.andrea@gmail.com=
> wrote:
> >> >>
> >> >> > > It's the concurrent modification that I was referring to (remov=
ing
> >> >> > > stop_machine()). You're saying "it'll always work", I'm saying =
"I'm not
> >> >> > > so sure". :-) E.g., writing c.ebreak on an 32b insn. Can you sa=
y that
> >> >> > Software must ensure write c.ebreak on the head of an 32b insn.
> >> >> >
> >> >> > That means IFU only see:
> >> >> >  - c.ebreak + broken/illegal insn.
> >> >> > or
> >> >> >  - origin insn
> >> >> >
> >> >> > Even in the worst case, such as IFU fetches instructions one by o=
ne:
> >> >> > If the IFU gets the origin insn, it will skip the broken/illegal =
insn.
> >> >> > If the IFU gets the c.ebreak + broken/illegal insn, then an ebrea=
k
> >> >> > exception is raised.
> >> >> >
> >> >> > Because c.ebreak would raise an exception, I don't see any proble=
m.
> >> >>
> >> >> That's the problem, this discussion is:
> >> >>
> >> >> Reviewer: "I'm not sure, that's not written in our spec"
> >> >> Submitter: "I said it, it's called -accurate atomicity-"
> >> > I really don't see any hardware that could break the atomicity of th=
is
> >> > c.ebreak scenario:
> >> >  - c.ebreak on the head of 32b insn
> >> >  - ebreak on an aligned 32b insn
> >> >
> >> > If IFU fetches with cacheline, all is atomicity.
> >> > If IFU fetches with 16bit one by one, the first c.ebreak would raise
> >> > an exception and skip the next broke/illegal instruction.
> >> > Even if IFU fetches without any sequence, the IDU must decode one by
> >> > one, right? The first half c.ebreak would protect and prevent the ne=
xt
> >> > broke/illegal instruction. Speculative execution on broke/illegal
> >> > instruction won't cause any exceptions.
> >> >
> >> > It's a common issue, not a specific ISA issue.
> >> > 32b instruction A -> 16b ebreak + 16b broken/illegal -> 32b
> >> > instruction A. It's safe to transform.
> >>
> >> Waking up this thread again, now that Changbin has showed some interes=
t
> >> from another thread [1].
> >>
> >> Guo, we can't really add your patches, and claim that they're generic,
> >> "works on all" RISC-V systems. While it might work for your I/D cohere=
nt
> >> system, that does not imply that it'll work on all platforms. RISC-V
> >> allows for implementations that are I/D incoherent, and here your
> >> IFU-implementations arguments do not hold. I'd really recommend to
> >> readup on [2].
> > Sorry, [2] isn't related to this patch.
>
> Well, it is. Page 44 and 98. You are changing an instruction, that
> potentially the processor fetches and executes, from an instruction
> storage which has not been made consistent with data storage.
Page 44 describes how two ST sequences affect IFU fetch, it is not
related to this patch (We only use one IALIGN ebreak).
Page 98 is a big topic and ignores the minimal fetch element size.
(This material also agrees that the IFU should follow ISA minimal
instruction size to fetch instructions from memory.)

If you want to add something in the ISA spec for this patch. I think
it should be at the beginning of the ISA spec:
---
diff --git a/src/intro.tex b/src/intro.tex
index 7a74ab7..4d353ee 100644
--- a/src/intro.tex
+++ b/src/intro.tex
@@ -467,7 +467,8 @@ We use the term IALIGN (measured in bits) to refer
to the instruction-address
 alignment constraint the implementation enforces.  IALIGN is 32 bits in th=
e
 base ISA, but some ISA extensions, including the compressed ISA extension,
 relax IALIGN to 16 bits.  IALIGN may not take on any value other than 16 o=
r
-32.
+32. The Instruction Fetch Unit must fetch memory in IALGN, which means IFU
+doesn't support misaligned fetch.

 We use the term ILEN (measured in bits) to refer to the maximum
 instruction length supported by an implementation, and which is always
---

This sentence is redundant. No IFU will misplace fetch instructions, right?


>
> > This patch didn't have I/D incoherent problem because we broadcast the
> > IPI fence.i in patch_text_nosync.
>
> After the modification, yes.
>
> > Compared to the stop_machine version, there is a crazy nested IPI
> > broadcast cost.
> > stop_machine -> patch_text_nosync -> flush_icache_all
> > void flush_icache_all(void)
> > {
> >         local_flush_icache_all();
> >
> >         if (IS_ENABLED(CONFIG_RISCV_SBI))
> >                 sbi_remote_fence_i(NULL);
> >         else
> >                 on_each_cpu(ipi_remote_fence_i, NULL, 1);
> > }
> > EXPORT_SYMBOL(flush_icache_all);
>
> Look, I'd love to have your patch in *if we could say that it works on
> all RISC-V platforms*. If everyone agrees that "Guo's approach works" --
> I'd be a happy person. I hate the stopmachine flow as much as the next
> guy. I want a better mechanism in as well. What I'm saying is that:
>
> There's no specification for this. What assumptions can be made? The
> fact that Intel, Arm, and power has this explicitly stated in the specs,
> hints that this is something to pay attention to. Undefined behavior is
> no fun debugging.
>
> You seem very confident that it's impossible to construct hardware where
> your approach does not work.
>
> If there's concensus that your approach is "good enough" -- hey, that'd
> be great! Get it in!
>
> >> Now how could we move on with your patches? Get it in a spec, or fold
> >> the patches in as a Kconfig.socs-thing for the platforms where this is
> >> OK. What are you thoughts on the latter?
> >
> > I didn't talk about I/D incoherent/coherent; what I say is the basic
> > size of the instruction element.
> > In an I/D cache system, why couldn't LSU store-half guarantee
> > atomicity for I-cache fetch? How I-cache could fetch only one byte of
> > that Store-half value?
> > We've assumed this guarantee in the riscv jump_label implementation,
> > so why not this patch couldn't?
>
> Which is a good point. Is that working on all existing implementations?
> Is that assumption correct?  We've seen issues with that approach on
> *simulation*, where you/Andy fixed it:
> https://lore.kernel.org/linux-riscv/20230206090440.1255001-1-guoren@kerne=
l.org/
>
> Maybe the RISC-V kernel's assumptions about text patching should just be
> documented, and stating "this is what the kernel does, and what it
> assumes about the execution environment -- if your hardware doesn't work
> with that =C2=AF\_(=E3=83=84)_/=C2=AF".
>
> What are your thoughts on this, Guo? You don't seem to share my
> concerns. Or is it better to go for your path (patches!), and simply
> change it if there's issues down the line?
>


--=20
Best Regards
 Guo Ren
