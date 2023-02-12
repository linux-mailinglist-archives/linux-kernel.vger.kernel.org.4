Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62174693B09
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 00:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBLXRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 18:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBLXRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 18:17:44 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56184DBE7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 15:17:43 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A388992009E; Mon, 13 Feb 2023 00:17:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9DF2592009D;
        Sun, 12 Feb 2023 23:17:42 +0000 (GMT)
Date:   Sun, 12 Feb 2023 23:17:42 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PING][PATCH v3] x86: Use `get_random_u8' for kernel stack offset
 randomization
In-Reply-To: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2302122311470.46819@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk>
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

On Mon, 30 Jan 2023, Maciej W. Rozycki wrote:

> For x86 kernel stack offset randomization uses the RDTSC instruction, 
> which according to H. Peter Anvin is not a secure source of entropy:
> 
> "RDTSC isn't a super fast instruction either, but what is *way* more
> significant is that this use of RDTSC is NOT safe: in certain power states
> it may very well be that stone number of lower bits of TSC contain no
> entropy at all."

 Ping for:
<https://lore.kernel.org/all/alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk/>.

  Maciej

