Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53680662993
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbjAIPOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbjAIPNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:13:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC463753F;
        Mon,  9 Jan 2023 07:12:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593A56118B;
        Mon,  9 Jan 2023 15:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0A2C433D2;
        Mon,  9 Jan 2023 15:12:28 +0000 (UTC)
Date:   Mon, 9 Jan 2023 10:12:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Quanfa Fu <quanfafu@gmail.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing/eprobe: no need to check for negative ret
 value for snprintf
Message-ID: <20230109101226.7f75fc0e@gandalf.local.home>
In-Reply-To: <20230109235913.8ac99d54cff8b7c3fc5dcfa4@kernel.org>
References: <20230109040625.3259642-1-quanfafu@gmail.com>
        <20230109235913.8ac99d54cff8b7c3fc5dcfa4@kernel.org>
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

On Mon, 9 Jan 2023 23:59:13 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon,  9 Jan 2023 12:06:25 +0800
> Quanfa Fu <quanfafu@gmail.com> wrote:
> 
> > No need to check for negative return value from snprintf() as the
> > code does not return negative values.
> >   
> 
> Thanks for simplifying, this looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Masami, do you want to take it into the probes branch, or do you want me to
take it into the tracing branch?

-- Steve


> 
> > Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
> > 
