Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A8265DF1F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjADVjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjADVjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:39:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2556D1C130;
        Wed,  4 Jan 2023 13:39:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1F6AB818FE;
        Wed,  4 Jan 2023 21:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626DCC433F1;
        Wed,  4 Jan 2023 21:39:15 +0000 (UTC)
Date:   Wed, 4 Jan 2023 16:39:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: Re: [RFC][PATCH] ACPI: tracing: Have ACPI debug go to tracing ring
 buffer
Message-ID: <20230104163913.7b13cd68@gandalf.local.home>
In-Reply-To: <CAJZ5v0iNdLyOpAxsCTTq-zqRfWDrJ5_c2DUcJYE5ZFn7u+2qdQ@mail.gmail.com>
References: <20221214233106.69b2c01b@gandalf.local.home>
        <Y5trUep9IvCv1Uwy@google.com>
        <20221215141146.6ceb7cf2@gandalf.local.home>
        <CAEXW_YQLtK=4LMJ+LHPVWU0wbV-027HJoCEKTjZvBZ6krrn6vw@mail.gmail.com>
        <20221215151333.49af5442@gandalf.local.home>
        <CAJZ5v0iNdLyOpAxsCTTq-zqRfWDrJ5_c2DUcJYE5ZFn7u+2qdQ@mail.gmail.com>
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

On Fri, 30 Dec 2022 16:52:36 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> Personally, I would use a command line option to control the behavior
> and the Kconfig option to provide its default value.
> 

I can add that.

> This way it can be flipped without rebuilding the kernel if need be.
> 
> I would also make the ACPI debug output go into the trace buffer so
> long as the Kconfig option is not changed or the command line option
> is not flipped.

Not sure what you mean by the above? You mean to make going to both as the
default?

-- Steve
