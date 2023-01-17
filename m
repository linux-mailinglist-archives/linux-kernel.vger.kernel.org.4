Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66152670C03
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjAQWrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjAQWqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:46:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D5BC171;
        Tue, 17 Jan 2023 13:49:13 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673992151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0EySvKf7KDIdxXLtAWjoJUjTf/tsFhH8nu8922rYbz4=;
        b=zlhaEqb4TYh2ZRuBkbkaFUODzaJzybzmp94wrNZ2DHgN3LcfnjQwxzMVr0K0pQuCafVpwt
        0gcfgOfsw042jRYHA7Gsv1zcIYQU24zntAiBeFj83PPNAU7juwuMfg7xj4SDVl3+m0OkZ8
        Jrkq2iyAZh9Zn6UthxWqpfwswXoXULsL1lHVSPQrYc+AyupkKB1Ep0Pd4pZpng2DdTd1Yp
        c13bWY8n/h89FHupOwCiSiFBY1wZwMB0ZdApku7YMvAewUrOD+ztr1MAaBnF3ej/1DBEzC
        r/rtcoo9Nse+0nyLvYpXr5waDphf+Q1yB9HmZoAQobnZ4laAKbdWTmHvuT1aMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673992151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0EySvKf7KDIdxXLtAWjoJUjTf/tsFhH8nu8922rYbz4=;
        b=YnRV+X6yqAJ6pyt3ZIY4niaQaGvNztmiXlWVgf6Ql8uakG1IC9gh+YResQ8mxBagzHX6oR
        2CgS9YvOqsstl/Cw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        coverity-bot <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] printk: Use scnprintf() to print the message about the
 dropped messages on a console
In-Reply-To: <20230117161031.15499-1-pmladek@suse.com>
References: <20230117161031.15499-1-pmladek@suse.com>
Date:   Tue, 17 Jan 2023 22:54:21 +0106
Message-ID: <87r0vsq1cq.fsf@jogness.linutronix.de>
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

On 2023-01-17, Petr Mladek <pmladek@suse.com> wrote:
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1530570 ("Memory - corruptions")
> Fixes: c4fcc617e148 ("printk: introduce console_prepend_dropped() for dropped messages")
> Link: https://lore.kernel.org/r/202301131544.D9E804CCD@keescook
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
