Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB816C1BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjCTQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjCTQib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:38:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7810C2CFC4;
        Mon, 20 Mar 2023 09:32:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CCB8CCE130E;
        Mon, 20 Mar 2023 16:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B13C433D2;
        Mon, 20 Mar 2023 16:32:36 +0000 (UTC)
Date:   Mon, 20 Mar 2023 12:32:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Message-ID: <20230320123233.720e0c01@gandalf.local.home>
In-Reply-To: <495eb06b-9a86-ff55-d0c9-66d836ce456a@linuxfoundation.org>
References: <20230207135147.5ce618d6@gandalf.local.home>
        <20230213204643.39f86987@rorschach.local.home>
        <20230318144202.486c43d1@rorschach.local.home>
        <8579dfaf-11bf-cefa-c3ed-eb9b2d9d1a22@linuxfoundation.org>
        <495eb06b-9a86-ff55-d0c9-66d836ce456a@linuxfoundation.org>
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

On Mon, 20 Mar 2023 10:30:44 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
> Steve,
> 
> The patch doesn't apply to linux-kselftest fixes branch.
> Please rebase and resend with cc to linux-kselftest.
> Makes sense why it got buried in my regular Inbox.
> 
> This one didn't show up in kselftest list. Fixes tag SHA
> is 13 char long. I fixed it and tried to apply. When you
> resend, please fix the Fixes tag as well.

Will do. Thanks Shuah!

-- Steve
