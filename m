Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D405F652351
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiLTPAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiLTPAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:00:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3477962CB;
        Tue, 20 Dec 2022 07:00:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5005614BD;
        Tue, 20 Dec 2022 15:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CB5CC433D2;
        Tue, 20 Dec 2022 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671548406;
        bh=JhK+3dW6gZr5eRXdMHW5F8cx8/ypjKUPkWePISV06ag=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b/28mBGvhq7T3fpidCdWjoXfl6U97/ldOFTibGujxC5bZXzrY1K7mkTo3eLdafmhK
         F1HdJGxiayViQNgUkRSq1TnUgFKAORyqNKpWPnollFMhm3O92bpKQ8eR8p57Pl8DeB
         XjFCVZ/WqONMTFUjmOv2e8gt9hYJIv18+hkeTFbei0zvc3hho1TBPvW2bQZURhJIHV
         J+PxgzA9YhiOnQjEzl1Fb0IpCgAvgp8rLLGC9pAvJ+iYBcgt+joQY21wLGVfjf9FFc
         OKTWPsZtLknNpfc0Ox0V8+F6gmjN9Bl9NJF05b3HCvNv9vprTjkDwaSaMuyXNO9szk
         YfhSQ/V3aFtcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 191AAC43159;
        Tue, 20 Dec 2022 15:00:06 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.2, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221219223825.GA2497163-robh@kernel.org>
References: <20221219223825.GA2497163-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221219223825.GA2497163-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.2-2
X-PR-Tracked-Commit-Id: 3367934dd3035afa72ac79ae649f142a530df157
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e0caea7545430a530bec19bb0de6c1c56c04924
Message-Id: <167154840609.23150.13267044066315697518.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Dec 2022 15:00:06 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 19 Dec 2022 16:38:25 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e0caea7545430a530bec19bb0de6c1c56c04924

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
