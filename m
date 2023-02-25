Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F26A27B0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 08:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBYHOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 02:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 02:14:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC43F1AF;
        Fri, 24 Feb 2023 23:14:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D3ACB801BB;
        Sat, 25 Feb 2023 07:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0A5C433D2;
        Sat, 25 Feb 2023 07:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677309242;
        bh=lfRzQHcrsc/JXtXVngh6uBLNX7IgQtx5NOSo4BewTUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDkHLFAzXKoBD8vMsZrA+gOZmE/s+lbQIFztfuO+hxc+YNiL3b5jfapHqoFtNT6uI
         i+weG5XpWssPOEN7w0NFRD2EV3kI/bb1Fb9QxBetbKd7Bz2UskOk+AqtUBswz76VoW
         6ccvL3WvYSb1O/rzGVXd6Qq3Pro09fS2YExKCi9RXaKrSIiy13/LYMlHGax4IGlYv0
         1rjlUjBjxVtGQVKwpufnM9wO5lRYyoLD3yAeXAVfjCWhw4n3bT7wvhGOyaIpBB8eFO
         l9ctY/Jqei9V6F1ZfnO/njossQ6tlxhtDmu2WmAc8uDctiG8xAAF8JgCI97uEi2LkK
         j/HtwX2Nic+Yw==
Date:   Sat, 25 Feb 2023 08:13:55 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20230225071355.437idpjgwy2m3a4d@wittgenstein>
References: <20230225103951.59997ec3@canb.auug.org.au>
 <20230224180443.1247077f0047c70451e7fc97@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230224180443.1247077f0047c70451e7fc97@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 06:04:43PM -0800, Andrew Morton wrote:
> On Sat, 25 Feb 2023 10:39:51 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > Today's linux-next merge of the mm tree got a conflict in:
> > 
> >   mm/shmem.c
> > 
> > between commit:
> > 
> >   7a80e5b8c6fa ("shmem: support idmapped mounts for tmpfs")
> 
> mm/shmem.c is under, umm, mm/.
> 
> Said patch was not made available to the linux-mm subscribers or to the
> shmem.c developers.  It doesn't have a Link: tag and doesn't appear to
> have been cc:linux-kernel and a google search for the title doesn't tell
> me much.

Hey Andrew,

Sorry, I picked up that patch because it deals with a vfs only feature
we maintain. It has no implications for mm and just deals with per-mount
file ownership changes (Detailed documentation under
Documentation/filesystems/idmappings.rst. It needs updates as of v6.3
but is correct otherwise.). While Hugh was Cced I didn't pay more
attention to what lists were Cced. Sorry about that. But again, it
really has no consequences for mm otherwise I'd never have taken it.

Re Link: Patches I pick up don't have Link [1] tags pointing to the
submission on lore as Linus had said in a discussion in 2022 that he
prefers to not have the lore links in the commit message at all.

[1]: https://lore.kernel.org/linux-fsdevel/20230120094346.3182328-1-gscrivan@redhat.com

Thanks!
Christian
