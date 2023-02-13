Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E0B6945DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjBMMds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjBMMdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:33:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260BE14E81;
        Mon, 13 Feb 2023 04:33:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C039DB811B2;
        Mon, 13 Feb 2023 12:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E478C433A1;
        Mon, 13 Feb 2023 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676291601;
        bh=jSUj13tPQOy0vmmgfJA0DRNCqRIflmIh9uZbV0EhPzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uMgaytmc5kcRCWAo9veL4kUIbSJ3U7UZzPYv+GE9gwzwsgS/xEJSIcXw1CnRyjz70
         uvwbadj1LbNdzLdRocxIPwQWjpxDIbEd3+Syi61fbZVPpl6/7obIMDroj3yf2SI8RD
         1pntr+X5SSKHp247aFPIWpww9rzfxTbPGO9H/B6JtJFR1uVggRy0qgv9W7us3We5YO
         0HgyJMd4rFTAbUvLJ50Zx5Mv3qzESBQpFskdrTGmRZ8HNYjrzUDzrl9RmVIqAs2BLN
         snZWZrOg5yOQoKXd/In+3FsRydrux9LoSdzm7HhG9lA7V1O4grgwxaccNxwj4fzxgA
         o4++H/wSuRD/w==
Date:   Mon, 13 Feb 2023 21:33:17 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the ftrace tree
Message-Id: <20230213213317.f8af920f93ef786d8dfa1996@kernel.org>
In-Reply-To: <20230212193515.6c99a476@rorschach.local.home>
References: <20230213081743.33c4d0c9@canb.auug.org.au>
        <20230212193515.6c99a476@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2023 19:35:15 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 13 Feb 2023 08:17:43 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > Commit
> > 
> >   ce9c752ee1e7 ("tracing/probe: add a char type to show the character value of traced arguments")
> > 
> > is missing a Signed-off-by from its committer.
> > 
> 
> Hi Masami,
> 
> Can you fix this commit, and rebase the probes/for-next branch? Then,
> I'll push it back to the for-next branch.
> 

Oops, sorry about that. Hmm, I think I missed to import it wrong way (without my script...)
since it also doesn't have the Link tag.
Let me fix that.

Thank you,

> Thanks!
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
