Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7568A70B96E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjEVJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjEVJxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:53:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21DAE9;
        Mon, 22 May 2023 02:53:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 62355219CD;
        Mon, 22 May 2023 09:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684749189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tAwcv/0opqfAzTbZ8LE0GBtCVCfivuLmJ0kcePdhuY=;
        b=s3s3DclJNCwaeJ9NFCQUFHdp4pkETcTo5YzWGy+WPgte0mb7JqT3ABd+YPspWJ8hSvwj4G
        wqLi9x/0LsNH7GuKx8EJjSRwk5xkL1KasUR/OsHy+nxarb10mDlYRCUV4s3hRvpL6SclWA
        sa/AhHPyzQebet5WBez2jG5AcWW+I38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684749189;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tAwcv/0opqfAzTbZ8LE0GBtCVCfivuLmJ0kcePdhuY=;
        b=fk5AIWrEN2Pty919DCwiJny2xQwClVGTKKR2gDmHjB/c4VM/kEgyk6xuc22QrleutCMwe1
        Vl8HZucOtpm8bzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4964313336;
        Mon, 22 May 2023 09:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9i7gEYU7a2QJfwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 22 May 2023 09:53:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A9ED5A075B; Mon, 22 May 2023 11:53:08 +0200 (CEST)
Date:   Mon, 22 May 2023 11:53:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jan Kara <jack@suse.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] SPDX conversion from UDF
Message-ID: <20230522095308.ypwi5txynkbvnfw7@quack3>
References: <20230522005434.22133-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522005434.22133-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-05-23 07:54:33, Bagas Sanjaya wrote:
> This small SPDX conversion series targets UDF file system, which is
> splitted from v2 of my SPDX conversion series that is triggered by
> Didi's GPL full name fixes [1]. It is done to ease review.
> 
> All boilerplates in fs/udf/ is converted, except fs/udf/ecma_167.h.
> The latter file apparently looks like 2-clause BSD Source-Code
> license, yet the second clause is from third clause of 3-Clause BSD.
> This custom license can't be expressed satisfiably in SPDX license
> identifier, hence the file doesn't get converted.
> 
> This series is based on mm-nonmm-unstable branch.
> 
> Changes since v1 [2]:
>   * Correct SPDX tag for LGPL (correct spdxcheck warning)
> 
> [1]: https://lore.kernel.org/linux-spdx/20230512100620.36807-1-bagasdotme@gmail.com/
> [2]: https://lore.kernel.org/linux-mm/20230517083344.1090863-1-bagasdotme@gmail.com/
> 
> Bagas Sanjaya (2):
>   fs: udf: Replace GPL 2.0 boilerplate license notice with SPDX
>     identifier
>   fs: udf: udftime: Replace LGPL boilerplate with SPDX identifier

The patches look good to me. So unless someone objects in a few days, I'll
queue them into my tree. Thanks!

								Honza

> 
>  fs/udf/balloc.c    |  6 +-----
>  fs/udf/dir.c       |  6 +-----
>  fs/udf/directory.c |  6 +-----
>  fs/udf/file.c      |  6 +-----
>  fs/udf/ialloc.c    |  6 +-----
>  fs/udf/inode.c     |  6 +-----
>  fs/udf/lowlevel.c  |  6 +-----
>  fs/udf/misc.c      |  6 +-----
>  fs/udf/namei.c     |  6 +-----
>  fs/udf/partition.c |  6 +-----
>  fs/udf/super.c     |  6 +-----
>  fs/udf/symlink.c   |  6 +-----
>  fs/udf/truncate.c  |  6 +-----
>  fs/udf/udftime.c   | 18 ++----------------
>  fs/udf/unicode.c   |  6 +-----
>  15 files changed, 16 insertions(+), 86 deletions(-)
> 
> 
> base-commit: 7e61b33831bc7680b24bc04af9ed9c1553dac406
> 
> Range-diff against v1:
> 
> 1:  442194d17ed043 = 1:  30fb64a215be1c fs: udf: Replace GPL 2.0 boilerplate license notice with SPDX identifier
> 2:  ccb407446ab324 ! 2:  f7cfeaa5cec879 fs: udf: udftime: Replace LGPL boilerplate with SPDX identifier
>     @@ Commit message
>      
>       ## fs/udf/udftime.c ##
>      @@
>     -+// SPDX-License-Identifier: LGPL-2.0-or-later
>     ++// SPDX-License-Identifier: LGPL-2.0+
>       /* Copyright (C) 1993, 1994, 1995, 1996, 1997 Free Software Foundation, Inc.
>          This file is part of the GNU C Library.
>      -   Contributed by Paul Eggert (eggert@twinsun.com).
> 
> -- 
> An old man doll... just what I always wanted! - Clara
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
