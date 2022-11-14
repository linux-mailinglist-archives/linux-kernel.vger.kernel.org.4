Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7962889B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiKNSxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNSxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:53:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3EF631F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:53:40 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668452018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HlnZ5FLysKeJjaiSOGGCqT+I2tM/sa8yMhVJESq11Ow=;
        b=Q66yMZ4N87skRT6OIqVzixCCKjTaJRuXMV16YAl0Zjqx25v64vtFBS8Piy3MlgzT6nxfh2
        OOtROhSdjyE1bSGIxXIdD/pZmJ3OfDeK7B1etlqqBJF2nDIgAlC14hSZNAQ4g24hVhms8p
        ZqISd9MefCv38hAJ3gDA1yn/Ctu6Ycv2mpBcEiN5RawWQHQwCdc7uIX83N6cnBRC4ihLNo
        N2w75EuzOLjT20XeFi8Nf8J2pqSQ/vTfKrvHrut0DoHQ7TpEn+oJWZJgmK7FrYlxKp3oaq
        O4WVtSEsm/6hLKKHugr7YvjjGHvV41rGqMnbjwe9cgF4ShMKnjvzKdRYAwlyUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668452018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HlnZ5FLysKeJjaiSOGGCqT+I2tM/sa8yMhVJESq11Ow=;
        b=LYzFeUZLVBt4vgsErV0S3WP5cfKKS8VIru/j1gkzsqlhI0K6dpGivaypRjZXGxvguzIX9W
        M6y4aySXEVmVj1AQ==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
In-Reply-To: <20221114090818.30b292c7@gandalf.local.home>
References: <20221110064101.429013735@goodmis.org>
 <20221110064147.343514404@goodmis.org> <87cz9qttdb.ffs@tglx>
 <20221113191135.0b61bb51@rorschach.local.home> <87pmdqs5vr.ffs@tglx>
 <20221114090818.30b292c7@gandalf.local.home>
Date:   Mon, 14 Nov 2022 19:53:37 +0100
Message-ID: <87fsels6z2.ffs@tglx>
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

On Mon, Nov 14 2022 at 09:08, Steven Rostedt wrote:
> On Mon, 14 Nov 2022 02:04:56 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> 
>> Coming back to your claim that I'm insulting. Please point me to the
>> actual insult I commenced and I'm happy to apologize.
>
> It's more the condescending attitude than a direct insult.

I can see that. TBH, this was just my last line of defense to not being
insulting, because I was seriously grumpy about this whole thing and
even more so when I discovered that it was just hastily cobbled together
and then sold as the panacea for solving driver teardown issues.

You surely can do better and you very well know how kernel development
works.

I'm sorry if I offended you. I might have to adjust my expectations.

Thanks,

        tglx
