Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37108633175
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKVAkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKVAk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:40:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73342721
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:40:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 910ADB818BF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F72C433C1;
        Tue, 22 Nov 2022 00:40:23 +0000 (UTC)
Date:   Mon, 21 Nov 2022 19:40:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>, Chris Mason <clm@meta.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] error-injection: Add prompt for function error
 injection
Message-ID: <20221121194022.683e22c7@gandalf.local.home>
In-Reply-To: <20221121192423.1ab25c4d@gandalf.local.home>
References: <20221121104403.1545f9b5@gandalf.local.home>
        <Y3vSQo85ofkfD/L8@zn.tnic>
        <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
        <20221121192423.1ab25c4d@gandalf.local.home>
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

On Mon, 21 Nov 2022 19:24:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 21 Nov 2022 15:36:08 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > The commit log is bogus and the lack of understanding what
> > bpf and error injection hooks are used for expressed
> > in this thread is quite sad.
> > Disabling error injection makes the system _less_ secure.  
> 
> Please specify.
> 
> As Masami replied, you are abusing this feature for some arcane way to do
> security. It's "error injection" how does enabling this improve security???
>

If you want to add BPF programs to determine who or what can access various
functions, then please work with the security folks and hook into their
infrastructure. Please do not make some home grown operations on top of an
interface that was not created for this purpose. That can only lead to
unexpected consequences.

-- Steve
