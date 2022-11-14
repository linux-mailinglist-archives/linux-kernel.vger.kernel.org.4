Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E441D6273DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiKNAda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiKNAd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:33:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D074E3B4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:33:27 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668386005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8kz1DEcjSZFrbtX+E0/EuqP/aOzm5uWRY6IedeZzrxg=;
        b=Mk3H3aAtLNVxoLG4TXeRB6G8wtPqpPCHhIvjSno5eurVoZ6qwN2cXwoFu1Wsf7bhuqkHnv
        kyewZqMtadC1ljOCegs96Gk+znQwNdhv8yW6t0tZVEx8gysS8NW4etvzjzDD4w7IBqCTbs
        PQA3IRPddaRK8jsvqzmUBreU0Pgh2GO+02+iBN9Lxt3GtuRTtdoHFvhbUcczw1WYxu14Pm
        MVRssnrvjjQW0ixABRKipQOdvow4cHh5dw2/q3OYynEsR++ESAPkUj5dvoA6xBLnLCRLKU
        ZOX8PxXnR3rwBvHuTKq7cYIbtnGARaBLYwsbl+3s86oVMOq7Q4ry6BQBUcUUkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668386005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8kz1DEcjSZFrbtX+E0/EuqP/aOzm5uWRY6IedeZzrxg=;
        b=N7Cic6nF7vggvcWYlb99PCkUdp992DG3FKzDNztE+8w2uuFSGfjEFtpZWv3Cw5H2MVJGja
        i8zuedVcf3p8oyDA==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
In-Reply-To: <20221113191518.0a3b29b1@rorschach.local.home>
References: <20221110064101.429013735@goodmis.org>
 <20221110064147.343514404@goodmis.org> <875yfitpdu.ffs@tglx>
 <20221113191518.0a3b29b1@rorschach.local.home>
Date:   Mon, 14 Nov 2022 01:33:25 +0100
Message-ID: <87sfims7ca.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13 2022 at 19:15, Steven Rostedt wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> You surely have spent a massive amount of analysis on this!
>> 
>> Can you please explain how you came up with the brilliant idea of asking
>> Linus to pull this post -rc4 without a review from the timer maintainers
>> or anyone else who understands concurrency?
>
> I trusted the source of this code:
>
>   https://lore.kernel.org/all/87pmlrkgi3.ffs@tglx/

Sure because uncomplied suggestions are the ultimate source of truth and
correctness, right?

I'm terribly sorry that I misled you on this, but OTOH it's pretty
obvious that you decided to ignore:

   https://lore.kernel.org/all/87v8vjiaih.ffs@tglx/

Thanks,

        tglx




