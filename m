Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1700F647060
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiLHNDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLHNDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:03:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892667647
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:03:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25DF161EFF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87892C433D6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670504614;
        bh=8WTaKC31dOLPvQwNBCuomCv6vG/IVVtjFcvUZPut1aU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RpA90rnK6ZkeW+faDwqBMKzwG2VlvHO3GVNI05AsaExpQmKIwfznkWgmdSaNmHkOE
         /vSOlfyY2CkO6/JJsgH1MksbIkHnJvbiZNB1gzYKJwklrTiNpQdKkOznyVcdeLEyZ5
         ss+q/ruufdMGBPBRs9CxES0u8rAxlYwJzG3mz0YL1i/B1++UCrQ8ZfAhw+ReqzJo+y
         jWxN1ta1yfpcq2vOXPMHRrwBYFsgfssJa9Pe0JBgXxwO0gxnQXbfUZiu/ZbqBgkobx
         WqxD4adrhfQPyTQEVeEGq+vrkkUpAeiMGYPWHRTmZHv/jeFYJFVxF9e1AG7vHsFybt
         i9hd9P4SnMCfA==
Received: by mail-ej1-f54.google.com with SMTP id fc4so3609148ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 05:03:34 -0800 (PST)
X-Gm-Message-State: ANoB5pmNKflfGb/AGMjft298xqFl2GfnDdbytwnjQoWtGOKuqOTvk6NF
        auq1W6/x7qUtdp7M+PD5vNQ0y67QvXLKQohEZnA=
X-Google-Smtp-Source: AA0mqf7H1OACUFYqDO0DYLD9ByXVmg2uFMotk/YK6ZOQTY23PYyp/o7HSpoGih4e2nuCrhBopLmnnqebWqxc1RUACxw=
X-Received: by 2002:a17:906:1811:b0:7ae:5a4:5356 with SMTP id
 v17-20020a170906181100b007ae05a45356mr64257205eje.748.1670504612741; Thu, 08
 Dec 2022 05:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20221202075854.2253116-1-maobibo@loongson.cn> <07e0d775-6bb7-051b-9ec9-71153efbdf21@xen0n.name>
 <c5e1b113-f457-2cc7-808b-b13f83adbb2b@loongson.cn> <c00462a5-c5c0-a749-15aa-c0efaf232e71@xen0n.name>
In-Reply-To: <c00462a5-c5c0-a749-15aa-c0efaf232e71@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 8 Dec 2022 21:03:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H62s_VL2Mv5_1CFkT7+JVvJd6Nmv18=aw9V_YU+AmsJGw@mail.gmail.com>
Message-ID: <CAAhV-H62s_VL2Mv5_1CFkT7+JVvJd6Nmv18=aw9V_YU+AmsJGw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: export symbol with function smp_send_reschedule
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     maobibo <maobibo@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

Applied, thanks.

Huacai

On Fri, Dec 2, 2022 at 5:41 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 2022/12/2 17:03, maobibo wrote:
> >>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.=
c
> >>> index 6ed72f7ff278..51dd3c3f06cb 100644
> >>> --- a/arch/loongarch/kernel/smp.c
> >>> +++ b/arch/loongarch/kernel/smp.c
> >>> @@ -141,6 +141,17 @@ void loongson_send_ipi_single(int cpu, unsigned =
int action)
> >>>        ipi_write_action(cpu_logical_map(cpu), (u32)action);
> >>>    }
> >>>    +/*
> >>> + * This function sends a 'reschedule' IPI to another CPU.
> >>> + * it goes straight through and wastes no time serializing
> >>> + * anything. Worst case is that we lose a reschedule ...
> >>> + */
> >>> +void smp_send_reschedule(int cpu)
> >>> +{
> >>> +    loongson_send_ipi_single(cpu, SMP_RESCHEDULE);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(smp_send_reschedule);
> >>> +
> >>
> >> While the change is in itself okay (one less case of mips legacy, gett=
ing in line with ia64, powerpc and riscv that all EXPORT_SYMBOL_GPL this), =
I'd suggest you batch this patch with the subsequent changes you plan to en=
able with this one, so reviewers would have more context and hopefully avoi=
d churn. (I, by my familiarity with Loongson and LoongArch development, kno=
w you're probably aiming to use this with KVM, but others probably don't kn=
ow, and again it's always better to have more context.)
> >>
> >
> > yes, kvm module depends on function smp_send_reschedule, only that it i=
s not mature now. And this function is standard API, not arch specified API=
, it is normal for modules to use it :)
>
> Hmm, maybe you could post some kind of "sneak peek" code for early
> reviews on broader things like overall approach and architecture?
> Frankly speaking, experience suggests that code from Loongson usually
> needs much refactoring to meet mainline standards, and posting your
> design and some initial implementation could save you and the community
> a *huge* amount of time and hassle.
>
> And I'm not arguing this patch shouldn't get included, it's the
> opposite, but I don't see any difference in applying it now or later
> when the whole LoongArch KVM support gets mainlined, so maybe it's
> better to wait so we don't cause any churn if the change turns out
> unnecessary. For example, in my grepping I found that x86 doesn't have
> smp_send_reschedule exported, yet its KVM port has no problem using it;
> and that the s390 and riscv KVM ports don't invoke smp_send_reschedule
> at all. So it's entirely possible that LoongArch won't need this change
> for KVM after all, and I'm suggesting to save everyone some time.
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
>
