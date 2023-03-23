Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8A96C5E83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCWFLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCWFL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:11:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4472C2CC53;
        Wed, 22 Mar 2023 22:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AD854CE201F;
        Thu, 23 Mar 2023 05:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29C5C433EF;
        Thu, 23 Mar 2023 05:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679548272;
        bh=fVqUN29p/Hv8Pi5OCwM2X5y2k52PxnaMlxks8rgWa78=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uyzqjg+4N7IJmP9rMbVpXdIuJICEiJLj4uPozBUocqCAOCdAZCkjPUktWDUSQiv+L
         QiA4lihVU+ya3tF31eDfi0gWhvlJdGhWtf3U3/v5P8bSuVuBx8MLdb1gTedzdNKXxW
         0WKD28NcbDRWhBI+J522Gq4i+a3CPCXAu0x5aXQqjjocq5sNuy+Jaq++5S87XyxcIq
         b0izdzpJiOVDAuydfJHFESBoQrd7xDrS34nncNfV+bdIUoiaC/OS8TgdTNQQjObPko
         s0qk6OZHAgkknNF0baZfkYv2cAZGqRxYmEZVp3hS2LcOwA5ukqiHwvQd/bl/l3Nf0B
         H5Q4/XxFtvXkg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 82F341540398; Wed, 22 Mar 2023 22:11:12 -0700 (PDT)
Date:   Wed, 22 Mar 2023 22:11:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <43b7534f-15ee-4cd7-a205-fa16fdb1ab14@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230323144411.0edde523@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323144411.0edde523@canb.auug.org.au>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 02:44:11PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the mm tree as a different commit (but
> the same patch):
> 
>   d70e2ecbc726 ("instrumented.h: Fix all kernel-doc format warnings")
> 
> This is commit
> 
> in the mm tree
> 
>   fa7596e30b4f ("instrumented.h: fix all kernel-doc format warnings")
> 
> (and tommorow it will be commit
> 
>   ce5e77e7b2cc ("instrumented.h: fix all kernel-doc format warnings")
> 
> in the mm tree)

Andrew, do you want to keep this one, or would you rather that I carry it?

I am good either way.

							Thanx, Paul
