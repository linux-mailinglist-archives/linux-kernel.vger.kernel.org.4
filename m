Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E145655561
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 23:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiLWWsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 17:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiLWWsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 17:48:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EDF1B78D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 14:48:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A9C61F6E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 22:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BD83C433D2;
        Fri, 23 Dec 2022 22:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671835714;
        bh=4PT5D/gbSRwOR3cOaqaaxkCKoLZYSeOMBnT7mw2KsGE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OBxHVt93C8gNfYFUz4Ek3mXlTZEusjbyG9xNApbPlaM6y+20Lz//EPKyA8deLsRAe
         1x164XR/qkoDQJCR7HnP9PzN1xcjweu11Q+4gyWuRk9iazvWtkurtstZTU1Ahg8HVg
         67UuP/kCSJuD/FxlPH/cnrsX2l5jttjbx6Xl58DbrYAzBMyb6QIsOnuV9jnCF+mTS8
         dxfvQORWsWKdp0l9PqwzPnOo3SxrYm6lAR9tXnM7ORe2bvdeExqYiqMM/xQoMiJlb+
         va/KgMbpMk/K1Aq5Q1y/vDEEWV3Z+8oKaYlqIe727sUzc6er6k+XXAQM16Ov0deISs
         yHLo8jJ6A5WZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4863DC00448;
        Fri, 23 Dec 2022 22:48:34 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221223213102.B9978C433D2@smtp.kernel.org>
References: <20221223213102.B9978C433D2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221223213102.B9978C433D2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.2-rc1
X-PR-Tracked-Commit-Id: cb3543cff90a4448ed560ac86c98033ad5fecda9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a023cbb11e3d05c39dbb67317cb77ef22d47404
Message-Id: <167183571428.7718.9431821273690327656.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Dec 2022 22:48:34 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Dec 2022 21:30:51 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a023cbb11e3d05c39dbb67317cb77ef22d47404

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
