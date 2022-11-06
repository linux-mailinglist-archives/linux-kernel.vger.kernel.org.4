Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180AB61E664
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiKFVSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFVSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:18:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F701055F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 13:18:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E966B8013C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 21:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178D4C433C1;
        Sun,  6 Nov 2022 21:18:02 +0000 (UTC)
Date:   Sun, 6 Nov 2022 16:18:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v5a 5/5] treewide: Convert del_timer*() to
 timer_shutdown*()
Message-ID: <20221106161800.05e93285@rorschach.local.home>
In-Reply-To: <20221106211518.GA162439@roeck-us.net>
References: <20221106054535.709068702@goodmis.org>
        <20221106054649.099333291@goodmis.org>
        <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com>
        <20221106160956.2414d73f@rorschach.local.home>
        <20221106211518.GA162439@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2022 13:15:18 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> > @@ -441,7 +441,7 @@ static void idletimer_tg_destroy_v1(const struct xt_tgdtor_param *par)
> >                 if (info->timer->timer_type & XT_IDLETIMER_ALARM) {
> >                         alarm_cancel(&info->timer->alarm);  
> 
> Does that mean something similar may be needed for alarms ?

No idea. But that could be added to the queue after workqueues ;-)

-- Steve
