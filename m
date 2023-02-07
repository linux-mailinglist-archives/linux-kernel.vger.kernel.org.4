Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A33A68DF3B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjBGRrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjBGRri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:47:38 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E42ACA2D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:47:37 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id v81so8268496vkv.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CY914VzVqB+fSxy9WxpWVLUSp1jcG757pUUHGil8Hd4=;
        b=IsvcsNAUCrPf1/y8inlkYZ/NYs/FAlUp3maKwLZlTe6T5Khs/Ziyc/yV0OepHvm4zx
         lPOZR4HJ4M9VvtqMmHpwabLUvbfVT8m6jeR++Yy6PQJSZQLp8f+UVF0SwvU60JCN4mSJ
         nbTT4rDe7UfV1P13VpovcPEuqUaJw9UOvc/XOVdzsZIU5yXkEmP4Zsi1/jHEV1sAkn6P
         BdJyaZ4v3zR7C1+vESwoOtsIpki427+BLRa1336tF9T0NtK65T9w7wsOrC0N5qRXxvHa
         8H4SpWWktU2HmcEfoNDgp+8G+C/Z1unzafh/nx4n1dRcfxe0i2JEUnrfMTVct12kCaAa
         OnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CY914VzVqB+fSxy9WxpWVLUSp1jcG757pUUHGil8Hd4=;
        b=COoQNaRwMogdZuWeLcvE8dI1e7IJ0Ag5tw5XsIBecXrMsYW6IOfwIOTuakeE6kVJ7q
         MqxZN8/W4t25BSjmXMUaiyEspA77JPqgN6pX+iRyHxr3cZ080avesbVmhm9CBj6f2ER6
         MtvXuDfdQNnihZ9B0g2SAiEfb1jFSmnYsryT8scmlUC4tkKxNMcco/vbrCsOqJ5bVkEp
         4tayG9Ac8c1Ost/efT1EWWB6AEjLAqT+yCogWvZu76t0oITw44EM1bqAmc4IxmWA8+0R
         UiVk3ly7jWvPnD/AtXV3Lr0VwL75jHAFy8xyiIIa499d2HHsXy3GomafiGp3bJzaOtBt
         7FcA==
X-Gm-Message-State: AO0yUKUvQ1NTsrK59egb2ObE09BTnCApjmainkGLp/9CT07zqrSSYgvp
        xpCRINrt/FT9hFjFN6uuAS/2Hy1kxG7bs+kNGcxVdg==
X-Google-Smtp-Source: AK7set+u0N05uEmq9E0SdpeF7zfcRTdc9ZgNfmWmpVqNDjLNTyVbkbxMQmMxL3400jLioHuy0QDn5LJEdPsTuSCzdr8=
X-Received: by 2002:a1f:b60f:0:b0:3dd:fce2:8505 with SMTP id
 g15-20020a1fb60f000000b003ddfce28505mr574476vkf.40.1675792056062; Tue, 07 Feb
 2023 09:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20230203192822.106773-1-vipinsh@google.com> <20230203192822.106773-3-vipinsh@google.com>
 <Y+GQNXDlNbJNvDd2@google.com> <CAHVum0d2dRvNaS+AMqdbF35D05dDQrtZ4TBQ1QOYx6he-Cy6YA@mail.gmail.com>
In-Reply-To: <CAHVum0d2dRvNaS+AMqdbF35D05dDQrtZ4TBQ1QOYx6he-Cy6YA@mail.gmail.com>
From:   David Matlack <dmatlack@google.com>
Date:   Tue, 7 Feb 2023 09:47:09 -0800
Message-ID: <CALzav=dw8hzbfOtWFo+tb6aKavrdfjrbuJ-o0_F39o=53u95MQ@mail.gmail.com>
Subject: Re: [Patch v2 2/5] KVM: x86/mmu: Optimize SPTE change flow for clear-dirty-log
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Feb 7, 2023 at 9:37 AM Vipin Sharma <vipinsh@google.com> wrote:
>
> On Mon, Feb 6, 2023 at 3:41 PM David Matlack <dmatlack@google.com> wrote:
> >
> > On Fri, Feb 03, 2023 at 11:28:19AM -0800, Vipin Sharma wrote:
> >
> >         if (wrprot || spte_ad_need_write_protect(iter.old_spte))
> >                 clear_bits = PT_WRITABLE_MASK;
> >         else
> >                 clear_bits = shadow_dirty_mask;
> >
> >         if (!(iter->old_spte & clear_bits))
> >                 continue;
> >
> >         iter.old_spte = kvm_tdp_mmu_clear_spte_bit(&iter, clear_bits);
> >
>
> Yeah, this is better. Even better if I just initialize like:
>
> u64 clear_bits = shadow_dirty_mask;
>
> This will also get rid of the else part.

On that topic... Do we need to recalculate clear_bits for every spte?
wrprot is passed as a parameter so that will not change. And
spte_ad_need_write_protect() should either return true or false for
all SPTEs in the TDP MMU. Specifically, make_spte() has this code:

if (sp->role.ad_disabled)
        spte |= SPTE_TDP_AD_DISABLED_MASK;
else if (kvm_mmu_page_ad_need_write_protect(sp))
        spte |= SPTE_TDP_AD_WRPROT_ONLY_MASK;

sp->role.ad_disabled is never modified in TDP MMU pages. So it should
be constant for all pages. And kvm_mmu_page_ad_need_write_protect()
will always return false for TDP MMU pages since sp->role.guest_mode
is always false.

So this can just be:

u64 clear_bit = (wrprot || !kvm_ad_enabled()) ? PT_WRITABLE_MASK :
shadow_dirty_mask;
