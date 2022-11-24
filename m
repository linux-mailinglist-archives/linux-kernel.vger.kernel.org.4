Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D371638025
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKXUWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:22:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D6E56D75
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 12:22:50 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669321368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XYSE3QZ53xOkshww4uTh7Z7V0CETVHVJ4n8Xg7C0/xk=;
        b=qp+n9mmkG3sBiDQ+MGoHL7rxQb+ImVm3bYdNIbWuG4MQGIcl73oRt6E3ecYdq6VwSsPEO7
        mk6l/xgbz1b+RpAlWpoiwa0tBwHi7ZGIfba9Io1Ro90FxZrNIn1/uBSVzYTCajerNciGcM
        ogn3Jr0x7AIPrJbDWHb0XHkTYqo6l+VPcZBFD8eVvzry+L1JXbf/XK6nj9SZMGTMJ9C1Xk
        qzdH016ySa+8t9iwLPXCYb0Klb/+4QfxwlDo/hZtzJU8/KeVJ0Ojp+Zll7cBHC33P7R21b
        9Ys/j534kRBQV5UqyeEEjfpeiqoahx51oLjtjXv9wbTwqwoBMKtUVE9haxu1Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669321368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XYSE3QZ53xOkshww4uTh7Z7V0CETVHVJ4n8Xg7C0/xk=;
        b=4KGV6t6tIWHpkvylnN+tlVTjkXHMxMdE/RCWc467z/yRtO/M8SpWjPGj+L2BgoSuJRJZwt
        +zi4MfEyIbyJTTCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 4/7] printk: Add struct console_buffers
In-Reply-To: <Y3+FEe7szf67kGKc@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-5-john.ogness@linutronix.de>
 <Y3+FEe7szf67kGKc@alley>
Date:   Thu, 24 Nov 2022 21:28:38 +0106
Message-ID: <87tu2oksq9.fsf@jogness.linutronix.de>
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

On 2022-11-24, Petr Mladek <pmladek@suse.com> wrote:
> If we agree to use the static buffers in struct console, feel free to use:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

I will move the struct definition and size defines into printk.c for v3.

John
