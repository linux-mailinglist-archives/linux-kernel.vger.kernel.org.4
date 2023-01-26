Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE1B67D094
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjAZPrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjAZPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:47:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D91A30FB;
        Thu, 26 Jan 2023 07:47:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAF07B81E6D;
        Thu, 26 Jan 2023 15:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451F3C433EF;
        Thu, 26 Jan 2023 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674748047;
        bh=I8frgwFUcYsO36nxpCERBITU0p5UkvAZZ8VucmYtFAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OxA0RVm/FOy1VuKPBG5AH8JfppCIydbgsWG6s91I+lSwZzYIjam0T+zZ7SKBIqoWS
         vQ3Ll1+X/PPT3s8+GTfjE4Rn/zewTF0aKxm3BU5Wp+8lgR5pbyOtgID/G3HZP72YNb
         NSLu68APdqBrOLk2FlWk9ktZlwR6xsvJhupANhNYqMRU1cw8nlOcjD5TG2ZGDGN6c7
         oUenUgW/z7nvwHnyxrABXrEOXxjkqy8vmHxuALxbhgHSyRproXKO15E2BvoycKin3L
         Vj7JAZWfvR5F3GscWSO1ZgLSFuH0TWuFNHnscquhnAeeNrHSNP4asCiukufebNv5Pl
         jHH/NxVUrcStQ==
Date:   Thu, 26 Jan 2023 15:47:25 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the tpmdd tree
Message-ID: <Y9KgjQBZX03hL0Cy@kernel.org>
References: <20230123081140.4fbc0aaa@canb.auug.org.au>
 <Y9KgBzb7DTsqoRSV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9KgBzb7DTsqoRSV@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 03:45:14PM +0000, Jarkko Sakkinen wrote:
> On Mon, Jan 23, 2023 at 08:11:40AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commits are also in Linus Torvalds' tree as different
> > commits (but the same patches):
> > 
> >   07e8ac925f39 ("xfs: fix off-by-one error in xfs_btree_space_to_height")
> >   3f5948c5cbb6 ("xfs: xfs_qm: remove unnecessary ‘0’ values from error")
> >   42131102fd2b ("xfs: make xfs_iomap_page_ops static")
> >   650db86fa92e ("xfs: get root inode correctly at bulkstat")
> >   81e251490768 ("xfs: fix extent busy updating")
> >   8c06bf34e6a4 ("Linux 6.2-rc3")
> >   9b56a9ba5a17 ("xfs: Fix deadlock on xfs_inodegc_worker")
> >   b8314b7eee32 ("xfs: don't assert if cmap covers imap after cycling lock")
> >   cb714cbd5150 ("powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT")
> >   d48aa1d1fa3e ("powerpc/vmlinux.lds: Don't discard .comment")
> >   ed70c7b3cd7e ("powerpc/vmlinux.lds: Don't discard .rela* for relocatable builds")
> > 
> > This is clearly caused by a bad rebase of the tpmdd tree :-(
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> 
> Thanks I'll fix it.

$ git log --oneline mainline/master..next
9e01d7dc0796 (HEAD -> next, origin/next, origin/master, origin/HEAD, master) tpm: tis_i2c: Convert to i2c's .probe_new()
d5c71a221b6b tpm: tpm_i2c_nuvoton: Convert to i2c's .probe_new()
3b68fc8c0e81 tpm: tpm_i2c_infineon: Convert to i2c's .probe_new()
3e39b1972330 tpm: tpm_i2c_atmel: Convert to i2c's .probe_new()
0bb7bb8f84f8 tpm: st33zp24: Convert to i2c's .probe_new()
65b5c7776242 KEYS: asymmetric: Fix ECDSA use via keyctl uapi
8a1719d664fb certs: don't try to update blacklist keys
6e7dadceca39 KEYS: Add new function key_create()
b4c45ccd5fcb certs: make blacklisted hash available in klog
8f00541caf05 tpm_crb: Add support for CRB devices based on Pluton
9257ac926329 crypto: certs: fix FIPS selftest dependency

BR, Jarkko
