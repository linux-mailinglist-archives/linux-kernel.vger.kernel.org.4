Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E4067F8AE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 15:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjA1O0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 09:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjA1O0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 09:26:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77541BE8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 06:26:12 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AF661EC04DA;
        Sat, 28 Jan 2023 15:26:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674915970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lBFGP4yA9k5cO2OLJZCLuNTIHgdD3+vaWhJ4I1sxvM8=;
        b=AfJTMGFn5O5ltgpj5wdZsOMxfOG21YLDguHUh+Oulfh93dCDMNc19PIu/BNcm/hUvbdKgE
        GVSwQ+8KgFuZT5ARsolPiWAtc4kR0mctikdlWuKFKH1c4Y7ZYyaYCAgpV8Lid6e0xZI5zz
        evcMq872nYblde6/DG7F15KQLL8Te7M=
Date:   Sat, 28 Jan 2023 15:26:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Failure during Stack Depot allocating hash table of 1048576
 entries with kvcalloc
Message-ID: <Y9UweHxSfPiAqgZx@zn.tnic>
References: <Y8Fq5m0CLfcFLCOY@zn.tnic>
 <07e42002-e78d-7947-19a7-0dd035466f50@alu.unizg.hr>
 <Y9UBFNwBeuePPsk3@zn.tnic>
 <d4871e70-c7c9-e638-d7c0-304ec8aea77b@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4871e70-c7c9-e638-d7c0-304ec8aea77b@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 02:55:58PM +0100, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
> On 28.01.23 12:03, Borislav Petkov wrote:
> > On Sat, Jan 28, 2023 at 03:41:50AM +0100, Mirsad Goran Todorovac wrote:
> >> This appears to be a duplicate of the report:
> >> https://lore.kernel.org/linux-mm/2c677d85-820c-d41a-fc98-7d3974b49e42@alu.unizg.hr/raw
> > 
> > Yah, looks like
> > 
> > 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")
> > 
> > needs to be reverted.
> 
> Unless I'm missing something (which might easily be the case) there is a
> patch for that issue in -mm already:
> 
> https://lore.kernel.org/all/20230119224022.80752C433F0@smtp.kernel.org/
> 
> Or where two different issues discussed in the thread Mirsad mentioned
> above?

Probably the same issue. This one fixes the issue on my machine - thanks!

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
