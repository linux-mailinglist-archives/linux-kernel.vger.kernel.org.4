Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEA67430AE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjF2Wjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjF2Wj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADC11FC0;
        Thu, 29 Jun 2023 15:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE70C6162A;
        Thu, 29 Jun 2023 22:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45109C433C9;
        Thu, 29 Jun 2023 22:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688078365;
        bh=QzkeXqkKfrWk5qaOGndnqsB6ssY1lvYVMppCLbvt8nc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i2iEghgURwhLXMIKD9QinxPOIxEfbdxDH1LyLP2ncBKreBGqu/a+6iP3hFFhKMGsO
         bF4xdE4dkJdpGOVdWrF5+K+trFXPU+4TQ0oYPOXJdWLBPIRXrQnJ9qy6MnV/V1mxd/
         Dp2rpW3QwsKiUrSL6D5agu+tTjei6VArLP3C+KkwN99arKBmXUE3oVzAeAjZ4KlfS9
         1k7ISN1F8QGqdNy3/5TK2X9b2Gt9dYYQVjnX5NoYu2k0qrgQvfpvU4ZHDEZOunWDqN
         SMwi/QNZI78on46NKk6NtjrHmEBR0FZ+aJUYCOTohRX7UUFw76eMQt0kP0Uspkmw33
         mAddK/H2c9T1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 331E0C40C5E;
        Thu, 29 Jun 2023 22:39:25 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230628120201.GA10364@alpha.franken.de>
References: <20230628120201.GA10364@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230628120201.GA10364@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.5
X-PR-Tracked-Commit-Id: e47084e116fccaa43644360d7c0b997979abce3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b775d6c5859affe00527cbe74263de05cfe6b9f9
Message-Id: <168807836520.26000.16561200645678922511.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 22:39:25 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
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

The pull request you sent on Wed, 28 Jun 2023 14:02:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b775d6c5859affe00527cbe74263de05cfe6b9f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
