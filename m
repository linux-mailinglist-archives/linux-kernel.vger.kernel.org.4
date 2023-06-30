Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D317434EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjF3GYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjF3GYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:24:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05621BCE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E3DC616B4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CAABC433C0;
        Fri, 30 Jun 2023 06:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688106269;
        bh=lveWGBMTvEwHHHDGj9HExpYyQgWjQtnZbyKtsBhwvwM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qhoiP/nsci6arZed8RPbaAMul8iVMbpc9BfOtb20Ice/TAVq8m+lfOvtkrRHoYme6
         ns5EJKAjCfh5OjUHBCT6t9+A3NUNX8aC63W7PnCurOya+wWp74fbn4+8Zs71jNLwHs
         PRhca6tlPowkeGE69qMxPI8Zb8KFYFnoZk5z5ANWc38CNarVE9/K1tKw4Ztun0hrYf
         4uim+Snosej3fLR7kZBP0fEeRLDtbGG/dFczzPTvmOu//pXF6ovbXrZren2eVCyOLN
         6khNHqDp0q3MKIj08hUdAZNE6v2ZoKUTv8g1C66p0jerYgExaEsHd8Zx4BRFH4iTrN
         79wG6q04GqwOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86FCFC43158;
        Fri, 30 Jun 2023 06:24:29 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: small updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627084058.GM52412@kernel.org>
References: <20230627084058.GM52412@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627084058.GM52412@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock memblock-v6.5-rc1
X-PR-Tracked-Commit-Id: de649e7f5edb2e61dbd3d64deae44cb165e657ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 075e333591e6aee7b0008dd6c14c361bb1509821
Message-Id: <168810626954.27935.14253937445736068250.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 06:24:29 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>,
        Yuwei Guan <ssawgyw@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 11:40:58 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock memblock-v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/075e333591e6aee7b0008dd6c14c361bb1509821

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
