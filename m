Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C4B645E09
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiLGPwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLGPw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:52:28 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703EB63BAA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:52:27 -0800 (PST)
Received: from zn.tnic (p200300ea9733e711329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e711:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B62C1EC0513;
        Wed,  7 Dec 2022 16:52:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670428346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KVcnPS5tJOaRRHzJjUSCWhz9ymXO6hwKKU1q+t1xjH0=;
        b=RE9PsnE3691Ny/BygbI/qr4QyIKpAqjn42XJ0S5AILjdNpbTh4O7wD1ksfd7OHzlfk9v5G
        XZWHsNhFlFEbMttRgcEszGkHnnJPZSAD6oaOw2BLrnLE5k/FapU3jo2Q9MLi39/cDZ0wG5
        kqPZ7b7XI6cndH6Vs2vokIhNOjU0Lx0=
Date:   Wed, 7 Dec 2022 16:52:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/boot: fix relying on link order
Message-ID: <Y5C2tXX7OazmJtEq@zn.tnic>
References: <20221101161529.1634188-1-alexandr.lobakin@intel.com>
 <20221107125528.543764-1-alexandr.lobakin@intel.com>
 <2993a60c-edaa-a29a-2644-3ee86c622847@intel.com>
 <20221121120918.388035-1-alexandr.lobakin@intel.com>
 <Y3t5wxKwIAycpDV8@zn.tnic>
 <20221121160030.395096-1-alexandr.lobakin@intel.com>
 <20221207150854.2077580-1-alexandr.lobakin@intel.com>
 <Y5CwECT3a7tySawo@zn.tnic>
 <20221207153000.2146772-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221207153000.2146772-1-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 04:30:00PM +0100, Alexander Lobakin wrote:
> But not every fix is a fix only when it's easy to find a repro,
> right...?

The basic rule is: only regression fixes during the -rc phase.

Documentation/process/2.Process.rst

although there it is not spelled out that it is regressions only. But
this is the rule we adhere to in the tip tree in general.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
