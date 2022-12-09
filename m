Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A3648314
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLINzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiLINzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:55:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F3176804
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:54:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670594093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ab75hFCZtUT7NrQrs3DM49B+BwGSoyqvD4tFdAumbY8=;
        b=RY1QOIM2IVUHyu82WZu8x/LEwRJC+kSbaeaJMlfJQYdu94BG4e7bwwSPU1tQ10LRASCLUp
        AUVCjuT/RIcF0y3FQn5exvMNkS7wwVmSTUQ1oN5xjGu0vMcL5d3HdFE3V4fB9TLojNSZG9
        oB3QnTwBMtNPz4dDwOYtyKbhwFCXH8kq+AulIRwDOguTqLD4etEJVmAzjCL/POQkx3z+gE
        fGL+lUDIthdxP4+1eQ+A9jsma+DWxZLYvt8t0lMeAh4MJDE2ohx6yf53JsxXPogUqpdiu5
        FdJ15QHYjtViEtUBA3paOnmbmOU1k10P5k8f2p2XN85DNdbH881AXs2K9PjLSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670594093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ab75hFCZtUT7NrQrs3DM49B+BwGSoyqvD4tFdAumbY8=;
        b=oW4Vnw2FpxWvCwG7welZP6XVKyLewZIllvjl7J9QiidSpN3OjGxaGVJ1wEBxHXEw/g2YNk
        fItVdWWz4MTVemDA==
To:     Nathan Chancellor <nathan@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH] x86/vdso: Conditionally export __vdso_sgx_enter_enclave
In-Reply-To: <Y5M8SZEN1N5Dt15X@dev-arch.thelio-3990X>
References: <20221109000306.1407357-1-nathan@kernel.org>
 <Y5M8SZEN1N5Dt15X@dev-arch.thelio-3990X>
Date:   Fri, 09 Dec 2022 14:54:52 +0100
Message-ID: <87r0x8d6mr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09 2022 at 06:46, Nathan Chancellor wrote:
> Ping? The default switch was remerged a couple of days ago so builds
> with tip of tree LLVM are going to be broken again:
>
> https://github.com/llvm/llvm-project/commit/241dbd310599e3c1a0f1b0c9ced14c8b8760539e

Sorry. That fell through the cracks. I'll take care of it.

