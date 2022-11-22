Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD4A63390F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiKVJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiKVJv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:51:26 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F232C11E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:51:25 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id io19so13116116plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJPRFWUS+kHDlUMP7u9x/6fCJJ/tjVlV+kEOIve76tU=;
        b=gpr1s7j38CU30DZx7QJ6i6Zckn7o9X6P7nSjOVTuO7Cn4+ARAsx4uVCSiPN9mC8Rvn
         GFG7bKKGccODi9sVbEf+zvp7a0M+CI4GAxUAwGeH2Cm0X4YFUiWBSvNRv4RJ6yDBcuFE
         8advTVWWv5OEyK2WO49jYEM6NHwE235MBMBx1Y3IsOwIO1Vkk+4bf9HDJQ7QgTSB1M8G
         hxSePriwPMdMeVybnw06OfDp6Pq3tA6utRmDBsD9ViTc1saKDwLBOdS37WER8+bORgp8
         Bf0dXNGCaUuYmzXlLd/HG/szwbb5ikY4M641gylv5dO8wujIecIv/0LUB3ppw5pzGNyX
         IZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJPRFWUS+kHDlUMP7u9x/6fCJJ/tjVlV+kEOIve76tU=;
        b=1Rq1/udSqaNAvuXNHye3rehWlHE69IbgbD8JpBxvxzimBKfZC9rE/ZtdhzWQr7kTYk
         8V2hYfI5nToeSOLiFHr3EvORZIuZpEAcKMbAXT5N1gfqQm06DzecrpmqbkxV5g7bMdp/
         5KVSoPb1qXi/rNX9nG/dI/PNX9X5zTELQk5HglqYzkEd2tVMY3g5fgXRwZAclNJj2F0A
         b3XxqJKf/0NeqzDDpy9SdaoPjn9hlTU91QR4nEeG+nBlPAfuTI0qbrq31J1z5s9CUHd8
         PyvvJB94UIOau2N10wiGq5z/IolwDa0n3Etimcu/U2I6H5FcAzqdTeSKMfJk2fHJD2W9
         B+1g==
X-Gm-Message-State: ANoB5pm+ZeWVoycKhN7McpuM5fF4yQIgp9H2/xfeJYeOw+1SRn4XaDie
        aTN0Sc4JXmlNLKtiatzRECk9mfdaGcppTWsjzag=
X-Google-Smtp-Source: AA0mqf54aYRkWpRvkuoQXCzil+q3LvsUhNdPKvB9vzawCX6CVfErmT6Mt+YkCcRXw4+YOMrssCEvNc/Lhu2hRRJ56g4=
X-Received: by 2002:a17:902:ca04:b0:17f:7f7e:70c7 with SMTP id
 w4-20020a170902ca0400b0017f7f7e70c7mr5083919pld.107.1669110684712; Tue, 22
 Nov 2022 01:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20221122075440.1165172-1-suagrfillet@gmail.com>
 <CAJF2gTQWuu2wUk-7WhFdov0PG5R1z_F_+OLqHM0nGnMiC1Yi_w@mail.gmail.com>
 <CAAYs2=iSTTuthLhwiyw08yG2q=yLrdKPmvbG2rS7uibzhe-wXQ@mail.gmail.com> <CAJF2gTT=r4VeWqpe+Tw2JDdTDU+r2mJiPmHq_i8eV5YRmrrLRA@mail.gmail.com>
In-Reply-To: <CAJF2gTT=r4VeWqpe+Tw2JDdTDU+r2mJiPmHq_i8eV5YRmrrLRA@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Tue, 22 Nov 2022 09:51:11 +0000
Message-ID: <CAAYs2=gBfKPBMBVpkOYfixavkANhBnArSdCdHDgv8219sR4BzA@mail.gmail.com>
Subject: Re: [PATCH] riscv/ftrace: fix ftrace_modify_call bug
To:     Guo Ren <guoren@kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8822=E6=97=A5=E5=
=91=A8=E4=BA=8C 09:29=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On Tue, Nov 22, 2022 at 5:11 PM Song Shuai <suagrfillet@gmail.com> wrote:
>>
>> Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=BA=8C 08:57=E5=86=99=E9=81=93=EF=BC=9A
>> >
>> > On Tue, Nov 22, 2022 at 3:54 PM Song Shuai <suagrfillet@gmail.com> wro=
te:
>> > >
>> > > With this commit (riscv: ftrace: Reduce the detour code size to half=
)
>> > > patched, ftrace bug occurred When hosting kprobe and function tracer
>> > > at the same function.
>> > >
>> > > Obviously, the variable caller in ftrace_modify_call was assigned by
>> > > rec->ip with 4 offset failing the code replacing at function entry.
>> > > And the caller should be assigned by rec->ip directly to indicate
>> > > the function entry.
>> > Thank you, it's my fault, but I think the problem is:
>> >
>> > Before (riscv: ftrace: Reduce the detour code size to half)
>> >      0: REG_S  ra, -SZREG(sp)
>> >      4: auipc  ra, ?          <- We need "rec->ip + 4" here
>> >      8: jalr   ?(ra)
>> >     12: REG_L  ra, -SZREG(sp)
>> >
>> > After (riscv: ftrace: Reduce the detour code size to half)
>> >      0: auipc  t0, ?  <- We needn't "rec->ip + 4" anymore
>> >      4: jalr   t0, ?(t0)
>> >
>> > I copied rec->ip + 4 blindly, then caused the bug. Right?
>> >
>> Yes, you're right.
>>
>> Here's my simple test case for your convenience.
>> ```
>> echo kernel_read > set_ftrace_filter
>> echo function > current_tracer
>> echo 'p:myp kernel_read' > kprobe_events
>> echo 1 > events/kprobes/myp/enable # ftrace bug
>
>
> Thx, I would fold the patch into (riscv: ftrace: Reduce the detour code s=
ize to half). And add Co-developed-by: Song Shuai <suagrfillet@gmail.com> t=
ag on that.
>
> I would send the v3 series involving your patches.
>
That's an honor for me.

Thanks,
Song
>>
>> ```
>> > >
>> > > The following is the ftrace bug log.
>> > >
>> > > ```
>> > > [  419.632855] 00000000f8776803: expected (ffe00297 1a4282e7) but go=
t (1a8282e7 f0227179)
>> > > [  419.633390] ------------[ ftrace bug ]------------
>> > > [  419.633553] ftrace failed to modify
>> > > [  419.633569] [<ffffffff802091cc>] kernel_read+0x0/0x52
>> > > [  419.633863]  actual:   97:02:e0:ff:e7:82:82:1a
>> > > [  419.634087] Updating ftrace call site to call a different ftrace =
function
>> > > [  419.634279] ftrace record flags: e0000002
>> > > [  419.634487]  (2) R
>> > > [  419.634487]  expected tramp: ffffffff800093cc
>> > > [  419.634935] ------------[ cut here ]------------
>> > > ```
>> > >
>> > > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>> > > ---
>> > >  arch/riscv/kernel/ftrace.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>> > > index 8c77f236fc71..61b24d767e2e 100644
>> > > --- a/arch/riscv/kernel/ftrace.c
>> > > +++ b/arch/riscv/kernel/ftrace.c
>> > > @@ -132,7 +132,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, u=
nsigned long old_addr,
>> > >                        unsigned long addr)
>> > >  {
>> > >         unsigned int call[2];
>> > > -       unsigned long caller =3D rec->ip + 4;
>> > > +       unsigned long caller =3D rec->ip;
>> > >         int ret;
>> > >
>> > >         make_call_t0(caller, old_addr, call);
>> > > --
>> > > 2.20.1
>> > >
>> >
>> >
>> > --
>> > Best Regards
>> >  Guo Ren
>> Thanks,
>> Song
>
>
>
> --
> Best Regards
>  Guo Ren
