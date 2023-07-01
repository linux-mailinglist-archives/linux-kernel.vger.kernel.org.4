Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41125744A7F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 18:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGAQTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 12:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGAQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 12:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108C510DC
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 09:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A030060B58
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 16:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 087B2C433C8;
        Sat,  1 Jul 2023 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688228381;
        bh=3Gv/jiuW8gpSP2P2vqG0v7wqLF6z1eu0+i6VLt1/ZYo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W1chCRpN0xyOYQVHMJ9bFp6G0+/6G7m+kSSt21+xxlCHjJvYsBpG4cchtEhCjlwb9
         Esjd3GuPpauxCC578a0J55Gz8vpCRwkmNuPySjZ6P5nnvGSd9+OihkccKmb7edfaFG
         z2kMQgHokWxyTWacBTpq4+yQicYFyiYPkYLfftaYIneh+gMw1pMw66som6LoD2Lrx+
         kEC4LYZyyMLrFJbv0CaZXOdcbpOYlicwIANT4Z1FCHRQ/IVsbDL/+p7oVQhdb1xvC1
         Z24oLVl7GWWzUlAnc6/rzHvim2NcwzHMJeWQwQNdmB5HfpNA6nxn5cTXsCuI88YokB
         T8V81KrgqHPoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6E80C0C40E;
        Sat,  1 Jul 2023 16:19:40 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fix for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKBRDMx96q25piLr@arm.com>
References: <ZKBRDMx96q25piLr@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKBRDMx96q25piLr@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 893b24181b4c4bf1fa2841b1ed192e5413a97cb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3c2b10d6f15640407bef3098accf10faa4ecf1b
Message-Id: <168822838093.4514.13819933134017512063.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Jul 2023 16:19:40 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Jul 2023 17:15:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3c2b10d6f15640407bef3098accf10faa4ecf1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
