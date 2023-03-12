Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F926B6B69
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCLUro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCLUrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:47:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8A02D4D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:47:39 -0700 (PDT)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F8AE1EC04F0;
        Sun, 12 Mar 2023 21:47:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678654058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yfnVBnx3NNbeE4xtmTMwZgPTZGC23pjg9csbzjAx2O0=;
        b=PuFdXlDTAtrQZVmOub28KsUMOLQ1Wr0zhvtD7D3AwKahPvzwMu5kn42OuPoqljwSOaqw3a
        43C9SgAWmj9B8Aiet6Sy4Qhkt9kkS863gR+5S03PjQ1G7Dg0YN3AzL79b9lfnRTsqtJk7n
        llzkk5aEgtBYz16fP0yYaqW2EmaUpLA=
Date:   Sun, 12 Mar 2023 21:47:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/paravirt: convert simple paravirt functions to asm
Message-ID: <20230312204738.GCZA46aqNzDRjqVF/u@fat_crate.local>
References: <20230308154210.18454-1-jgross@suse.com>
 <20230309133950.GDZAnhpnon5fk4Fg/X@fat_crate.local>
 <e7e42a4b-cf0d-d6ad-2f66-0f52898e818a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7e42a4b-cf0d-d6ad-2f66-0f52898e818a@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 07:24:17AM +0100, Juergen Gross wrote:
> The "normal" cases not using alternatives should rather be switched to
> static calls.

Or that.

> Whether it is possible to mix a static call with alternatives needs to
> be evaluated.

I'd prefer not to mix them. Either should be fine and if neither have
the required functionality, then it should be added depending on which
- static calls or alternatives - would make things simpler.

I'd love to get rid of the whole paravirt glue and use the facilities we
have in the tree instead.

But no hurry - it should be nice and clean work. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
