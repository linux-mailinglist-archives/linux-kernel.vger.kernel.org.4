Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED0464C0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiLMXcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbiLMXb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:31:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794D52BFA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:31:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13CBF6178A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CB61C433F2;
        Tue, 13 Dec 2022 23:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670974315;
        bh=pGky/CEJuW+pxYIiMJK2v04mXSHTSqP9tXQCOq/ABZI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TExGWmslttfSWhb8nCnlpAms2XvoTQ+Fe7y4tg6vk8r++QCB28VHFEZM/zeBU4ikS
         0B9cN8xllmBjbclsxiRrvs8VGSm9I0Zb5fwQtk0iUbGsjztroihv+2BZXGOl+ZtYlR
         k1cPu3LqydK8tsSlQZGorPixLLXcleB0Q1cRZgRnGa/pGwtmrcpF6WfepzC9fDfDET
         wjAbXY8AHT8kfxNU0yu55Rr62p0zPfXv/KrDrbn8cbbA9wRBJrHoBzmVzR5ETbHnZa
         58sanDN5b3CIw7EUhX1wkEmLhj68x6Es1faDfiMBjlOLWYY5+UfRCGcuLgZMDPzefc
         4G/RXbJI7l9WA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C68CC00445;
        Tue, 13 Dec 2022 23:31:55 +0000 (UTC)
Subject: Re: [GIT PULL] x86/paravirt for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5iRQGixyy51mBLB@zn.tnic>
References: <Y5iRQGixyy51mBLB@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5iRQGixyy51mBLB@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v6.2
X-PR-Tracked-Commit-Id: 00e8f7153bcdecc5c31e307c7c17fecf42308fc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82c72902c50f8b5e28f59c2f2ec1c4ba20dbfa08
Message-Id: <167097431544.3216.2489058963702169555.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 23:31:55 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 15:50:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82c72902c50f8b5e28f59c2f2ec1c4ba20dbfa08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
