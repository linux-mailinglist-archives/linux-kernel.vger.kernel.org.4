Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9766A1C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjAMSRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjAMSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:15:55 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D3010E7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:07:04 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4b6255ce5baso295248817b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qoxr5X5imkz2olyJUzF1rhC2GFm22yRwb2J/WfLDgXQ=;
        b=dpxojtaZxe37je5lIn27UJw3451J9nTITh/73Iz7YPdEwivuYKLF+mEsM4TPJordCx
         tOK6i53c6fxIEjCBN4osHXTal+EL8RJ4weGrEjHrGUgzIl6AREQAc6U4iFTNU3+bsei7
         6WZcxhcmbCNrg/fGvcMuje4hfNbWEbtY4x1UnpXbSYuZcEZrAbMkS00736iqJbdgXsYc
         MASpAof7wBsOjMKaeyzUTLKkqGlwKc/IIUfeKXiflNewBpGEHg/HZqhyChic8FNa34l1
         wTQY6ezJ2la+PL0kJNHw/+bsAWL84qKZPUoQPZFqxZgk443sxu1O0HeFg8ImFTrlurLM
         DXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoxr5X5imkz2olyJUzF1rhC2GFm22yRwb2J/WfLDgXQ=;
        b=QutWR2Soc4LrgAwe12SSW6AYnxlO/le46T0pqJKgSurNMdxEHbvs41sj4uutRyEoTw
         GFqaVXTj0tNphkzGUwWTx8pZR4LuIiem61vPyfUjLqdkc2Q+M48IozZ1tOrpqN6Y8Ev9
         JHIYwMcK2lDGsOn1jNO1WKPKtlWVxbA9VboH0h7VEn+0glQda5epGvVG7b0pxJLDRFzE
         0lqlA4CJlujQXRbx0VAU90J7H1xBGWDpmOIh1zJ3jUwm4PHcIwxBbzVsfn5bsN7069Kf
         cVHjoNOYXe4EBtg+u4okaDoCObRoHBIRwk116nn386SpADXg+gzRZqu5G6+4ijFPAHNW
         HFSA==
X-Gm-Message-State: AFqh2kr1ruuJZ+ep5B9KnEtxw74AomhG9X1XTkbgnVFjaHpvxU/+Xn9f
        8ksQf4g4TJWnhe2fnYQwIXPLzx9ScW2rrIiV9pRnkg==
X-Google-Smtp-Source: AMrXdXum2Aq9jKTZUMljeuJMdEobnuyptEBNDCpABh7ohWzPstzMjndzTJDzVcRD+Cv6ug9+n/QrfiUUmFF1+xaHyKs=
X-Received: by 2002:a0d:d9c5:0:b0:4de:4c70:5504 with SMTP id
 b188-20020a0dd9c5000000b004de4c705504mr368547ywe.318.1673633223864; Fri, 13
 Jan 2023 10:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20221221222418.3307832-1-bgardon@google.com> <20221221222418.3307832-4-bgardon@google.com>
 <CANgfPd9d=rDxS2BeMRfXt1co1hPFJbDtF7vMe1r-XpTpOsYhNA@mail.gmail.com>
In-Reply-To: <CANgfPd9d=rDxS2BeMRfXt1co1hPFJbDtF7vMe1r-XpTpOsYhNA@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Fri, 13 Jan 2023 10:06:27 -0800
Message-ID: <CAHVum0dK+hoYWFguBns_ryg=te__WZbDh=2BkW6dt853RxTCYA@mail.gmail.com>
Subject: Re: [RFC 03/14] KVM: x86/MMU: Move the Shadow MMU implementation to shadow_mmu.c
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Nagareddy Reddy <nspreddy@google.com>
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

On Wed, Dec 21, 2022 at 2:40 PM Ben Gardon <bgardon@google.com> wrote:
>
> On Wed, Dec 21, 2022 at 2:24 PM Ben Gardon <bgardon@google.com> wrote:
> >
> > Cut and paste the implementation of the Shadow MMU to shadow_mmu.(c|h).
> > This is a monsterously large commit, moving ~3500 lines. With such a
> > large move, there's no way to make it easy. Do the move in one massive
> > step to simplify dealing with merge conflicts and to make the git
> > history a little easier to dig through. Several cleanup commits follow
> > this one rather than preceed it so that their git history will remain
> > easy to see.
> >
> > No functional change intended.
> >
> > Signed-off-by: Ben Gardon <bgardon@google.com>
>
> Woops, I guess this message bounced because the patch was just too long.
> I can try to split it in two if folks would prefer, or just send a
> list of the functions / definitions moved.
>

Interesting, I can see this patch in my email client,
lore.kernel.org/lkml but not in patchwork.kernel.org

One more way can be to move declarations to shadow_mmu.h first and
then in subsequent patch move definitions to shadow_mmu.c. I do agree
it won't reduce size much but it will make it easier to see which
functions are becoming the part of API.

> > ---
> >  arch/x86/kvm/debugfs.c          |    1 +
> >  arch/x86/kvm/mmu/mmu.c          | 4526 ++++---------------------------
> >  arch/x86/kvm/mmu/mmu_internal.h |    4 +-
> >  arch/x86/kvm/mmu/shadow_mmu.c   | 3408 +++++++++++++++++++++++
> >  arch/x86/kvm/mmu/shadow_mmu.h   |  145 +
> >  5 files changed, 4086 insertions(+), 3998 deletions(-)
> >
>
> ...
>
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
