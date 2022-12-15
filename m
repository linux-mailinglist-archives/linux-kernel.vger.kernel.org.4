Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8817564E236
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiLOUNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiLOUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:13:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DF62EF4B;
        Thu, 15 Dec 2022 12:13:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB140B81C44;
        Thu, 15 Dec 2022 20:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E7CC433D2;
        Thu, 15 Dec 2022 20:13:35 +0000 (UTC)
Date:   Thu, 15 Dec 2022 15:13:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: Re: [RFC][PATCH] ACPI: tracing: Have ACPI debug go to tracing ring
 buffer
Message-ID: <20221215151333.49af5442@gandalf.local.home>
In-Reply-To: <CAEXW_YQLtK=4LMJ+LHPVWU0wbV-027HJoCEKTjZvBZ6krrn6vw@mail.gmail.com>
References: <20221214233106.69b2c01b@gandalf.local.home>
        <Y5trUep9IvCv1Uwy@google.com>
        <20221215141146.6ceb7cf2@gandalf.local.home>
        <CAEXW_YQLtK=4LMJ+LHPVWU0wbV-027HJoCEKTjZvBZ6krrn6vw@mail.gmail.com>
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

On Thu, 15 Dec 2022 14:52:48 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> Another approach could be to always enable the trace event by default,
> if the CONFIG is turned on. Or do a printk() telling the user about
> the event to enable, so they know why their trace buffer is empty.

Yeah, that is another option.

And, yes I need to document it better. I started to, but then decided to
hold off until I get some feedback in case this is rejected.

> 
> Up to you and the ACPI maintainers. ;-)

I'm going to guess I may not hear back until the new year. I'm fine with
that :-) I'll send a reminder then too as I Cc'd the linux-trace-kernel
list, which will keep it active in patchwork.

Cheers!

-- Steve

