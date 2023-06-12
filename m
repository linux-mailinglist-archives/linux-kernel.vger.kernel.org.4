Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584B472CC03
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbjFLRFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbjFLRFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:05:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956D9E7B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:05:47 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D2E41EC008F;
        Mon, 12 Jun 2023 19:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686589546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iI3sumeUQaq1tz9CtWmsfggsFnd9M6EvrVjxwtdM0MI=;
        b=F5iSPj2vDiaQzibJ+SRJ52T8+s0DK2jqmiDJqAhh4ll0LQ8hsIaceOwWaqE1OtRtd/3EUy
        xxMX1HG5rzL5q4yeYYsmS2X1PPjNYza5gpQhZ6DWx1uFHeVSGwuVfBmCuE8SjKeQynBHWf
        yDA//Rf4lN8RWM6upmuBT0aCKA1uIog=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Twelo9z9i5Cc; Mon, 12 Jun 2023 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686589544; bh=iI3sumeUQaq1tz9CtWmsfggsFnd9M6EvrVjxwtdM0MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N00XqUTFv0qbMoKSk8ph1ucz5CIm0Ey/54kt1ZtzwKao2nOAq6jh8wXzDWt11aOoO
         pehsrhEr+UCMudZIlyyYgaWrf/J3QrwlDqHr3G/ilYuR1tQjdDUEKviMXvLvlW2baj
         nkvMuNUl1rp49eUoi1SkE0XxTtLO2Ru+tB99s4gAOSgvfhOatX3SAjGrsrbA7mz3iz
         CQzLfnMo0AwpG/DVFyD+gjaxPefAjhgNJBmEaPWM8EnCt0yG1LUSERB5pGdyKvhbBG
         4q78WQ+lsRTUv+zL/D7l0yNb6+3z8lI8CXfj6CSY42VTZurDw5p2WfKgoj0E+dEhhg
         cwm1drRyEiI3i234YWi+1eMoQAvfNVVvLfRE36MCjHEwCP4XzVriRZwcMx1N5c6JrA
         81FqOoyUgTEK23hlW51rVDQgDnDjSas0Iy/qA1GuojeZd3C1vy7FNF10oogddycZxU
         ehOLcRIyJbKjcamW1swWeD6CPqhAZuPHo4K+wzu6/Oo1MxXa9ienJHxjEgVA4oenur
         ppBsTkhviS9RacWXKF2Fe+bZjhtMaAbLOJlT6eqdQbxWRsllOaUcCVY52cGsynmC2e
         jz2FOwnKlIE9UZfYysm9qUGMmP52JO6NnMmu67e1VCY0MQJOm/3FcH9QSCsk5+Q2a8
         0SY9y1/ly6VjJJfNVWidMYm8=
Received: from zn.tnic (p200300ea971dc5f0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f0:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCE2240E0035;
        Mon, 12 Jun 2023 17:05:36 +0000 (UTC)
Date:   Mon, 12 Jun 2023 19:05:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     pawan.kumar.gupta@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>, paul@paul-moore.com,
        leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <20230612170532.GOZIdQXLYZCGKZQFXv@fat_crate.local>
References: <20230203120615.1121272-1-leitao@debian.org>
 <87352z7xld.ffs@tglx>
 <ZIcVoIAQbRl1GTo5@gmail.com>
 <20230612133230.GJZIcebkHxd8QJs0Dv@fat_crate.local>
 <ZIchqLWousxkCqyB@gmail.com>
 <20230612135301.GKZIcjPY0xvbNsiVNd@fat_crate.local>
 <ZIcoss0r/898/CpH@gmail.com>
 <20230612160807.GNZIdC58KQ8IibZjrt@fat_crate.local>
 <ZIdJs0F8Ow4sV27r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIdJs0F8Ow4sV27r@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:37:07AM -0700, Breno Leitao wrote:
> I am not sure if these bugs (MDS, TAA) are speculations related. Pawan
> could help us here.

"Microarchitectural Data Sampling is a hardware vulnerability which allows
unprivileged speculative access..."

"TAA is a hardware vulnerability that allows unprivileged speculative
access to data which is available in various CPU..."

That's all in the tree.

Your grep no workie?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
