Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52754699455
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjBPM3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBPM3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:29:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AB62202E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:29:29 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26AE81EC0910;
        Thu, 16 Feb 2023 13:29:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676550568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OmK0LFQF2H88m7lKl33/05bbgVtwEAo1+3ic2R12ZJQ=;
        b=GesKoEatdeJwml187Wk3rupOghLkelFQ6ZseSwF5sUA762TPHlebJVUZQx17LQv5Qm+yAw
        NimBXVkIUQbq2FUcxg9Mxri7h/9vWjp9zlbguxI5/mBNPgkP+65ewXBp8hH6Sn9AnpZEKM
        eWGbje3c/6Z7OVysPY95zarCcfsYXNA=
Date:   Thu, 16 Feb 2023 13:29:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Message-ID: <Y+4hpAdn+JQEBqoG@zn.tnic>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com>
 <Y+ohfE/wICFKO/93@zn.tnic>
 <cc6c58a8-b162-a6eb-37d4-40786f532837@suse.com>
 <Y+4SqDN2Hssau4fq@zn.tnic>
 <e5138aad-175e-d9bb-93f2-2fc563e09a41@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5138aad-175e-d9bb-93f2-2fc563e09a41@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 01:19:22PM +0100, Juergen Gross wrote:
> Hmm, I must be blind. I can't spot it.
> 
> I'm seeing only the feature bit #define and a call of
> setup_clear_cpu_cap(X86_FEATURE_SEV_SNP) in this patch.
> 
> Or is it done by hardware or the hypervisor?

Correction - I meant CC_ATTR_GUEST_SEV_SNP not the CPUID feature flag.

Sorry for the confusion folks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
