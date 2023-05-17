Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF517070E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEQShT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 14:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjEQSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DEB2134;
        Wed, 17 May 2023 11:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 462F164A11;
        Wed, 17 May 2023 18:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701ACC433D2;
        Wed, 17 May 2023 18:36:52 +0000 (UTC)
Date:   Wed, 17 May 2023 14:36:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH 0/4] Extend rseq with sched_state field
Message-ID: <20230517143650.55eb8ce7@gandalf.local.home>
In-Reply-To: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 11:26:50 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> This prototype extends struct rseq with a new sched_state field, which
> contains a "on-cpu" flag kept up-to-date by the scheduler.
> 
> It is meant to be used by userspace adaptative mutexes to decide between
> busy-wait and futex wait system call (releasing the CPU) behaviors based
> on the current state of the mutex owner.

Woot!

I'm so glad I talked Jon into hanging around for André's spurious talk.
He's the one that brought up rseq (as he mentioned in his article), and I
guess you read that :-)

Unfortunately, I'm in the process of a lot of trips and
meetings/presentations over the next few weeks, and I will not be able to
look into this. But I hope that André could test it out.

Cheers!

-- Steve
