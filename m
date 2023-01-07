Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205E4660CF8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 09:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjAGITY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 03:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjAGITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 03:19:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D63943D8B
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 00:19:19 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673079557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rEtFGluSGdI0YRGC/pB7hK3o7LkcSyHnrGSCqsxNZjc=;
        b=3N910OaNJxa5H8/FsmRWy7qD4aUYC4jBL058TBKaJK7/zpT4LTJrpKegtEVeG/fbwoQ3qz
        uAOtGzCyxsyvLCi54AqTl74vbFlaPpweIKTXHicGxyAYuaWU60jVCE938CF5SC7GilF7l3
        M64KD+k62/dBjls0CYt7RxDO6znKJLaoYVYfvDABmb/11HtdVTafG4AvFTzAKuALifDVUd
        MreJq4EAew7VlYmTe1tvRSKK52JYKPKL1piH0x7IaPHY7VvIRhEu4I6QZOgVGBIx2AjM7a
        8VVTTulrVHDN0zi8+3l4Z12imaa4S0XJGGewg11xoIUT8k+vZTy2sjJoZkd2iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673079557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rEtFGluSGdI0YRGC/pB7hK3o7LkcSyHnrGSCqsxNZjc=;
        b=hoST8no3FWhOC7ZjBsoiBQP2fregLZcsrYgUXp7aOSQWmRrl5TGd2IU4ljLrKivoBvqwbA
        1a4igsbYgSpK1xAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 0/8] printk: cleanup buffer handling
In-Reply-To: <Y7gEVpMTvI0WzPH7@alley>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
 <Y7gEVpMTvI0WzPH7@alley>
Date:   Sat, 07 Jan 2023 09:24:35 +0106
Message-ID: <87zgaudag4.fsf@jogness.linutronix.de>
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

On 2023-01-06, Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2023-01-05 11:43:27, John Ogness wrote:
> I see three ways how to move forward:
>
> 1. Respin the entire patchset.
> 2. Respin only 7th patch + send the follow up fix seperately
> 3. Push first 6 patches and handle the rest separately.

I will respin the entire patchset. That is easist for me and makes
things quite straight forward for you.

I still am looking into and will to respond to your comments on patch
7/8 before I do the respin.

John
