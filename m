Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846966A1202
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBWV3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBWV3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:29:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018AF166C8;
        Thu, 23 Feb 2023 13:29:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6577B81A2A;
        Thu, 23 Feb 2023 21:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026CDC4339B;
        Thu, 23 Feb 2023 21:29:34 +0000 (UTC)
Date:   Thu, 23 Feb 2023 16:29:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the ktest tree
Message-ID: <20230223162933.44766b78@gandalf.local.home>
In-Reply-To: <20230223162452.454a3fd6@gandalf.local.home>
References: <20230224081708.383a5e57@canb.auug.org.au>
        <20230223162452.454a3fd6@gandalf.local.home>
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

On Thu, 23 Feb 2023 16:24:52 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 24 Feb 2023 08:17:08 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> Ah sorry. When I was doing my pull request for Linus, I realized I
> accidentally had a commit that wasn't to go upstream. I rebased to remove
> it, but never updated my for-next branch.

The commit message even had:

    ktest.pl: Process variables within variables
    
    Allow a variable to contain another variable. This will allow the
    ${shell <command>} to have its command include variables.
    
    [ When I remember the use case for this, I'll send out the real patch ]

Which is what reminded me that it wasn't suppose to have been in for-next
to begin with.

> 
> Doing that now.

Done.

-- Steve
