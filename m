Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF7366994B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbjAMOCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241050AbjAMOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:01:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311F0BF75;
        Fri, 13 Jan 2023 05:58:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCC25B82163;
        Fri, 13 Jan 2023 13:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A8F5C433D2;
        Fri, 13 Jan 2023 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673618305;
        bh=oIZX+dr+xeJD/+N3OsfU1Sw7gp2v7ioCcNJZx+8U3wE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CSxLlvUmxRoSqF+B47Er/tcuCSNCdu8B5a3gW38P1LPSB+8FaLF2HBZQrPJP+i7O4
         xn93Y+3EVfjtgOUJ54vusAbGb3WOlISMsCG5P/5CIG26f8cCIpMdt9buEjXe7wbbIA
         acvTUyDdmJvcbOJw0/+vj+/nhD+vqjZv9lKlBFITkW4q5Wodt/doWPNHOg3/0Gx6nk
         ZriKbc4cCYzgqAJnZJ00xPVAaBVhhczGDcz+KkIDSn6I/WF9CjWjkvhU0/eN47k9qz
         XdFYGAxgR2hT/FZVhW0qmiG3+Zn4Uy+t4pRYx44etmJvkg6Y9I+rDy1Xd9pXuSXA/g
         AAX02RhQv/ahw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BDDDC395C7;
        Fri, 13 Jan 2023 13:58:25 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hTgcWELD7-4SUZdMpm+CQHS+CRfzshjsHL9iAerE98mw@mail.gmail.com>
References: <CAJZ5v0hTgcWELD7-4SUZdMpm+CQHS+CRfzshjsHL9iAerE98mw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hTgcWELD7-4SUZdMpm+CQHS+CRfzshjsHL9iAerE98mw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.2-rc4
X-PR-Tracked-Commit-Id: df3a71aba40fbe4bbd0842170e70c236eaed7c40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdbbca256cf3f8b1f3f37a7102b54bf99f2fa656
Message-Id: <167361830536.16011.11207962694910210942.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Jan 2023 13:58:25 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Jan 2023 12:06:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdbbca256cf3f8b1f3f37a7102b54bf99f2fa656

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
