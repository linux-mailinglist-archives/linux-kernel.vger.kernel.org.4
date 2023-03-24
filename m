Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9646C7D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjCXLqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCXLqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:46:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A453212B1;
        Fri, 24 Mar 2023 04:46:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53C6211FB;
        Fri, 24 Mar 2023 04:47:26 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.56.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9211E3F766;
        Fri, 24 Mar 2023 04:46:40 -0700 (PDT)
Date:   Fri, 24 Mar 2023 11:46:31 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org, jolsa@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/7] Refactor ftrace direct call APIs
Message-ID: <ZB2Nl7fzpHoq5V20@FVFF77S0Q05N>
References: <20230321140424.345218-1-revest@chromium.org>
 <20230323194355.3f714774@gandalf.local.home>
 <20230323220042.40ec4904@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323220042.40ec4904@gandalf.local.home>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:00:42PM -0400, Steven Rostedt wrote:
> On Thu, 23 Mar 2023 19:43:55 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Since that commit only contains the updates for the direct trampolines that
> > ARM64 needs, and I'm not going to rebase that branch, you can just merge it
> > into the ARM64 tree so that you can base your changes on it. Make sure you
> > merge that commit, not the branch, as I have more tracing specific patches
> > on top of that commit.
> 
> I just made it easier for you. I created a signed tag: trace-direct-v6.3-rc3
> 
> So just pull from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> 
> tag: trace-direct-v6.3-rc3

Thanks Steve; much appreciated!

Florent, can you post a new spinf of the remaining arm64 bits rebased atop
that?

Thanks,
Mark.
