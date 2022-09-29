Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C285EF656
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiI2NXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiI2NW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055C5147CE8;
        Thu, 29 Sep 2022 06:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F2C26136A;
        Thu, 29 Sep 2022 13:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290EFC433C1;
        Thu, 29 Sep 2022 13:22:54 +0000 (UTC)
Date:   Thu, 29 Sep 2022 09:24:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs, kprobes: Fix the wrong location of Kprobes
Message-ID: <20220929092406.3383b5a1@gandalf.local.home>
In-Reply-To: <75c28f07-4bc7-6094-d264-d7657c40ba88@loongson.cn>
References: <1663322106-12178-1-git-send-email-yangtiezhu@loongson.cn>
        <20220926142218.100e0d9b@gandalf.local.home>
        <75c28f07-4bc7-6094-d264-d7657c40ba88@loongson.cn>
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

On Thu, 29 Sep 2022 18:01:01 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> On 09/27/2022 02:22 AM, Steven Rostedt wrote:
> > On Fri, 16 Sep 2022 17:55:06 +0800
> > Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >  
> >> After commit 22471e1313f2 ("kconfig: use a menu in arch/Kconfig to reduce
> >> clutter"), the location of Kprobes is under "General architecture-dependent
> >> options" rather than "General setup".
> >>  
> >
> > Probably add a "Fixes:" tag for the above mentioned commit.
> >
> > Anyway, Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> 
> Thank you.
> 
> Do you know which tree this patch will go through?

I believe that Jon can take it through his documentation tree.

> Is it necessary to send v2 with "Fixes:" tag?

No, Jon could add it.

Thanks,

-- Steve
