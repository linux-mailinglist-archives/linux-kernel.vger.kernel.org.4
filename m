Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FE865BD9C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjACKEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjACKEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:04:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EDE2AC1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:04:52 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672740290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E3KITp9UuHNzVKGQYCfax765qudKnsr2yR64IZ6lWwk=;
        b=1jpfeyXhhGBOMaG7SamVwLRMNv2XO7MDVMIId4Fl+3UxhZNXSLn3Icgk4tWQOost4PmdbM
        4Ymp/U9Z9+J8UGJRfXWm6QpQ3kpBT7MmyXY0md57xjTgFrSa19abk7HmJErGg1tton6Ubg
        WTQ1akho/UCsZWnR9VKqM3pkEtJziBziMuSZGuu1Uxu0tik1feY6RvqVgLkHknJ5H6oCeo
        jyP53b9q7h/DxY1ReBsfsjnBwvAsO/RFR+Xf9TEkzLmrJ1pG9sZtSFGBLjnu/AZx+eM3jl
        t/Miz1bSmMJzawohQfdxw/kraZ0fZXKTkAJ7hIfIujKopsPLePsGCzfwsFexEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672740290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E3KITp9UuHNzVKGQYCfax765qudKnsr2yR64IZ6lWwk=;
        b=OT7Miwgmkw5nWI75w8nP+AWhPzOkkja1LB0aJY/CpSQ1z/Fv43wKXGCGuLpNgqei9nZXM2
        wohelW9K2H2rIDBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 4/6] printk: introduce struct console_buffers
In-Reply-To: <20221221202704.857925-5-john.ogness@linutronix.de>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-5-john.ogness@linutronix.de>
Date:   Tue, 03 Jan 2023 11:10:12 +0106
Message-ID: <871qocdjdv.fsf@jogness.linutronix.de>
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
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -81,3 +81,13 @@ u16 printk_parse_prefix(const char *text, int *level,
>  
>  static inline bool printk_percpu_data_ready(void) { return false; }
>  #endif /* CONFIG_PRINTK */
> +
> +/**
> + * console_buffers - Buffers to read/format/output printk messages.

This documentation is not included in the kerneldocs, but it should at
least be proper kerneldoc format. It should be:

 * struct console_buffers - Buffers to read/format/output printk messages.

John
