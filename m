Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0FC675D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjATSuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATSuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:50:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF64272E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:50:18 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9584E1EC0682;
        Fri, 20 Jan 2023 19:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674240616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mlAaFJkX/4xLCktmWlDerlFUb03AZz3swLHDsNYfVmA=;
        b=Ha6TA7GZGdbps8Ssbo+m3AuDad72/fidXdtXhrPl23YC6+U1LvqLt2F8PFrhGKPyKO7Dnb
        9Fe4h/ZtwPG0SPhm85n6HIecBr0j/QGxqTO/wWpMbSlBSAYE5qx6HU45OFOOWRYxwdtSrN
        fNY8kY0tRjiWZiGTmZI6Nxv/PH1Ys5w=
Date:   Fri, 20 Jan 2023 19:50:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Subject: Re: [PATCH v11 2/7] x86/sev: Change snp_guest_issue_request's fw_err
Message-ID: <Y8riZEg+4rZ/65+T@zn.tnic>
References: <20230111194001.1947849-1-dionnaglaze@google.com>
 <20230111194001.1947849-3-dionnaglaze@google.com>
 <Y8qgjgPCmnPR4tQL@zn.tnic>
 <CAAH4kHbDk8d1sqsNaJmGLkpjyXyHBH=9BWSh8XOZCAKu8vvFAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAH4kHbDk8d1sqsNaJmGLkpjyXyHBH=9BWSh8XOZCAKu8vvFAQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 10:03:33AM -0800, Dionna Amalie Glaze wrote:
> I was operating under the assumption that kvm: sev: patches should
> only touch kvm, and virt: coco: sev-guest should only touch sev-guest.

No, we pretty-much never do that. If a patch touches multiple subsystems, the
relevant maintainers agree on its path upstream.

> If you're okay with a patch that changes both areas at the same time,
> then I could do that.

Yes pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
