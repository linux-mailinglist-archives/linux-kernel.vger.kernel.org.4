Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A0A74876E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjGEPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjGEPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:05:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1331998;
        Wed,  5 Jul 2023 08:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E78615C9;
        Wed,  5 Jul 2023 15:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CD7C433C7;
        Wed,  5 Jul 2023 15:05:35 +0000 (UTC)
Date:   Wed, 5 Jul 2023 11:05:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, dan.carpenter@linaro.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/trace: Fix cleanup logic of
 enable_trace_eprobe
Message-ID: <20230705110534.1b79bf79@gandalf.local.home>
In-Reply-To: <20230705110302.2492a550@gandalf.local.home>
References: <20230630121627.833560-1-tz.stoyanov@gmail.com>
        <20230701090254.72323659@rorschach.local.home>
        <20230702235001.5bd26b8cd85028fc2bce94e6@kernel.org>
        <CAPpZLN7=m=zMrLz9hwk4TcVJRC42ZsxuwRDjpkUPVxPpMW4v7w@mail.gmail.com>
        <20230705110302.2492a550@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 11:03:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 3 Jul 2023 06:47:12 +0300
> Tzvetomir Stoyanov <tz.stoyanov@gmail.com> wrote:
> 
> > Ok, I'll send v3 with the counter, although I think it is a bit
> > overengineering - that optimization is in code that is unlikely to be
> > executed.  
> 
> It's not really over-engineering. We have this type of logic all over the
> kernel. When rolling back something, you really only want to rollback what
> you did, and not more. It prevents future bugs and makes things a bit more
> robust.
> 
> I'll go pick up v3 now.
> 

Masami, I see you delegated this patch to yourself. If you have something
you are working on to send to Linus soon, I'll let you take it.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

