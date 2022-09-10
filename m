Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72845B47BF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIJRi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIJRix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:38:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E107491EF;
        Sat, 10 Sep 2022 10:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E88C60C88;
        Sat, 10 Sep 2022 17:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 691BFC433D7;
        Sat, 10 Sep 2022 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662831532;
        bh=yLqF8KF66P7mglxm0ydPdltwIbrN+hgyBaZahaQ6Zs0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cA541T+/hNwClWSjLLrzFQDQDQWidO7ccAc2ClGQUUTTkcHEs0F9CceZkn3NP4YT6
         zpZVDPV33MDmkYELbgvJycMLsQgjKqRGifgTFwR2Db/3yBJ9CMQXEoWq9edAHKTg02
         vwRhYoAXfWoRlT7PDtySKbF0wozzn08iR2Kaiz27ALszHTBzfjEjfjNWEvcnJz5Nv7
         yXk9n0EpaTHLX4r8Sf7HdNVReRSQpslkkBRHw5JSEc/ogEDT0lc9AheRVtaetkxi/+
         goSpNs/S/Dr9KsgvbR5D0Ud6MKVV4Z2IdYfqoyi4kt5a1crVgSwCyfVziC9+P0c+zL
         KpDCKA/XRYLsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 534AEC73FF0;
        Sat, 10 Sep 2022 17:38:52 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.0-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220910142942.1152413-1-linux@roeck-us.net>
References: <20220910142942.1152413-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220910142942.1152413-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.0-rc5
X-PR-Tracked-Commit-Id: 88700d1396bae72d9a4c23a48bbd98c1c2f53f3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 445e0bc7594a81d0e51d74c21a675c77369de4eb
Message-Id: <166283153233.31692.635662600575237387.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Sep 2022 17:38:52 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Sep 2022 07:29:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/445e0bc7594a81d0e51d74c21a675c77369de4eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
