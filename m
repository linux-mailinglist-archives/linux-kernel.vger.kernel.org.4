Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF42460295E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJRKds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJRKdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:33:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797C2B40CF;
        Tue, 18 Oct 2022 03:33:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666089221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GvKiGfPyShsK+GvYYLINaiTRXie/hm95P1NyidQp4i4=;
        b=QLoke5eOwT1o//npbqpx2AqoX4S+0Mmm72lMh8+pPLzxVa7g6ro7O3oXXR7u/dgQgEgiI0
        hig9rZ3EmXA7oEyf/vOqSvlT32SsOMiG3xzFePEGINz1cEhARP4mqiS1f38Nin2m+AT+OA
        C7hVF8++3KIV3IVBtYt2Z54+xZbw07vy0Ckps8Ax5ps/pyF62Y+bme1Z4yuoraa2v37QKr
        2yohNMbyuiAfauYzmtQVckB4v9NeA8NnDICZdczUJ2Y731gBU81d5IzU+asMFHxBzZNVxm
        aM/aG3I8LPwa0wZnMlRyqBjfsvgir7wbZJ2sY7uJPTlW1nLr42EPuQhj+8Wrcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666089221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GvKiGfPyShsK+GvYYLINaiTRXie/hm95P1NyidQp4i4=;
        b=avunMScV36xH2kpBqOeIH1n+lVDuyyk0drjwE5lKBDodAY38VRm0dEfrr4rU1LLQSoZJFw
        4dEyoJmfZBsvTnDg==
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, tglx@linutronix.de, pmladek@suse.com,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
In-Reply-To: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 18 Oct 2022 12:39:40 +0206
Message-ID: <87k04x4e0r.fsf@jogness.linutronix.de>
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

Hi Paul,

On 2022-09-29, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> This RFC series provides the second version of an NMI-safe SRCU reader
> API in the guise of srcu_read_lock_nmisafe() and
> srcu_read_unlock_nmisafe().

I would like to post a new series for printk that will rely on the
NMI-safe reader API. From the feedback of this series it appears that
the RFC v2 is an acceptable starting point. How should we proceed?

Will Frederic be sending a patch for the extra safety checks using
srcu_nmi_flags? Are you planning on posting a new version? Should I
include this or another version within my upcoming series?

Thanks for all your help on this!

John
