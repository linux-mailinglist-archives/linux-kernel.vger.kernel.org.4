Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165335E7E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIWPUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiIWPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:20:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5EA8CDD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:20:09 -0700 (PDT)
Date:   Fri, 23 Sep 2022 17:20:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663946408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ChXukQZHG1H+NkDadHDSMq1SZcmQ3PX5cO0/7t8CDJw=;
        b=Xtm2p4aap/w8OKZ6h9PJXQsBl9lbw6/Qln1VWS7xrQ7VbxkCot98ZIieNTMJqghyX5i2FW
        FpHL+QYw1K+hDBXzZAHC8WWDFqYNYdTeohesE1A/e6Obo9txlMxWuXj31b83FlH9JrgHMP
        zGtIpesVAuK0dEwFZY2+rMwWHk1MQwDqCmGvW1PQiuf5FgzWwCDf+Xm2DkIUJOeB5+/7n/
        I24Ptjt/c60xRF8+KIoFHftMvAlEnyLnMlM1eMNjoUthuKB7EA1UFkdM/1sqSuSQ2/We8n
        LObEDAoEhy25wxS6oLC8q3+hZI6mczRoCks6fpUJTRYjjZyoCLalMwPip0AwCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663946408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ChXukQZHG1H+NkDadHDSMq1SZcmQ3PX5cO0/7t8CDJw=;
        b=YGAA4hl3yGSZMXLrcMn2k6YV7qztam8qm7ur/lVvwBNjqjrMhYTXpBKUelhQPyIJ+VMSP4
        f472O4RCHEQNzXCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        John Kacur <jkacur@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: Re: printk meeting at LPC 2022
Message-ID: <Yy3Opv5f5QG9eNih@linutronix.de>
References: <20220910221947.171557773@linutronix.de>
 <87h71cr1gb.fsf@jogness.linutronix.de>
 <875yheqh6v.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875yheqh6v.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-23 16:55:28 [+0206], John Ogness wrote:
> If I have missed anything relevant, please let me know.

I just wanted to state, that there was discussion at the end about
removing the early_printk drivers in favour of the atomic-printing
driver/ support which should be capable to do the same.

> John Ogness

Sebastian
