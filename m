Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9622F5B5E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiILQkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiILQkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:40:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFF21B7A2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:40:09 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663000805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slnxiOp+gkRXmBVTDJrYoCWxL2o6z4OOeTrE9ERi8pk=;
        b=PpRUNZSVcaZHfWwdBQdAtjTjPFNNQpCQ4HFaxk2TSxNrY11dlIYpKDZJDeqFmnEhkpsHUz
        xSa7lbFV+MZpr7sgLNychRlMiV/LY/tkLt7qBqaRmBl6j4NSqgwo2olejgJe6Oou5W2XE2
        sc6D3PPxvEs10IT+Ti/XTrTXo06IhtRmlifFc+wQDXprhdKs4kui7tozauuqIk9veVEPTf
        KaRodEQDwDrTDMyzbrB8F/HiH6WRjrZSur+fR7MKffQvoHHExPSkjcm0eOieIIDmJT68d6
        yJ1gIe3wZFyJUIofYK9urHQAEUIF5ZbmHzkk+te4B/UIqXprRIadub5XP2+MwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663000805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slnxiOp+gkRXmBVTDJrYoCWxL2o6z4OOeTrE9ERi8pk=;
        b=6kc5/xjrB7UM1LAK4AFV7+uMUVeL1LlInMN9h0imVlUTWy7ec6rGwS+7adDt+df7tZeYvr
        3ygAg93t5c0cL6Ag==
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        John Kacur <jkacur@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: printk meeting at LPC 2022
In-Reply-To: <20220910221947.171557773@linutronix.de>
References: <20220910221947.171557773@linutronix.de>
Date:   Mon, 12 Sep 2022 18:46:04 +0206
Message-ID: <87h71cr1gb.fsf@jogness.linutronix.de>
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

Hi,

We now have a room/timeslot [0] where Thomas and I will be presenting
and discussing this new approach [1] for bringing kthread and atomic
console printing to the kernel.

Wednesday, 14 Sep. @ 3:00pm-4:30pm in room "Meeting 9"

John Ogness

[0] https://lpc.events/event/16/contributions/1394/
[1] https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/
