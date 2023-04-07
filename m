Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76EC6DB4A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDGUCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGUCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:02:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B2BA5F8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:02:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680897723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KDgeuP1CRjM5yVgKt24lwTWuLcEavHaa1Pg0LqBilwY=;
        b=ccUkEnk2obRzCpm5vAAP03h9vmyGYOjoOxmP3d8xVqZX9voVPMVjX9nICaWkif5BwYmBfg
        9HUtPGMyHIzm9lNyQ9qcaEhToEu/Qr5TWpEssmz4D1N8KWuH67ohp4FZ8Bgb6sngouRiCf
        r30SbMf8jOg52RzCrsePwDipIPm/EjYNSUVKp99Cj8j3Z9fc8BTJgcjPfcmSvNedBw57Kl
        zGoZGnAg2E6IKjxC57Z/7vBzVyCpIJE5M6BMuUCntMrCjp7mFtLtC2e9LdmnZzn1Bg6EQS
        gFw7EBPdbgWrBqfrQuP8JJNBeLIN62UTV+6PZJXWKeIRiUWYi2PkFcJmibF5Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680897723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KDgeuP1CRjM5yVgKt24lwTWuLcEavHaa1Pg0LqBilwY=;
        b=KXaYF4jALCQoEKS1B2SmhsPSVPnKIALE59RZbidri8QU83ar6oS1aU/Q2exaGwRh9DZail
        SXkwjpsv3BTXodCQ==
To:     "Dae R. Jeong" <threeearcat@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: WARNING in do_timer_settime
In-Reply-To: <ZCFDGrz5mJXLLC49@dragonet>
References: <ZCFDGrz5mJXLLC49@dragonet>
Date:   Fri, 07 Apr 2023 22:02:02 +0200
Message-ID: <87bkjztq9x.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27 2023 at 16:17, Dae R. Jeong wrote:
>                                                WARN_ON(!kc->timer_was_running);
>                                                // kc->timer_was_running is NULL in clock_posix_cpu

You mean timer_wait_running, right?

That's discussed already here:

 https://lore.kernel.org/lkml/000000000000566d5405ae2f6f70@google.com

Thanks,

        tglx
