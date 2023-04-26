Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D611B6EF121
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbjDZJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240312AbjDZJY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:24:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F5049F0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:24:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t49IDwaq2x4WGWQQUhvLBVEVFBDyKYU9fH7BGbQe+gY=;
        b=amzgg8P5WWpzLgqm/vBfuir+6kM7bE1Na06l264T1jSbXswRsC9aDQtdxIeHdjpWExCyp/
        vmi3bobzdTF/S6n59uENh8zzw3mSvRzBV8FTzeYNhvVHijOmia6h5HL657IST5Ktco3iQ4
        aVQFqAFejMU1zo5XvYt3wVjfqIGTMxwatDfcs1H1cZvGxatJKHsZM7+so4mHnT+uzHp2rx
        SPEnHYVDwGs/b4CLqjjXe/O5TvdHtwbvHd4a5IyfaCbxx4uyhLuhKn8MJixcMCVcaZat8W
        TCyBlyWha01i9Hy8pTBylFKG8PFfsWhCfDZFq8biSSEeH3HRhMfQxtR4QhMOXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t49IDwaq2x4WGWQQUhvLBVEVFBDyKYU9fH7BGbQe+gY=;
        b=tQOJfhZlxWHiYISrY4h2jM/Dc/7hzAlE0fNXtNbiByfH9NInF+p9NVWZ9J9r+OldVpuco9
        5GGEnHUIGPURqSAQ==
To:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH] x86/CPU/AMD: Rename the spectral chicken
In-Reply-To: <20230425211522.GGZEhC6nkdsOapSxVL@fat_crate.local>
References: <20230425195024.17808-1-bp@alien8.de>
 <20230425205944.GB1350354@hirez.programming.kicks-ass.net>
 <20230425211522.GGZEhC6nkdsOapSxVL@fat_crate.local>
Date:   Wed, 26 Apr 2023 11:14:44 +0200
Message-ID: <87cz3ryph7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25 2023 at 23:15, Borislav Petkov wrote:

> On Tue, Apr 25, 2023 at 10:59:44PM +0200, Peter Zijlstra wrote:
>> This gets to be the spectral chicken forever more as punishment. Next
>> time AMD can try again, and if they manage to get their act together and
>> publish something before I get to write the code and invent a name for a
>> magical bit, they get to name it how they like.
>
> It is unlikely that you'll have to do that again.

That's a purely speculative assumption.
