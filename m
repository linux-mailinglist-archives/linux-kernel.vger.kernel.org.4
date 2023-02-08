Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7539868F7FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjBHTZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBHTY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:24:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A635BA7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:24:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso3619590pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 11:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nFH9EbcbDU6VShApHck5rgBRp4h43n3I1a0V/XMrymg=;
        b=cFdTS+fxYQUFjHGd5/a07qXBmf47vi1Y8aqZUxUX1ocUjjtHF+qMNkrAbRjR3CurS9
         Wysl6/0UmlmRO9hmwCzgBGQJf0D+WarKLRV8ngePn8Sgls/PxPTGKMsUAYbwKuU9WuZy
         NenYI8OPB0Ekhjb8hIn/r/yxQtOcbRPzUocYKh36skH1N9jVxjXzTOd7qbnMEAskBeNe
         D554eZfikaAnAAr9udBeL0Z89M3lCU8Mz/x+6HI11a/6LMyPbEIS0oq530D8knVXFH5F
         JmfuctPtQiIM9BvNYQFLvX6TQISQ6J2B/1LiyrZWFc/KVnaLrGmNWPuEiCf0q02YvmUX
         aZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFH9EbcbDU6VShApHck5rgBRp4h43n3I1a0V/XMrymg=;
        b=YJREz1brxaBJd2RPmVWrZJE0XelF5IExxh90hch0yJJcqnq+kwqIzu4ocW9FgtMx/y
         12fSPORXMgM8ywF0bpJBpr8AnJalIkSUFsSSpnqWqxMU3/iJEGkgKOND4+D0oOlnRCA2
         3G6HtP7gCcSpuCD8BtPRKV/nHmO8M5HyHg+Et2A/6lh3luC4M7TY0VLZn9fM8cf8ObZq
         i7EBPgvNr3tM/XofKcv9XosEV2MPS1sLVn7rfCgbliTDq/XOm3A5l1k+rt4EW/dBCmeG
         VqjLatZxhauNZTpb0ME3mOa+63RMxAnEPMb6v8W/p6lPeN9sxKB++FqUv/KNekVit4ww
         e+YA==
X-Gm-Message-State: AO0yUKVeahn1h062XnFM3jpeKNl099AKBVDgesgnsKyuC3ix+si4s61V
        U8nuziGxJmp6ntvqd93IL3mvRW9EEutaFkqn8MU/sQ==
X-Google-Smtp-Source: AK7set9OCcDDAdFg90qjazeaLAgMFk7kQfWenK545jnfxARWYtHyqmWTlv1mXdao/5ynfJfNZSoWcI13ewlfZoTodp0=
X-Received: by 2002:a17:902:c412:b0:198:99b5:cabf with SMTP id
 k18-20020a170902c41200b0019899b5cabfmr1996775plk.25.1675884297591; Wed, 08
 Feb 2023 11:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20230124211455.2563674-1-dionnaglaze@google.com>
 <20230124211455.2563674-2-dionnaglaze@google.com> <Y9emVjoTBrM2+Y5P@zn.tnic> <e0d52194-d478-b33e-851b-d5067f4a7669@amd.com>
In-Reply-To: <e0d52194-d478-b33e-851b-d5067f4a7669@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 8 Feb 2023 11:24:46 -0800
Message-ID: <CAAH4kHbXKnWyO5hS19q74jDQjvAvj6rUw_Q06Of1+Fmng50-7Q@mail.gmail.com>
Subject: Re: [PATCH v13 1/4] virt/coco/sev-guest: Add throttling awareness
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
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

>
> >
> > In any case, I'd like for us to document it somewhere eventually if that
> > hasn't happened yet so that all parties are clear on what is supposed to
> > happen and what the protocol is.
> >

Hi y'all, checking in on this thread. Are we waiting for the new GHCB
spec to be published before merging this fix?

-- 
-Dionna Glaze, PhD (she/her)
