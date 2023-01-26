Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F5167D727
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjAZVCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjAZVCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:02:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84CE559F;
        Thu, 26 Jan 2023 13:02:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3FA94CE2383;
        Thu, 26 Jan 2023 21:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B821BC433EF;
        Thu, 26 Jan 2023 21:02:41 +0000 (UTC)
Date:   Thu, 26 Jan 2023 16:02:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] docs: ftrace: always use canonical ftrace path
Message-ID: <20230126160240.0c2375c5@gandalf.local.home>
In-Reply-To: <CAGRrVHwykqUBREOAVB0tYQiVT5VsHKpda4POtR_k6j3oxDUTSQ@mail.gmail.com>
References: <20230125213251.2013791-1-zwisler@google.com>
        <87a6259mll.fsf@meer.lwn.net>
        <20230126153438.5e98da15@gandalf.local.home>
        <CAGRrVHwykqUBREOAVB0tYQiVT5VsHKpda4POtR_k6j3oxDUTSQ@mail.gmail.com>
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

On Thu, 26 Jan 2023 13:41:05 -0700
Ross Zwisler <zwisler@google.com> wrote:

> Yep, I'll send out patches to take care of the rest, just wanted to
> send this out since I had it ready.
> I'm planning on dividing up the patches by subsystem/maintainer, but
> am open to suggestions if that sounds incorrect.

Breaking it up by subsystem/maintainer sounds like the right approach.

Thanks Ross,

-- Steve
