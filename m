Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1502665B43A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjABPar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjABPaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:30:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6767BFFF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:30:45 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFF301EC04AD;
        Mon,  2 Jan 2023 16:30:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672673444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Up1m0OJhiErKqvWpzWXhZumq6qIKqRuLaBUohHyflMY=;
        b=r1tGw2VoYvma/zE0p2o5NCb9vxTJirwASfQvzOEz9rv2nf/ZbBonwZuvHlLyrB/vhfl9RX
        UIP0O/IpULX8VOFOgaxL59mO8w9DeY7V0TwxXnUz2gXV8hX7eDH/u9Bu+0+dukS1v2NZUq
        6c4KebbJvA+oeY4dpjEcsoH3RgG/dSQ=
Date:   Mon, 2 Jan 2023 16:30:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: lib: Separate instruction decoder MMIO type from
 MMIO trace
Message-ID: <Y7L4n0imic1ncHhe@zn.tnic>
References: <Y5oy0vwZQAwzkDkr@zx2c4.com>
 <20221214203454.337299-1-Jason@zx2c4.com>
 <20221214213015.GA16072@ranerica-svr.sc.intel.com>
 <Y5zRTqDmjeJzjeFf@zx2c4.com>
 <CAHmME9ojkPUV-acD8o1rFsfR+f7URG8PW44GUUt8WUK0O=KD6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9ojkPUV-acD8o1rFsfR+f7URG8PW44GUUt8WUK0O=KD6w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 03:49:23PM +0100, Jason A. Donenfeld wrote:
> Do you think you could queue up this patch for 6.2 as a fix? It has
> basically no chance of breakage and does fix a real symbol clash.
> 
> https://lore.kernel.org/lkml/20221214203454.337299-1-Jason@zx2c4.com/
>
> This doesn't fix any existing compile error that I'm aware of, but if
> this makes it into 6.2, it would avoid me having to carry it in a series
> I'm working on,...

Our general rule for urgent fixes going through tip is that they should qualify
to be CC:stable fixes. And this one isn't so I think you should hold on to it
and submit it along with the whole series as it is usually done.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
