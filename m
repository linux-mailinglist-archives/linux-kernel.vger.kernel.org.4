Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984C3699A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBPQyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBPQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:54:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C13E1731;
        Thu, 16 Feb 2023 08:54:16 -0800 (PST)
Date:   Thu, 16 Feb 2023 17:54:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676566454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HgwpfwpBRcdmrw0xHtZT6EgPiXiKo400rbBJ6GT2kY8=;
        b=hxj7q4wZYxQ8ehd6jCiZfklQLxt5OshDtj9jtgGDz3/iCylW2MYcT2dqA/X6QlgWmzw9Gp
        VHBTl0By1ImmZhPXvlEPphmFlyARbQT7RM31i6GkEgp4UE62MtEIK5vlvi9i9FiFbR/QFc
        +dQngc16ayNpFZGKLczaemx/04MTZos1uKGU87+rMyc1H1HgV/1UcP4Nonz6532RGqgyvu
        1PDkmHRnPG9QUSLs1FLy+piHlkB6s1VNbXV/l/Avxm22HBuNZAhDn7Z6EGEqbh6mDqZsmt
        8QF6mPlHoYWDDaH7VUEtSs3Qxy3oCfIxQtftKetj2r1Dw0dM2jq2+wuS4+RAUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676566454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HgwpfwpBRcdmrw0xHtZT6EgPiXiKo400rbBJ6GT2kY8=;
        b=ArTJOFIAdKcOe5XUWC382h5tlcaCLfClGZsfw5LYJMBmupEPNpkoluk5maIw1etnDrwKSe
        YHqNRfl/tp8nZiCw==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Thalmeier <michael.thalmeier@hale.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5.15-rt] printk: ignore consoles without write() callback
Message-ID: <Y+5ftWNKMv9WJTXT@linutronix.de>
References: <87zg9d99mp.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zg9d99mp.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-16 11:45:58 [+0106], John Ogness wrote:
>  This is only a problem for the PREEMPT_RT tree. Mainline does not have
>  this problem.

Is this 5.15 and less or current dev RT and less?

Sebastian
