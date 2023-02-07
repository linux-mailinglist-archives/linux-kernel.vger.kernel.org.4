Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3DD68D658
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjBGMVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBGMVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:21:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09041EFA8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:21:21 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F4021EC06C0;
        Tue,  7 Feb 2023 13:21:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675772479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5LWxEGrohFFdhKBL23ohMzv2EyTst8hduQlCMpvRp6s=;
        b=J9c5QYdbwgjioW71Jl+OKPXRUiEKuTEXEd+SGm6g3h6Kd4ZCyOhOiYVnGn6F/zP2CfFw2O
        fvzby235OJXhFo9Zv1biKZQ8dNmTXwdRrw1BPKTj/mwvJfJaoqpTWJ4qy7dAwsAP+SDTjD
        w7AwxG0qF2bNtfzEiI6VBneBZ+WRfD0=
Date:   Tue, 7 Feb 2023 13:21:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     "Kani, Toshi" <toshi.kani@hpe.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 5/6] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Message-ID: <Y+JCO0+L4VnJH75g@zn.tnic>
References: <20230207072902.5528-1-jgross@suse.com>
 <20230207072902.5528-6-jgross@suse.com>
 <Y+I5NyAeu4LWFBcA@zn.tnic>
 <d8f27757-b33c-9701-e6e5-477ac6648393@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8f27757-b33c-9701-e6e5-477ac6648393@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 12:54:53PM +0100, Juergen Gross wrote:
> Fixed MTRRs are all below 1MB. So no, they can't cover a PMD.

Good, belongs in the commit message.

And we need more code staring like this to make sure nothing else
breaks. As said, upsetting the universe is not easy.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
