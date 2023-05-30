Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25822716F93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjE3VTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjE3VTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:19:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBC8C9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AB06633BC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CE82C433D2;
        Tue, 30 May 2023 21:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685481572;
        bh=NOO26cqnTWEsAYU2cQM0VTpfVyTQP8oNbdPhKwh9oOc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LJg73qZnwvID0rEC+Pf66GcjiTm9kRCtCYiz49AyRTiAFSCp0djRu0FJ+BDrOl+dT
         Dygdicl7LUlug+QCy6TOf/QFSqiLNs2tkN+4I89wgxyoTbNw3MPgXs2ZKzWj86nbkf
         X6D/zKbz4Ig5hDDyxYrKId2ksQolScwfpEYl47Xovkwq3rHQPgQSI90+nzqRREo7zx
         +e/iwwSmNhOfK4/M4XxeH1qynbVtpF22wtR4OncEnGCwHBDChHIWQzrNSn03edlSfd
         4xObEg5NhSHd97xRbSqpedyWz4N2dzJEJCO8fv/UGyR394AFSq1x9OBqwNM1Bu8y2o
         PCIj4f3ovMYqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85AABE52BF6;
        Tue, 30 May 2023 21:19:32 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230530120329.A60C0C433D2@smtp.kernel.org>
References: <20230530120329.A60C0C433D2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230530120329.A60C0C433D2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.4-rc4
X-PR-Tracked-Commit-Id: 0cc6578048e0980d254aee345130cced4912f723
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1683c329b6a2ee54989811089854a8ac2d5b5fc1
Message-Id: <168548157254.4416.6159937987116978484.pr-tracker-bot@kernel.org>
Date:   Tue, 30 May 2023 21:19:32 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 30 May 2023 13:03:15 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1683c329b6a2ee54989811089854a8ac2d5b5fc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
