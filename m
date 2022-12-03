Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DFC641880
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 19:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLCS7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 13:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLCS7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 13:59:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E918B0B;
        Sat,  3 Dec 2022 10:58:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CB1260C22;
        Sat,  3 Dec 2022 18:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43036C433C1;
        Sat,  3 Dec 2022 18:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670093938;
        bh=SNhCoKOPfx4WrAVg/q/qFWAYIr/Cf9IY7ocpzAH/B+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4mGJKgcDWJ1Mz5LeWr8aXlSQQW9I/nd/ylVfzp3dXJwmR5Ts4r8t95aMGJZYGamK
         JBmUC3iQ7PtEESWG26SIfUXfqBxw2uCLDPb6ZxE8cJwlIb6Dh+XFDTQ+VvaUf0/2fi
         2uVokEubQd6gfpkp9kaa/mKYrwkKBXYty0VAzuYX7J4hMfwAYU0GPBOij9i6At/0/P
         cSJZQod42TQ3U70g9yumhlEYkPOY5Xndj/QZdgHXaSC2xRDA5vDu9Wyh7yrqQtnwLi
         h3nlNPljcFp3Mt0VlapmJQHOqMxG2/8mMmf2Y0NEUDLvbljeVFj/KPiLmUikgzkfUb
         u8yR/n8oNl12g==
From:   SeongJae Park <sj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        sj@kernel.org, stable-commits@vger.kernel.org
Subject: Re: Patch "mm/damon/sysfs: fix wrong empty schemes assumption under online tuning in damon_sysfs_set_schemes()" has been added to the 6.0-stable tree
Date:   Sat,  3 Dec 2022 18:58:54 +0000
Message-Id: <20221203185854.159885-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y4s0x8aOxb2w+2wR@kroah.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sat, 3 Dec 2022 12:36:39 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sat, Dec 03, 2022 at 12:23:48PM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     mm/damon/sysfs: fix wrong empty schemes assumption under online tuning in damon_sysfs_set_schemes()
> > 
> > to the 6.0-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      mm-damon-sysfs-fix-wrong-empty-schemes-assumption-under-online-tuning-in-damon_sysfs_set_schemes.patch
> > and it can be found in the queue-6.0 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> 
> Nope, breaks the build, now dropped.

Thank you for letting me know this.

It needs commit f5a79d7c0c87 ("mm/damon: introduce struct
damos_access_pattern") to build.  Sorry for not noticing this before.  Could
you please add the commits together?


Thanks,
SJ
