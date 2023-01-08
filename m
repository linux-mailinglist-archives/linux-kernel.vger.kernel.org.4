Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA524661921
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjAHUL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbjAHULl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:11:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CC2DFB1
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 12:11:38 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B9981EC01A9;
        Sun,  8 Jan 2023 21:11:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673208697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UPk59aPmcy0l3XMwNeO5y6KIq0NZNlOrlUTVcdd+O9Q=;
        b=fgMVBZFgGIIcir4/E+UrYUYuEeFN4tnA4lzQlb9wA+BTaLk1R++hQI0E5qkLXbFli3inEl
        xN8qRnvQu7xddW9ZU8YmGlzP7DYj7DSjMuFitkEb29xfd43+8AUKqbTUTIc3lYGKKm2HsU
        Os9iiKg0JG3M/FFbPd5utYaueNyEcYw=
Date:   Sun, 8 Jan 2023 21:11:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86: Disable kernel stack offset randomization for !TSC
Message-ID: <Y7sjdYeS4WNOW7pu@zn.tnic>
References: <alpine.DEB.2.21.2301081919550.65308@angie.orcam.me.uk>
 <Y7sfdxJ5/2DSQK/l@zn.tnic>
 <alpine.DEB.2.21.2301082001540.65308@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2301082001540.65308@angie.orcam.me.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 08:04:14PM +0000, Maciej W. Rozycki wrote:
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 4
> model		: 3
> model name	: 486 DX/2
> stepping	: 5

Real hw?

If so, LOL, amazing that a box like that still even boots.

A modern phone is likely orders of magnitudes more powerful than this relic.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
