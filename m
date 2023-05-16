Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA25705666
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjEPSzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjEPSzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:55:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E9E7694
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:55:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a950b982d4so1145ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684263310; x=1686855310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fHu8DghP/3luSr7ps7cBkVA14o+LEPwp4DzxgOICm0=;
        b=PQra5aLAKweWx6sxQ9LQKGxtQmMSj6L3InB131yJxQf9Qao0ZYno8VO7BoSCiP+hdT
         l1JHvbFQfKzn4+oePfkBF5L6SHIEd2pD1WAsZLGpLifK3ziVki/otrV/jYMXudwdsyXG
         mjw8fONH/DYIIydqN6AbnSzJ5bLD6PQh/DY5n3ZcG8pxEVYxR70fOXEXbrHJH+bkII/T
         cYts/4bA3vmTnu9ahsSkZ7sW+0fX/zwd3gEs9HVogW2LDzfDFXPH3CulOb5LA/IpS649
         tr1TdcmqDIfT7AEzx8mjlqv7Xa987pLc8wn/TRh93b3F+S3G7sDRM5rsErUXTuLu9uyx
         HHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263310; x=1686855310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fHu8DghP/3luSr7ps7cBkVA14o+LEPwp4DzxgOICm0=;
        b=XYY9+SrFpePK3lhorWCANZtrJzYz5Qb/BGtMf+aDYYGuj4k5jc6vO6rKkebmEGzdSt
         C0UnWtAR9v5pOszcSjXonbUq5n0NmRps6L98XYOC9hxdLEdzrGn+/m6NbYWQd7vMnnLZ
         JVZtpzj2U6E15g5cdBHyOff9zeIyl6qhOOq8ht4aM45hFiD8Vgd3SyHLzttxyqt43Ymf
         zJGbSe7DNHhj1Lwtb9Q81JJXB9pM+6fwF/id72Fc7OhHl4+skn0b0M8ztyMTQ6NFAYL2
         hIRKkxjttCP9O+XaOz5v7WrJKpIpjfEwARkFXKKJ9ed1evFsMVNl3RPrHsmPfDAdKPl0
         zXPw==
X-Gm-Message-State: AC+VfDyCGZTR/cpdWB89w16NX6orwbaRvtJZK3mQmvGirqi55lmauOYV
        Qe+x57McBCpseZ3O7ANoAxgG/zQl49YsaKPE67ZVAw==
X-Google-Smtp-Source: ACHHUZ7tZ09F/p3tKg+e7V/wH7ylAcrEIIFRoV+uNHj0vk7rLne7WYSwiuVG8QKXQ1XXx7qqfBebFzGe81h5v2o/EMM=
X-Received: by 2002:a17:902:dac6:b0:1ac:2daf:34da with SMTP id
 q6-20020a170902dac600b001ac2daf34damr3858plx.17.1684263307150; Tue, 16 May
 2023 11:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230414172922.812640-1-rananta@google.com> <20230414172922.812640-8-rananta@google.com>
 <ZF5xLrr2tEYdLL1i@linux.dev> <CAJHc60wUu3xB4J8oJ+FCxerDad1TzZLCMgHYGFfv0K-hzC0qmw@mail.gmail.com>
 <ZGPPj1AXS0Uah2Ug@linux.dev>
In-Reply-To: <ZGPPj1AXS0Uah2Ug@linux.dev>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Tue, 16 May 2023 11:54:55 -0700
Message-ID: <CAJHc60wF19h9ixEQK5SS+oGA41xNqrFQaH9VE6sS0DXjQFCh7A@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] KVM: arm64: Use TLBI range-based intructions for unmap
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ricardo Koller <ricarkol@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 11:46=E2=80=AFAM Oliver Upton <oliver.upton@linux.d=
ev> wrote:
>
> On Tue, May 16, 2023 at 10:21:33AM -0700, Raghavendra Rao Ananta wrote:
> > On Fri, May 12, 2023 at 10:02=E2=80=AFAM Oliver Upton <oliver.upton@lin=
ux.dev> wrote:
> > > >  int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u6=
4 size)
> > > >  {
> > > > +     int ret;
> > > > +     struct stage2_unmap_data unmap_data =3D {
> > > > +             .pgt =3D pgt,
> > > > +             /*
> > > > +              * If FEAT_TLBIRANGE is implemented, defer the indivi=
dial PTE
> > > > +              * TLB invalidations until the entire walk is finishe=
d, and
> > > > +              * then use the range-based TLBI instructions to do t=
he
> > > > +              * invalidations. Condition this upon S2FWB in order =
to avoid
> > > > +              * a page-table walk again to perform the CMOs after =
TLBI.
> > > > +              */
> > > > +             .skip_pte_tlbis =3D system_supports_tlb_range() &&
> > > > +                                     stage2_has_fwb(pgt),
> > >
> > > Why can't the underlying walker just call these two helpers directly?
> > > There are static keys behind these...
> > >
> > I wasn't aware of that. Although, I tried to look into the
> > definitions, but couldn't understand how static keys are at play here.
> > By any chance are you referring to the alternative_has_feature_*()
> > implementations when checking for cpu capabilities?
>
> Ah, right, these were recently changed to rely on alternative patching
> in commit 21fb26bfb01f ("arm64: alternatives: add alternative_has_feature=
_*()").
> Even still, the significance remains as the alternative patching
> completely eliminates a conditional branch on the presence of a
> particular feature.
>
> Initializing a local with the presence/absence of a feature defeats such
> an optimization.
>
Thanks for the info! Introduction of stage2_unmap_defer_tlb_flush()
(in patch-7/7) would call these functions as needed and get rid of
'skip_pte_tlbis'.

- Raghavendra
> --
> Thanks,
> Oliver
