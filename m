Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548DF64A57C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiLLRFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiLLREo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:04:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919D21115C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:04:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27B9A6115C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E32C433D2;
        Mon, 12 Dec 2022 17:04:40 +0000 (UTC)
Date:   Mon, 12 Dec 2022 12:04:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [for-next][PATCH 02/11] tracing: Add __cpumask to denote a
 trace event field that is a cpumask_t
Message-ID: <20221212120439.0ff806e2@gandalf.local.home>
In-Reply-To: <20221212111256.3cf68f3e@gandalf.local.home>
References: <20221124145019.782980678@goodmis.org>
        <20221124145045.743308431@goodmis.org>
        <6dda5e1d-9416-b55e-88f3-31d148bc925f@arm.com>
        <20221212111256.3cf68f3e@gandalf.local.home>
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

On Mon, 12 Dec 2022 11:12:56 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Another possibility is that I can add parsing to the format that is exposed
> to user space and simply s/__cpumask *[]/__cpumask[]/
> 
> Which will get rid of the pointer array of cpu masks.

Actually, I found a better way to get rid of that "*". Would that work for
you? That is, if the above shows:

   field:__data_loc cpumask_t[] mask;    offset:36;      size:4; signed:0;
   
Instead?

-- Steve
