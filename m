Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608256F89AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjEETnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjEETnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80641BE4;
        Fri,  5 May 2023 12:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 540526403E;
        Fri,  5 May 2023 19:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809E7C433D2;
        Fri,  5 May 2023 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683315823;
        bh=T5l6dCqo8uMqAE9WymPOpZEzKUonWCblD9zWQKPe/zA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jcPs6Nm6/3xa+PQ0mSfWkbKxZ9VUhyheDiN8a4JLxjBrgXT0GYONOB1ksgu6pJXOe
         v/hlUk7rY7lImDYAXiZ5n+JwgQFHZ/5RiM+3cDomJQv34TiBL/M19xzsa/zycpYhJW
         sM+SsxzPTxmqnJ5pIO6URw0dB8UJPhDcfYmDeG+H3pwJhUni5rP0QEQa0eXqU8iNGC
         rSB1HI2gojRZ2i+uleZXdJuZ5UQW2+yCFn4jA9/l/g+PW+I3FIvrx+eYMt75OjKXL8
         KXx+bJUaBwDpkUfspkSRcWsyseAv21vAW51sv5ROEPio0uKeeu7nMnJYodWpISOLUa
         SYEtAn8gNA9HA==
Date:   Fri, 5 May 2023 12:43:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     workflows@vger.kernel.org, aros@gmx.com,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        tools@linux.kernel.org, linux@leemhuis.info
Subject: Re: Introducing bugbot
Message-ID: <20230505124342.5ed51cc7@kernel.org>
In-Reply-To: <20230505-blunt-corncob-6e6e95@meerkat>
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
        <20230505085218.60c62d75@kernel.org>
        <20230505-lent-swoosh-4897e2@meerkat>
        <20230505123226.731d8ff8@kernel.org>
        <20230505-blunt-corncob-6e6e95@meerkat>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 15:39:38 -0400 Konstantin Ryabitsev wrote:
> On Fri, May 05, 2023 at 12:32:26PM -0700, Jakub Kicinski wrote:
> > Interesting. Obviously that assumes the bug needs a fix, and we're
> > talking bugzilla so lots of clueless people lobbing non-issues at us.  
> 
> This is why anyone can create a bug on bugzilla, but only a subset of people
> can enable bugbot on it (by setting the bugbot+ flag).

Makes sense!

> > But also - Closes: is a legit trailer now? I thought we only allow Link:  
> 
> It's a semi-legit trailer and is going through -next:
> https://docs.kernel.org/next/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Ah, must have come in this merge window, cause we don't have that text 
in networking trees yet. GTK.

> > In any case - I'm guessing I just don't have permissions to close the
> > issues via web. Is your preference to iterate on the bot or maintainers
> > to request permissions in BZ (how?)?  
> 
> Yes, it's not a power granted by default, but people just need to ask.
> You should have this awesome power now.

Can confirm, thanks!
