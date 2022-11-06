Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9B861E6BF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiKFV4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiKFV4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:56:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5292632;
        Sun,  6 Nov 2022 13:56:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D17060DBF;
        Sun,  6 Nov 2022 21:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2729C433D6;
        Sun,  6 Nov 2022 21:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667771797;
        bh=tmoMBh0NtTLCrcuQlh83dR/WTBY9GjenE9BEF/+LliA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dTp9JA88eko0SuKZ0oLnqMoBhFrZEoMHyclGmvB+AJsoMv1s7Y8h1SHmWLUgX4znr
         NeyeYmSARCgB6z6YOCX5WYklKpuGutGTw1mBs3N9AeaAlzMXiIaav/yJv2eCRioozn
         3RwzPwHAjtBenRolk/A1v1n0TkuIAR8CM59qCotOySuwnUS/D8q44GnT5fxNpEgGzI
         aNxmd5+fnRu8MaSIeQBMNzWJHgJRD851Fg+Li5ksz1w1/ut/M9kggSWrdsabO8pPnT
         X166BPy1MbcS5QeTaptUQkSbjxO1K08d77/DkXNFnuNw2ElWfGUD78XDEqBqwMm5Q6
         J/DoGVr62rF4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E057AC41621;
        Sun,  6 Nov 2022 21:56:36 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221106140706.808902-1-linux@roeck-us.net>
References: <20221106140706.808902-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221106140706.808902-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.1-rc4
X-PR-Tracked-Commit-Id: 1e699e177e339e462cdc8571e3d0fcf29665608e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa52994915dca444dbb8e6b91eb82b749ba7a1ec
Message-Id: <166777179691.27970.11086155896782800145.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Nov 2022 21:56:36 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  6 Nov 2022 06:07:06 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa52994915dca444dbb8e6b91eb82b749ba7a1ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
