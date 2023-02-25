Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666BE6A26C1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 03:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBYCEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 21:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBYCEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 21:04:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7891ABDE;
        Fri, 24 Feb 2023 18:04:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46ADFB81D71;
        Sat, 25 Feb 2023 02:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9830C433EF;
        Sat, 25 Feb 2023 02:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677290685;
        bh=njB/fBkK89vowMo+PTgMfc1M2mA7IPn6ckS05a9nhBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RgGI57odWPE7MZG8+mP9mLr9EyCWxb5iSatK0AkzNyMvc4uscPHj33BVzDnd7YXZh
         ukUF4ISLmVLo2utwRvj9ZGh8PNvmh9Pt0nkZ4f5s2JHkdnWv7pSP2YyIwnuBPF4N53
         zuEIEgOdeGIi9imbYRqsWkSWReVJjRNpoySZejxY=
Date:   Fri, 24 Feb 2023 18:04:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-Id: <20230224180443.1247077f0047c70451e7fc97@linux-foundation.org>
In-Reply-To: <20230225103951.59997ec3@canb.auug.org.au>
References: <20230225103951.59997ec3@canb.auug.org.au>
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

On Sat, 25 Feb 2023 10:39:51 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the mm tree got a conflict in:
> 
>   mm/shmem.c
> 
> between commit:
> 
>   7a80e5b8c6fa ("shmem: support idmapped mounts for tmpfs")

mm/shmem.c is under, umm, mm/.

Said patch was not made available to the linux-mm subscribers or to the
shmem.c developers.  It doesn't have a Link: tag and doesn't appear to
have been cc:linux-kernel and a google search for the title doesn't tell
me much.

> from Linus' tree and commit:
> 
>   9323c8b93d95 ("mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem")
> 
> from the mm tree.

"mm-unstable tree", thankfully.

Is OK thanks, I'll fix this up when I resync with upstream.

