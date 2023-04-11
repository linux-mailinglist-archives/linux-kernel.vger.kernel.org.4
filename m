Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9191A6DDAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDKMX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKMX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:23:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64E41707;
        Tue, 11 Apr 2023 05:23:54 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73BF51EC0102;
        Tue, 11 Apr 2023 14:23:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681215833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=U91yrCJOeaVtdZbsR7c3QE7v7nHaAXGphx6CJX18KdU=;
        b=Gg2BhMhs4U2g3JSr/wHcKxH+DS0dtgDgEa/5/Lap7Y8sfmv28i2jHD+Yx1z992I9m+D1fc
        wC/bgI92Yvwv5XE9/Fk8rYVqznCn5rrhx+RT50S9uus+lScLaRrYJyjqFwVF5u0FORr8mL
        S8ESuZ2V4xMlhLpLtNxgA5x+rjPleVE=
Date:   Tue, 11 Apr 2023 14:23:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Wen Pu <puwen@hygon.cn>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "corbet@lwn.net" <corbet@lwn.net>,
        "jgross@suse.com" <jgross@suse.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 0/2] arch/x86: Set L2 Cache ID on AMD processors
Message-ID: <20230411122348.GAZDVRVNvbbS8F5NUB@fat_crate.local>
References: <20230410163527.1626-1-kprateek.nayak@amd.com>
 <7d5f81e3-0890-ae35-2e5c-59d1b0950297@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d5f81e3-0890-ae35-2e5c-59d1b0950297@hygon.cn>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 12:10:38PM +0000, Wen Pu wrote:
> I have tested the function cacheinfo_amd_init_l2c_id() on Hygon machine,
> it had the same result as yours above. So Hygon also should set the
> l2c_id. Could you please set it for Hygon, or should I send a separate
> patch?

Separate patch please.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
