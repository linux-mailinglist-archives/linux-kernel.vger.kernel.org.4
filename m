Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38766A48A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjB0RzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjB0RzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:55:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768CD14EBD;
        Mon, 27 Feb 2023 09:55:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DB4960EA4;
        Mon, 27 Feb 2023 17:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB44C4339B;
        Mon, 27 Feb 2023 17:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677520518;
        bh=Gg1PrIqbpLkGQONlbbbPq62LBjWYn8JkZK6skP1Kkzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=el14UImsZH1o/cuc+yW+knWgrX7Wg7XxG+Pt6HZErVO9WFfnF7YRDuqPblb41K2ds
         eitC0htr8HpyxIx7yQ2RoSlJssIN9108U5DF2jpI2kpuymDh8TwGlOfA9gZaeUfnh7
         l68fKRGFLbkIpE7x7zKurOXiZyHCUO7Gey261zTA=
Date:   Mon, 27 Feb 2023 09:55:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-Id: <20230227095517.284d7f6bfb9bcf0956740d9a@linux-foundation.org>
In-Reply-To: <20230227101849.mhqssqw56vphwy3k@wittgenstein>
References: <20230225103951.59997ec3@canb.auug.org.au>
        <20230224180443.1247077f0047c70451e7fc97@linux-foundation.org>
        <20230225071355.437idpjgwy2m3a4d@wittgenstein>
        <20230225125227.8d8e81f72a586aed77b67423@linux-foundation.org>
        <20230227101849.mhqssqw56vphwy3k@wittgenstein>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 11:18:49 +0100 Christian Brauner <brauner@kernel.org> wrote:

> On Sat, Feb 25, 2023 at 12:52:27PM -0800, Andrew Morton wrote:
> > On Sat, 25 Feb 2023 08:13:55 +0100 Christian Brauner <brauner@kernel.org> wrote:
> > 
> > > Re Link: Patches I pick up don't have Link [1] tags pointing to the
> > > submission on lore as Linus had said in a discussion in 2022 that he
> > > prefers to not have the lore links in the commit message at all.
> > 
> > Surprised.  What was his reasoning?
> 
> Sorry, it took me a while to track down the mail where he complained
> about that:
> 
> https://lore.kernel.org/lkml/20220516045821-mutt-send-email-mst@kernel.org/T/
> 
> I generally think they are useful but I also don't have a strong opinion
> on this matter.

Well, I cheerfully disagree.  A Link: to the original patch submission
also guides the reader to any followup discussion.
