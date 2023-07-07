Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6E374A900
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjGGC14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjGGC1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346301BF8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B86DA61657
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 02:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25F9DC433CB;
        Fri,  7 Jul 2023 02:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688696868;
        bh=HYYgVkklhcqyJB6h3QYqtutoo90qAy8w7E1rYbtITnI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E2gc3KADWiNanLrzAqRGKIlJptU+UbGsxqS8H6FY1J5eTRFUqy+3jbx69j6jIz/KL
         kEVaWh8TpCaE96B0x8lVDcqq1HWYMjhM2SmIQvxHciKqHkYnMNCUEPjCN645wZyeXx
         1YuOjlwFGK6t5bjbYg8UULeu7SV0U+yM9GeDc4n1qy7W4vU+uwKY+DuEK9YUWM8ACH
         GDWOS5X22IN1laSSfze6dlytPeeAqRiTm322Va9QcKyzx6Ba+njnH36zzsjLweVWOY
         cWGMJNbYvkh8dpRStxVjLdCgvNAXazKz6+fNTGEkuV0GwbZsVZ/UOwDQ9bJMs5K2PI
         D3I0ofvSq0i+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10728E53801;
        Fri,  7 Jul 2023 02:27:48 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.5-merge-window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230706144108.B31A6C433C8@smtp.kernel.org>
References: <20230706144108.B31A6C433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230706144108.B31A6C433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-merge-window
X-PR-Tracked-Commit-Id: e9bd04e52d649c3cfd713b594c5db35cab03c42b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 146d7ce3e01cba1eae25dcdc6d39cec68347962e
Message-Id: <168869686806.32373.5862359650126906756.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 02:27:48 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 06 Jul 2023 15:40:57 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/146d7ce3e01cba1eae25dcdc6d39cec68347962e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
