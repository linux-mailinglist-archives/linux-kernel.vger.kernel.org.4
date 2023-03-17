Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70036BF6A3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCQXt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCQXt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:49:27 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A981BBB88
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:49:26 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id t4so7397312ybg.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679096966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5fL6F3mPwoA7sLSKblKlhrnG1SyfjvzqQaa+DnqN6I=;
        b=jlzykgWGzVdf2uGbPxbEO5u0/e5FGFX0CaSijaUHBEXqOPlr2pWjeVpYiXVWeUOZUN
         Mfh68xsB9pk3pn3fhvIMjWCkK98hgS7t+3sIQx3KGJi5+cXX6sQNaL3qF3jcQJoNrfVd
         rxSxrh6md6PlO4IWVaJCx/xis1AnGGO5vNs2VG4O2vcbMGFniWU0SFYq7PM9ZOODaOI+
         fDZXXvav8cKIvKofGAzB1N45w4h0Upa4LAjJfmvG5OzWfNdEu17JA4SALVfN7oSZ/FsS
         AbEkFxFGCaQQudJdTdNZtxs4GLBJjZ4N6VYeX/dUj01vvqHinvmz8avGz6mk+k42JTpJ
         qtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679096966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5fL6F3mPwoA7sLSKblKlhrnG1SyfjvzqQaa+DnqN6I=;
        b=BG0R0vNHxDfeQQ/fhHK9/ubw5+Ya33IvG8m9ngeLNrC4BLmTRXThnMBgXXaCabvdnP
         xHavqyO1bt0KAX/j5OVgl+Zu8CtYrnGuK2jT6Sc2Cqg5FXEeAHmvWuMsrHvfkaQ5CPty
         9npct5t3oIeng0IaiG0Vm00NZiCIWzRgSa5xRJ2ePBT0kY7FkdrTSrAwnH1aYuc433JE
         Jid2TwzlVkCOoblXrc9+l3EJlOs/M07Tjju2S/YgSiri7X0YjTUZGsR+8Eme6hAGO+H3
         CvPuG/k0ZCnga5xPf+Mr82FhPOhqT8aHPsHVQuaCPO4qsnSiJ1aN7kEjN4qTJJExDWmn
         iN2A==
X-Gm-Message-State: AO0yUKW2eSXIonyp+3WwsbIU8a/qN5+7gnw1KxNZME0i9oJCRj+MXXNX
        575fXftj+t4R8YLpANCaA1JVkC2OmtSf189ymAo7uA==
X-Google-Smtp-Source: AK7set8Pz4tY+CCiW+ssZqKDXY9nva643d3YexIUkH3Vjz9KgB+OIFgOVsqyUGKWq2Caa6x2e+Rlfn6/Q1xCm7RzeUw=
X-Received: by 2002:a5b:70c:0:b0:b3f:f831:bfdd with SMTP id
 g12-20020a5b070c000000b00b3ff831bfddmr184229ybq.13.1679096965695; Fri, 17 Mar
 2023 16:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230211014626.3659152-1-vipinsh@google.com> <20230211014626.3659152-8-vipinsh@google.com>
 <ZBTu40/IYurmQi5N@google.com>
In-Reply-To: <ZBTu40/IYurmQi5N@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Fri, 17 Mar 2023 16:48:49 -0700
Message-ID: <CAHVum0fM3CLda98e-nBP6yPBLkRvBhUq=iZqZGCC_6jT08SM0Q@mail.gmail.com>
Subject: Re: [Patch v3 7/7] KVM: x86/mmu: Merge all handle_changed_pte* functions.
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, bgardon@google.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 3:51=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Feb 10, 2023, Vipin Sharma wrote:
> > @@ -1301,7 +1283,7 @@ bool kvm_tdp_mmu_set_spte_gfn(struct kvm *kvm, st=
ruct kvm_gfn_range *range)
> >       /*
> >        * No need to handle the remote TLB flush under RCU protection, t=
he
> >        * target SPTE _must_ be a leaf SPTE, i.e. cannot result in freei=
ng a
> > -      * shadow page.  See the WARN on pfn_changed in __handle_changed_=
spte().
> > +      * shadow page. See the WARN on pfn_changed in handle_changed_spt=
e().
>
> I was just starting to think you're an ok person, and then I find out you=
're a
> heretic that only puts a single space after periods.  ;-)

I know, I know, I can't help it. I just love the way single space
looks after periods.
