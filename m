Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED51963CB16
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiK2Wfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiK2Wf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:35:28 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB63FBAE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:35:28 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id h15so2206050ilh.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u1YDot3GGBmRjZM+GL6Pr3WbiG8l/Ggk2Feit5hvBvQ=;
        b=EYMId/XRHnbF/7tIi9pNzFyluy7UttGzgnvzL1yBFaqKA1LJhPcAd8fXr0RthfcDkd
         93nOanJ40PiPYO7p91qJXh8yGj8cxlQTfFYLurZQb3n5Jy/aTWFdXiLY0C/gifkyQXoj
         IJomHVQN+cO2PMjuP6maMINxtBJZP8+i8k1/roJqrqMWuqpUbpZdnkwp64MKMVw3IiFj
         Fv7CtTGnvKcRNcIt2Ka/6sAF9ftUkWyAWHDWgs0ywsOmZsHqHJ54LvbAiohoPfUY5Yq+
         /fUUvVEStPg5Pg6kX0HbCwzP2ccIoPHkW/Eq2vULpbU6xoE3IvKQRtQBv1j3AOzau+mb
         tgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1YDot3GGBmRjZM+GL6Pr3WbiG8l/Ggk2Feit5hvBvQ=;
        b=LeA+5OPc59WvzIJcaiMWmQtgaeKkk137BLum3q6QldfEx2I4kNJXZI7dvjFDuJS3Q+
         Q8emsB5AovRZJr3GGm/5vq5wSGHnzNchQCvzQ0936dYoyP2U97Vnod98uooTSXCeq1TR
         wd6VCeWHsFjFnVD13hRiYOsLeoFA53IWFnAUlwMriNEGp39HfCZdktvtFN/5nyjVCJWw
         KfWbgxuahsUQ335VoaMR5GrVy78/n5FMOWVe6ZmpztM1dojWbNBNLSedVHhTLVpCLxEN
         g3gnn6LJkbe6BY9TjO03eXS25rwDRs4bBz/yxOkK9ZavUNVuSbK1vdncHYJ218/t1nxI
         aC0A==
X-Gm-Message-State: ANoB5pkh+lHCtEG10WLb7zVcDsJNGqBhnJQK1cjJIlPJfz2iB0mjZzm4
        JotB0zbTviqAdf0JbOlc7SVXYq8pC9y+i4LF9l5Qbg==
X-Google-Smtp-Source: AA0mqf7wFQsqZEr63POwH6S8Dpw3iGeiljBDSWn9sDclQ+vHY/rYe+tr86b5rd1/fj/+ds0Xz2SlrdaX09yxNaP62BI=
X-Received: by 2002:a92:6809:0:b0:2f9:4d92:5b2a with SMTP id
 d9-20020a926809000000b002f94d925b2amr17965499ilc.177.1669761327293; Tue, 29
 Nov 2022 14:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20221129191839.2471308-1-jannh@google.com> <20221129191839.2471308-2-jannh@google.com>
 <87fse1v4rf.ffs@tglx> <CAG48ez3UBb3Aq7+AFSmRj5a9czmew5b0PEdhWQ9qvQdeejnJZg@mail.gmail.com>
In-Reply-To: <CAG48ez3UBb3Aq7+AFSmRj5a9czmew5b0PEdhWQ9qvQdeejnJZg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Nov 2022 23:34:51 +0100
Message-ID: <CAG48ez2AqgQJKXYdLXh-WaoMuKBgCUuVge_8RAghKBDhfkeJJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] time/namespace: Forbid timens page faults under kthread_use_mm()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
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

On Tue, Nov 29, 2022 at 11:28 PM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Nov 29, 2022 at 10:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, Nov 29 2022 at 20:18, Jann Horn wrote:
> >
> > > find_timens_vvar_page() doesn't work when current's timens does not match
> > > the timens associated with current->mm.
> > > v6 of the series adding this code [1] had some complicated code to deal
> > > with this case, but v7 [2] removed that.
> > >
> > > Since the vvar region is designed to only be accessed by vDSO code, and
> > > vDSO code can't run in kthread context, it should be fine to error out in
> > > this case.
> >
> > Should? Either it is correct or not.
> >
> > But the way more interesting question is:
> >
> > >  struct page *find_timens_vvar_page(struct vm_area_struct *vma)
> > >  {
> > > +     /*
> > > +      * We can't handle faults where current's timens does not match the
> > > +      * timens associated with the mm_struct. This can happen if a page fault
> > > +      * occurs in a kthread that is using kthread_use_mm().
> > > +      */
> >
> > How does a kthread, which obvioulsy did kthread_use_mm(), end up trying to
> > fault in the time namespace vvar page?
>
> By doing copy_from_user()? That's what kthread_use_mm() is for, right?
> If you look through the users of kthread_use_mm(), most of them use it
> to be able to use the normal usercopy functions. See the users in usb
> gadget code, and the VFIO code, and the AMD GPU code. And if you're
> doing usercopy on userspace addresses, then you can basically always
> hit a vvar page - even if you had somehow checked beforehand what the
> address points to, userspace could have moved a vvar region in that
> spot in the meantime.
>
> That said, I haven't actually tried it. But I don't think there's
> anything in the page fault handling path that distinguishes between
> copy_from_user() faults in kthread context and other userspace faults
> in a relevant way?

Ah, but I guess even if this can happen, it's not actually as bad as I
thought, since kthreads are in init_time_ns, and init_time_ns doesn't
have a ->vvar_page, so this isn't going to lead to anything terrible
like page UAF, and it's just a garbage-in-garbage-out scenario.
