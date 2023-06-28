Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C51741B02
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjF1Vdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjF1Vdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:33:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0081FE3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:33:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687988025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZOti4bFsQ+YqSH9SqMcgJmOznZL6VmfHAJFqOvYM4L4=;
        b=jjCJfc3O3rrI2T8uWkCaRvxJJdMrPjA2uTt3mrBy8207xSrnovEThH5lDAcHk9L6Pus4/M
        OvzED7lctb+tS59JzWQqP7cFRg/oOtQXQlCVZ+5NgbtwSq3/F3qA7X6DSPucsl3tB7lnnp
        6P1AmE+DV4FcsB2apgT8pVLFWmifXXjmuGVk1ojvy9+xrFXp/2tJjli9H4WhOzQ9BbVPzZ
        lRe+yQALMwRE/nUDObhYdZqCmY8hyiN/u/kpjKvZ+mZAmyalhitBlbFJ5IU/6x8IRmNdeY
        pOobOuYPWc0AuirNSbQe6sdbQZ2iKSlY0w8v925KbnA5+6UuM6fvp9inDnSvuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687988025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZOti4bFsQ+YqSH9SqMcgJmOznZL6VmfHAJFqOvYM4L4=;
        b=Fqh2GeNZCuIvnCUGeUpBPCgJ2QJlQg+4cbn9lyVVv1xL/9x9t2LYmEAiCn6KXZ6iOWXr+1
        m6miu0NNghMOzTBA==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Reunbreak the MEM_ENCRYPT build
In-Reply-To: <CAHk-=wghER2OsCc+H2USU+nmh72QJ-kqTmaHq=YFd=0xaivubw@mail.gmail.com>
References: <ZJyECvfrOWhKJj4t@casper.infradead.org>
 <CAHk-=wghER2OsCc+H2USU+nmh72QJ-kqTmaHq=YFd=0xaivubw@mail.gmail.com>
Date:   Wed, 28 Jun 2023 23:33:44 +0200
Message-ID: <87ttur2rwn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28 2023 at 12:52, Linus Torvalds wrote:
> On Wed, 28 Jun 2023 at 12:03, Matthew Wilcox <willy@infradead.org> wrote:
>>
>> Probably this is the wrong fix.
>
> No, that looks like the obviously correct fix, I just don't see how we
> all missed that stale declaration.
>
> I guess we all had X86_MEM_ENCRYPT enabled, which hides the problem.
> And other architectures wouldn't have had the issue.

Sigh. I'm sure that I fixed that before. No idea how I missed it in the
final reference merge (again).

Sorry.

        tglx
