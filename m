Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA16DDDD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjDKO1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDKO1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:27:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3E76185
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:26:35 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 779361EC0683;
        Tue, 11 Apr 2023 16:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681223193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vD783CY818jNVcfjeYDBZSYOGkg35bmnXsk+jWP4W10=;
        b=Tc30nmS4cxXKukqUyCHBhBowDaKbd4JmCZob36VJ198pte45nW67eeexxij8qIFxPHNieR
        BjJY7IcGCh+Sk+ZjL6XDUlJL8SxHqkEGR5B4dJ6kZfeSFbhGpJ2Vf73n8i9AGetVCpi9db
        PY5EtvKJcUy4Bmuf/cf4FF2VF1KA04U=
Date:   Tue, 11 Apr 2023 16:26:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Message-ID: <20230411142633.GBZDVuGU6HaVYxlCJ6@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>
 <BYAPR21MB168853F1DD1B76FACC1CFFFBD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <6febc91b-e0ac-5b14-5bb5-98dc017440ae@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6febc91b-e0ac-5b14-5bb5-98dc017440ae@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:04:00PM +0200, Juergen Gross wrote:
> Yeah, the condition needs to be:
> 
> 	if (!(hv_is_isolation_supported() ||
> 	      cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) &&
	      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Why is that needed at all?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
