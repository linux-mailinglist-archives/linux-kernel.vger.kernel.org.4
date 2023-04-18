Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C866E5E25
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDRKCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDRKCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:02:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3307448B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:02:17 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E4631EC01A9;
        Tue, 18 Apr 2023 12:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681812136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QQQ2jWyhmFY0H3eR6a597ErIMnQghfZmL7vvMzAh2Ks=;
        b=hkQ0kNkBPvEW1oN05pplf2j1RaCqbELt5sWWJ2Sa6AIi9g8ojcIIT2NYk5FsHiXwbQE+EV
        7q6pmJZefTa4eB/SMSL1I0H11sgD9pp/EbFygk7B4rDxN85ajixssJIkDpji5qJs3m4hZm
        uX+sgeW2Iyh/2mJaA+45PDqYkniOKqs=
Date:   Tue, 18 Apr 2023 12:02:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: fix build issue with binutils before
 2.28
Message-ID: <20230418100212.GBZD5qpFuxKaz3WtAC@fat_crate.local>
References: <20230418064228.21577-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418064228.21577-1-w@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 08:42:28AM +0200, Willy Tarreau wrote:
> Boris, I understood from your message that 2.28 was the first working version,
> so that's what I mentioned here. My tests showed that 2.27 wasn't sufficient
> and that 2.29 was OK.

No, you have it right above:

U suffix - 2.27
L/LL suffixes - 2.28

I was wondering where to put that info for future reference but didn't
find a good place so I extended your commit message with it. Now at
least we have left bread crumbs in case we need it in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
