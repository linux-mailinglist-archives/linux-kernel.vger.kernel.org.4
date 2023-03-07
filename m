Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829B46AEC99
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCGR4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjCGR4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:56:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E9E97495
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:51:00 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 615651EC03CA;
        Tue,  7 Mar 2023 18:50:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678211459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5CrX8ZHpjgqcaC3CuOic2aam0DqtoSUDlnETZ6zHY7Y=;
        b=Uuv10lv6gNI23iL9L0JMAVc0CsJQX/CHbNGK8XBBtW9iX1Givxi3uZSn2A5zgLQp9t29KE
        cMF8ooOr3oodOu9eOV7wx9Og3yUfy9kbL+ACYib5c5qkKfUwYTtcoX5F/dlbH/SC8bjjCB
        8TrIKbqOPKNFIuWCRNfQHrkSzm2JqXg=
Date:   Tue, 7 Mar 2023 18:50:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tavis Ormandy <taviso@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Monakov <amonakov@ispras.ru>
Subject: Re: [PATCH] x86/amd: Work around Erratum 1386 - XSAVES malfunction
 on context switch
Message-ID: <20230307175050.GCZAd5eu0/Mk2fdLz5@fat_crate.local>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <20230307174643.1240184-1-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307174643.1240184-1-andrew.cooper3@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:46:43PM +0000, Andrew Cooper wrote:
> +	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
> +	 * certain circumstances on Zen1/2 uarch, and not all parts have had
> +	 * updated microcode at the time of writing (March 2023).

Any reason for rushing this and not waiting for me to clarify affected
models first?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
