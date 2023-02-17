Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A986969A74A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjBQIqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:46:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA365F811;
        Fri, 17 Feb 2023 00:46:34 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676623591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4g/1vUDyuiJgz9OzO27/dWGjuogwe1DTybHTEs9CwCA=;
        b=m201kr7Azn48qC/IhXEhrXwRCLAyqxMUMnh5z1goNi5xdCPliHBzWmBcAuuSWQug1mV+BP
        ez3wadE+1LN/3ULXwQVK0Sas+po2zTu61Z0JG697Up49ufENOJKVf3IGBxsZ9SJKxrQyuz
        OmlJs3MnrxYzSCYTWlPfy8ILiWLmzcfBYO22O3QozCip2oPlTRLlUYHbb+3g0yYM4PVsAD
        rABfaamPzev4+EDkVnCKwwjf+MoAmHkD6jTjwwbB4bkENnO11++EhSfC2YV99dTkjEsUQZ
        ZCBS4dvdSkndt1n580von8FtrDBscgZqM07Zc+hE8Yj+71Dr104uEWBDHhO4Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676623591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4g/1vUDyuiJgz9OzO27/dWGjuogwe1DTybHTEs9CwCA=;
        b=QhX4cBvATdidLg5qYUrUQy+Uod7s/1GcvBrJhwKrEVkpUBhnh0qt1JfwmZUl7JGTqeaMB4
        Fo6ZtlGJAm/q+KDw==
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Thalmeier <michael.thalmeier@hale.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5.15-rt] printk: ignore consoles without write() callback
In-Reply-To: <Y+5ftWNKMv9WJTXT@linutronix.de>
References: <87zg9d99mp.fsf@jogness.linutronix.de>
 <Y+5ftWNKMv9WJTXT@linutronix.de>
Date:   Fri, 17 Feb 2023 09:51:16 +0106
Message-ID: <87bkls65pf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-16, Sebastian Siewior <bigeasy@linutronix.de> wrote:
>>  This is only a problem for the PREEMPT_RT tree. Mainline does not have
>>  this problem.
>
> Is this 5.15 and less or current dev RT and less?

5.10-rt is also affected. The changes for 5.10-rt are the same, but the
patch does not apply as-is. I will reply with a patch for 5.10-rt.

5.4-rt is not affected.

John Ogness
