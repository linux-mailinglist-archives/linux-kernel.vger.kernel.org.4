Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB3C72CA7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbjFLPnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbjFLPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:43:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2410019C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:42:59 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0CF61EC064A;
        Mon, 12 Jun 2023 17:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686584577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8EspJ/Elh2px1mslQwXk5H0vcDjb0ivi0q1DuXHoGEw=;
        b=mw9l3GboumJwxN7hVJTaNTpLrZIbSuXchYHCsMjSaXHMdS+MDX5cwLAcNJPDDuOR6foJsm
        k4/KxMyjIpMwZ3EmVZesd6sQUHOcEmeMi6jbgfq492qMZWFVrA2ERe/GVjKkOE3uldVCCM
        E8aVtLxuWdyVQmr78AmrzqTchrpw6ag=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Uv3WVub-y1Qe; Mon, 12 Jun 2023 15:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686584574; bh=8EspJ/Elh2px1mslQwXk5H0vcDjb0ivi0q1DuXHoGEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCz+qgyUP2+uOY6IZRk1sUqWx57vRP9T2Uv35Y9/R/vaapsEH4z8tA7aNRUNfmVgs
         ymYxumb7qOvdIRFLL/fS8SA704fL8m6Zt2IUVELtYUo1ftm9VQsylTUmgZz2NvPR1x
         vWZUTPodxe/D9YQoOLzBy8bvmxqqoWx8N9Gyqin5aDaX8d8VEI0dyUsk2JnpOfzvLI
         a4PE/ywHMQYQdeR7LBlNPYnVo25/vskqLjq1WtMrA3OuGbRCGIgeOjRCwE6CBeQwB4
         1j0AJ1d3TSIXi6XNHaF5j5x2Ymmlg3deZ6dlZ0dlu4LtorHQ15b4IqeVl73HJ/MSqO
         JUorJwbwPdDZpcko6HqmkhwbVPQJzH67rjB0kvLAARaVZZ9D0mbMw0sBh/OKu+k6PG
         1PU/hiy/upMQh96QrJ05vKHQVAmASVZmYbn+1KndilgLlh6e82fEE0VkXWiIPGpd8S
         Uzd4RmS/mwrF+FHjYX1EUZAyfhx0ZLzu2o3d44AveVm/IfWqvB5a167vIWsoXtWAQY
         u2IIUm5CT0an90FhV3BTIPHzD2TAH/OwspFJy+KwuH3wD0WQKGasZOm7rK6MfaKUbD
         gk+aKsDxj7qWHIE9vurK49BXpeWibBhTM1lzJgTgvafymuG8Cyk3hxcuy1I/AGGd9L
         +DJrj5YrT4e2Ozr5HtRvElYo=
Received: from zn.tnic (p200300eA971Dc5f0329c23FffEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f0:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A699140E0035;
        Mon, 12 Jun 2023 15:42:51 +0000 (UTC)
Date:   Mon, 12 Jun 2023 17:42:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Add a "microcode=" command line option
Message-ID: <20230612154246.GLZIc89v6Q2THgsY8N@fat_crate.local>
References: <20230605141332.25948-1-bp@alien8.de>
 <20230605141332.25948-2-bp@alien8.de>
 <87ilbs7lcr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ilbs7lcr.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 05:26:28PM +0200, Thomas Gleixner wrote:
> Why is it suddenly required to prevent late loading on SMT threads?

The intent is, like a chicken bit, to revert to the *old* behavior which
would not load on both threads. In *case* some old configuration of CPU
and microcode cannot handle loading on both threads. Which is from
Bulldozer onwards but I don't think anyone uses Bulldozer anymore.

> That's the exact opposite of what e7ad18d1169c ("x86/microcode/AMD:
> Apply the patch early on every logical thread") is doing.

No, see patch 1 - it does exactly the same what this commit does but for
late loading.

Bottomline: on AMD, we should load on both threads by default.

> no_late_all is a horrible option name.

Yeah, at the time dis_ucode_ldr was horrible too. I tried harder this
time.

What do you suggest?

> Also the explanation is not mentioning that this is only relevant for
> late loading.

Huh, it has "late" in the name. :-)

> Aside of that why is this a kernel side chicken bit and not communicated
> by the microcode header?

See above. This chicken bit is there, just in case, to help in the case
where the user cannot do anything else. It should not be used, judging
by all the combinations I've tested here.

> How should an administrator know which microcode versions need this
> treatment and which do not? How is that supposed to work on a fleet?

None of them should need it. Thus, a chicken bit as a last option in
production.

> global variable name without a proper prefix. Moo.

Lemme fix.

> Where is the documentation which tells me what I'm supposed to write
> into this file? Also this is a generic file, right?

Lemme write some docs about it.

> So what's the meaning for non AMD? I can write this bit into it
> successfully and nothing happens, right?

Yes, this bit is AMD-only.

> Why ULL bits for a unsigned long variable?

There's no BIT_UL() macro.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
