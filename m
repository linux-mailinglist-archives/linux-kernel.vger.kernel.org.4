Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6454567B6DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjAYQXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjAYQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:23:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B425A368
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:22:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7879E60C88
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E271EC433EF;
        Wed, 25 Jan 2023 16:22:55 +0000 (UTC)
Date:   Wed, 25 Jan 2023 11:22:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuang Wang <nashuiliang@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Natalia Petrova <n.petrova@fintech.ru>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [for-linus][PATCH 00/11] tracing: Updates for 6.2
Message-ID: <20230125112252.53b48267@gandalf.local.home>
In-Reply-To: <20230125161824.332648375@goodmis.org>
References: <20230125161824.332648375@goodmis.org>
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

On Wed, 25 Jan 2023 11:18:24 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> ftrace/urgent

Actually, that will be trace/urgent (had it in the wrong branch :-p)

-- Steve
