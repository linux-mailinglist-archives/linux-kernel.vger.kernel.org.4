Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE866196C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjAHUjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjAHUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:39:12 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24B03B7E3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 12:39:10 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id EE60A92009C; Sun,  8 Jan 2023 21:39:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E91B192009B;
        Sun,  8 Jan 2023 20:39:09 +0000 (GMT)
Date:   Sun, 8 Jan 2023 20:39:09 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Borislav Petkov <bp@alien8.de>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86: Disable kernel stack offset randomization for
 !TSC
In-Reply-To: <Y7sjdYeS4WNOW7pu@zn.tnic>
Message-ID: <alpine.DEB.2.21.2301082029541.65308@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301081919550.65308@angie.orcam.me.uk> <Y7sfdxJ5/2DSQK/l@zn.tnic> <alpine.DEB.2.21.2301082001540.65308@angie.orcam.me.uk> <Y7sjdYeS4WNOW7pu@zn.tnic>
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

On Sun, 8 Jan 2023, Borislav Petkov wrote:

> > processor	: 0
> > vendor_id	: GenuineIntel
> > cpu family	: 4
> > model		: 3
> > model name	: 486 DX/2
> > stepping	: 5
> 
> Real hw?
> 
> If so, LOL, amazing that a box like that still even boots.

 Why?  I have slower non-x86 hardware that boots current Linux.  This box 
at least has 128MiB of RAM (I still look forward to doubling it if I find 
the right modules) and boots quite quickly.  It's portable (luggable) too.

> A modern phone is likely orders of magnitudes more powerful than this relic.

 It doesn't provide the environment to verify that EISA FDDI networking 
(defxx.c) continues to operate as expected though.

  Maciej
