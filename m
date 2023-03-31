Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644DC6D269C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjCaR07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjCaR05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDAB1CBA5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C40B62AA6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 17:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CF07C433EF;
        Fri, 31 Mar 2023 17:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680283616;
        bh=/dM+IjqDVKCbWfVL0N2lP1q7XwfnF+NxY6ITegE3JmU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GzjVDpl8xX7Hm0iF2BlE8s8Bc3MSvjRzzy8fCEFLBajz4u0Lg2tynJPaqWyx/LJ9H
         TxH1SIOM7l4RF9qF3lltueqXTj+DWnl+XxnHmO+g/H/gkOzRMJig9gPH6KfvosrTEj
         lq/ji+/E5NSxKX2a2VXOW/r3GoAEJs363dYAxAQTTAyFRNolcIS1a9nsvemASuchJ+
         WJcyvXT1ZRRG95XxA0B7an8Ht6ETimc+Pov7yODyoaMGK+8YAl2kDH79+1z8ai0I45
         CdxI1fVRyFhsLr3eQfFXuFMR9BWuUnfserBjT6Y5LgZXO708bd6KI66petWLfpZC31
         QCsp46J9w4zDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBFD6C43157;
        Fri, 31 Mar 2023 17:26:55 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-39dd74a6-0889-4b33-b276-201f02823d17@palmer-ri-x1c9>
References: <mhng-39dd74a6-0889-4b33-b276-201f02823d17@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-39dd74a6-0889-4b33-b276-201f02823d17@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc5
X-PR-Tracked-Commit-Id: 4622f159098e098611f393cccf73d52b007e70bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39f692125c388aa657e77e5ae07ea72be02d99a5
Message-Id: <168028361595.4567.13902678577977519217.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Mar 2023 17:26:55 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Mar 2023 08:01:05 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39f692125c388aa657e77e5ae07ea72be02d99a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
