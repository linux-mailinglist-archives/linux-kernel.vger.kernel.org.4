Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D535F3BD3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 05:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJDDqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 23:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJDDpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4562A13E91
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 20:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26D3861215
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BEC1C433C1;
        Tue,  4 Oct 2022 03:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664855102;
        bh=mpa+y0GekaFAN++hvFnsza+tscaAm7nWw7qnz5S89S4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O1XBuQZh9PLIbVM4lbNAi48QUK3nXU9o7iIOuzrBSSUx2MWttx3ut8872rNiV5SG9
         F+RoW1j9W48Ka30VaRtAJ+GnDKWQr0ZtyEGl6LTGP+ZgvypVbvxgtqbrSMcypQbL0b
         jzP0GXPuUZcrR4pSe5tkhqBJZIjk3Y21lmk5XGABK5dUWIJHgy+OTIhOXFwB10F6pu
         nDplSTS6j13iLuyyya7ttwOmWhuhOPNKbdBTDMu65dMX1Uad/Jz7KPPsD2spfI0s7R
         fepyTy+zarx0KeSJcCfjikb5T1dgVZZD5EsMQRFPrwl2YprKEac9L/OUhTzXifGs/g
         6zvFuacrV9XAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77A9EE49FA3;
        Tue,  4 Oct 2022 03:45:02 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221003182552.GA7517@redhat.com>
References: <20221003182552.GA7517@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221003182552.GA7517@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.1
X-PR-Tracked-Commit-Id: 3b7610302a75fc1032a6c9462862bec6948f85c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4309528f3dec3ead08cd4bd09e0e5fe081ab9f9
Message-Id: <166485510248.18435.12968218712513171398.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 03:45:02 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Oct 2022 13:25:52 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4309528f3dec3ead08cd4bd09e0e5fe081ab9f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
