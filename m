Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF1C73E828
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjFZSXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjFZSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:23:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8B3ED
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:22:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba81b37d9d2so4804544276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687803740; x=1690395740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPRyJF+wc441mX/igIYWUk1kWDdqXia6VMBE4smrHR8=;
        b=t7Zs0fuZ9/iB4TLkmlKtKWliIF6FnDkaJ9kebLk5ZrFKDnWSQ/FKH4LRTN5vb9Y9Oy
         IYdl0LlwSZeC5KiI+d40XxASJIVtCxYb+CrF0goeDBgSzNuxO5P37V7C/yd2W5duzXcT
         vjsUvRuQAJiyNibCnla3SpwWu8P6v1Z8nBIk9RY0nISo5VJtum8WdG6hmUOYmDcRRqbQ
         4zRza9MMei61+IHWpOyJQAWn2j6/ISkZ7QqSw9giq2SQTsTahlAqHzMTl44NLzLizfJY
         cmgj/zAAxNir6eI79IRcRNqFV4j+W33FjN00/wRgIQj3yREYnPDuT8qAuNVp9xLp3r1W
         oeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803740; x=1690395740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yPRyJF+wc441mX/igIYWUk1kWDdqXia6VMBE4smrHR8=;
        b=FjaQL3YyRZ1ASYjW3p3eF9xkIf0k7VyxbV18G7AfS33YqwFbhu7Ig9JRli86/dR+Wh
         pKePNbYBeCByJ5wWDJnEmWW1Co/uUPTPgeVo7VpzjgA33u+uUcbdU64qYLA0YzVRvpoc
         WT/asEfsmpZ6+7sSslXjTJ4Ek03ZX8dop1OxafZ836F88dIGwd9GXjjes2xMIRUr7xNu
         L0kBUnKdEI14+8WArNxzYhj3GjSPwpalFruJme+kRyHDyERiGXRkAcGdIqHtKpliG1pe
         J2KfrgkP9Tc/wssJyToampIWHreTKvMenveTEmdPQipqXYSUeGQ1Q49o/toDxt9yASk8
         65Cw==
X-Gm-Message-State: AC+VfDwiId9HwgJCZ85G1PuUqw7yQ0QWuOPwcdUiKo074VVWYt6zxTB7
        HMCA8qMmsso+efQYWduv2I5hUIIwlxQ=
X-Google-Smtp-Source: ACHHUZ7aIvwvO0Y7VS/sEBG9ypLoolrISMkfZROmndUsY6CUjJdJQjHwZ7Mn0vjqevKmUbfI3B81QCliWVM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6dd5:0:b0:c1e:f91c:2691 with SMTP id
 i204-20020a256dd5000000b00c1ef91c2691mr1619859ybc.10.1687803739903; Mon, 26
 Jun 2023 11:22:19 -0700 (PDT)
Date:   Mon, 26 Jun 2023 11:22:18 -0700
In-Reply-To: <a8bae991-c9af-ef45-20de-b9369f4dbf09@amd.com>
Mime-Version: 1.0
References: <20230524155339.415820-1-john.allen@amd.com> <20230524155339.415820-7-john.allen@amd.com>
 <161174d013dff42ddfd2950fe33a8054f45c223e.camel@intel.com>
 <ZINGaJnNJ54+klsD@johallen-workstation.lan> <9ef2faeaa38e667bd4daa8ee338d4cade452c76c.camel@intel.com>
 <ZJYaNSzup+yuYxNy@google.com> <52ea8386-8652-dd91-23de-9d35781cb131@amd.com>
 <ZJm64a7IKuSDS9bz@google.com> <a8bae991-c9af-ef45-20de-b9369f4dbf09@amd.com>
Message-ID: <ZJnXWmaN57fi7WbV@google.com>
Subject: Re: [RFC PATCH v2 6/6] KVM: SVM: Add CET features to supported_xss
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023, Tom Lendacky wrote:
> On 6/26/23 11:28, Sean Christopherson wrote:
> > On Mon, Jun 26, 2023, Tom Lendacky wrote:
> > > On 6/23/23 17:18, Sean Christopherson wrote:
> > > > On Fri, Jun 09, 2023, Rick P Edgecombe wrote:
> > > > > Also, since the host might have CR4.CET set for its own reasons, if the host
> > > > > handled an exit with the the guests MSR_IA32_S_CET set it could suddenly be
> > > > > subjected to CET enforcement that it doesn't expect. Waiting to restore it
> > > > > until returning to the guest is too late.
> > > > > 
> > > > > At least that's the reasoning on the VMX side as I understand it
> > > > 
> > > > The APM doesn't come right out and say it, but I assume/hope that S_CET is saved
> > > > on VMRUN and loaded on #VMEXIT, i.e. is the same as VMX for all intents and
> > > > purposes.
> > > > 
> > > > The host save state definitely has a field for S_CET, and VMRUN documents that the
> > > > guest values are loaded, I just can't find anything in the APM that explicitly states
> > > > how host S_CET and friends are handled.  E.g. in theory, they could have been
> > > > shoved into VMSAVE+VMLOAD, though I very much doubt that's the case.
> > > 
> > > Yes, the host value is saved/restored on VMRUN/#VMEXIT. Anything that is in
> > > the VMCB Save Area (the non-SEV-ES save area) is fully virtualized (unless
> > > noted otherwise) and doesn't require special processing to save/restore the
> > > host values.
> > 
> > Would it makes sense to add a column in "Table B-2. VMCB Layout, State Save Area"
> > to specify whether a field is handled by VMRUN+#VMEXIT vs. VMLOAD+VMSAVE?  I can't
> > find anywhere in the APM where it explicitly states that VMRUN+#VMEXIT context
> > switches everything in the Save Area except the fields listed in "15.5.2 VMSAVE
> > and VMLOAD Instructions".
> > 
> > "15.5 VMRUN Instruction" kinda sorta covers that behavior, but the information is
> > either incomplete or stale, e.g. for host state it says "at least the following"
> > 
> >    Saving Host State. To ensure that the host can resume operation after #VMEXIT,
> >    VMRUN saves at least the following host state information:
> > 
> > but for guest state it says "the following"
> > 
> >    Loading Guest State. After saving host state, VMRUN loads the following guest
> >    state from the VMCB:
> > 
> > and then both provide incomplete lists of state.  A pedantic reading of the guest
> > case suggests that there's a large pile of state that *isn't* loaded, and the host
> > case isn't all that helpful because it's way too handwavy.
> 
> I'll communicate this feedback to the folks that update the APM volumes and
> see what can be done.

Thanks, much appreciated!
