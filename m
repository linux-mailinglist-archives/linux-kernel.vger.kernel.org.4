Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF9A5B4DA3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIKLCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiIKLCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:02:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4898A2B60F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:02:28 -0700 (PDT)
Received: from nazgul.tnic (dynamic-046-114-095-207.46.114.pool.telefonica.de [46.114.95.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 330B71EC04D3;
        Sun, 11 Sep 2022 13:02:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662894142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P5kwIvUHBjyBBUAObapdTIJePWA8t5W0c1fO0gvG0vs=;
        b=JxDoua72qGlka0u6SbfQr0k6tskgWj4a+ra+EanXJI6cdjzdXPEn8BUPApQAAXfpU23ScR
        Mk2jxg6pbqFzDGGYrV5EZwbj6T/dyoTyEbFGAebQRmahNBMBjY/V22ilOCz3x1xZ0SOpvX
        zaQDMJML+OWaSCrr5uh+IOY9yPnhmeE=
Date:   Sun, 11 Sep 2022 13:02:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 04/10] x86: move some code out of
 arch/x86/kernel/cpu/mtrr
Message-ID: <Yx3AP9dDPqbRn5OX@nazgul.tnic>
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-5-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220908084914.21703-5-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 10:49:08AM +0200, Juergen Gross wrote:
> Prepare making PAT and MTRR support independent from each other by
> moving some code needed by both out of the MTRR specific sources.

This needs to be two patches at least: first one is only *mechanical*
move without any changes. The next one(s) do the renaming and other
changes etc. Otherwise reviewing it is unnecessarily complicated.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
