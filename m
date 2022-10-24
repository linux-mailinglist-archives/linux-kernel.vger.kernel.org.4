Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82160B547
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJXSTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiJXSS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280D2237F5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:59:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C07C9614AC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7231BC433C1;
        Mon, 24 Oct 2022 16:21:52 +0000 (UTC)
Date:   Mon, 24 Oct 2022 12:22:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Shuah Khan <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] selftests/ftrace: Capture dependency on external
 programs
Message-ID: <20221024122202.01b643c6@gandalf.local.home>
In-Reply-To: <20221018103033.3af4c9d2@gandalf.local.home>
References: <cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
        <20221018103033.3af4c9d2@gandalf.local.home>
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


Hi Shuah,

Can you take this through your tree?

-- Steve

On Tue, 18 Oct 2022 10:30:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Masami,
> 
> If you are OK with this patch set, perhaps Shuah can take it through her
> tree?
> 
> -- Steve
> 
> 
> On Tue, 18 Oct 2022 19:33:39 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > This is v2 of the below patch:
> > http://lkml.kernel.org/r/20221017101927.303547-1-naveen.n.rao@linux.vnet.ibm.com
> > 
> > The second patch is new, and converts some other tests to use the new 
> > way of specifying dependency on external programs.
> > 
> > - Naveen
> > 
> > 
> > Naveen N. Rao (2):
> >   selftests/ftrace: Add check for ping command for trigger tests
> >   selftests/ftrace: Convert tracer tests to use 'requires' to specify
> >     program dependency
> > 
> >  tools/testing/selftests/ftrace/test.d/functions           | 8 +++++++-
> >  tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc    | 7 +------
> >  tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc | 7 +------
> >  .../trigger/inter-event/trigger-field-variable-support.tc | 2 +-
> >  .../inter-event/trigger-inter-event-combined-hist.tc      | 2 +-
> >  .../trigger/inter-event/trigger-onchange-action-hist.tc   | 2 +-
> >  .../trigger/inter-event/trigger-onmatch-action-hist.tc    | 2 +-
> >  .../inter-event/trigger-onmatch-onmax-action-hist.tc      | 2 +-
> >  .../trigger/inter-event/trigger-onmax-action-hist.tc      | 2 +-
> >  .../trigger/inter-event/trigger-snapshot-action-hist.tc   | 2 +-
> >  .../inter-event/trigger-synthetic-event-dynstring.tc      | 2 +-
> >  .../trigger/inter-event/trigger-trace-action-hist.tc      | 2 +-
> >  12 files changed, 18 insertions(+), 22 deletions(-)
> > 
> > 
> > base-commit: 6c0f39e87b6ab1a3009e3a49d3e6f6db8dc756a8  
> 

