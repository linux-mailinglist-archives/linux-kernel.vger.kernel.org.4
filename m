Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF076126D2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 02:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJ3B36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 21:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJ3B3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 21:29:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F046580;
        Sat, 29 Oct 2022 18:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED5F7B80D81;
        Sun, 30 Oct 2022 01:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A87A7C433D6;
        Sun, 30 Oct 2022 01:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667093381;
        bh=wW/3IjMHtkVJu+daeALn/GNz7gKs/NWGCDtcHz5V52g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FzyNCopZyj6RT+D4zOkkxdIuen0oDcmYV6K1jJ1CdxDPqyeOh2wdbuvOIIL0SmgKm
         EYpLaaEoO4hsKjGu8RCq9WHard1Hien5xyUeiXpRT9La5dxKWkhfAAQlOPi27Tsmcy
         v/qNib0FuNs39uPFTx8WdruyldeKCNM+mL+nIA+tVZr2LFBryXhpvQNsjr+/ajJmi5
         vrphBWaBlegf5bshjQ4gppPkYg060xWeVvRsvHTnlxlpCOOw6Pz+SmfylpYYC7w0oO
         IZYsbUCnF/K3KkOWFKZolXthEE0VZCgL8Ws7M63qfLz6rMd+peJ/FeJt2PDc0u5ukh
         LQDExe35FW5XA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F2CAC4167B;
        Sun, 30 Oct 2022 01:29:41 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <849ccec8eca62c218b36853c2be3ae288983d1e5.camel@HansenPartnership.com>
References: <849ccec8eca62c218b36853c2be3ae288983d1e5.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <849ccec8eca62c218b36853c2be3ae288983d1e5.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 307539eed46395d27e0ecc0ae4d9d6e99eb15fcd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83633ed70c50d3a8470c7e40732efa165dcc2dc7
Message-Id: <166709338158.23656.15378550568662499562.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Oct 2022 01:29:41 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Oct 2022 17:15:39 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83633ed70c50d3a8470c7e40732efa165dcc2dc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
