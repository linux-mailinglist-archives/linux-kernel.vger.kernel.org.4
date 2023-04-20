Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB36E9D00
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjDTUVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjDTUVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:21:31 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BFA1FC2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 13:21:30 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2476a718feeso1186929a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682022090; x=1684614090;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpTOoqFwr6PXx8ZhPhp2F5vKR6FTzxj9fbkenjMTw+I=;
        b=ayMsf68dO1AJVJrABTkUhl1NMkj9wzJIuYm23qPHqGOJfv8Tzmr/MMZxooBdbFWuv6
         cTmzvZGQL22AByne/8vqNIb7Ula7gng50G2+VKpqMx484CV6DQsedQ06XTaeu+DQM49b
         Xv9bZenL7yQF4ga4/MTIH59v2WCdxiBmdnXbayZvn5qNdcPSs6tpTkKYHX2oOZ/dvVZJ
         7iBN8GopMbKfBq0gxr0rs7bCE35mGMrwZMp+IWcuRhn8r0n6FUEqG0/jssdTgwXjPBGo
         QXUjX+PVWO6OKOdititLEBWM39bjy4BtfGL6XjtBawa9+EgUy4H8fBEsjKUgS+1l2k/k
         uAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022090; x=1684614090;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mpTOoqFwr6PXx8ZhPhp2F5vKR6FTzxj9fbkenjMTw+I=;
        b=MeOcmV2PIrCUr+LkDF9tBuDN2SYdlMekhcTgNemJOERaO0Ezmy0GfV71TFgUaNW5aW
         YsGBLgXvBxsQeymVd/XaeXD5GzeXRwQ0WPfBXBVa6kuN0INMpODBfgLSMbEMFvob7D35
         GEvh1IV3UTKZaf2pSQe5YPVF1pd6ly25NR4aigBrtpsPA+T9NC1ZGPgmxlAlHXhIJrJu
         vHailQl+HMtE1kVD6nMhCQUXWgFgUxX21JAkC8vHvgXgwttoaKaQ28FYJdFGpPDqbM6v
         7tLYKj+fBsjVHJtLGumWKguVJQHl1QPD1qhq1dnCfrl8p8gfqihXMkaiUzmncRBja03Y
         ls+Q==
X-Gm-Message-State: AAQBX9dsvC8DI4U0Jb9ThYeq2hQqQ7OJw67K8GbDO3j8FldL31Jp0w5c
        zt3OCUclcwbAeGmyXynn+AxaqL4SKag=
X-Google-Smtp-Source: AKy350bOw0CcGSD5HxBsCHP7eQv+pVq4+ffvtFW6Bs0RrLmmQY0i686r1Bx3KLV/2OwqstA5HB5kaL3ma/k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:470b:b0:247:e66:1d90 with SMTP id
 h11-20020a17090a470b00b002470e661d90mr728232pjg.6.1682022090286; Thu, 20 Apr
 2023 13:21:30 -0700 (PDT)
Date:   Thu, 20 Apr 2023 13:21:28 -0700
In-Reply-To: <CAHBxVyE+SkQ-jpbupmJU4fpuiXY_GufnANDBUuO5bMHDsudeYg@mail.gmail.com>
Mime-Version: 1.0
References: <20230419221716.3603068-1-atishp@rivosinc.com> <ZEFopfs5Ij/AIkee@google.com>
 <CAHBxVyE+SkQ-jpbupmJU4fpuiXY_GufnANDBUuO5bMHDsudeYg@mail.gmail.com>
Message-ID: <ZEGeyLYCIj75Hmwa@google.com>
Subject: Re: [RFC 00/48] RISC-V CoVE support
From:   Sean Christopherson <seanjc@google.com>
To:     Atish Kumar Patra <atishp@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        "=?iso-8859-1?Q?Bj=F6rn_T=F6pel?=" <bjorn@rivosinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-coco@lists.linux.dev, Dylan Reid <dylan@rivosinc.com>,
        abrestic@rivosinc.com, Samuel Ortiz <sameo@rivosinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023, Atish Kumar Patra wrote:
> On Thu, Apr 20, 2023 at 10:00=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Wed, Apr 19, 2023, Atish Patra wrote:
> > > 2. Lazy gstage page allocation vs upfront allocation with page pool.
> > > Currently, all gstage mappings happen at runtime during the fault. Th=
is is expensive
> > > as we need to convert that page to confidential memory as well. A pag=
e pool framework
> > > may be a better choice which can hold all the confidential pages whic=
h can be
> > > pre-allocated upfront. A generic page pool infrastructure may benefit=
 other CC solutions ?
> >
> > I'm sorry, what?  Do y'all really not pay any attention to what is happ=
ening
> > outside of the RISC-V world?
> >
> > We, where "we" is KVM x86 and ARM, with folks contributing from 5+ comp=
anines,
> > have been working on this problem for going on three *years*.  And that=
's just
> > from the first public posting[1], there have been discussions about how=
 to approach
> > this for even longer.  There have been multiple related presentations a=
t KVM Forum,
> > something like 4 or 5 just at KVM Forum 2022 alone.
> >
>=20
> I did mention about that in the 1st item in the TODO list.

My apologies, I completely missed the todo list.

> Thanks for your suggestion. It seems we should just directly move to
> restrictedmem asap.

Yes please, for the sake of everyone involved.  It will likely save you fro=
m
running into the same pitfalls that x86 and ARM already encountered, and th=
e more
eyeballs and use cases on whatever restrictemem ends up being called, the b=
etter.

Thanks!
