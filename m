Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAB566659E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjAKV26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjAKV2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:28:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECEFD2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:28:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673472509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCjvYL67va4kbIV0y3JFubXaqggKMzUBIg/jnZYhsoQ=;
        b=bvIz7V+QGn6ddaIIj7CbKJ6ElcEVJmyTi4frCe8CZYPQAqtqrjqsbA/tww9qQPpS/njVOb
        taCw1h8Nuh+GTjNjkJm5p92qoH9uMioa2S18PV4DzbG6tAN9KEViw7Q6YRMQFqT+mhodFG
        khw/iRM+4tMbygFMiaFhH8z4uC6OL8HNehelTGIgk8Ir0iXPSYSTv5KqwZSaqMXFscVzvE
        eva6hRadr80ne8DuaEXlcnHsg+HOXSXaIL/KjH/zKA8anHSEhG9IHwEhSkIEbsiWr7jqu+
        X6wmERFPy0rjVgdzFqT5rLyWua0S100eAcM60tkv8EVO/i3SlLZOVg0DBwZugQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673472509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCjvYL67va4kbIV0y3JFubXaqggKMzUBIg/jnZYhsoQ=;
        b=Y2AoSnv/brZcSmEUqAJWszqyOMru/gIc+rD/WuYFbztkpn+YS2u1RIEvL5qIoxhnggyES5
        50RjKqSlYHZwpOBg==
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH] posix-timers: Support delivery of signals to the
 current thread
In-Reply-To: <CACT4Y+aqT=e30Rvhz233NQBqXioNE11kPWbfcdnYQPk8QMkRBQ@mail.gmail.com>
References: <20221216171807.760147-1-dvyukov@google.com>
 <CACT4Y+aqT=e30Rvhz233NQBqXioNE11kPWbfcdnYQPk8QMkRBQ@mail.gmail.com>
Date:   Wed, 11 Jan 2023 22:28:29 +0100
Message-ID: <87tu0wep6q.ffs@tglx>
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

On Wed, Jan 11 2023 at 16:49, Dmitry Vyukov wrote:
> On Fri, 16 Dec 2022 at 18:18, Dmitry Vyukov <dvyukov@google.com> wrote:
>> We are trying to implement sampling program analysis based on this.
>> We don't need 100% uniform sampling as a CPU profiler would need,
>> but we still need the signals to be reasonably distributed across
>> the process threads.
>>
>> Thomas, does the idea look sane to you overall?
>> Are there any existing alternatives to this?
>
> Hi Thomas,
>
> I guess this was lost in your inbox during the holidays period.
> Please take a look. Should I mail this as a non-RFC patch?

It's not lost it's just in that huge pile of backlog. I'll get to it in
the next days.

Though it would be probably good to resend and explicitely CC

       Eric W. Biederman <ebiederm@xmission.com>
       Oleg Nesterov <oleg@redhat.com>
       Frederic Weisbecker <frederic@kernel.org>

Thanks,

        tglx
