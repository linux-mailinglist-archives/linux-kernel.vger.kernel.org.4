Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AE0695E95
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjBNJMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjBNJLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:11:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DE9241D0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:10:10 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0D9E1EC08BF;
        Tue, 14 Feb 2023 10:10:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676365808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lJzUNBJF+EToTnj0WiHGhlsiqWuytRkjeSbLDMewF1M=;
        b=o6xc/2CaOy9m7rKWTjNM/rAiF/3clYs4bUeU4ZSmsE7AiUyaEYb3AfCtudCGi/ofNtDIe2
        qQh6udms/y6taXFj9yc4bU4PpldahUTadv2FWT6oseskBEximfnnXu2LfYTWpUCOZaM2tT
        TYXmrS+hWaNiHQPbAzHi2b9ubwWQGsk=
Date:   Tue, 14 Feb 2023 10:10:05 +0100
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
Message-ID: <Y+tP7fvvSFSSCznH@zn.tnic>
References: <6257114d-a957-f586-145c-d2a885417360@suse.com>
 <Y+pRK6a419jenR9R@zn.tnic>
 <Y+pTDFQlX9qNL35z@zn.tnic>
 <85de8576-05b7-400d-6020-7dba519c1d2e@suse.com>
 <Y+pZ5ccprqequvpE@zn.tnic>
 <ca2e1560-5846-2a4b-6c27-aa8ceb17ee5c@suse.com>
 <Y+qHMsZhYaYEmtTo@zn.tnic>
 <6f561386-9bc4-a3bf-656d-db27a2275413@suse.com>
 <Y+tNQvpXdOAfZztQ@zn.tnic>
 <3520cd7f-0e60-b140-9fd3-032ddb6778b5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3520cd7f-0e60-b140-9fd3-032ddb6778b5@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:02:51AM +0100, Juergen Gross wrote:
> I just don't like the idea of trying to catch all possible misuses in
> lower levels, at the same time introducing the need to modify those
> tests in case a new valid use case is popping up.

So what would you do: generally allow this so that potentially other
guest configurations misuse it?

And when we decide to change it, all those users will come running and
complaining that we broke it?

And then we're stuck with a nasty workaround in the tree because we have
to support them too?

See, all we do here is because of such misguided (or maybe didn't know
better) decisions which have happened a long time ago.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
