Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E48F694FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjBMSyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjBMSyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:54:07 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DDC22026
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:53:44 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 924881EC0856;
        Mon, 13 Feb 2023 19:53:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676314422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/5jo0PaPQ7ACDdvrEWc9uL75mS09dgl+DJrzE8+4cEQ=;
        b=QltKN+XjYAS0gGfUzsCVojIuTjiL4feraD4Tq/cPhd9Yg4lnOw2WAwuCJONvv7QFV12Ajo
        uKqtI6FA9VTIOWfxfsAVzeMxCsMxTuC3mh78pTz48mMCIG7coeaRvWuAVC5Nn++Ingx0U8
        8CVRdJIXK+2ZYovtv68PgtSfXzPpM/k=
Date:   Mon, 13 Feb 2023 19:53:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Message-ID: <Y+qHMsZhYaYEmtTo@zn.tnic>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com>
 <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com>
 <Y+pRK6a419jenR9R@zn.tnic>
 <Y+pTDFQlX9qNL35z@zn.tnic>
 <85de8576-05b7-400d-6020-7dba519c1d2e@suse.com>
 <Y+pZ5ccprqequvpE@zn.tnic>
 <ca2e1560-5846-2a4b-6c27-aa8ceb17ee5c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca2e1560-5846-2a4b-6c27-aa8ceb17ee5c@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 04:44:09PM +0100, Juergen Gross wrote:
> Okay, and it has MTRRs enabled (as Hyper-V SEV-SNP guests), so I shouldn't
> test that, I guess (or we should disable the feature before calling the
> overwrite function).

I think we should handle TDX the same way - as if the MTRRs are
read-only there. So you can check X86_FEATURE_TDX_GUEST in addition.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
