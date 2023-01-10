Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5560C663634
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbjAJA3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjAJA3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:29:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC9B3E0CB;
        Mon,  9 Jan 2023 16:29:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BB29B80FA1;
        Tue, 10 Jan 2023 00:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FE3C433EF;
        Tue, 10 Jan 2023 00:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673310546;
        bh=nlwMVqdfyfWGqSrdKjFN0jOOqL7rpv3P5eTI+FHk55U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kLuxQz7M66TCkH49qiE6uAu7QyKYieIVc/O/dN943nh0Wt1VOvPareWYsew9btg5c
         1/aKQCgJpbRkEqjWfoPjAAQDeTeQDffrOB2gJWhsk8tXm0Vh3ihu9T3fRzgh99TGO6
         jhWGqxc0/3gAUkLzbFuGBQcvNQA4rYFAKAmb0gefuYKt7tW+R6BOx5u6jtzCX33VNB
         qNZYPYRbZ/2wSFFMRXGIVpVfCPPDUqOXh3zrl9FEVA49iaSQhDNA/FPZuDhpB0QpRJ
         A5stgSB3NCQFKbqs2DuRarWKW6oBSyELmTavmI8w4dhi9MukVsjBahE3eVBDyrLGhl
         aXPII9JJoqUxA==
Date:   Tue, 10 Jan 2023 09:29:03 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Quanfa Fu <quanfafu@gmail.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing/eprobe: no need to check for negative ret
 value for snprintf
Message-Id: <20230110092903.e499c42d9a3c443c20419c70@kernel.org>
In-Reply-To: <20230109101226.7f75fc0e@gandalf.local.home>
References: <20230109040625.3259642-1-quanfafu@gmail.com>
        <20230109235913.8ac99d54cff8b7c3fc5dcfa4@kernel.org>
        <20230109101226.7f75fc0e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 10:12:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 9 Jan 2023 23:59:13 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Mon,  9 Jan 2023 12:06:25 +0800
> > Quanfa Fu <quanfafu@gmail.com> wrote:
> > 
> > > No need to check for negative return value from snprintf() as the
> > > code does not return negative values.
> > >   
> > 
> > Thanks for simplifying, this looks good to me.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Masami, do you want to take it into the probes branch, or do you want me to
> take it into the tracing branch?

Yes, I'll take it to probe/for-next.

Thank you!

> 
> -- Steve
> 
> 
> > 
> > > Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
> > > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
