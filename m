Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E465674C6D6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGIRqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjGIRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:46:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC1103
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB46160C02
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 17:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AC39C433C7;
        Sun,  9 Jul 2023 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688924794;
        bh=YJ0eZ1Bh2C5DSX58Y4Fos6sKsxHbMCAE2eiL4bHwGw8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UQfcHoRJgw3mETBTbq0WsVnhkqeCUBGaDI3mNQ32XKtaf8ZBMMYXyGvp+6K7N+YSm
         jOaiXDIecVSLI5T7SWO/rw76NXSWUdXclPUhPuWbwJm+ejNfzzMU720VjJt177U9lR
         iUrSGbcVtoJRHiqYKMHimZSoRjO9l4zocqD8WiqnEMjNpN8v/G9Fa/261BLZ3GGUb1
         qPnTOiRcYu0LGUDBnGAB70JWTPqpYr1Bbi/W8fuCp9GQDie6kJ1LmzsKdwjHX9fcTF
         eLp+0SMp68zFw8c9xs9CyenX532aNG7wYwTzkK9oQbTDcOKsmFPtMTJDQD+K4uwsGE
         iSBDt1uM1oL3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09D9AC4167B;
        Sun,  9 Jul 2023 17:46:34 +0000 (UTC)
Subject: Re: [GIT PULL] NTB bug fixes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKor+IDTZ8OR/Xu9@athena.kudzu.us>
References: <ZKor+IDTZ8OR/Xu9@athena.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKor+IDTZ8OR/Xu9@athena.kudzu.us>
X-PR-Tracked-Remote: https://github.com/jonmason/ntb tags/ntb-6.5
X-PR-Tracked-Commit-Id: bff6efc54bd0e27a332eb733525d7f698fd4a5b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cff068739688791cf7a8f427b7ca6230d798914a
Message-Id: <168892479403.9789.16700462643229908303.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Jul 2023 17:46:34 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Jul 2023 23:39:36 -0400:

> https://github.com/jonmason/ntb tags/ntb-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cff068739688791cf7a8f427b7ca6230d798914a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
