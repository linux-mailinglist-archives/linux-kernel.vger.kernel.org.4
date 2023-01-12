Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB25E66711C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjALLlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjALLkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:40:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE84058324
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:30:43 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 724821EC05F1;
        Thu, 12 Jan 2023 12:30:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673523042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VEu3Q1moApa2dK72HY6h2xEc+p/QX+YGFb++a93yE1w=;
        b=FnSZsgXWMn/EDEz12m29pdcXc/xvbhi+HhkpC1CAYHcGm+qWedGBYyEZYHAjeB7JYDgZb0
        RikyRQgrVm0eMV3IW8razXbBnO/TX/cjZjxyKnoxWkBBno4txfZvmth3e2u4X722pFwgJc
        8FKUJvUCwGcqFaHTlxZE9sV2ciIIwgc=
Date:   Thu, 12 Jan 2023 12:30:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Disable kernel stack offset randomization for
 !TSC
Message-ID: <Y7/vYry8Va+NJpxA@zn.tnic>
References: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk>
 <Y72CByxvewQv78YH@zx2c4.com>
 <alpine.DEB.2.21.2301120129020.65308@angie.orcam.me.uk>
 <B71587C5-21E8-4F7C-94FB-92E2AA9F840A@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B71587C5-21E8-4F7C-94FB-92E2AA9F840A@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 05:53:37PM -0800, H. Peter Anvin wrote:
> Not to mention that we could use rdrand here if it is available (although it
> is slower than rdtsc.)

Yeah, no RDRAND on 486. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
