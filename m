Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADED70F04C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbjEXIKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjEXIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:10:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9BDA1;
        Wed, 24 May 2023 01:10:49 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684915848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDNsNlWRYKgt782T3/Agu9IJLsTFRckuzBM5WP6JWeY=;
        b=08ZKCoEmx575FSIoTYamJgNW8rePnBVnnUl6NvnxaHXFWU6Rq224/aupOg/eEc4vuc4MfQ
        MH4PTQrb+f1zmJHllRcVdq+SI0dxpy/Kg6w1jrEXpX1EmpZjjpfo46v2QNQKk08bOcGP0o
        vpcOnSSgXeNhk3BtvXOh3hYUo3217cnemU1FZEHbLOa0Tx/TUHuxCC0joPcDxX6sbD5Ubq
        /FLwZbEDF1qBFLkXxuwtgKrcEVC/5mBI22AhFxc50qla3SfCyZHQMGzRxFxOU+CCHC3WyR
        WijQa6rJJYvCYOgU3Xaq77sNcWZkJbb3+slB2DaDzZ0mPGekEuhomUFOiQML/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684915848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDNsNlWRYKgt782T3/Agu9IJLsTFRckuzBM5WP6JWeY=;
        b=lAhXoMdbrS11A26A40eqmMgwoW8fQdExtcMd2/P417ochMP88Os923k/4UfR12W1tS7eSv
        W04A72RRvpeyo3AQ==
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Corbet <corbet@lwn.net>, phone-devel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] vsprintf/doc: Document format flags including field
 width and precision
In-Reply-To: <20230522150853.30417-1-pmladek@suse.com>
References: <CSSLOC8WDIPE.1WO9BXZQA7A12@otso>
 <20230522150853.30417-1-pmladek@suse.com>
Date:   Wed, 24 May 2023 10:14:20 +0206
Message-ID: <877csyjgnf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22, Petr Mladek <pmladek@suse.com> wrote:
> +Examples::

> +	printk("Dynamic table: |%*d|%*s|\n", id_width, id, max_name_len, name);

> +	printk("Dynamic precision: %.*f\n", precision, value);

Generally speaking, it is rare to use printk() without a loglevel
specified. And it is preferred that the pr_ or dev_ macros are
used. Perhaps the examples should call pr_info() instead?

John Ogness
