Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CD36608C1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjAFVTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbjAFVTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:19:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A133381D44
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 13:19:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D7CDB81ED1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 21:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA110C43396;
        Fri,  6 Jan 2023 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673039945;
        bh=yVLNkZQT3F6G5kW3KNji6w44vsBmJ17vxiKfBp5M8bc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WJd1TrEFaBmJgQGfDaP07uScusWM/RPM5ugjz9oXgRNSvQqe3/MhMjbRMEFA4j0/9
         BZX453i1j0zYtdfi7ICjRNVCcoNX6Rw/qYEcWXNIfZpEi1Br8PsgaKrek7ChdgtlMY
         xbqy8DVGx0ltFhA1z9G/ufzRp1KNjYSklDXHca/D5gPvUrTOpWnzeaxXbXLSb9h4+/
         Tv7Y9J/knI+VZm3ymb0oXqOkAhUV7v/3u1kwk+22gegmk3uh7awp4Ecf9HtgXaJFWT
         sTDRt3pd6ciWqgZS2QihByGA6Mj/sk4fQiAzZR6MA5+BNP6OswYAN4TC/ZhZcpQhcD
         CjMsXFODfpqHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D04EFE270ED;
        Fri,  6 Jan 2023 21:19:04 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-96b62708-327b-4721-a0ef-49ef52a1b3c2@palmer-ri-x1c9>
References: <mhng-96b62708-327b-4721-a0ef-49ef52a1b3c2@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-96b62708-327b-4721-a0ef-49ef52a1b3c2@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-rc3
X-PR-Tracked-Commit-Id: b9b916aee6715cd7f3318af6dc360c4729417b94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a389e54642a86c91d683b2f0b248f1d2f4e52611
Message-Id: <167303994484.10294.2900232298703872108.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Jan 2023 21:19:04 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 06 Jan 2023 10:13:09 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a389e54642a86c91d683b2f0b248f1d2f4e52611

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
