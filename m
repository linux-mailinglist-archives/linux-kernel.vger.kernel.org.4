Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085B669E865
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBUTfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBUTfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:35:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1179211679;
        Tue, 21 Feb 2023 11:35:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5DA2B810A5;
        Tue, 21 Feb 2023 19:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A18C433D2;
        Tue, 21 Feb 2023 19:35:37 +0000 (UTC)
Date:   Tue, 21 Feb 2023 14:35:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/11] tracing/user_events: Remote write ABI
Message-ID: <20230221143535.3207b6ee@gandalf.local.home>
In-Reply-To: <20230221174251.GA1786@kbox>
References: <20230120230518.17697-1-beaub@linux.microsoft.com>
        <20230220170135.3c9bea01@rorschach.local.home>
        <20230221174251.GA1786@kbox>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 09:42:51 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Would you prefer I start another version and include the key maintainers
> from fs/exec.c, kernel/exit.c, and kernel/fork.c?

Yeah, you could just do a "[RESEND]" patch set, if nothing has changed (or
maybe just rebase if needed.

> 
> I've added akpm and brauner in these patches. I've pinged akpm privately
> about these, but didn't get any responses.

Yeah, I think he'd rather see what others think before doing anything.

> 
> It seems like Eric Biederman, Kees Cook, and linux-mm would be good
> folks to add here from get_maintainers outputs.

Sure. And yes, definitely include linux-mm.

-- Steve
