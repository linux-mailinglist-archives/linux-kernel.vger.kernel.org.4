Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483DD719883
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjFAKLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjFAKKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8F1BCF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 783D261B0C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82018C433EF;
        Thu,  1 Jun 2023 10:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685614147;
        bh=XrUey8Al3fXP8Obl/rCn7MUgAoOvTp7xJZIZrA6It28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cvIULwIeR/KSZQXaBkzL2ZUYuyvZAncyosiTBUD3WGQY0Q/A5C5hZCnq8WuulUmbR
         Wp+TM+3jXcQzTXhrnfG7Eq+GJZ/V+m8639ZLcad8R11frIOu7MRwGOcprDC9Cv/XR3
         Ezj2C2y50tB40LZQ4aqnLnrregDBiWZp1gNNSedaid8GxB4k0/SklzJeCLdfw8NCc6
         ysVOfwsOQLHM3w9TurOFTv4itZrnCKvgw2RiVgLTH2RcnZVJcUVh/i7wIJbZY+speh
         +dAb7H3xwDCQVCiEwla9nVSjgeowDTJyAnF3aqgniilNwSng54Jba9tv1zXqFy6i9p
         7rg1aE0RVHC2A==
Date:   Thu, 1 Jun 2023 12:09:04 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 07/20] posix-timers: Set k_itimer::it_signal to NULL on
 exit()
Message-ID: <ZHhuQMqVIDQoACQA@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.196462644@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.196462644@linutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:06PM +0200, Thomas Gleixner wrote:
> Technically it's not required to set k_itimer::it_signal to NULL on exit()
> because there is no other thread anymore which could lookup the timer
> concurrently.
> 
> Set it to NULL for consistency sake and add a comment to that effect.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
