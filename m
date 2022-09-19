Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D776D5BD612
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiISVET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiISVER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:04:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76FB4BA62;
        Mon, 19 Sep 2022 14:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76367B81C67;
        Mon, 19 Sep 2022 21:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605D7C433C1;
        Mon, 19 Sep 2022 21:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663621454;
        bh=LW7CYJSRHFYN/gb5MZn9Kw9lSzELow4U9z0Yp02eXio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ST6LBWXH2TL0dHV0RZsg5+qtNblclbm+ONEACfp7IdCv6a9FymN2EOWKTyb32CQxW
         fsRDfhrbfT0d6KLO4pLU/dS8Tqlwj64ewQjEMcP1ZD/DlJPTA2ZoTBRAvfymBxXs2o
         2kOYVa0wwaJ0+Yi3hDKDyFPBnvkTKFSJCDODMV34=
Date:   Mon, 19 Sep 2022 14:04:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
Message-Id: <20220919140401.c63f8a81b239e9b8139f54d8@linux-foundation.org>
In-Reply-To: <YyiBF5V6I7SYHqJy@google.com>
References: <20220919082105.73c0e270@canb.auug.org.au>
        <YyiBF5V6I7SYHqJy@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 07:47:51 -0700 "Zach O'Keefe" <zokeefe@google.com> wrote:

> Apologies here.  Yes, the correct Fixes tag should be, based off latest
> mm-unstable,
> 
> Fixes: 8d88fef0b3d8 ("selftests/vm: add thp collapse file and tmpfs testing")
> 
> Now, I'm quite confused as to has this happened as I've been generating
> citations using something similar to the --format string you reference, but
> perhaps this time I chose to do it manually and messed it up.  Anyways, will
> write something to catch these mistakes in the future.

The hashes in mm-unstable change every day.

Doesn't matter, I'll queue fixes against mm-unstable's foo.patch as
foo-fix.patch and I'll squash foo-fix.patch into foo.patch before
moving f.patch into mm-stable.


> Andrew, there are a few changes incoming to the "mm: add file/shmem support to
> MADV_COLLAPSE" series based off recent reviews (including another patch with
> a commit description change).  Perhaps it's easier for me to send a new (v4)
> series to mm-unstable to address these?  Otherwise, I'm not sure how to
> request these metadata changes.

As described above, the metadata gets fixed at this end.  mm-unstable
is called "unstable" for a reason ;)

But yes, I think a replacement series would be best in this case.
