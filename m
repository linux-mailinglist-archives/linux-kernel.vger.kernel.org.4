Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A017A69D6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjBTXMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBTXMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:12:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9DC21A17;
        Mon, 20 Feb 2023 15:12:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6F45CE0FEE;
        Mon, 20 Feb 2023 23:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9ABC433EF;
        Mon, 20 Feb 2023 23:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676934733;
        bh=myAH5eZ5ub5wV5qEDQk1HxOrTlqqHHktJtxtMQt6p1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yiCjlOzxhhpLEudc6C4brpC7YJKxP4z0sCxXrCiiCK6pf6+KXIXp89p/PxCQxiQy1
         tFlbABQG7FUQcJ4hX/Qf0r/cWyL1+okZFuTOtJj3KuxCcUj0sA4m7xMsx5ZkB5M/bB
         hWeuSQaDrsLVrnj2+5F9vSH/KtYYg+6QorVUm5q8=
Date:   Mon, 20 Feb 2023 15:12:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the mm-nonmm-stable tree
Message-Id: <20230220151211.1cdec7528db28a00320a855f@linux-foundation.org>
In-Reply-To: <20230221090827.16d1bf96@canb.auug.org.au>
References: <20230221090827.16d1bf96@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 09:08:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
> 
>   bf470202dd9f ("fs: gracefully handle ->get_block not mapping bh in __mpage_writepage")

CommitDate: Thu Feb 2 22:50:07 2023 -0800

> This is commit
> 
>   7010839ccfd4 ("fs: gracefully handle ->get_block not mapping bh in __mpage_writepage")
> 
> in Linus' tree.

CommitDate: Thu Jan 26 16:46:35 2023 +0100


So I'm wondering why this came to light on Feb 20?

Thanks.
