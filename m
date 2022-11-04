Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A361A4E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiKDWvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiKDWvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:51:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F86554DB;
        Fri,  4 Nov 2022 15:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D955F61A38;
        Fri,  4 Nov 2022 22:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4988EC433D7;
        Fri,  4 Nov 2022 22:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667601996;
        bh=iXRuDCF5abt+rGS1XqNIeqy7Lm7nRxbZ5FzIZ4tgQ7Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mAXTlxb2lvr92p2QRjRzL65DwKcnq7qcOl+kFYTdV2KCc2KidNYepg63ZDZXxdlnS
         V9mvOP0wl/CGLRbB43H0tT82owzgSQl9PHyRZOerPSreYXu5Ac443KPyA9OZftF8zt
         Cr+9VjgxGzf82RfZsYiWukKTt5LhBJ792lUVLsAL0L8EzseRyPP+Xil0tid88M8Ses
         7HkiRr749KNtFJl4OnDNKNL9cnDS4LK3exdl4pzXAZv1n391eMPCL+Rxmbq4ty/9dd
         T8AEGOHwR3eMeOu7AYDLaP+rJaBqlGA+rWhV0Y/mqcoMebJS3mT6FTuNnQRa/cnvdi
         3U4c3zSYEgkdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30797E270DF;
        Fri,  4 Nov 2022 22:46:36 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v6.1 #2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221104174830.57435-1-mic@digikod.net>
References: <20221104174830.57435-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221104174830.57435-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.1-rc4
X-PR-Tracked-Commit-Id: 091873e47ef700e935aa80079b63929af599a0b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d8401be15a9e59af701db08fc0f973c3587f2ae
Message-Id: <166760199619.25569.6080941804402391064.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Nov 2022 22:46:36 +0000
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  4 Nov 2022 18:48:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d8401be15a9e59af701db08fc0f973c3587f2ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
