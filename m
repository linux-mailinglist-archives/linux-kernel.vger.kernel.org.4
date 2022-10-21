Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793CA607994
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJUO2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJUO2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:28:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BF3248C6;
        Fri, 21 Oct 2022 07:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81857B82C28;
        Fri, 21 Oct 2022 14:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43263C433D6;
        Fri, 21 Oct 2022 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666362519;
        bh=oBA51cHBOey6R1BJUTUYDH4OF65S/Q7BkylN1Ppwcfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rutlczWOBPQN7E5aSPCOi7Xj9tMJER1qazG+NFCPnPiuZlfaWuBkQJbeT/1PGHh3p
         nQlUdPx92DyzCxgzVzto6kz3E1LCzp/aA8QOtn1sTuA8Hm0Mbj+mFVXYvszGcsLCCm
         I2sMuh6NpUoo4zKgrbKWK9u3Q5SN8YW24Y0gHTkitfvr0fadMMWI/0+G7TzDjHcMLw
         EoLOGmyydm5sN0n3WomQwat+rxgNN5kXVXU5vfZuuRmMdXZiYJn8XZInL8xEsfePrz
         qhBLkiE3yA4AAipdlbIURPScQy0Iz514tr4uk5d+hTtpLE8EBGDX7/7zMat7UBJHGz
         VPo9c9QDeTqJA==
Date:   Fri, 21 Oct 2022 23:28:36 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Colin King (gmail)" <colin.i.king@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/hist: add in missing * in comment blocks
Message-Id: <20221021232836.4a4fe8140fb591edbb87a2e5@kernel.org>
In-Reply-To: <69d9ee66-c312-0387-1307-62fda7bd24ae@infradead.org>
References: <20221020133019.1547587-1-colin.i.king@gmail.com>
        <20221020234423.42816821e2d09aba61db5e69@kernel.org>
        <6005e7c0-5901-ef5a-6af7-2801975e39bc@gmail.com>
        <69d9ee66-c312-0387-1307-62fda7bd24ae@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 11:07:12 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> 
> 
> On 10/20/22 08:10, Colin King (gmail) wrote:
> > On 20/10/2022 15:44, Masami Hiramatsu (Google) wrote:
> >> Hi,
> >>
> >> On Thu, 20 Oct 2022 14:30:19 +0100
> >> Colin Ian King <colin.i.king@gmail.com> wrote:
> >>
> >>> There are a couple of missing * in comment blocks. Fix these.
> >>> Cleans up two clang warnings:
> >>>
> >>> kernel/trace/trace_events_hist.c:986: warning: bad line:
> >>> kernel/trace/trace_events_hist.c:3229: warning: bad line:
> >>>
> >>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> >>
> >> Thanks for the patch.
> >>
> >> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >>
> >> BTW, what version of clang are you using?
> >> I couldn't see this warning with clang 15.0.0. Maybe I need a kconfig option?
> > 
> > clang-13 and kernel W=1 for this specific case, e.g. kernel built using make  CC=clang-13 HOSTCC=clang-13 W=1
> > 
> 
> but those are kernel-doc warnings, not clang (AFAIK).

Ah, I got it.

Thanks!

> 
> > 
> >>
> >> Thank you,
> >>
> >>> ---
> >>>   kernel/trace/trace_events_hist.c | 4 ++--
> >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> >>> index 48465f7e97b4..087c19548049 100644
> >>> --- a/kernel/trace/trace_events_hist.c
> >>> +++ b/kernel/trace/trace_events_hist.c
> >>> @@ -983,7 +983,7 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
> >>>    * A trigger can define one or more variables.  If any one of them is
> >>>    * currently referenced by any other trigger, this function will
> >>>    * determine that.
> >>> -
> >>> + *
> >>>    * Typically used to determine whether or not a trigger can be removed
> >>>    * - if there are any references to a trigger's variables, it cannot.
> >>>    *
> >>> @@ -3226,7 +3226,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
> >>>    * events.  However, for convenience, users are allowed to directly
> >>>    * specify an event field in an action, which will be automatically
> >>>    * converted into a variable on their behalf.
> >>> -
> >>> + *
> >>>    * This function creates a field variable with the name var_name on
> >>>    * the hist trigger currently being defined on the target event.  If
> >>>    * subsys_name and event_name are specified, this function simply
> >>> -- 
> >>> 2.37.3
> >>>
> >>
> >>
> > 
> 
> -- 
> ~Randy


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
