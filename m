Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF9468DF2B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjBGRmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjBGRm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:42:29 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C6F39CD4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:42:27 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-52770ee8cf0so128569587b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vYS0rH2Prb4CNt5r3A6oJS0gr0A7wGBLNFVaC7bs/J4=;
        b=I0IPiTWDtkwAHRjmJmB5BurzNbE3T687O4fja4LkxOF2M/HCzKujwysFi0Wji9Cbcv
         I4Z26Nm5pJfVR9FXpyY9X4PhGXRHpC3csevLVyfUOGk8WF258uYW9fdbW+CCR9yGWOUp
         FSqFXbsDkBiNgV1b0KgW4AprYfSwTp97GY5JpcppZIM+JD3MR6cm/wjWPrWcMnIUWu5f
         O29SYOQ1ozCsHg8Z3phNZ4G7MPnyQFazfsryTjkJwxlo3guQPKuGRi2FGLhA7MLIhfJd
         zKsDvhntNXhBNHkuQsOyAPf22CJDce8H3odLPH5L1tHlTyZpEnPKF5IKUSnpt66pKHSl
         v+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYS0rH2Prb4CNt5r3A6oJS0gr0A7wGBLNFVaC7bs/J4=;
        b=YcpoRCwiDOxz+DOKk0+ZEOe1ebYaXgyL2YSOuVuZPBEQRBfbPFCcvSI7PyaPghGJUB
         cXZI803gMRW1PtkyZhehEbpHnOJfzUs0DzUGcVI48ywvaNALSZnobbBjEImP3mlGywQ0
         loxpGpA3RNPmsVNDmuPY7FB7apxTOT8Ss84riUi6nknlaRThdnevolBx7vvNGSRzYBT4
         YijQRIFl6ncz28GgA7pW2WVj8KHr7vlD/vxzOplc3VHVbIZneoGkKiGw4aWJek3xtEVv
         sjW6QDjsomC9wPImjV0n541y6ACWLL0YY58DYlCl5E5UUAyHxnJxlgwoteE0jaWnzJ8i
         1uZQ==
X-Gm-Message-State: AO0yUKWhFm5PzZL8HtqeiUjOQdZzOMqSitJuTmr6+va9lCtyWzRRNlj1
        tB5MgqHZpBfLrY8cNgdXb6l7P7cbUJuJeTIKXIZ2YQ==
X-Google-Smtp-Source: AK7set8fj/mR29ZWsQ8S7g0deW2NvMZv95xKmBDFaq1RaHMUnPOOtdQtCn7Lnx/cUsmTHjAuynjca9DCOnlObL+O/nw=
X-Received: by 2002:a81:8004:0:b0:4b0:84a1:3a9d with SMTP id
 q4-20020a818004000000b004b084a13a9dmr487970ywf.66.1675791746607; Tue, 07 Feb
 2023 09:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20230203192822.106773-1-vipinsh@google.com> <20230203192822.106773-3-vipinsh@google.com>
 <CALzav=d9h-fVgdsK138m74a_qTyay9cprcbdWAJk4GJtw4p6tg@mail.gmail.com>
In-Reply-To: <CALzav=d9h-fVgdsK138m74a_qTyay9cprcbdWAJk4GJtw4p6tg@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 7 Feb 2023 09:41:50 -0800
Message-ID: <CAHVum0ffSwm62Tv9=HbQbMy42iq9Z4skMp1FxTVTothVmTgM5w@mail.gmail.com>
Subject: Re: [Patch v2 2/5] KVM: x86/mmu: Optimize SPTE change flow for clear-dirty-log
To:     David Matlack <dmatlack@google.com>
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

On Mon, Feb 6, 2023 at 3:53 PM David Matlack <dmatlack@google.com> wrote:
>
> On Fri, Feb 3, 2023 at 11:28 AM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
> > index 30a52e5e68de..21046b34f94e 100644
> > --- a/arch/x86/kvm/mmu/tdp_iter.h
> > +++ b/arch/x86/kvm/mmu/tdp_iter.h
> > @@ -121,4 +121,17 @@ void tdp_iter_start(struct tdp_iter *iter, struct kvm_mmu_page *root,
> >  void tdp_iter_next(struct tdp_iter *iter);
> >  void tdp_iter_restart(struct tdp_iter *iter);
> >
> > +static inline u64 kvm_tdp_mmu_clear_spte_bit(struct tdp_iter *iter, u64 mask)
> > +{
> > +       atomic64_t *sptep;
> > +
> > +       if (kvm_tdp_mmu_spte_has_volatile_bits(iter->old_spte, iter->level)) {
> > +               sptep = (atomic64_t *)rcu_dereference(iter->sptep);
> > +               return (u64)atomic64_fetch_and(~mask, sptep);
>
> I think you can just set iter->old_spte here and drop the return value?
>

I can do this. However, my intention was to keep the return contract
similar to kvm_tdp_mmu_write_spte(). On second thought, should I make
this function signature similar to kvm_tdp_mmu_write_spte() just to be
consistent?



> > +       }
> > +
> > +       __kvm_tdp_mmu_write_spte(iter->sptep, iter->old_spte & ~mask);
> > +       return iter->old_spte;
> > +}
