Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EF26F92D6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjEFPqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjEFPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:46:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CBD1AED9;
        Sat,  6 May 2023 08:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8668F61090;
        Sat,  6 May 2023 15:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF53CC4339C;
        Sat,  6 May 2023 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683387965;
        bh=iImZRb7Z9X6K38AcNa9k7oLF5Iv6jC8+p65in2Ohhec=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CDP9IHtSS8ucz4xvDCN7EJooS6ZcIGPaAwfwFgpG5mU2+EAE6LkSflc9jP7dyfuH1
         Tw8jeHyISnqhS5Ec8iSE5vbzeQlhzMMhQaeFOUZeNFAV/ouC8UL3G1zhrTNMYhm3tf
         KI97Z6e8z6ypUChUej3VtHNrGfDl9ZTEfRS1uurLuR1OkaTxkpFqQLnJ3kgaL60gG7
         u/zsRQm+5HXh3dTI26OAq2JVEXF04M0Htj235FEFPeMiuBfll6L39pxNyActTceHWV
         CxgA7l8jKvp7F/bJf1iTk0mRuOkHQaFYMB1N2IBbupCu+wdc2BPcXWn0ov4YNAUd5C
         fMjXipPOQyFTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC364C41677;
        Sat,  6 May 2023 15:46:04 +0000 (UTC)
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.3+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8cee6d6bfe70066bcfdb5497ec2a468e8b2e5682.camel@HansenPartnership.com>
References: <8cee6d6bfe70066bcfdb5497ec2a468e8b2e5682.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <8cee6d6bfe70066bcfdb5497ec2a468e8b2e5682.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: c5749639f2d0a1f6cbe187d05f70c2e7c544d748
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd9e11d6477a52ede9ebe575c83285e79e823889
Message-Id: <168338796489.28822.65294900563011369.pr-tracker-bot@kernel.org>
Date:   Sat, 06 May 2023 15:46:04 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 06 May 2023 08:27:13 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd9e11d6477a52ede9ebe575c83285e79e823889

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
