Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5742563FA5C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiLAWNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiLAWNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:13:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05782EF6E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:13:01 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669932779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpFrIjygw1nEQgBssLvc9/qJ/y+/KmwjS+Tba1a5pog=;
        b=LdH1lLci95ifxQcuT1jnW//zS0cEDj71ygxerjdYEBoR4KUyFh9Gsm81ahh7fn4+RH4e2A
        Rc+ZKm8s5BsTblFm3zjVijH/0F6lPgjlUlv0xwlwRNFawMSoIGKtifo43HRPhylx2bVJwW
        fAEQ4Ub1evbfFVTn9o18fv2eF2if5JHutBff6Y2TG/dxBYqQPYLSxQRBsGTws7fUqFne3X
        NSwniqlyDWndEvJJ8nrGKcEzTRyShJ42Gk/YYD4VHV6kDXN4O48aCPr+oXkXs9XMl6BDue
        SgkwV90oGJzT8iy8NTboC85nU0oxKfVRkNcpjloVdT37g8u3KESk+KClM3AZEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669932779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpFrIjygw1nEQgBssLvc9/qJ/y+/KmwjS+Tba1a5pog=;
        b=yUQftVOvC3PEmt3cgwQiZB18W0625RCd43SBflq0zQREV+T4Kz6L+OrKLqRdujmtrdUZG8
        /vv2X223YicsKOAg==
To:     paulmck@kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        qiang1.zhang@intel.com
Subject: Re: [PATCH printk v5 03/40] printk: Prepare for SRCU console list
 protection
In-Reply-To: <20221201215650.GK4001@paulmck-ThinkPad-P17-Gen-1>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-4-john.ogness@linutronix.de>
 <Y4jw3hSuwt3RG4DL@dev-arch.thelio-3990X>
 <87lenqq012.fsf@jogness.linutronix.de>
 <20221201215650.GK4001@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 01 Dec 2022 23:18:44 +0106
Message-ID: <87edtipycj.fsf@jogness.linutronix.de>
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

On 2022-12-01, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> I therefore need to pull this into the pile for the upcoming merge
> window:
>
> dbc6ca150842 ("srcu: Make Tiny synchronize_srcu() check for readers")
>
> And kudos to Zqiang for a proactive fix!  ;-)

Yes! Great job!

> I will add your (John's) Tested-by, but please let me know if this is
> inappropriate.

Sure.

Tested-by: John Ogness <john.ogness@linutronix.de>

John
