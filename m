Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9BD6C13C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCTNm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjCTNma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:42:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E64E18F;
        Mon, 20 Mar 2023 06:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30D2AB80E94;
        Mon, 20 Mar 2023 13:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80055C433EF;
        Mon, 20 Mar 2023 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679319745;
        bh=naVEH+QIViA3UHAdeSosAsZFojj7/UKSfsNTRhm77zA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSFll3J+o9LlFKwVlEKuDjkF+IAg469ABeibMrvFj8S1GJxYxxO7oiQk3YdnKuf24
         EKqyooi5wRxUKM6PVPMQUvBDwVjHtZJXmBZ9Ln81ptr3FCkWoyURlGwDSB4DDEes0j
         2+qfRMZUPe/AYMcZOmvDhVdrPgHdS6QWEhhpBPSkjeXQ6TPVw52rvuPYZk8vYODeUy
         pZuwuHl5RrCLh6RKQYG2EE/ezs4NVJJlRCdcrcKm0XRB2ouAmiNvCkDJLDFuifxJ3L
         g05gMH18P6L+wyBUBxVi7+47t/Iy5UE2zlMrU7eU+82iGMvwhKsZznDX3sDm4yu+pj
         RpWNsjlGiQAGw==
Date:   Mon, 20 Mar 2023 15:42:22 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas =?utf-8?B?PT9JU08tODg1OS0xP1E/V2VpPURGc2NodWg/PQ==?= 
        <linux@weissschuh.net>, Matthew Garrett <mgarrett@aurora.tech>,
        Uwe =?utf-8?B?PT9JU08tODg1OS0xP1E/S2xlaW5lLUs9RjZuaWc/PQ==?= 
        <u.kleine-koenig@pengutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] tpm: changes for v6.3-rc4
Message-ID: <20230320134222.3pdn4l7nydgtg52w@kernel.org>
References: <20230320133718.m2z4kal4nxhofvbx@kernel.org>
 <20230320134015.k55kgzrzb4zdhjjn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320134015.k55kgzrzb4zdhjjn@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 03:40:18PM +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 20, 2023 at 03:37:18PM +0200, Jarkko Sakkinen wrote:
> > Hi,
> > 
> > Sent because of a build fix for previous PR. Also couple of less important
> > fixes.
> > 
> > BR, Jarkko
> > 
> > The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:
> > 
> >   Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v6.3-rc4
> > 
> > for you to fetch changes up to 923c8dfa9a3640d4dcedd7df12b53254f7e6e4fc:
> > 
> >   tpm: fix build break in tpm-chip.c caused by AMD fTPM quirk (2023-03-20 15:27:03 +0200)
> > 
> > ----------------------------------------------------------------
> > tpm: v6.3-rc4
> > 
> > ----------------------------------------------------------------
> > James Bottomley (1):
> >       tpm: fix build break in tpm-chip.c caused by AMD fTPM quirk
> > 
> > Mark Hasemeyer (1):
> >       tpm: cr50: i2c: use jiffies to wait for tpm ready irq
> > 
> > Yu Zhe (1):
> >       tpm: remove unnecessary (void*) conversions
> > 
> >  drivers/char/tpm/eventlog/common.c  | 6 +++---
> >  drivers/char/tpm/tpm-chip.c         | 2 +-
> >  drivers/char/tpm/tpm_tis_i2c_cr50.c | 3 +--
> >  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> Please ignore. Had a dependency to non-upstream bad. My mistake:
> I tested with a branch containing encrypted hibernation patches.

Ugh :-( "I" = James

BR, Jarkko
