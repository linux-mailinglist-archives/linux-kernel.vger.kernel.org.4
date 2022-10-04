Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EC55F4925
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiJDSTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJDSS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:18:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768BF3ED6D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 11:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1787BB81BAD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 18:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFE72C433C1;
        Tue,  4 Oct 2022 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664907533;
        bh=/f5LFrzmZOUiiFrggkxioq+aQu2r1hxQFC5nZUU/CRo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=egGgkBEhOwEDvNimZJHIe2qqMm9OvpRPOMuKoTVvP6pkcNahORiVPijoZPbbQsbHP
         LU2r91IyWc5EXqDePm8uDKWA7rPsgpG835lJCwTVIfFN3lFlp70zSCuV6hJyy3foKK
         WOnm5QJA7qySNMuQeB+vufm2zJaxWfLLOikG9L3OZgHs8s6vAlo9hI3SzE0ukpQtxt
         F3sw9lQvLkuF9JpA9ZDuLohhYREgr39pWwa8wkoHFIpVYLtxFtJujyO4qZAK5qvG8Y
         e1auzCCcEbM//hAQCoYYhOBxJywUBOvZRBQDRkMXYWRsm99+/agVbrrdifrT6TccJw
         9hO2bTokF8I/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE1D4E21EC2;
        Tue,  4 Oct 2022 18:18:53 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTEHLd-PVLArOH20UGaB21JJzz5nT54VFegF23631QSxA@mail.gmail.com>
References: <CAHC9VhTEHLd-PVLArOH20UGaB21JJzz5nT54VFegF23631QSxA@mail.gmail.com>
X-PR-Tracked-List-Id: Linux Audit Discussion <linux-audit.redhat.com>
X-PR-Tracked-Message-Id: <CAHC9VhTEHLd-PVLArOH20UGaB21JJzz5nT54VFegF23631QSxA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20221003
X-PR-Tracked-Commit-Id: 934f70d9d498a7fffd611edf48356698f1d72e91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c645c11a2dba116bad3ee43e08e330db8f03ede6
Message-Id: <166490753370.15936.11551051255575412972.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 18:18:53 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Oct 2022 15:19:57 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20221003

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c645c11a2dba116bad3ee43e08e330db8f03ede6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
