Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51A5681A81
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbjA3Tax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbjA3Tat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:30:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8852687;
        Mon, 30 Jan 2023 11:30:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F8C2B8165B;
        Mon, 30 Jan 2023 19:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B3AC433D2;
        Mon, 30 Jan 2023 19:30:42 +0000 (UTC)
Date:   Mon, 30 Jan 2023 14:30:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] trace: acquire buffer from temparary trace sequence
Message-ID: <20230130143041.713c4c7b@gandalf.local.home>
In-Reply-To: <28cd9aca-1945-ceed-2756-162132d576ef@quicinc.com>
References: <1675065249-23368-1-git-send-email-quic_linyyuan@quicinc.com>
        <28cd9aca-1945-ceed-2756-162132d576ef@quicinc.com>
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

On Mon, 30 Jan 2023 21:14:01 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> @Steven current design is not safe, as user still can write to buffer 
> which have no enough space.

I'm assuming that it would never use more that DWC3_MSG_MAX, and that's set
to 500. The size of the trace_seq() is 4096 (or PAGE_SIZE), I doubt it will
ever be an issue.

How do you think the user can still write more than enough?

-- Steve

> 
> do you think it is better to improve dwc3 trace in fast assign path ?
> 


