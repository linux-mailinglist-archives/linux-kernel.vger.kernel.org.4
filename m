Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85926A727D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCASCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCASCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:02:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF764A1C5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:02:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 288AA6144D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 898B2C433D2;
        Wed,  1 Mar 2023 18:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677693729;
        bh=kO5Wi1sF+r0PAn7FwLozPKkQkacs/Nay+DJ4pfDvRbk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bLfakHSCIDslMw9ZrVqh6VAbxK/Jy6TKX/Gtll4OlxjOS6f7SKgCNyEz95qnyVL+N
         B9NyjZ6JEYn9+dJEiX6hHt60arV76R9bgycJ6q578YeqaqzQg25pPbkMwx7hl59adS
         AtF8WPq7UOCpRkXJG847iw6MLGcYbnoIGnluzP7IJt8TVtnQ4RPVwhP5YXVXFrlumR
         WZfe7kQwsAVlfKJx3L6mjaujVcOuG+FhvWAt3Fo07l2RNeaDDWK7k7xg/+yr79QGOZ
         SQbU2lpsDnbXkNw1au5gVJmiCV0ZGyPoNxNjOHMgrMlw16zEs/HwTOo/k+bdny5p1Z
         RCn0IxOTAnU/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 795ADC41676;
        Wed,  1 Mar 2023 18:02:09 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <52785855.187162.1677658023892.JavaMail.zimbra@nod.at>
References: <52785855.187162.1677658023892.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <52785855.187162.1677658023892.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.3-rc1
X-PR-Tracked-Commit-Id: 04df97e150c83d4640540008e95d0229cb188135
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64e851689e441e66e001ae063d4536602f9f74cb
Message-Id: <167769372948.10213.11066361498534065985.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Mar 2023 18:02:09 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Mar 2023 09:07:03 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64e851689e441e66e001ae063d4536602f9f74cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
