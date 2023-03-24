Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB10D6C825D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjCXQbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjCXQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8F3469C;
        Fri, 24 Mar 2023 09:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05BDB62BD4;
        Fri, 24 Mar 2023 16:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A9F9C433EF;
        Fri, 24 Mar 2023 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679675467;
        bh=FrqcRhfq8Ns4v7PkuzfuLpnvv8DbtBSesc4kWRkQcpM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XU8DGjvkTHtANmBsg1h4bA4hyAru2QEQqSDnFswpAbLA5bCkW0dOmwn/RSuuuWsuw
         Q3LaeeEFUS6YF9P4Oy2J77hG61qtHZ3Kvy+j2oqbf+UvdfBgWBQpW210hs8bd6ykJc
         SB26w2aBgk9jzvv+nqlL0usaT4gwlwfQ3Q/OHa5e3sdJyRwFe1hZvBvqLeGJXJtD0j
         1npz7Gpt871xVSVNuWdIzn4dK1ISBZflxDd6e6rCRjRM3uY5E5gRX8V/VOJeva23tG
         7BygyJrrAm/YSSbBsrEnssS4fpkPimLOKuauU/+OLmlInbUbKOoRH9r1OYUChp9KrA
         UyLuuuZ231fdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59655E2A039;
        Fri, 24 Mar 2023 16:31:07 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f2515dfb43cd4dd334ea2bda00f8576f69a40178.camel@HansenPartnership.com>
References: <f2515dfb43cd4dd334ea2bda00f8576f69a40178.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f2515dfb43cd4dd334ea2bda00f8576f69a40178.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: a13faca032acbf2699293587085293bdfaafc8ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6dd74c51b48567e6ec56276aa35c8d25f6472f6f
Message-Id: <167967546735.8924.4856686892293566084.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 16:31:07 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Mar 2023 19:36:37 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6dd74c51b48567e6ec56276aa35c8d25f6472f6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
