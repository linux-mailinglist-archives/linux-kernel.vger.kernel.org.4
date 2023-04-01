Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E706D3147
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDAO0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjDAO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:26:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1473AD30
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 07:26:28 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F193C1EC03DB;
        Sat,  1 Apr 2023 16:26:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680359187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3B+zsaPtlmltz8XFOiurt9dC/urcpVERHr2urY/O8Ds=;
        b=rCbUHfLQIrDqQAHr9N4KWxC/ieOe9VLRIMbt2hjb/YHVRdyMeFKgH/pyt7iO5xU2Ew9QNP
        9UzFixbcTi7CJUMlpjq7rC1/vF5u0CnwLu2KbfPqYANXEJjb6EZOb78/xIgPx9rWvqIdZR
        pKwHTXHm1ggFaKhqxPpt/w2dpmTiMq4=
Date:   Sat, 1 Apr 2023 16:26:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 09/12] x86/mtrr: construct a memory map with cache
 modes
Message-ID: <20230401142626.GDZCg/EsspWrd7BV1G@fat_crate.local>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-10-jgross@suse.com>
 <20230331125740.GCZCbYxFkJOg8hIl6C@fat_crate.local>
 <73226c11-4443-1e52-4566-5799d21e4ccb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73226c11-4443-1e52-4566-5799d21e4ccb@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 03:35:07PM +0200, Juergen Gross wrote:
> Hmm, this makes it much harder to see that the code really does nothing
> if enabled isn't set.

Both callsites in mtrr_bp_init() are behind such a check already.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
