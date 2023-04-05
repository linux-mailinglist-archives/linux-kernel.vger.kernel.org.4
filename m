Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A16D7E29
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbjDEN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbjDEN4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07500F3;
        Wed,  5 Apr 2023 06:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FD7563D94;
        Wed,  5 Apr 2023 13:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096A4C433EF;
        Wed,  5 Apr 2023 13:56:41 +0000 (UTC)
Date:   Wed, 5 Apr 2023 09:56:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] tracing: Free error logs of tracing instances
Message-ID: <20230405095639.32e3476a@gandalf.local.home>
In-Reply-To: <f871aa71-9c2e-6a31-151c-2e4cae70a0b2@alu.unizg.hr>
References: <20230404194504.5790b95f@gandalf.local.home>
        <5d6332fc-a64a-5e1a-33e0-a7f1e31b2f90@alu.unizg.hr>
        <f871aa71-9c2e-6a31-151c-2e4cae70a0b2@alu.unizg.hr>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 12:47:08 +0200
Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr> wrote:

> >> Cc: stable@vger.kernel.org
> >> Fixes: 2f754e771b1a6 ("tracing: Have the error logs show up in the proper instances")


> > 
> > Please add
> > 
> > Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

Thanks!

> 
> If it mattered, I could proceed bisect on the other device (we'd get Fixes:
> line, but the bug is already patched).

I'm pretty sure the above commit listed in the Fixes tag is the culprit.
Feel free to test before and after to confirm.

-- Steve
