Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42496349CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiKVWIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiKVWIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:08:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2150C70186
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:07:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE2AE618E5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 22:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C800C433C1;
        Tue, 22 Nov 2022 22:07:55 +0000 (UTC)
Date:   Tue, 22 Nov 2022 17:07:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        revest@chromium.org
Subject: Re: [PATCH 2/3] ftrace: export ftrace_free_filter() to modules
Message-ID: <20221122170754.7962724c@gandalf.local.home>
In-Reply-To: <20221122165938.353ee7c0@gandalf.local.home>
References: <20221103170907.931465-1-mark.rutland@arm.com>
        <20221103170907.931465-3-mark.rutland@arm.com>
        <20221122165938.353ee7c0@gandalf.local.home>
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

On Tue, 22 Nov 2022 16:59:38 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > + * This can allocate memory which must be freed before @ops can be freed,
> > + * either by remvoing eached filtered addr or by using  
> 
> I love how you cut and pasted two typos four times. ;-)

Besides the "remvoing" and "eached"...

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

But please send a v2.

-- Steve
