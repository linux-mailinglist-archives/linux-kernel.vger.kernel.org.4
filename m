Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B76F606B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 23:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjECVGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 17:06:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDDC7A94
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 14:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6034563003
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 21:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A5BC433EF;
        Wed,  3 May 2023 21:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683147970;
        bh=BJaWoQEwi1nsRGaASt1366eU6W3XLddSBQxqT3JtCXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DxuYsd9iiuRdr6p7QdaO8G+QMUAoci3OATTy+KDSrBag9t1Z9E/S2g29TRr9nQz8J
         7z32VV9tA6DzSnMc8u4PNFwIoJahMxhtLeYBqtc69/E3tT0+JlyCz4SuOkPOsbrdv5
         LfgKFUuKkAMpLvsqo7ktPKou0bea0oA9OJxzGV7c=
Date:   Wed, 3 May 2023 14:06:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Danila Chernetsov <listdansp@mail.ru>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Linux Memory Management <linux-mm@kvack.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: ntfs orphan? (was Re: [PATCH] ntfs: do not dereference a null
 ctx on error)
Message-Id: <20230503140609.e65bdc2b0e55ba6f49bbb620@linux-foundation.org>
In-Reply-To: <ZFHgAhisxjKQxhLx@debian.me>
References: <20230407194433.25659-1-listdansp@mail.ru>
        <ZFHgAhisxjKQxhLx@debian.me>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2023 11:16:02 +0700 Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> On Fri, Apr 07, 2023 at 07:44:33PM +0000, Danila Chernetsov wrote:
> > In ntfs_mft_data_extend_allocation_nolock(), if an error condition occurs
> > prior to 'ctx' being set to a non-NULL value, avoid dereferencing the NULL
> > 'ctx' pointer in error handling.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Duplicate of 10-years-old outstanding patch at [1].

Well, the patches are actually quite different.  Is Danila's longer one
better?

> I'm not speaking of the patch itself but rather on unfortunate state
> of ntfs subsystem. It seems like the maintainer is MIA (has not
> responding to patch submissions for a long time). Some trivial
> patches, however, are merged through mm tree.
> 
> Konstantin (from newer ntfs3 subsystem), Andrew, would you like to take a
> look on this orphaned subsystem (and help reviewing)? I'd like to send
> MAINTAINERS update if it turns out to be the case.
> 

Sure, I can join linux-ntfs-dev@lists.sourceforge.net and hendle things
which come along.

Or Christian may want to do that?

> 
> [1]: https://lore.kernel.org/all/1358389709-20561-1-git-send-email-nickolai@csail.mit.edu/


