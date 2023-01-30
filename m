Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9D3681BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjA3UoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjA3Un5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:43:57 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E41283B66E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:43:48 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id AFD6E92009C; Mon, 30 Jan 2023 21:43:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id AC3C492009B;
        Mon, 30 Jan 2023 20:43:47 +0000 (GMT)
Date:   Mon, 30 Jan 2023 20:43:47 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Disable kernel stack offset randomization for
 !TSC
In-Reply-To: <CAHmME9p9emE9WXBJyxCuCF64GqTPKqhMEJO9kpts-OdE8_2=pg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2301302034340.55843@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk> <Y72CByxvewQv78YH@zx2c4.com> <alpine.DEB.2.21.2301120129020.65308@angie.orcam.me.uk> <CAHmME9p9emE9WXBJyxCuCF64GqTPKqhMEJO9kpts-OdE8_2=pg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

> >  Thank you for your input.  I've had a look at the function and it seems a
> > bit heavyweight compared to a mere single CPU instruction, but I guess why
> > not.  Do you have any performance figures (in terms of CPU cycles) for the
> > usual cases?  Offhand I'm not sure how I could benchmark it myself.
> 
> Generally it's very very fast, as most cases wind up being only a
> memcpy -- in this case, a single byte copy. So by and large it should
> be suitable. It's fast enough now that most networking things are able
> to use it. And lots of other places where you'd want really high
> performance. So I'd expect it's okay to use here too. And if it is too
> slow, we should figure out how to make it faster. But I don't suspect
> it'll be too slow.

 Thank you for your explanation.  I have v3 ready for submission; would 
you mind if I added you with a Suggested-by: tag?

  Maciej
