Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F065CD16
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjADG3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjADG3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:29:35 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEB8E8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 22:29:35 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4a0d6cb12c5so136468437b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 22:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fD1BF6eIpLn1kMLVXqapgTeTtZOdXnJgD4XqrBopXjo=;
        b=cIjB1NS641tIaXXEglM5aOOqZgFlDhgVu0gk8E5lbgIuidrIyai+fVZIIVhqVd9q5G
         x8plZvmzJtjZ9SvJwNpYYCH8m+pv8KzyEYXNycfAdc2BgvqgdCCDKwiBOvjL9/GqaBhL
         qQNZ8UtCMGCym7tp2Tt8na4a/56UdmyMkbJaqt6XQb8Cyci9Z2KC56OJ2eOhmCMkogBp
         9kcsOpruuNkGVV4fl06F8JoIg/WU+qwLbXiXac3NIx/lfRYPPMj3nFzH2VbArStFV3f0
         0CoaoaGwNimHZR1HLwzDT1gRjnXe8ps4kqeafOkGEJbBxgwm2L0QpUwPKhCTW4js9KFy
         YXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fD1BF6eIpLn1kMLVXqapgTeTtZOdXnJgD4XqrBopXjo=;
        b=v4MMAAFcQ4CR113OLk90SeWt/FSTGQD8NWn0/MkGeUpLVbahEYOqAjyR6N51pkLIgh
         dpHeFiWPP78FoihIGWHMPeyFlEIv5JbTvbrBmAhVzlN+M6alzLBBRbEzssC7qjiwpv+A
         +n04Fk1YGXxQTLuud9Gy6ra8FJCJs6+gu5SiA4puxVk+cYmBFukeANfBOIGeVjDmDXSi
         Og2FJK9GxruOT1njrwiB5bbw1JmaSuedtEo1coh0XFYJ0crW3Ig4oEiIa3qUefoZiAo9
         U6YhaW7b7RXEnfw5OP24Wc+dgWMWs8I74FsE+8jkG8Rb8W/aid3ZvF5CyTU8PRsMiV4j
         kIMA==
X-Gm-Message-State: AFqh2ko3//CmHwp6v4hl8sy9tH6w2MPuthqhldYiozg0B6hyapUfRHUJ
        dH0P0UvVlPhomRhqKrg2bjuthO6muTb1Arg46RpU7A==
X-Google-Smtp-Source: AMrXdXsshjPER6eCEYkbzv/OIgalg7Opl3RnfQ782yTQM+fbCSqEifVm7EhxLfagjfcb8EUt/PiNIOVbDKvJTm9JgBw=
X-Received: by 2002:a81:1913:0:b0:4b3:302b:ee94 with SMTP id
 19-20020a811913000000b004b3302bee94mr394601ywz.144.1672813774126; Tue, 03 Jan
 2023 22:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20221222023457.1764-1-vipinsh@google.com> <20221222023457.1764-2-vipinsh@google.com>
 <CAL715WKT_WbaUHT++tvnKr9fhGObiJpyKdD-zMmmcZnt4Bc=Gg@mail.gmail.com> <CAHVum0f9kxHBBR8mBQrA3FrNHvPvqkGE8qXxKJhrnKoE6XkySg@mail.gmail.com>
In-Reply-To: <CAHVum0f9kxHBBR8mBQrA3FrNHvPvqkGE8qXxKJhrnKoE6XkySg@mail.gmail.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 3 Jan 2023 22:29:22 -0800
Message-ID: <CAL715W+UjRqqs4aJHoGDf+1c1OMHp8LhhSNgtjkGD5TbFVW_ng@mail.gmail.com>
Subject: Re: [Patch v3 1/9] KVM: x86/mmu: Repurpose KVM MMU shrinker to purge
 shadow page caches
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 5:00 PM Vipin Sharma <vipinsh@google.com> wrote:
>
> On Tue, Jan 3, 2023 at 11:32 AM Mingwei Zhang <mizhang@google.com> wrote:
> >
> > On Wed, Dec 21, 2022 at 6:35 PM Vipin Sharma <vipinsh@google.com> wrote:
> > >
> > > +static void mmu_free_sp_memory_cache(struct kvm_mmu_memory_cache *cache,
> > > +                                    spinlock_t *cache_lock)
> > > +{
> > > +       int orig_nobjs;
> > > +
> > > +       spin_lock(cache_lock);
> > > +       orig_nobjs = cache->nobjs;
> > > +       kvm_mmu_free_memory_cache(cache);
> > > +       if (orig_nobjs)
> > > +               percpu_counter_sub(&kvm_total_unused_mmu_pages, orig_nobjs);
> > > +
> > > +       spin_unlock(cache_lock);
> > > +}
> >
> > I think the mmu_cache allocation and deallocation may cause the usage
> > of GFP_ATOMIC (as observed by other reviewers as well). Adding a new
> > lock would definitely sound like a plan, but I think it might affect
> > the performance. Alternatively, I am wondering if we could use a
> > mmu_cache_sequence similar to mmu_notifier_seq to help avoid the
> > concurrency?
> >
>
> Can you explain more about the performance impact? Each vcpu will have
> its own mutex. So, only contention will be with the mmu_shrinker. This
> shrinker will use mutex_try_lock() which will not block to wait for
> the lock, it will just pass on to the next vcpu. While shrinker is
> holding the lock, vcpu will be blocked in the page fault path but I
> think it should not have a huge impact considering it will execute
> rarely and for a small time.
>
> > Similar to mmu_notifier_seq, mmu_cache_sequence should be protected by
> > mmu write lock. In the page fault path, each vcpu has to collect a
> > snapshot of  mmu_cache_sequence before calling into
> > mmu_topup_memory_caches() and check the value again when holding the
> > mmu lock. If the value is different, that means the mmu_shrinker has
> > removed the cache objects and because of that, the vcpu should retry.
> >
>
> Yeah, this can be one approach. I think it will come down to the
> performance impact of using mutex which I don't think should be a
> concern.

hmm, I think you are right that there is no performance overhead by
adding a mutex and letting the shrinker using mutex_trylock(). The
point of using a sequence counter is to avoid the new lock, since
introducing a new lock will increase management burden. So unless it
is necessary, we probably should choose a simple solution first.

In this case, I think we do have such a choice and since a similar
mechanism has already been used by mmu_notifiers.

best
-Mingwei
