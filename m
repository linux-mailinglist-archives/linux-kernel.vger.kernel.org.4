Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93A869757D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjBOEog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBOEod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:44:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A53A5FE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 20:44:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83BA661A1E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73B1C433D2;
        Wed, 15 Feb 2023 04:44:28 +0000 (UTC)
Date:   Tue, 14 Feb 2023 23:44:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     x86@kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip v2] x86/kprobes: Remove unneeded casting from
 immediate value
Message-ID: <20230214234426.2376ffd1@rorschach.local.home>
In-Reply-To: <167641982421.1677831.18379341946856978545.stgit@mhiramat.roam.corp.google.com>
References: <167641982421.1677831.18379341946856978545.stgit@mhiramat.roam.corp.google.com>
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

On Wed, 15 Feb 2023 09:10:24 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Remove unneeded casting from immediate value assignments for relative
> jump offset. Since the immediate values in the 'insn' data structure are
> assigned from immediate bytes as a signed value to insn.immediate.value
> by insn_field_set(). Thus, if we need to access that value as a signed
> value (in this kprobe's case), we don't need to cast it.
> This is a kind of clean up (should not change behavior) follows Nadav's
> bugfix.
> 
> Link: https://lore.kernel.org/all/20230208071708.4048-1-namit@vmware.com/
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v2:
>   - Remove meaningless immediate size branches too.
>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
