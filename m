Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA7A69A393
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBQBs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjBQBs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:48:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6075FCC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 17:48:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90B87CE2DA6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93896C433EF;
        Fri, 17 Feb 2023 01:48:51 +0000 (UTC)
Date:   Thu, 16 Feb 2023 20:47:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        alison.schofield@intel.com, davidgow@google.com,
        thunder.leizhen@huawei.com, jianlv@ebay.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracepoint: Allow livepatch module add trace event
Message-ID: <20230216204745.5f8d9c15@rorschach.local.home>
In-Reply-To: <20221223000808.0f4df11b@rorschach.local.home>
References: <20221102160236.11696-1-iecedge@gmail.com>
        <20221114122255.72588f45@gandalf.local.home>
        <CAFA-uR8TakkW=KoA_9RXcyw00Zj8+nNn2erSZ4Y9ULNM8ne11g@mail.gmail.com>
        <20221114220216.05dd0541@gandalf.local.home>
        <20221116000707.a8a692e377d8daaf3764ee64@kernel.org>
        <20221115101837.37da9d1e@gandalf.local.home>
        <CAFA-uR_Bhc8fdBXajKzSSXQ1Cf_iLirK0gS+TovPM9G7MLv=dg@mail.gmail.com>
        <20221223000808.0f4df11b@rorschach.local.home>
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

On Fri, 23 Dec 2022 00:08:08 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 23 Dec 2022 12:52:18 +0800
> Jianlin Lv <iecedge@gmail.com> wrote:
> 
> > hi, Steve
> > Any other comments for code changes?
> > Is it possible for this patch to be merged?  
> 
> Ah, I had it marked as waiting for a reply. But I think we got side
> tracked on the discussion.
> 
> Anyway, this is a trivial patch, I think I can get it in during -rc1.
> 

And it appears that due to the Christmas holidays, I dropped the patch.

I'm adding it to the queue now.

-- Steve
