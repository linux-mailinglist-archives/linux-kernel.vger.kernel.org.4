Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE0674B06E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjGGMFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjGGMFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:05:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898B42107
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:05:18 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B56B1EC0752;
        Fri,  7 Jul 2023 14:05:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688731517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tjF/QqGa0qsAvyUihFguAca9FAzsegEZ5UY2WEya8HA=;
        b=gWJnDqMgQC4R3UaVNU/tMD5E/NJxqbMpiCSzrcpyBaq3Hr0flp4d+4VjAu1/xwBwwUVlsq
        NrMGfRR6Mq2U2rncB6akM+sUIQKvSQPqP9WKvVE9wx/75Fue5J+Htav8bRF+vJvy+psSeV
        ZIrW4fcaltDeANhpTn72q6rJGOgIsKw=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cpaTwayr73ga; Fri,  7 Jul 2023 12:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688731513; bh=tjF/QqGa0qsAvyUihFguAca9FAzsegEZ5UY2WEya8HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EH33v1456aJqJuIadd7ZoLwdlljCZYwMrE+/OlOK646lEItWhku9WKgCgwlog5IYc
         V883LcPHxgsEgE8USsb1VneesiajT2WU2oroiXdwifBqh1W3eNKbHmEy2I7w8q96+o
         oTp8u/eqo1fB1uRbFiUTpZ8z+KLY6gcc8OtDboSpwMQvGRSnMAOPgTf6cdctQFi+SC
         6NldF/xnZ6bLrhGorKQqV7PydR/AI06EC46sHQOPf0n7UaTfX2JSGUjXYwktAlsKsc
         BkISqsMD4bEC5TxfeoXPnJAt8Q5v715bE0RPqMnOD92Z6WZAJeM8cb5abj+2RieXbu
         oxdSFvx38ehit63y2WTkFhNhxv3FhaZuPBV/7yyLO0M4AiLngudiWjv8NxPJp+oVzF
         FV3V+XTN32wn0VSK4arpbsW9n9LLeCkUwxGpc9x8ROSkqX1uTMXGdANCvkuUol6b69
         rlI2iz5jWDUJgxCYRmA3Fa9abxao1kfbKAJ7aj4VvRz9+Wh07yB98RrwhtflLuxs6P
         shW8lKgxD41s57dil+CP7pQ6KUarCWTmBniw0BXiGBSyG2V9WnKQ+A0SXR4fi+Z9e1
         q8BrHR5L/QpXJ6lImMUSF8L2jNcDRWcS6JNyO2ykliSQlPXBe4S0K0x/061BtrDTv0
         bM2PfKYW+zcGt1z2RNyGTaq0=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7CED40E0187;
        Fri,  7 Jul 2023 12:05:05 +0000 (UTC)
Date:   Fri, 7 Jul 2023 14:05:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/cpu: Add support for modern x86-64-v* march
Message-ID: <20230707120500.GDZKf/bDf8wIQmpixs@fat_crate.local>
References: <20230707105601.133221-1-dimitri.ledkov@canonical.com>
 <20230707112805.GCZKf2xdf2kMJ/S1DU@fat_crate.local>
 <CADWks+Y7yRfQgd3iKM=qg8-HnQc51QLFNOsWXmR7Rfdn29SSkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADWks+Y7yRfQgd3iKM=qg8-HnQc51QLFNOsWXmR7Rfdn29SSkw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Matz

On Fri, Jul 07, 2023 at 12:46:50PM +0100, Dimitri John Ledkov wrote:
> On Fri, 7 Jul 2023 at 12:28, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Jul 07, 2023 at 11:56:00AM +0100, Dimitri John Ledkov wrote:
> > > Add support for setting march to x86-64-v2, x86-64-v3, x86-64-v4 with
> > > tuning set to an early family of CPUs that support such instruction
> > > levels. By default gcc sets generic tuning for x86-64-v*, which is
> > > suboptimal for all brands of CPUs with such instruction set support.
> >
> > Prove that it is suboptimal for the kernel. Numbers please.
> 
> It's not suboptimal for the kernel as is, it is suboptimal for
> march=x86-64-v* as documented in gcc - probably gcc should actually
> prohibit mtune=generic with march=x86-64-v* settings.

I can't parse that. You probably need to explain in greater detail:
these are the current GENERIC_CPU options, the problem is <bla>, the fix
is <foo> and so on.

> > And even if it shows on *some* uarch:
> >
> > * we need a *single* setting for distro kernels - i.e.,
> > CONFIG_GENERIC_CPU and compilers do make sure that -mtune=generic does
> > the most optimal code generation for all uarches
> >
> > * our Kconfig option set is abysmal so don't need any more if useless.
> >
> > Yeah, a patch like that keeps popping up on a regular basis but no,
> > thanks.
> 
> The biggest issue is that march & mtune is always set, and there is no
> option to use the compiler configured builtin default, or pass in an
> arbitrary string.

Why would you want to use the compiler configured builtin default?

> Would it be acceptable to change GENERIC_CPU to not set neither march
> nor mtune and thus use the compiler configured default? If not, would
> it be acceptable to have a new option GENERIC_NONE which does not set
> any march/mtune and thus uses a compiler configured default? Or for
> example, allow a new freeform string for march and mtune?

You're asking me all those questions but you're not giving any reasoning
*why*. You need to sell it to me and explain why it should be in the
kernel. What's the use case that the majority of users out there will
profit from and so on and so on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
