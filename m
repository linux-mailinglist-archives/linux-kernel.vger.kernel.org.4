Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA929689ECD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjBCQEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjBCQEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:04:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C81E9E9F7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:04:40 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28EB71EC056D;
        Fri,  3 Feb 2023 17:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675440279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XnZGp/+lSExcuzhYLTWQkvwciK483VsilpIhN9a04dE=;
        b=MixwCGRru3FmNLTI/7W9dcuJYglOCqPbnG90uctWWjXdGVEpdvsgv537vVdnZUoR+p95Q/
        HD6tarxtBuC787EMqYVsx+ILFYZfehbgeOFAgApWheFli1Sj1qpsfkGfECWeWSGnVC+hp6
        HOcRcGvLTpTEUkPO7tspzRgwRLpxGeM=
Date:   Fri, 3 Feb 2023 17:04:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86/alternative: Support relocations in alternatives
Message-ID: <Y90wk4FVBtmFJZ4s@zn.tnic>
References: <Y9py2a5Xw0xbB8ou@hirez.programming.kicks-ass.net>
 <Y90IaYHDbCN9P0OX@zn.tnic>
 <Y90ilxBFMAQZ/dRg@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y90ilxBFMAQZ/dRg@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 04:04:55PM +0100, Peter Zijlstra wrote:
> How about:
> 
>   apply_relocation(u8 *buf, size_t len, u8 *dst, u8 *src, size_t src_len)
> 
> Because I get horribly confused by the whole instr and repl thing.

And I get confused by the @src thing. :-)

When it says repl, I know it is the replacement instruction and its
length. You could add kernel-doc as a help I guess...

Rest on IRC. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
