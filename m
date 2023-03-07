Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971B86AF66B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCGUJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjCGUJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:09:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8FB2A6C0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:09:17 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A6F9F1EC0688;
        Tue,  7 Mar 2023 21:09:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678219755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NL0Fj5tWdSV5sPCmkwv5b9tNtDRbTqKhaYee0FG+wA0=;
        b=JTEiliCzp27QvlqSQc9C6WJEmJLr+u/K3kgQNP4VyBmjcF639CANM39Lv1Qk5tc+6FMjP1
        zFBxI+KUSNVxlnQ928HBM7Pv/hwm4nrpNjY70H9/ezXH9mEreGZL1LqKnAQ92Z2k0K6txr
        ULDJIFAh0Wn7aPRUW93uHfDoCHWABqU=
Date:   Tue, 7 Mar 2023 21:09:11 +0100
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
Message-ID: <20230307200911.GIZAeZ54t0tchbZSTa@fat_crate.local>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <20230307174643.1240184-1-andrew.cooper3@citrix.com>
 <20230307175050.GCZAd5eu0/Mk2fdLz5@fat_crate.local>
 <940596cc-a440-181a-a72a-36282a26dd0a@citrix.com>
 <20230307185632.GDZAeI4LwBDUU3/OP9@fat_crate.local>
 <ee866b3e-a53b-4c26-0272-20e798c0650d@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee866b3e-a53b-4c26-0272-20e798c0650d@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 08:01:36PM +0000, Andrew Cooper wrote:
> Sure, but why is that helpful?
> 
> XSAVES and XSAVEC are functionally identical on Zen1/2 because these
> CPUs don't advertise any supervisor XSAVE states.

I guess... We'll know soon enough.

> It is only Zen3 where XSAVES starts doing more than XSAVEC (and even
> then, only after the CET series actually gets merged...)

Yeah, latter should probably happen this time around. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
