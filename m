Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3673B2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjFWIhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:37:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C877EC6;
        Fri, 23 Jun 2023 01:37:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 439D56199F;
        Fri, 23 Jun 2023 08:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75531C433C0;
        Fri, 23 Jun 2023 08:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687509420;
        bh=j/8yv1geRksB8yZCizmbt8vPeQ+X4F73RDWW++AWaNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tbj2m3xc3q9jG/MqbkmqV4WQcrvZFpSelN0FtHFJT3sfODMB3ZesiJoOOn5Z6J+wV
         +k61rwBiPS6dQOvkNsOO6mpkw3ANRuP1ypaNpmHI/IlW364Lgz0beImthz4i4XYOwH
         7fU0eFJCd/PF0JhvFVJUqDUG3ko2qq/ExZQGPaKFMIdMw19QrAH7R15G1FcBz5t9fb
         rh/hlNF/vGqhGu4s2sS0VjpEOPaS8GDiS9ToMzJSvoVcObLAcaRnY/nCWY8EFljD78
         vk4LLUblBZ6sFD8PRFWyQVFhsq3jun05pp2Qt/IkQqC3sWcKobdaxgHmDPjlCi88Yi
         NkaVhQRMLwZmg==
Date:   Fri, 23 Jun 2023 17:36:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the ftrace tree
Message-Id: <20230623173657.44901820f684668d5b38da26@kernel.org>
In-Reply-To: <20230622184840.1dd4e945@gandalf.local.home>
References: <20230623083456.1aa36194@canb.auug.org.au>
        <20230622184840.1dd4e945@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 18:48:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 23 Jun 2023 08:35:50 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > Commits
> > 
> >   e46ad59233cf ("selftests/ftrace: Add new test case which checks for optimized probes")
> >   bd2cdc432190 ("selftests/ftrace: Add new test case which adds multiple consecutive probes in a function")
> > 
> > are missing a Signed-off-by from their committer.
> > 
> 
> Masami, can you rebase and fix those commits?

Oops, yes. 
Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
