Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B48C719AEA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjFALXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjFALXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631D7139
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 04:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7BA761DF3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32FCC433EF;
        Thu,  1 Jun 2023 11:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685618581;
        bh=/byoYWAm2n0rnIUvmDzdprBnBJXH3Xu07+mJNR8FSQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilrXZk1q5AhcgmXduYTYZYndFtv9CO9Jr8hc3Q4fz8CDpDlsKbjXZjaqCIaGdAv/q
         MUynBRQgOnfl2NHN3ZeOnmwGPz8HkANZt1raw7RFd8VUK/oRwj6OgjxkZMmBc+n0/W
         79vZZnOVoPtgiN5rIg1m50p+gnhZTAzEstpAEH7iqWg2lnRLzQiMtV7W7gKE62oTek
         AyxyiP5zsabzu113tHFHS4cL8lKj4fX4B4YaBydQSItIQJQQOGZVs+71OtoQtxvian
         Q8dvuJZR9PG3vkOqzPoISOO9A4coGRdQ/bIwv9yYIwAG7FDqgoRpTv5/6MJ6UGuiMC
         LQtFTUGqKjJ8g==
Date:   Thu, 1 Jun 2023 13:22:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 13/20] posix-timers: Document sys_clock_settime()
 permissions in place
Message-ID: <ZHh/koHBCae9OSHV@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.514700292@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.514700292@linutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:16PM +0200, Thomas Gleixner wrote:
> The documentation of sys_clock_settime() permissions is at a random place
> and mostly word salad.
> 
> Remove it and add a concise comment into sys_clock_settime().
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
