Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F164061D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiLBLwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbiLBLwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:52:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24792D757C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:52:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669981936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MxUgapFgQeAY8vmEc0fUSYeWC09ZtOYl1lu3CzVnn5k=;
        b=vLUJdaLG8FuAjkjsRytMPFLo6IvVpJkbHhYhwhv4mOBc8kG3I58WjdSkUG1DO1CoGMmcae
        0+83iKRyKSjOEY38SafPhKTRiAqpULG9wYcMYO243CsTFroN8ZudUzX/eKEF16nYy1wcFI
        vjTvLBMj6RudOBJRGafC2oYLSJvVhLgi+kNP/d21wJR8g7Yb2bEmcZrj8YuQAQ5jcb20Ou
        iTwvVGbDNeFT5pIreZJjiDC9b83o5bAtySy9hyVXVA5yIyDskvzQu8EX6PspqymI78Uat4
        nB7eh+kIXikrAC5ZwXo15aytgrQfg9GQ8eIyudu1Eq+/6Co0tTb0ZTLZLKkEdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669981936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MxUgapFgQeAY8vmEc0fUSYeWC09ZtOYl1lu3CzVnn5k=;
        b=4tJKvMoE2Rc5132Wivb1ggSpYYkc4xrKbw9va65uy7xLyBGVLVw6klpCUEEijlmQkt3lGJ
        YOMCejcdH4LOkpAA==
To:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Denys Vlasenko <dvlasenk@redhat.com>,
        Seiji Nishikawa <snishika@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes/x86: allow to probe a "nop" insn with 0x66 prefix
In-Reply-To: <20221201142644.GA27185@redhat.com>
References: <20221201142644.GA27185@redhat.com>
Date:   Fri, 02 Dec 2022 12:52:16 +0100
Message-ID: <871qpiqaz3.ffs@tglx>
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

On Thu, Dec 01 2022 at 15:26, Oleg Nesterov wrote:

> From: Denys Vlasenko <dvlasenk@redhat.com>
>
> Intel icc -hotpatch inserts 2-byte "0x66 0x90" NOP at the start of each
> function to reserve extra space for hot-patching, and currently it is not
> possible to probe these functions because branch_setup_xol_ops() wrongly
> nacks NOP with REP prefix.
>
> Fixes: 250bbd12c2fe ("uprobes/x86: Refuse to attach uprobe to "word-sized" branch insns")
> Reported-by: Seiji Nishikawa <snishika@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

The SOB chain is invalid as it lacks the author's signoff.
