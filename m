Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2590662D14C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbiKQCxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbiKQCxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:53:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86EABCBC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 18:53:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2F0662080
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD1BC433C1;
        Thu, 17 Nov 2022 02:53:28 +0000 (UTC)
Date:   Wed, 16 Nov 2022 21:53:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aashish Sharma <shraash@google.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arun Easi <aeasi@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix warning on variable 'struct trace_array'
Message-ID: <20221116215326.38deff56@gandalf.local.home>
In-Reply-To: <20221107160556.2139463-1-shraash@google.com>
References: <20221107160556.2139463-1-shraash@google.com>
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

On Mon,  7 Nov 2022 21:35:56 +0530
Aashish Sharma <shraash@google.com> wrote:

> Move the declaration of 'struct trace_array' out of #ifdef
> CONFIG_TRACING block, to fix the following warning when CONFIG_TRACING
> is not set:
> 
> >> include/linux/trace.h:63:45: warning: 'struct trace_array' declared  
> inside parameter list will not be visible outside of this definition or
> declaration
> 
> Fixes: 1a77dd1c2bb5 ("scsi: tracing: Fix compile error in trace_array calls when TRACING is disabled")
> Cc: Arun Easi <aeasi@marvell.com>
> Signed-off-by: Aashish Sharma <shraash@google.com>
>

Queued. Thanks Aashish!

-- Steve
