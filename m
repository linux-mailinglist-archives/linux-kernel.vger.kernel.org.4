Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B78E5BD48E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiISSKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiISSKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:10:04 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A3EE0BD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:09:40 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1278a61bd57so562471fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kinTjsTMKWd+HF2A95PNPhp0ZSHokoUBxlIlduG7fRs=;
        b=Z9n+eNdWdh71NGqMwqlMdnGMkR+MfqHA3wiPVazUKLvvgnHURhbyz5tXcX8OndG0jF
         URQm5pcCEx33iQRKI5zFPbEgH51JFbW9BaAXYNFjgA5EPgMkmh2V98Civxgd5idJUz4q
         N8bx3Ufnvv5tXmdkiuZqMFqLzJ5RWk/VVEmZ/5r6upWFCH9p4MHsGu5NNqC6soqW2oB3
         lwtV5aFIKP1Mk+gChIWcM5JW1eZiH3puViRgtakqwSp1UjXFmmBx/jq37EYsyjSMOtet
         U0hoQISnRKXADaLvG+0m5BWoyOYnTaFmXyNvfsj2FyDAvW8FK+lchT/JgcpwM3NoIZ2G
         iDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kinTjsTMKWd+HF2A95PNPhp0ZSHokoUBxlIlduG7fRs=;
        b=aSx7mjeJ0sFZ8hn2asjA2ADqo0GEQouNS3ZdYpC2WovZdsCqj6ZPbAicC3rQbV4DLj
         7fMGXHi0pWYmFnpsBmTazE+yeA9n1UxQ6wBQuUxkz4qMgBKRjlH1wHUcLJkr90e/gvAc
         YcDd2tMxflvRM+CwlTw/9mOJTQBB0qgVvR60eYCwpPu4k6Uk6kLKR6wTTLQs/Lb4gOuR
         fRuzuayjZTupE9LTbjGrv34tii+w3liQn5iXoaTzRWaHCXhe4hHKjeKc0SkTIlVQ3pFI
         soiTRAdXa21G68lpONEsI+12IPefdAnmTAdZkg3IDEkHE1yK1u1nX37mVlF6+pJ0qqLO
         wH+A==
X-Gm-Message-State: ACgBeo2H3dElGPEOBF81j2p0JAwOxCGFbngLLR93QR46CUmTVAktqEn8
        doraVCfwL4NiJqqnedVx4J8iOCv0FmLQ+KweOwhRRA==
X-Google-Smtp-Source: AA6agR5DN+7DnOIoUE61op1nJjTuN8PFxR6X8cvIHEmjOifcEhIIHF7V7R8Ea8/MENkIhjW/tg4kd/FPe8WCOTlndv0=
X-Received: by 2002:a05:6870:580c:b0:12a:f136:a8f5 with SMTP id
 r12-20020a056870580c00b0012af136a8f5mr15703777oap.269.1663610979201; Mon, 19
 Sep 2022 11:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220916045832.461395-1-jmattson@google.com> <20220916045832.461395-3-jmattson@google.com>
 <YyTZFzaDOufASxqd@google.com> <CALMp9eQXroxQYiWUCejd0Cj7kD5g5navWY_E2O_vzbVAQjLyNg@mail.gmail.com>
 <YyT0G9y0RRyBDiPD@zn.tnic> <YyT5uW8bjXae2c4l@google.com> <YydrsMjAF5zjqTGK@zn.tnic>
In-Reply-To: <YydrsMjAF5zjqTGK@zn.tnic>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 19 Sep 2022 11:09:28 -0700
Message-ID: <CALMp9eTmcTjJ+aAN3EPANqx3Qo3Psiafz1iuT3fKgpM4Qe0OaA@mail.gmail.com>
Subject: Re: [PATCH 2/5] KVM: svm: Disallow EFER.LMSLE on hardware that
 doesn't support it
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Avi Kivity <avi@redhat.com>, Babu Moger <babu.moger@amd.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org
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

On Sun, Sep 18, 2022 at 12:04 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Sep 16, 2022 at 10:33:29PM +0000, Sean Christopherson wrote:
> > ...
> > Either way, KVM appears to be carrying a half-baked "fix" for a buggy guest that's
> > long since gone.  So like we did in commit 8805875aa473 ("Revert "KVM: nVMX: Do not
> > expose MPX VMX controls when guest MPX disabled""), I think we should just revert
> > the "fix".
>
> If, as message 0/5 says, setting this bit so that SLE11 Xen 4.0 boots as
> a nested hypervisor is the use case, then sure, unconditional NO_LSMLE
> and we all should go on with our lives.

Fantastic! That's what I'll do in V2.
