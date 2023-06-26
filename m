Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAC773EE77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFZWLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjFZWL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:11:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D407846A0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 414D66105A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A70FDC433C8;
        Mon, 26 Jun 2023 22:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687817181;
        bh=ML9Op3Bjd4WhXNdmGxudhPhbXqYfsKAeS/+E9nA16U0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AKMMJEsI37oPNCu5RCyFFmnZymHJWlro3ObMeugRUkb+12Cl3KICE6opgXgPxfcSg
         uCtzCa/8fpYo0LKHemM7BLA4eK4MKSLqIvmWOnwX8EiOXH7wnMCMXGFTRORBjA4zn1
         ziuINXQ746x1TLtBrQmERmvptXE5xLjscLzX2krs+qIBMRFz1TeCVpZurMBaLTt1BD
         0mwbdKPOgqzdzoUhC6IIQaY/MJK1TUeTTMsc0EZqZeZptmHgKdI0xLdY00zkoc4/Hx
         YBWrdN/gLIN9oforVvTzuMJdKIdJrMJ4/Gyb476ERMY6HhTD9uderwlXTOT2QzBGFE
         PJNyMkfVtDINw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EB14C395E0;
        Mon, 26 Jun 2023 22:06:21 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168778151111.3634408.15121565787828756774.tglx@vps.praguecc.cz>
References: <168778150975.3634408.5562070824299155127.tglx@vps.praguecc.cz> <168778151111.3634408.15121565787828756774.tglx@vps.praguecc.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168778151111.3634408.15121565787828756774.tglx@vps.praguecc.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-06-26
X-PR-Tracked-Commit-Id: f121ab7f4ac32ed2aa51035534926f9507a8308b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0017387938993553fe8e08bd9bcf398fb609d136
Message-Id: <168781718158.14634.14033769133798340067.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 22:06:21 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 14:13:48 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-06-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0017387938993553fe8e08bd9bcf398fb609d136

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
