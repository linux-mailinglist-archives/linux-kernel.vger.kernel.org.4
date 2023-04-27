Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA96F0C84
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245313AbjD0TVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244756AbjD0TUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268434EDD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7285663F51
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4399FC433A0;
        Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682623220;
        bh=KZd1Fl3c1k6iByr1mWzr0QrUXPeMRjoUB9JYIRHTQ0E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eZw771+tbnJYcJfyAG8Z+jn5U/j4Te4X5VHWIOsRMRN/VKd3CU9p1G/carngDah+x
         3LbwAXQvVT70Z1X4cQd/Ti+ogourdduRM9R6vPGIX+iLepOXopHFL/RyFydYSfBs8n
         cDAs5Zy8TGRIcJdtGjZPOJzwmvo7U7q21zgcamOPh/bkCsgPK5zYjN2kJXW6ZJRFdp
         6bFedWsigqo4Q952tJ1mvWMHJks0mltSU7GfFE35M/nKzoWVspNI0wPl6prR8krXXb
         D9FCyOt203ac/fpO/XKhGT1Q5BapuBLXuw4JF5MStDi4fm0+XN4c2IWZZ7WLLQgd8N
         awdvzp6A32TLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 321C2E5FFC8;
        Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] firewire updates for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230427034934.GA556709@workstation>
References: <20230427034934.GA556709@workstation>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230427034934.GA556709@workstation>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-6.4-rc1
X-PR-Tracked-Commit-Id: 02dc51a0a07a379539b4661ecb56eeb5b19b3928
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b02847fc2e7a55b7247cf80c14527555bdc965af
Message-Id: <168262322020.21394.15111472696504588354.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 19:20:20 +0000
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     torvalds@linux-foundation.org, broonie@kernel.org, tiwai@suse.de,
        stefanr@s5r6.in-berlin.de, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 12:49:34 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b02847fc2e7a55b7247cf80c14527555bdc965af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
