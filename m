Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB66C679CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjAXPIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjAXPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:08:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98FB127
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:07:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7109B81260
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0EBC433EF;
        Tue, 24 Jan 2023 15:07:55 +0000 (UTC)
Date:   Tue, 24 Jan 2023 10:07:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, erhard_f@mailbox.org,
        ndesaulniers@google.com, mhiramat@kernel.org, sandipan.das@amd.com
Subject: Re: [PATCH 3/3] x86/static_call: Add support for Jcc tail-calls
Message-ID: <20230124100753.13608e1f@gandalf.local.home>
In-Reply-To: <Y8/X6fdRT80jssIf@hirez.programming.kicks-ass.net>
References: <20230123205915.751729592@infradead.org>
        <20230123210607.173715335@infradead.org>
        <20230123174431.4421dfdf@gandalf.local.home>
        <Y8/X6fdRT80jssIf@hirez.programming.kicks-ass.net>
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

On Tue, 24 Jan 2023 14:06:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > Just to confirm, as it's not clear if this is the static call site or one
> > of the functions that is being called.  
> 
> Ah, you've not looked at enough asm then? ;-) Yes this is the static
> call site, see the __SCT_ target (instruction at 0x35d).

Yeah, could you specify it a bit more in the change log such that those
looking back at this don't have to have that requirement of staring at
enough asm ;-)

It's actually been some time since I stared at compiler output (although
now that I'm starting to play with rust, that's going to start back up
soon).

-- Steve
