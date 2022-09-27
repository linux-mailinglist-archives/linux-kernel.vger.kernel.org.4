Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB5E5EC6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiI0OvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiI0Ouw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:50:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C43716585
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:49:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5F01121C3C;
        Tue, 27 Sep 2022 14:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664290145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r7gHLAsqqjKR4VVNIMdZNXErWi/MsNiwElhdXmPPiHo=;
        b=D4m3hA7J01NTw5Cl+2EViQe5Hc8t3DVuV1vlTXwXX35FomunVphmfTqbxcrFYWpbrHpHdb
        PMFN9mxFdJkOjISY6TuPNngcw7vK6MIQ6szX2KN1a1filMWrxFRsID1OS15ruxTWN9MksC
        M4iG755zNEc8LZFJnEt0lQVNrwwQcSE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C0BD62C16B;
        Tue, 27 Sep 2022 14:49:04 +0000 (UTC)
Date:   Tue, 27 Sep 2022 16:49:01 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 1/2] lib/vsprintf: Remove static_branch_likely() from
 __ptr_to_hashval().
Message-ID: <YzMNXXjqFPfDXBMy@alley>
References: <20220927104912.622645-1-bigeasy@linutronix.de>
 <20220927104912.622645-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927104912.622645-2-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-09-27 12:49:11, Sebastian Andrzej Siewior wrote:
> Using static_branch_likely() to signal that ptr_key has been filled is a
> bit much given that it is not a fast path.
> 
> Replace static_branch_likely() with bool for condition and a memory
> barrier for ptr_key.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
