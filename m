Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344AC6CC951
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjC1Rdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1Rdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:33:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC00BBA8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:33:51 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 50D721EC0666;
        Tue, 28 Mar 2023 19:33:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680024830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KBNRP3e9M5RFCWFO8J+cQyDzijJcv3wHe97SaOz7xzI=;
        b=Q1rNMo5F+BMlJjt0yeBdU1/pTY2eW77D3hVqC36B9Y1Yn+pEd0X0vr3EXMoZdn/4R8oVWT
        CbGLuJmyWNcarnFxJKH9LdWLyswfZXJj//0EB9IJTIMr4/93nF3pu49ufJP8NhdcBAN1hZ
        OutplFuEKr0UPSggl/+KGejy8ualE4I=
Date:   Tue, 28 Mar 2023 19:33:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     David R <david@unsolicited.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Message-ID: <20230328173346.GFZCMk+pSqXgGJ+Oi7@fat_crate.local>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
 <4c660f0f-2845-0e02-ccf9-619958e24236@unsolicited.net>
 <20230328142014.GCZCL3nkW5Qx5jhfsB@fat_crate.local>
 <57385475-c289-356f-d696-fc6decce1390@unsolicited.net>
 <20230328171057.GDZCMfobguhGUFiUuh@fat_crate.local>
 <97f68715-0dd3-6037-7945-f1f724e210f4@unsolicited.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97f68715-0dd3-6037-7945-f1f724e210f4@unsolicited.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:32:31PM +0100, David R wrote:
> I can't reboot now 'till Thursday. Will try then and report back.

Appreciated, thanks!

I'll try to repro here in the meantime but I'm afraid I won't be able to
- this looks like a BIOS issue. But we'll see.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
