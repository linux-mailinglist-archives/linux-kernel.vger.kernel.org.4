Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73CC65BD96
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbjACKDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjACKDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:03:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3016378
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:03:07 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672740185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ia48XZ+rJ3+0cgYelmyE22oDDkFM+0EZrFwymwMtBw=;
        b=KiN4rhenR2zl5tNA4zjwWpJgBp6p4V+rSqsTDZ0fWUbyXiPyCSCss8D5jwUIbyY384aciW
        M0V/DiNO228IgKDVN+K/mt2WaceKEmC/3F/eZZK/p+sKxhHihA2HL8Ay16NHbSk08DZumm
        MvZ4NNo0DrulVH4+zm7zZ84uU3ngZcgrip+NoGIpPBQrSPTnw+mmr22EKkn8oNVdBv6wDx
        VlXr4UydrH+0zzb8kh3XZfbcA+8PvptqkIRcqkiINyiU6WcCsomU7qDaqA8FHxpKe8RaaM
        NgQmcYaGsGcr5Due5ANe26VAZsYa6UQ8W2gGBwZp8lf5xUjKnTbYbi5l+5oV0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672740185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ia48XZ+rJ3+0cgYelmyE22oDDkFM+0EZrFwymwMtBw=;
        b=ek9NgPly71ow3oUauWsso+QRkDmnAljkt8Em5SoHO4+bry16lDjnFXdkk+I7K9JVSNpeAY
        BInDfAVqFUixWGBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 5/6] printk: introduce
 console_get_next_message() and console_message
In-Reply-To: <20221221202704.857925-6-john.ogness@linutronix.de>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-6-john.ogness@linutronix.de>
Date:   Tue, 03 Jan 2023 11:08:27 +0106
Message-ID: <875ydodjgs.fsf@jogness.linutronix.de>
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

On 2022-12-21, John Ogness <john.ogness@linutronix.de> wrote:
> +/**
> + * console_message - Container for a prepared console message.

This documentation is not included in the kerneldocs, but it should at
least be proper kerneldoc format. It should be:

 * struct console_message - Container for a prepared console message.

John
