Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28529620273
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiKGWmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiKGWmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:42:51 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4882AE14
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:42:49 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13d9a3bb27aso13609252fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 14:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vsChQ3Tg7BF0NokFjc4G7r9sJNrOBJh9/tEuPiQJZ4U=;
        b=OXhUPL/kJdt9DnBObe1Id8rcIBkiCprGnHElQF9Iy72vdVdarJzoUqRkqUVcPc7uag
         3KFtCnuZdO3NjW9xDDeXQzRQl6OLXUXK5LXiB6hiuFGItYJiR17DTewS2jdhjqnqD+g1
         8i7zh7bAUKWVq+/WpnzdNJSqMX94gYuoLAAXBGMCNFGmzw/RWpiD6eGSEQDDtr3pf+Vl
         VkWVvSvyNra/fAtqrtLDLtOm5du81bi0bVzLElJByceuBY6/aN3S5ipPTbnzdGxV5nWt
         ecIRbD2AlUVWIt51t/NEpt+Lw9Nap4WU64BAusqpScSDeYr6V+47+CEj/iA6AJlznbxc
         tedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsChQ3Tg7BF0NokFjc4G7r9sJNrOBJh9/tEuPiQJZ4U=;
        b=c27h3q/VoC7d+EY8sws2lz1jMKVuyvaZuAcKtrLpmUC0bCa6AtgUnw4V1KbOHDuSmK
         wHuB89/m1dAxFzazi2te7PEfIt9BRAOhauRGETzRkdvzRpXXhLOFftfQqC+RzXp2Tz68
         YKXfFgoGLd/sbJxOz6qLotx+/ofhr2Q+gLRVOnRr7pS4S/5YAIcgWAXJyVU0xbL0+N5p
         Nyf64lrIBrw6cWJpmjA0hASfRx8/e7NVMHP1x4THZe8tkugZqtYLCNLKP+lItJjlOst/
         ag0PZ29JRCQrOblWtxAAKZ906zZ4rLfs5nzp8eJI4cDa/BUNjTyQFd5is9gFiGAEEayX
         6v2A==
X-Gm-Message-State: ACrzQf3L6FJTRWARqmWWwZNQiA1JoN8apyfZOTrRSXtUvNe1gSfod304
        Won1Qe7X9glZShLT0y286sZrvUqLtxngaPBQwPkAUA==
X-Google-Smtp-Source: AMsMyM4NZpvJWbLRxOFQy/+nu4rp8cnP13s67kptg+Q4wXsrGI82n8mTDZ2xnlRFJOFpPkW6r4TUq2IwT1YnDuw0EGo=
X-Received: by 2002:a05:6871:8a3:b0:13b:18ef:e8df with SMTP id
 r35-20020a05687108a300b0013b18efe8dfmr30681436oaq.181.1667860968566; Mon, 07
 Nov 2022 14:42:48 -0800 (PST)
MIME-Version: 1.0
References: <20221104213651.141057-1-kim.phillips@amd.com> <20221104213651.141057-4-kim.phillips@amd.com>
 <CALMp9eSpKGCYK_1r3o326ui5RVoH73_RR5-LR2Div9Jm5zvk6A@mail.gmail.com> <f25152d2-7045-94f4-d5dc-69b609c0be6a@amd.com>
In-Reply-To: <f25152d2-7045-94f4-d5dc-69b609c0be6a@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 7 Nov 2022 14:42:37 -0800
Message-ID: <CALMp9eQF7iPXCNkafmaGHY5Dzg+opt0xp+Y8ceML8RTxFyCo7A@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/speculation: Support Automatic IBRS under virtualization
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Nov 7, 2022 at 2:29 PM Kim Phillips <kim.phillips@amd.com> wrote:
>
> On 11/4/22 5:00 PM, Jim Mattson wrote:
> > On Fri, Nov 4, 2022 at 2:38 PM Kim Phillips <kim.phillips@amd.com> wrote:
> >>
> >> VM Guests may want to use Auto IBRS, so propagate the CPUID to them.
> >>
> >> Co-developed-by: Babu Moger <Babu.Moger@amd.com>
> >> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> >
> > The APM says that, under AutoIBRS, CPL0 processes "have IBRS
> > protection." I'm taking this to mean only that indirect branches in
> > CPL0 are not subject to steering from a less privileged predictor
> > mode. This would imply that indirect branches executed at CPL0 in L1
> > could potentially be subject to steering by code running at CPL0 in
> > L2, since L1 and L2 share hardware predictor modes.
>
> That's true for AMD processors that don't support Same Mode IBRS, also
> documented in the APM.
>
> Processors that support AutoIBRS also support Same Mode IBRS (see
> CPUID Fn8000_0008_EBX[IbrsSameMode] (bit 19)).
>
> > Fortunately, there is an IBPB when switching VMCBs in svm_vcpu_load().
> > But it might be worth noting that this is necessary for AutoIBRS to
> > work (unless it actually isn't).
>
> It is needed, but not for kernel/CPL0 code, rather to protect one
> guest's user-space code from another's.

The question is whether it's necessary when switching between L1 and
L2 on the same vCPU of the same VM.

On the Intel side, this was (erroneously) optimized away in commit
5c911beff20a ("KVM: nVMX: Skip IBPB when switching between vmcs01 and
vmcs02").
