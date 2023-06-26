Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7AB73EB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFZUGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjFZUGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:06:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BC0198A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3736B60FCB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FC5BC433CA;
        Mon, 26 Jun 2023 20:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687809762;
        bh=q1AYkOo0C8d8bzUL4fGWSkmp4uaLYnCzLu3ARo76SDY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aOwikcGfuaQzIiWEhkZQPjq6RkGcGHX0pzPbw5nuK7pVZq2DA/QWquaGPukkiH3Ss
         gFnb2Kfk5o7LjPARYLRPsRP+g2LlBoIV8nZaZ/m1bbWu/MIUQpRzYSsXg8x795XGcg
         pX5e0VlMCDGL0ET92HGwe9VAKemfJGVmROK29WewM0StWTwqmWJ328a1tucjN67+rd
         WJO1XFKkLClmyD22agHyIWjDp4vIxV++Zl6DBztLkokce2kh09ToOeb3e8GsS7lhV9
         7s+BDsGcfs3Tuid13a5x1B4DVAkC5tFJyUu+yhNabjoOVLZLHbk87OtxKVcpF7wf04
         VLUMvRXkTk4/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E708C43170;
        Mon, 26 Jun 2023 20:02:42 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJkWa+t/WBCXs9XT@debian>
References: <ZJkWa+t/WBCXs9XT@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZJkWa+t/WBCXs9XT@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc1
X-PR-Tracked-Commit-Id: 8241fdd3cdfe88e31a3de09a72b5bff661e4534a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 098c5dd9cf96fc6d7f35429561ef58cd7c5fcecf
Message-Id: <168780976257.7651.3821421140079280801.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 20:02:42 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yangtao Li <frank.li@vivo.com>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>,
        linux-erofs@lists.ozlabs.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 12:39:07 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/098c5dd9cf96fc6d7f35429561ef58cd7c5fcecf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
