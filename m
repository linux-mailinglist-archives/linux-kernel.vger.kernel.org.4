Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CDD6AF416
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjCGTNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjCGTMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:12:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE59A335F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:56:38 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A66D1EC03CA;
        Tue,  7 Mar 2023 19:56:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678215396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dTusDOQwMDeKVBfn+2f55GHXCbTMacqdk+cRAchKMqk=;
        b=oyS7f891HN89lkaZANq6/IWwuoQK0P+hTrT4eXAFUDmmSFXdKrTpTqfnF7cDx+RSCm1/Zg
        ZKeHGuZzCVbMcjoJwqvuAeCJx+X1h3Llh67mLHrj4DEfqPMtWFMahzEki7QG95CB2Jg1Wv
        UXKmTQNLN03/c7fwLigYRXMQfvBzmsM=
Date:   Tue, 7 Mar 2023 19:56:32 +0100
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
Message-ID: <20230307185632.GDZAeI4LwBDUU3/OP9@fat_crate.local>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <20230307174643.1240184-1-andrew.cooper3@citrix.com>
 <20230307175050.GCZAd5eu0/Mk2fdLz5@fat_crate.local>
 <940596cc-a440-181a-a72a-36282a26dd0a@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <940596cc-a440-181a-a72a-36282a26dd0a@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 06:22:01PM +0000, Andrew Cooper wrote:
> Well yes - more and more reports of impacted systems.
> 
> Having the full list of affected models is great and all, but how is it
> going to change this patch as a workaround ?

We don't have to clear the feature flag on those systems which have
a fix.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
