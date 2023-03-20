Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8864F6C1EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCTR6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCTR5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:57:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E1331BF4;
        Mon, 20 Mar 2023 10:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC3A4CE13A1;
        Mon, 20 Mar 2023 17:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52E8C4339B;
        Mon, 20 Mar 2023 17:51:34 +0000 (UTC)
Date:   Mon, 20 Mar 2023 13:51:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Tom Rix <trix@redhat.com>, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: set direct_ops storage-class-specifier to
 static
Message-ID: <20230320135132.26b29f36@gandalf.local.home>
In-Reply-To: <ZBibbUQlkytYsoN9@FVFF77S0Q05N.cambridge.arm.com>
References: <20230311135113.711824-1-trix@redhat.com>
        <ZBibbUQlkytYsoN9@FVFF77S0Q05N.cambridge.arm.com>
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

On Mon, 20 Mar 2023 17:44:13 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Sat, Mar 11, 2023 at 08:51:13AM -0500, Tom Rix wrote:
> > smatch reports this warning
> > kernel/trace/ftrace.c:2594:19: warning:
> >   symbol 'direct_ops' was not declared. Should it be static?
> > 
> > The variable direct_ops is only used in ftrace.c, so it should be static
> > 
> > Signed-off-by: Tom Rix <trix@redhat.com>  
> 
> This makes sense, and as this stands:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> ... but Florent's rework of the API is going to remove this anyway:
> 
>   https://lore.kernel.org/all/20230316173811.1223508-1-revest@chromium.org/
>   https://lore.kernel.org/all/20230316173811.1223508-4-revest@chromium.org/
> 
> ... so if we take Florent's series, this patch isn't necessary.

Except that it's already upstream:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8732565549011cabbea08329a1aefd78a68d96c7

I had to rebase Florent's patch to accommodate this change.

-- Steve
