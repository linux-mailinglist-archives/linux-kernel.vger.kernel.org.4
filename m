Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985CD6C2DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCUJ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCUJ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:28:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA4D320058;
        Tue, 21 Mar 2023 02:28:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E82D2AD7;
        Tue, 21 Mar 2023 02:29:08 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.54.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00B833F766;
        Tue, 21 Mar 2023 02:28:23 -0700 (PDT)
Date:   Tue, 21 Mar 2023 09:28:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Rix <trix@redhat.com>, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: set direct_ops storage-class-specifier to static
Message-ID: <ZBl4rZz/fULw+sWp@FVFF77S0Q05N>
References: <20230311135113.711824-1-trix@redhat.com>
 <ZBibbUQlkytYsoN9@FVFF77S0Q05N.cambridge.arm.com>
 <20230320135132.26b29f36@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320135132.26b29f36@gandalf.local.home>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:51:32PM -0400, Steven Rostedt wrote:
> On Mon, 20 Mar 2023 17:44:13 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> > On Sat, Mar 11, 2023 at 08:51:13AM -0500, Tom Rix wrote:
> > > smatch reports this warning
> > > kernel/trace/ftrace.c:2594:19: warning:
> > >   symbol 'direct_ops' was not declared. Should it be static?
> > > 
> > > The variable direct_ops is only used in ftrace.c, so it should be static
> > > 
> > > Signed-off-by: Tom Rix <trix@redhat.com>  
> > 
> > This makes sense, and as this stands:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > ... but Florent's rework of the API is going to remove this anyway:
> > 
> >   https://lore.kernel.org/all/20230316173811.1223508-1-revest@chromium.org/
> >   https://lore.kernel.org/all/20230316173811.1223508-4-revest@chromium.org/
> > 
> > ... so if we take Florent's series, this patch isn't necessary.
> 
> Except that it's already upstream:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8732565549011cabbea08329a1aefd78a68d96c7
> 
> I had to rebase Florent's patch to accommodate this change.

Sorry for the noise; my fault for being so far behind with patch review!

Mark.
