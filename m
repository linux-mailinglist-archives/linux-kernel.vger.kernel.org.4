Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3C16AA554
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjCCXFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjCCXE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:04:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BAA5CF;
        Fri,  3 Mar 2023 15:04:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 777B9B81A0C;
        Fri,  3 Mar 2023 23:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3968DC433D2;
        Fri,  3 Mar 2023 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677884664;
        bh=QC7IkASzfgr8S/jSIfmbViPcDXgTwRHh2Y1CaxMl73U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OA+Vm5m8lH5icW2rG9WSLYQ0bAYyJy1CS4EHhqkJKNWxxqfRuqDNNsAtWhf9WCSP9
         H5craiC1TiVEb/p2qCbsF+epsKlUEryt3CR2/6ZIEuKbtIgSFOhuyz0EzYu5xIPbKb
         1gk2GrHjGaUyqnmL+YUd12f6kQBsn6OmKJiUOccpQRPBxfcFPwCy9kJJtjXggKdKw2
         HF8zv2JsL05sxou8YKz+O0gscjaievdOg2CvlpYngiaO+27pZAJgZldVM0DyJWgjtP
         nPpHARrvM1gQPhat6fLZP1guXrkeeBIHXL+PESBelrL39UvYlIAyuXRNyNd2oPsay0
         ecE/ApREOOuVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 253A4E68D5F;
        Fri,  3 Mar 2023 23:04:24 +0000 (UTC)
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.2+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <24e8a84979c4ac65ddc2d41ecb0d1d53412a7d39.camel@HansenPartnership.com>
References: <24e8a84979c4ac65ddc2d41ecb0d1d53412a7d39.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <24e8a84979c4ac65ddc2d41ecb0d1d53412a7d39.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 901b894af5b933cf6576eec05746f34b46e2ac83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06caa751545512fae98c21f282006a7fff852daf
Message-Id: <167788466414.32457.4279094887450841903.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Mar 2023 23:04:24 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Mar 2023 16:03:59 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06caa751545512fae98c21f282006a7fff852daf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
