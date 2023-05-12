Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C9470089A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbjELNGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbjELNGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:06:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688A912E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 055BB65648
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68AEAC433EF;
        Fri, 12 May 2023 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683896774;
        bh=CX+UaDvSJrmy+3c+/siD7Jiy6Dn8AM6fRpmrXZHqrZ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uSelc3dCHdPcuEiMWQ7YnNe0LFYwq/d4eU/0O+N82Ya3yEBvy4o1R00mK8WBLhDuy
         YSZPYLES4NfSZAAL/u+038wDypmlXnK2blsmEL2MVm7pde78n/v1TjaCK6bdVmeh1+
         2ObyQVTZb+Z66pDe/IFjxWnpLdjtl3ny78aVefBBOmqGZM1roVmc3ze8HJG4VvXNeG
         SpNCw+BrVTccv0Eo/zTwB8i8CY/fXz2UCNeUkfQPGYfklc936NhXY1Gb3OdQthksLe
         dbB2RW7fKx+t/tYGtGi0S0SIyOeyGteQu/IhzV/ehbqnInDDLlCQfj4uQCNHOlSTcO
         bqty4V+XQ8Rbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E452E26D20;
        Fri, 12 May 2023 13:06:14 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for 6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230512094817.GA904820@workstation>
References: <20230512094817.GA904820@workstation>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230512094817.GA904820@workstation>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.4-rc2
X-PR-Tracked-Commit-Id: f7dcc5e33c1e4b0d278a30f7d2f0c9a63d7b40ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47a2ee5d4a0bda05decdda7be0a77e792cdb09a3
Message-Id: <168389677431.28818.2052185343489918483.pr-tracker-bot@kernel.org>
Date:   Fri, 12 May 2023 13:06:14 +0000
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     torvalds@linux-foundation.org, broonie@kernel.org, tiwai@suse.de,
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

The pull request you sent on Fri, 12 May 2023 18:48:17 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47a2ee5d4a0bda05decdda7be0a77e792cdb09a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
