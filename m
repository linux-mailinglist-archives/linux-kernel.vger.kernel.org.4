Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55A6609A60
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJXGQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJXGQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:16:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D68062ABF;
        Sun, 23 Oct 2022 23:15:47 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666592145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCbVxyt7yxLaXovSUM+KpSiw2MQMAc+inr2LpPXJ4wo=;
        b=p4bbCSC7bL3/ZJmk3u/rU5FXXJdW83g71cNNqZH6KCQFC7MPyJVXauBQhfSQy2xV0IAPWi
        NwWKYUsdors7MQZvQwS4Mv1JbGu8A5Y1EcfgmGlo1e/AJ7ArwhklucVGWE+9FKWH7bGPh/
        Cqqf3LD111LRSlng1XbqkP/eKWIXcyUWiiz366tYXxPdubDdOtUoloZ6Le1ijiUSGuPQwT
        jkmZv7rlohmAalnXWmDQMK5KEysOMxhnVWOSOuZPlH3Yppz/bw1mNKcvr8sOs6n20vOjyX
        OmeN5I8pUfa5y9Y4Q/n2GMKCiOhm37gAIlZ0s4X28pBrGUOlXY9O/dfg/ILzbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666592145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCbVxyt7yxLaXovSUM+KpSiw2MQMAc+inr2LpPXJ4wo=;
        b=tSjMNPtZyxO2dnKLfthHjN4VTNUZ6ZdAeL8l7h16uQayBUnFu9ok+ST7d5cKNtEtJSY5U+
        3ZbQ/vamPsmjGgDw==
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, tglx@linutronix.de, pmladek@suse.com
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
In-Reply-To: <20221021184152.GO5600@paulmck-ThinkPad-P17-Gen-1>
References: <87k04x4e0r.fsf@jogness.linutronix.de>
 <20221018152418.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <87ilkh0y52.fsf@jogness.linutronix.de>
 <20221018185936.GX5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018215721.GA1716567@paulmck-ThinkPad-P17-Gen-1>
 <87pmeoawwe.fsf@jogness.linutronix.de>
 <20221019191418.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <20221019220537.GA1234896@lothringen>
 <20221020222718.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <87r0z1gy51.fsf@jogness.linutronix.de>
 <20221021184152.GO5600@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 24 Oct 2022 08:21:44 +0206
Message-ID: <87y1t5zqzz.fsf@jogness.linutronix.de>
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

On 2022-10-21, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> And srcunmisafe.2022.10.21a diffs equal, so it hopefully also passes
> your C-I.

It does. Thanks, Paul!

John
