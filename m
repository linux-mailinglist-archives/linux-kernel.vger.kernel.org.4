Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE06449B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiLFQsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbiLFQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:48:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BA4E005;
        Tue,  6 Dec 2022 08:47:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A056617E9;
        Tue,  6 Dec 2022 16:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D634AC433C1;
        Tue,  6 Dec 2022 16:47:53 +0000 (UTC)
Date:   Tue, 6 Dec 2022 11:47:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] trace: Fix some checker warnings
Message-ID: <20221206114752.2b5c14c4@gandalf.local.home>
In-Reply-To: <1158740.1670343616@warthog.procyon.org.uk>
References: <20221206225859.de7c2f68e9e50a65ac7c7c30@kernel.org>
        <20221206221813.3c7cfa0c6e51b551869912b3@kernel.org>
        <167023571258.382307.15314866482834835192.stgit@warthog.procyon.org.uk>
        <998783.1670333070@warthog.procyon.org.uk>
        <1158740.1670343616@warthog.procyon.org.uk>
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

On Tue, 06 Dec 2022 16:20:16 +0000
David Howells <dhowells@redhat.com> wrote:

> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > Is there a tracing tree this can go through?  
> > 
> > Yes, you can find it in MAINTAINERS file.
> > We are using git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git  
> 
> Okay - is there someone who can apply it to that tree?
> 

Yes, I'll do it this week, after testing. I'm redoing my testing
infrastructure (to give it to Masami), so I'm a bit behind.

-- Steve

