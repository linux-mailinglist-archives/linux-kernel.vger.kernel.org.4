Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B47A711273
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbjEYReG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241045AbjEYRd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B7AE5E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0036C647EC
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 17:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 675D2C433D2;
        Thu, 25 May 2023 17:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685036018;
        bh=9rdW4gKL4JQPZbJ50fD/tu9SsGts1bqUKqqLCYxgo2c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ecSqJnjh7DcaIUvO3hc7R2yfMNvbrJTyAyGxAzJq2x/dtRxqu7EXLaO8TIOlYQR3B
         z+kLbIkdxyLFDipGU+4yp+SmKVSXil22SkFVMYLfUaYJ6CzYo7XBWXeDFcOmGPvLjq
         HHg6RWcReQxg0qtKdfq7QBZ6lhgkovVqmWrHscxoJNInrZvr9UgaYK5C23HV2apZM2
         2oXcgPxpFw4iVFSswc0TnYpFYIZKG61K5wxhgB8d3VmOnhRiP/5WlPaa4DGpC4+zER
         h2yDW2NrHIfKBjc1pAVl3QXB8EbzbuQTXIJZMTMIdCrOsyryUJ+SAawEnIWrBMpHn1
         4RK5VjJOR0+OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54BB5C4166F;
        Thu, 25 May 2023 17:33:38 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87h6s0dgi5.wl-tiwai@suse.de>
References: <87h6s0dgi5.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87h6s0dgi5.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.4-rc4
X-PR-Tracked-Commit-Id: 4ca110cab46561cd74a2acd9b447435acb4bec5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 029c77f89a15e0e2f209ac5be9ec1d9672b8b09a
Message-Id: <168503601834.13926.520389558083331093.pr-tracker-bot@kernel.org>
Date:   Thu, 25 May 2023 17:33:38 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 May 2023 09:20:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/029c77f89a15e0e2f209ac5be9ec1d9672b8b09a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
