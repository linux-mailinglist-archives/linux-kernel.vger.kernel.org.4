Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E566286F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiKNRXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbiKNRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:22:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DB421E27
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:22:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46B92B8109D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 17:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34405C433C1;
        Mon, 14 Nov 2022 17:22:27 +0000 (UTC)
Date:   Mon, 14 Nov 2022 12:23:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     alison.schofield@intel.com, davidgow@google.com,
        thunder.leizhen@huawei.com, jianlv@ebay.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracepoint: Allow livepatch module add trace event
Message-ID: <20221114122255.72588f45@gandalf.local.home>
In-Reply-To: <20221102160236.11696-1-iecedge@gmail.com>
References: <20221102160236.11696-1-iecedge@gmail.com>
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

On Wed,  2 Nov 2022 16:02:36 +0000
Jianlin Lv <iecedge@gmail.com> wrote:

> In the case of keeping the system running, the preferred method for
> tracing the kernel is dynamic tracing (kprobe), but the drawback of
> this method is that events are lost, especially when tracing packages
> in the network stack.

I'm not against this change, but the above is where I'm a bit confused. How
are events more likely to be lost with kprobes over a static event?

-- Steve
