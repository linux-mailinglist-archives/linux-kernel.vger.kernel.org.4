Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DDA69BE1C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 03:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBSCID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 21:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBSCIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 21:08:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A149EB77
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 18:07:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97C1760BEB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 02:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 056E2C433EF;
        Sun, 19 Feb 2023 02:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676772478;
        bh=gc9aBtVfZ3Nc7uHU3ZV35DL+UTbRaidJmW9gHUdGQiQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m9dihm6JbB15tl20hSMkNvZWWsYfCPp7YwXtnOUhjGzWQjNcbKK1hEQx1AMQUoe9p
         4gkJFEk/15WqbpERkLLrf4wg07CHLBwuMAiuQoQVqd0c32lz2GI8MhluV0d0TkuVpy
         5fOsea0eB3fauuCWiEQekmcvqFpchfFl/WEb6NSD8SsTlvQRSf+uaFP+8MNcuF1JKz
         TBSxGb7HHb0lhFm/38Ho333/lhzz6Pp4bYxfmZxSHiy3mYBL/avRYkygoZkNUXijDx
         bpFWKLBtUIOmQwyfpOow/mc8kgUKLqtbm3Fo4UGUXoo9STf0HTp1r65Q5nzHFEocrN
         4sgbWuWhUaraA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC485E49FA5;
        Sun, 19 Feb 2023 02:07:57 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167676366450.269954.1214202439225962646.tglx@xen13>
References: <167676366161.269954.1941292974323519398.tglx@xen13> <167676366450.269954.1214202439225962646.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167676366450.269954.1214202439225962646.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-02-19
X-PR-Tracked-Commit-Id: f9f57da2c2d119dbf109e3f6e1ceab7659294046
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 925cf0457d7e62ce08878ffb789189ac08ca8677
Message-Id: <167677247789.889.6364538925532063570.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Feb 2023 02:07:57 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Feb 2023 00:42:26 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-02-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/925cf0457d7e62ce08878ffb789189ac08ca8677

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
