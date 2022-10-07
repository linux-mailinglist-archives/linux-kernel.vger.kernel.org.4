Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505E55F7DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJGTVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJGTUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:20:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D962DAAD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8673761D10
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 581E4C43470;
        Fri,  7 Oct 2022 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665170420;
        bh=D+2F8mK5TcirZWdqJHGmVCSpcFagqlOzEuOomyC2xMA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EjPqnMIwFQ5PSxJ58H4TPRwvLV0Mc0deO7P3OC0P6bu3IdFQWZznBXvxk87RpMtu+
         nSsM1O8IapdO7rK+M5behKUSJ9BzWobY9m7F1DWwV/HPezxSY9rfdF2Ue6b3jUY7tS
         4xcAPq3EGAecgUKskdhAwW2weK7TbxE4QGpqoPd0NI4uenD4wj/Fcwy2416G89uIRs
         j9QchJoVrhlcF5DPU5QXQeZ2az/6WmvT27jI35pXVbzZmIF9ufXn4lamZNSLTqM0o8
         oXr3hguncSEQRLIQ4YtHTSVArbTLxyykuvd032w1jJySPLNu5Npn2s52LTrYk6m1qx
         Vl6aumy/PeR3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44D3BE21ED6;
        Fri,  7 Oct 2022 19:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yz6Zi7B2RS16sXhT@google.com>
References: <Yz6Zi7B2RS16sXhT@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yz6Zi7B2RS16sXhT@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-6.1
X-PR-Tracked-Commit-Id: 72a95859728a7866522e6633818bebc1c2519b17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae9559594cb851aff774d5bea243b84c6acf761d
Message-Id: <166517042027.8063.10696727127589518090.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 19:20:20 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Oct 2022 10:02:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae9559594cb851aff774d5bea243b84c6acf761d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
