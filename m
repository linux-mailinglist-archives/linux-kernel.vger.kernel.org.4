Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2166C7123
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjCWTiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjCWTiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A43BCC11;
        Thu, 23 Mar 2023 12:38:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2472E62880;
        Thu, 23 Mar 2023 19:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564DFC433EF;
        Thu, 23 Mar 2023 19:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679600283;
        bh=dGaKZA8A8KfO/ta/dS5PjEMTliu8Xt3rxSYy6IGrzs4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A5TjiufTDyWzyFq1S++++V/Ll9zTJneNUEuk4vGvd4QAe38IHYL+4dUAXqbDTSB4u
         qS4/vfXx92USi8+4BvMcjPyiS/xTyhiqr9BcC6tVOuZ0rLsSpnbYQ6mqXZZegrFRGV
         KUScLVkHqyAFZy6r5rDk+O8SLvm3/4Dh3r68I/Io=
Date:   Thu, 23 Mar 2023 12:38:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-Id: <20230323123802.dabe9aae5de69dd07a88b96b@linux-foundation.org>
In-Reply-To: <20230323135835.747893ef@canb.auug.org.au>
References: <20230320144721.663280c3@canb.auug.org.au>
        <20230323135835.747893ef@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 13:58:35 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > arch/sparc/include/asm/current.h:18:30: warning: call-clobbered register used for global register variable
> >    18 | register struct task_struct *current asm("g4");
> >       |                              ^~~~~~~
> 
> This has come back today.  Did my fix up get dropped accidentally?

Yes, looks like Lorenzo didn't integrate that fixup when redoing.  And
I failed to check for that (I usually do...).
