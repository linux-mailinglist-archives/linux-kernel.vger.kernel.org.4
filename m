Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6406D71A25A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjFAPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFAPTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:19:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEB3FC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:18:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f8d485ef3so135121466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632737; x=1688224737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dqfj7XT7ypNuOm5Zdn1QVpcZDvXLZqNRb5KEDxhoVAE=;
        b=cN5aaBEvgj50xDP9QJ/O48t98czXZVlgqoDh97w6f91k9kTWAQKpbSvTek/AOedAjh
         OBNOys9mp7nvLS/eDF2YEDcb0frrQSJoLRgdbx65elgL/OF7szfY98Z+UeTl177NIpyb
         lYkIqm/WRbrD4E4Q5x7PULuHG41eaJAim/FgPkNwO//u0G+0Q82/vkgnRJSGDqd0sNRr
         WzXMPMNY5qUGiy4Zs63b2Oi3EVPhkDIsJbvFWMYAwdbV82ad9UIOnDqffv8+wiW3N40S
         nu6kDfE+qfur9PoB3Gyh9pC0vv39dTRX07Y+f/lUOtsgn/bVSZKWTeni2Tw+Vb6rckGi
         wv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632737; x=1688224737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dqfj7XT7ypNuOm5Zdn1QVpcZDvXLZqNRb5KEDxhoVAE=;
        b=MjSVOYJa/zID9GA22zN/0JLyeUOubmBsGu9cNbrWvu+SdYxAKWQMvhgkAT1kPZQmfu
         cY82WWeBcSGGb8OnSTqAy78y9BQbRRwuRal7nan5ApKm0KzAUirWb+IT6n0/xuRy0aDN
         UVKsBrTtWa/u14BDzXcrpyKnc/gHvxCCWWURIwcOQcWyJnExYoKg6Gv07oVXcmzVOyJN
         Z0LkeEPJUVF0xjDJus1aKdpHDjXijW5Idxj6wZsx1JNsNfRHYP/oLKV8/YBgCBSjSC3i
         tSR9U8a6xf4egNyjCRhoJ6hL6MP6x5eGSEcu8Lnoo6tfKHeoE+3lsvLPzmoZvxGurbOF
         B7PA==
X-Gm-Message-State: AC+VfDynaQm+MunNBVvX2naVM2kM27k7UyBWjiYu1CfztcsDPAikLj3Y
        jJqZAAy7iUjC7npjc97pTML9cnCyQ/HGp2pRPK8=
X-Google-Smtp-Source: ACHHUZ7LVBpC+oIwc0ERPssPK4gHs4qTJHslJQsI72Uez/Ox+8OUC0HYgk3WFO7aTSAKzgUQOSepYJM/RgiWH6J3AtM=
X-Received: by 2002:a17:907:7285:b0:96b:e92:4feb with SMTP id
 dt5-20020a170907728500b0096b0e924febmr8235977ejc.60.1685632737163; Thu, 01
 Jun 2023 08:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6uZWgZQsVh=1-U2B4ZZZz6EPJ3gkv0mxHSNGOMPB=VwQ@mail.gmail.com>
 <87zg5lj1yb.ffs@tglx>
In-Reply-To: <87zg5lj1yb.ffs@tglx>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 1 Jun 2023 23:18:44 +0800
Message-ID: <CAAhV-H5u_fqa_0p6dcduDW0xhJGYJKzc6FfANB9KuOpjLB9ZPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] genirq/msi, platform-msi: Adjust return value of msi_domain_prepare_irqs()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Tue, May 30, 2023 at 11:03=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Tue, May 30 2023 at 16:34, Huacai Chen wrote:
> > On Tue, May 30, 2023 at 4:19=E2=80=AFAM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> Let's take a step back and look at the larger picture:
> >>
> >>  1) A PCI/MSI irqdomain is attached to a PCI bus
> >>
> >>  2) The number of PCI devices on that PCI bus is usually known at boot
> >>     time _before_ the first device driver is probed.
> >>
> >>     That's not entirely true for PCI hotplug devices, but that's hardl=
y
> >>     relevant for an architecture which got designed less than 10 years
> >>     ago and the architects decided that 256 MSI vectors are good enoug=
h
> >>     for up to 256 CPUs. The concept of per CPU queues was already know=
n
> >>     at that time, no?
> > Does this solution depend on the per-device msi domain? Can we do that
> > if we use the global msi domain?
>
> In principle it should not depend on per-device MSI domains, but I
> really don't want to add new functionality to the old operating models
> as that does not create an incentive for people to convert their stuff
> over.
Thank you for your advice, but for our scenario, its effect is no
better than this patch (because not all devices are aggressive
devices), so we give up. :)

And as Jason said in another thread, this problem can be solved by
simply reducing the number of queues by ethtool. So let's ignore this
patch since it is not acceptable.

Huacai
>
> >> So the irqdomain can tell the PCI/MSI core the maximum number of vecto=
rs
> >> available for a particular bus, right?
> >>
> >> The default, i.e if the irqdomain does not expose that information,
> >> would be "unlimited", i.e. ULONG_MAX.
> > OK, thanks, but how to expose? By msi_domain_info::hwsize?
>
> Probably. Needs a proper helper around it.
>
> Thanks,
>
>         tglx
