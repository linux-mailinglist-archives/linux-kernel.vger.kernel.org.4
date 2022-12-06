Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF56439A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiLEXlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiLEXk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:40:57 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6AB1F9D5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:40:56 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3b5d9050e48so135334157b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1XpPiuU4p7y2BHUr48owYWL2ZnOwViLqZpMqfBRHOM=;
        b=jbs4F9nAawTHiuAuWv1gntU3x8fAjjnYdjhi2fAiIYTPKcYUoNMUhGbbGDjX8SDEoy
         Mt3n3dT11GQODiSgIMwec7RTtMhegG+rSfoXR+AVrjtqX3BC9U9CSn4PM2+VHkLXv2Uz
         79smb4ccIDfrYGMUXnrlIRE9zl5oGQETsIKF8KpRlMV8kkuDDNjGjLgnRHG/0tiFrSYp
         yk8HjCBJupSjwV9JdoQM/xwYaA9h/2c5s/BRl7LToU5JpnZyZNunBvfwowXW/6xiGCkM
         0l+b87UmiQnEvy4EWS6Z0sxds3HEqsSy8lpwSd6Uhimxgt6axAH+uZmcl2lUBI5rUgXY
         vzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1XpPiuU4p7y2BHUr48owYWL2ZnOwViLqZpMqfBRHOM=;
        b=kXPVqTxZtPf4vjdyPkqALVzgeLBoO36YCCLHOIIv2HYJKNW9rQYLlDsXG/aZVl+/wB
         PCM/JqGYT7cJMbAmpeYxpsnIVm4k5Mj/k1BK4Mrmr+h+4zmNHDuZ8faAIFJwRKOVKTOu
         1R8z9vVaHRXEgLLNKUYc++N5VUMl8kH8ykwDvmniNNFugYk4qMnU8IEfjpwaxyz0CtwO
         dsL5xXlBu1chY8tWGKawGkrjb/aVaF3YkJOt4kEV8WZD6Ra0aDVRFPvbXT6/2tAto2lB
         Vp3c41lh2IfgVzlFXe0lCpzOn5jamnd569O9fuUscJw1FKH+oTp8vP8+JWjDCRQPmZih
         4CCA==
X-Gm-Message-State: ANoB5pl+TlWZQoDEsjrrjzIWL7au9rKs2jCrU3Yuw7xGxEn3VhXhTtHQ
        v1XqquimLZn5R6yxV9+zYRv08DcGPLDnFnN25AXv3A==
X-Google-Smtp-Source: AA0mqf5+yC3WJomDYsSgi1w4XGwJPXgKSzyopoHtr8lsMwHUg8TtjArIRYirkvIVXsv16kAqtS/Gcr0QTU2lR22NArw=
X-Received: by 2002:a05:690c:8:b0:391:c415:f872 with SMTP id
 bc8-20020a05690c000800b00391c415f872mr61617741ywb.318.1670283655905; Mon, 05
 Dec 2022 15:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20221201195718.1409782-1-vipinsh@google.com> <20221201195718.1409782-3-vipinsh@google.com>
 <CANgfPd9Khg2tMAfpj18R39cqzerFE6pu+4YUSrYr3KD5FG9zRA@mail.gmail.com>
In-Reply-To: <CANgfPd9Khg2tMAfpj18R39cqzerFE6pu+4YUSrYr3KD5FG9zRA@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 5 Dec 2022 15:40:19 -0800
Message-ID: <CAHVum0cf_AeJ8rZGcWdne=QV6f_+09b=7kJb3xd-9eNiZr75Qg@mail.gmail.com>
Subject: Re: [Patch v2 2/2] KVM: x86/mmu: Allocate page table pages on NUMA
 node of underlying pages
To:     Ben Gardon <bgardon@google.com>
Cc:     dmatlack@google.com, seanjc@google.com, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Dec 5, 2022 at 10:17 AM Ben Gardon <bgardon@google.com> wrote:
>
> On Thu, Dec 1, 2022 at 11:57 AM Vipin Sharma <vipinsh@google.com> wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 1782c4555d94..4d59c9d48277 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -384,6 +384,11 @@ static void kvm_flush_shadow_all(struct kvm *kvm)
> >         kvm_arch_guest_memory_reclaimed(kvm);
> >  }
> >
> > +void * __weak kvm_arch_mmu_get_free_page(int nid, gfp_t gfp_flags)
> > +{
> > +               return (void *)__get_free_page(gfp_flags);
> > +}
> > +
>
> Rather than making this __weak, you could use #ifdef CONFIG_NUMA to
> just put all the code in the arch-neutral function.
>

I am not sure how it will work. Here, I am trying to keep this feature
only for x86. This function will be used for all architecture except
in x86 where we have different implementation in arch/x86/mmu/mmu.c
So, even if CONFIG_NUMA is defined, we want to keep the same
definition on other architectures.





> >  #ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
> >  static inline void *mmu_memory_cache_alloc_obj(struct kvm_mmu_memory_cache *mc,
> >                                                gfp_t gfp_flags)
> > @@ -393,7 +398,7 @@ static inline void *mmu_memory_cache_alloc_obj(struct kvm_mmu_memory_cache *mc,
> >         if (mc->kmem_cache)
> >                 return kmem_cache_alloc(mc->kmem_cache, gfp_flags);
> >         else
> > -               return (void *)__get_free_page(gfp_flags);
> > +               return kvm_arch_mmu_get_free_page(mc->node, gfp_flags);
> >  }
> >
> >  int __kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int capacity, int min)
> > --
> > 2.39.0.rc0.267.gcb52ba06e7-goog
> >
