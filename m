Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04265E9A3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjAELQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjAELQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:16:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558CC1D0F0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 03:16:17 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B86F41EC04F0;
        Thu,  5 Jan 2023 12:16:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672917375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sYCv9u4CQpRS47MBdEdo6QEOn787RP/SmqW6LhEI0a0=;
        b=WjTPr0LLwRQs4SSRgcNVGk7Yipd2rogy9bfwgwLiXS+BXbWyStNpV/QwuEepKA2kRbM2N0
        qQEiHkCA2K/SkjuduJ5deHqC2BbUpgIu/8g98sqW0LVXKPgeHFgBo2FFAWxmLcQC7/z/op
        kAQ0NeMoN54AM+OqhEvsdfVoI8sg41c=
Date:   Thu, 5 Jan 2023 12:16:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -v2] x86/alternatives: Add alt_instr.flags
Message-ID: <Y7axe5t79c0gEL4+@zn.tnic>
References: <20221219195312.7054-1-bp@alien8.de>
 <Y6RCoJEtxxZWwotd@zn.tnic>
 <Y7atvpsIOk+p3TLv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7atvpsIOk+p3TLv@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 12:00:14PM +0100, Ingo Molnar wrote:
> Neat - my only nitpick would be s/ft_flgs/ft_flags - it's more readable and 
> we haven't run out of a's yet I guess. ;-)

Yeah, probably leftover from when I was trying to fit the params in 80 cols...

>    Reviewed-by: Ingo Molnar <mingo@kernel.org>
> 
> I minimally boot-tested it as well.

Thx, lemme queue it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
