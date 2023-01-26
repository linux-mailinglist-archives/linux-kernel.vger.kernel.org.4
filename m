Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A1567D08F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjAZPp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjAZPpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:45:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB4E2686A;
        Thu, 26 Jan 2023 07:45:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18DBA61896;
        Thu, 26 Jan 2023 15:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24238C433D2;
        Thu, 26 Jan 2023 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674747914;
        bh=LHRHDzLm9LWFpExQnuxPr8v2tFfVJzIuUrxWWsNuf3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eh6ohAlNGPuQh+oWljwE65VWJlgdvpk5EstZJBFPQuiCUv+1zs+o9THi0w7mDp2uV
         4MjxNp+bweut1H0AZdEVumdEFm3v+P6kFOayCKZR8OYL2EArUJM4Is643I85D0ETHA
         MepRrMNrDiObKli2DHZqJtUUJHhxbjmvespsHcJ4YjPj70fFzKsbDsnwpoQY5LHmVx
         igWkaGieidB05INEXk3TWzSCr9TyCl9yId0wIs1OWABwjOt7WKN2tiahR907BinN3V
         MSgeMSD+D4vdGA7dfy1aduYUW55Luf/2ApvbxAGkDlYgeFhcH2CSh9Rlh4hLvCTxh5
         1S3WG+rbiFTHg==
Date:   Thu, 26 Jan 2023 15:45:11 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the tpmdd tree
Message-ID: <Y9KgBzb7DTsqoRSV@kernel.org>
References: <20230123081140.4fbc0aaa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230123081140.4fbc0aaa@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 08:11:40AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   07e8ac925f39 ("xfs: fix off-by-one error in xfs_btree_space_to_height")
>   3f5948c5cbb6 ("xfs: xfs_qm: remove unnecessary ‘0’ values from error")
>   42131102fd2b ("xfs: make xfs_iomap_page_ops static")
>   650db86fa92e ("xfs: get root inode correctly at bulkstat")
>   81e251490768 ("xfs: fix extent busy updating")
>   8c06bf34e6a4 ("Linux 6.2-rc3")
>   9b56a9ba5a17 ("xfs: Fix deadlock on xfs_inodegc_worker")
>   b8314b7eee32 ("xfs: don't assert if cmap covers imap after cycling lock")
>   cb714cbd5150 ("powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT")
>   d48aa1d1fa3e ("powerpc/vmlinux.lds: Don't discard .comment")
>   ed70c7b3cd7e ("powerpc/vmlinux.lds: Don't discard .rela* for relocatable builds")
> 
> This is clearly caused by a bad rebase of the tpmdd tree :-(
> 
> -- 
> Cheers,
> Stephen Rothwell

Thanks I'll fix it.

BR, Jarkko
