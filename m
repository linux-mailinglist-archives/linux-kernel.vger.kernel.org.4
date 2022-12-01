Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E5863F86D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiLAThb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLATh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:37:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05B8BE4;
        Thu,  1 Dec 2022 11:37:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D0AB620E3;
        Thu,  1 Dec 2022 19:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A349EC433D6;
        Thu,  1 Dec 2022 19:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669923444;
        bh=o1e5cNkaeVBHeVFdVZ4Nge7QDteEUWAJtDcjpk1vBy8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E1kyj1rsUoTDoTY1rJD9Zo5GlpSW9KDcXtPUsKUI0cKKyVWQw5XQljMqYoOolnm10
         McznQlnhIYMI3CgddpdZ8saDWKRhKevcKPixjtrRaumRc2kTW+2iqTBso1TIM5kTT9
         nRICS1O8siFF6BCDZLyNIIeOYvNvpkgjXbo8N+k6Als/LsdQ737j89pwydPADrFHgZ
         Mh3sAgm6aC/wIypHiwjTzZce/2UELHcA4pJuDHCaIRVgTw+bvBL4zSqWudcAJVIs0y
         4e42ouV/v7tDFpTFjmkiVwCPI/i140sVyNqA+d/DBrNQAK+OuPjKJMVUAf0czgmb8y
         wz6KoIX0Tk+YQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F901E270C8;
        Thu,  1 Dec 2022 19:37:24 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.1-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221201172526.2290129-1-linux@roeck-us.net>
References: <20221201172526.2290129-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221201172526.2290129-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.1-rc8
X-PR-Tracked-Commit-Id: 9bdc112be727cf1ba65be79541147f960c3349d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e214dd935bf154af4c2d5013b16a283d592ccea5
Message-Id: <166992344458.6584.1340713015035746798.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Dec 2022 19:37:24 +0000
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

The pull request you sent on Thu,  1 Dec 2022 09:25:26 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e214dd935bf154af4c2d5013b16a283d592ccea5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
