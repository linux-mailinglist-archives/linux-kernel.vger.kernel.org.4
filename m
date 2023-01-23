Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C673A677FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjAWPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjAWPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:33:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD22113D8;
        Mon, 23 Jan 2023 07:33:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FFE3B80CA9;
        Mon, 23 Jan 2023 15:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BBAC433D2;
        Mon, 23 Jan 2023 15:33:45 +0000 (UTC)
Date:   Mon, 23 Jan 2023 10:33:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        linux-trace-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Documentation: kprobetrace: Improve readability
Message-ID: <20230123103341.56f42e72@gandalf.local.home>
In-Reply-To: <20230122083138.300ab49e15c7b3de13f0f121@kernel.org>
References: <20230121225304.1711635-1-yoann.congal@smile.fr>
        <20230122083138.300ab49e15c7b3de13f0f121@kernel.org>
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

On Sun, 22 Jan 2023 08:31:38 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Sat, 21 Jan 2023 23:53:02 +0100
> Yoann Congal <yoann.congal@smile.fr> wrote:
> 
> > Hi,
> > 
> > Version 3 of this series of small readability fixes on kprobetrace.rst.
> > 
> > v1: https://lore.kernel.org/linux-doc/20220915153358.813993-1-yoann.congal@smile.fr/  
> 
> Thanks for fixing document!
> 
> This series looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> for this series.
> 
>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Jon, care to take this series through your tree?

Thanks,

-- Steve
