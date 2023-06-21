Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E337738D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjFURjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjFURjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A6919B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BAD261652
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5ACAC433CA;
        Wed, 21 Jun 2023 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687369146;
        bh=vqyrew1wpgYyiBt0Iuq/kPw/y1As6MGbmtuRuQX3Y+Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NuK7jjhCVHpDq2ljNvu9Vv/WW4/8xpdTjNu2vwt4QcTrFECRRtmiVQmUGW2vi9tOM
         N30o0br83rlQjIJpYbUMVNHENpEgjlqw+XPxIgL1Z51GupWk2L1I/uQPRiLhPzXWes
         KVIPDrI94MSyUb9T4qNN96ROrM2LyHDDRijECIJIwsl4JhoL3U7bXpPFLRPC+3D8/O
         vXKbQZjB6dqHumRwExu67nUYW8UVCBTgPPX4olHIrKhOmooJef/njtTBpfhVu0JFzB
         D9QKMn1aESBu4niS0rdmpggZoTDguvCi6xD3RP0GH8q8sm3lYRYpH+ZYThHvV9daSP
         YB4Fkv4ML/gcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACA1FC4316B;
        Wed, 21 Jun 2023 17:39:06 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230621132320.1DDCBC433C8@smtp.kernel.org>
References: <20230621132320.1DDCBC433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230621132320.1DDCBC433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.4-rc7
X-PR-Tracked-Commit-Id: 7257d930aadcd62d1c7971ab14f3b1126356abdc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e6fb54de1ef34fd20a0bdd99ce72a657814391b
Message-Id: <168736914670.5231.2819722205607388039.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Jun 2023 17:39:06 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Jun 2023 14:23:16 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e6fb54de1ef34fd20a0bdd99ce72a657814391b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
