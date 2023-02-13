Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC98B695034
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjBMTC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBMTCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:02:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425C222A16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:01:33 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676314891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hU1lsRw1zpwuVOtyG8VTdR96f277U9pg09qoEEE+O3Y=;
        b=JXmwIuCzOWw57Y1Wq16REUs+aoRA7ELea0k9bvME2k58zzpdUv4OrjU8k4b4JqPdcaH/2o
        5mxqramJxGCtdL1Qhgfoo0kDRmwhIEGWEFakyKc04HCsZKu83Yzl313eHVQWVSeRGYsX1E
        fdMzqOJCcWwix0d8NEStGhdPtcHYZJfu+rtgamw2VfPfoJwnoDHK47ziSoxLXpdMwgiH25
        0iooIHMkqnPP1jxz85B5bexfsr2NRzx15mWIWX7L+8ekJruuZnUHKa+UP0DYJgqHbKDPSZ
        6fYwJf3AS5E4W1z99LD0MGwpEMolb596ttUWOyn/JDpI3T1EjCcCiPZrebcS/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676314891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hU1lsRw1zpwuVOtyG8VTdR96f277U9pg09qoEEE+O3Y=;
        b=WNljXspFsYM1v+q75lrckafBKvjOKKcSm5teTykrQjbRY4IZytYPgUDLZGwQnSHNmV87SJ
        QiPggDaterT4WCCQ==
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PING][PATCH v3] x86: Use `get_random_u8' for kernel stack
 offset randomization
In-Reply-To: <alpine.DEB.2.21.2302122311470.46819@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk>
 <alpine.DEB.2.21.2302122311470.46819@angie.orcam.me.uk>
Date:   Mon, 13 Feb 2023 20:01:31 +0100
Message-ID: <877cwltmno.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12 2023 at 23:17, Maciej W. Rozycki wrote:
> On Mon, 30 Jan 2023, Maciej W. Rozycki wrote:
>
>> For x86 kernel stack offset randomization uses the RDTSC instruction, 
>> which according to H. Peter Anvin is not a secure source of entropy:
>> 
>> "RDTSC isn't a super fast instruction either, but what is *way* more
>> significant is that this use of RDTSC is NOT safe: in certain power states
>> it may very well be that stone number of lower bits of TSC contain no
>> entropy at all."
>
>  Ping for:
> <https://lore.kernel.org/all/alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk/>.

I'm waiting for you to address Peter Anvins feedback. You also cite him
w/o providing a link to the conversation, so any context is missing.

Thanks,

        tglx
