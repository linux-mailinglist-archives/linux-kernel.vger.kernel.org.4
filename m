Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787B8636EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKXANU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXANR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:13:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B94926123;
        Wed, 23 Nov 2022 16:13:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3716161F82;
        Thu, 24 Nov 2022 00:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7034DC433D6;
        Thu, 24 Nov 2022 00:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669248795;
        bh=tSZZanP7qrvlFJT/sNP6C4cmKLPsR8ixiTuNYSxcDJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Hlynf8iqE1hGw7d95+4Rkx8Bzs57fu17eRhoQIQxQpZ4j7Xq8FbLJex7ZwAzgqV6
         pwEG0rO05psdzZy3+IsEnGR8HnQzPRLBH7UFhnWhTLSrkCYIKgRxIEF+z+8OYLRfkG
         gviSWzS2lws4oP41EspLQNxvrDnI7+potPKa+0Vw=
Date:   Wed, 23 Nov 2022 16:13:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
Message-Id: <20221123161312.48c1a103da3e4c2df8da7bf9@linux-foundation.org>
In-Reply-To: <CAG48ez31N1S6g1h8HT8Wxvt8a5m7Y1gJ6JKkVTB2z9G8AGbONA@mail.gmail.com>
References: <20221124090815.7e550d88@canb.auug.org.au>
        <CAG48ez31N1S6g1h8HT8Wxvt8a5m7Y1gJ6JKkVTB2z9G8AGbONA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 00:06:28 +0100 Jann Horn <jannh@google.com> wrote:

> On Wed, Nov 23, 2022 at 11:08 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > In commit
> >
> >   d5d60d30f574 ("mmu_gather: Use macro arguments more carefully")
> >
> > Fixes tag
> >
> >   Fixes: a6d60245d6d9 ("asm-generic/tlb: Track which levels of the page table=
> >
> > has these problem(s):
> 
> I'm not sure what happened here - when I apply the mail that I sent
> with "git am", the "Fixes" line is properly one line. But in the
> version that landed in the tree, it looks as if the quoted-printable
> encoding was not decoded for that one line?

My email client has trouble decoding the quoted-printable stuff.  I
have a nightly script which tells me about stragglers, but Stephen
sometimes gets there first.  99% of people use
Content-Transfer-Encoding: 8bit.


