Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3BB6F495D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjEBR6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjEBR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:58:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB401704
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D38A627D8
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 17:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C59C6C4339E;
        Tue,  2 May 2023 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683050276;
        bh=3iPCe2Ie0CJR0DbrVmvyG2MloAx3aMWRYMZPEHQ/b8s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I+DM/omwaO3bSKBsMHTya0U8PeG54Px10HfzBZPCVXLJVESVWUVaPgqtWXTt80Ps9
         dxds+tRHdr08ntwM8+/+AufLaKbrDKgFqx64xFL1REpOk01H7GjdO8n24TYoVEWyDx
         dTOqJ5uoJYDAQTnuV3q+v1EGttwkZzPNver7mxAfhMNoYNi69192f7uvDBA/ocGG/U
         eGcWXx51Cov7Yp9DsOry/CgITUmmXtcaxe98lOWWB80MR0gNgTTnWr7PzFzJGMlnty
         IiORCSsLq5YA0VZnVAkG1NYKpOiYvdbC8F3iPoV+4zDdSmoEUzrcuJdm8dDRS5s8H7
         /Iu42jv0oA6dQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B41BAE5FFC9;
        Tue,  2 May 2023 17:57:56 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230502163129.GL620451@google.com>
References: <20230502163129.GL620451@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230502163129.GL620451@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.4
X-PR-Tracked-Commit-Id: fb200218b40b7864f64f1a47de61e035d8934e92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7b3ffe2d7e476f11d73b74093006aa936f59e8b
Message-Id: <168305027673.6897.9122268974026356816.pr-tracker-bot@kernel.org>
Date:   Tue, 02 May 2023 17:57:56 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 May 2023 17:31:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7b3ffe2d7e476f11d73b74093006aa936f59e8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
