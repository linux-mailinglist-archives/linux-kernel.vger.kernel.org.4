Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B5A68311C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjAaPPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjAaPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:15:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09458964;
        Tue, 31 Jan 2023 07:13:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D6E36153C;
        Tue, 31 Jan 2023 15:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2215AC433EF;
        Tue, 31 Jan 2023 15:13:02 +0000 (UTC)
Date:   Tue, 31 Jan 2023 10:13:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anton Gusev <aagusev@ispras.ru>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix wrong return in kprobe_event_gen_test.c
Message-ID: <20230131101300.510a47f0@gandalf.local.home>
In-Reply-To: <20230131075818.5322-1-aagusev@ispras.ru>
References: <20230131075818.5322-1-aagusev@ispras.ru>
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

On Tue, 31 Jan 2023 10:58:18 +0300
Anton Gusev <aagusev@ispras.ru> wrote:

> Overwriting the error code with the deletion result may cause the
> function to return 0 despite encountering an error. Commit b111545d26c0
> ("tracing: Remove the useless value assignment in
> test_create_synth_event()") solves a similar issue by
> returning the original error code, so this patch does the same.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Anton Gusev <aagusev@ispras.ru>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks Anton!

-- Steve
