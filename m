Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82E764BF75
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbiLMWgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbiLMWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:35:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E885D19004;
        Tue, 13 Dec 2022 14:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 832B361744;
        Tue, 13 Dec 2022 22:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E299BC433D2;
        Tue, 13 Dec 2022 22:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670970946;
        bh=new3YaTtbUyNtea+91i8A486mJdUC7vF704r5+cqMoQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XXsnIfVbQ0vDffZf9bvjHP1O/Osk/h7IlbW9zZUprkJgn0SwkNv8eLZl/byyhvJJP
         sVRmWUn5kzxcdrQYgkuBcpzzi6MV2mQ69DroFX+NVxAbMeTwRVmdWb02v1sHZI98Dz
         0NYd/Fwryb2eErfisgXK9uHoJKBwzT+KKmOQ28ST/HbI20oi1JWXSDgaA0ISLNsF98
         9/GrN58Mk5/ei71awUsYUOLMlhcmb7wFk1R4Qacs8xWnVT5D2+FyopFNBNPHnV8VAi
         ASK0tEDFLuf8FGl3pvvZ3J4ZdoNFeO1C1mLPLa/kfQLnp3gTpMaFz80b4i56tsqTIr
         AtTlgiLNJktoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3336C41612;
        Tue, 13 Dec 2022 22:35:45 +0000 (UTC)
Subject: Re: [GIT PULL] modules changes for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5fpJ6MOxf9PD8Vh@bombadil.infradead.org>
References: <Y5fpJ6MOxf9PD8Vh@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5fpJ6MOxf9PD8Vh@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.2-rc1
X-PR-Tracked-Commit-Id: 4f1354d5c6a3264c91238962d1597eef40c40419
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ba2c3ff98ea8bfb219288dbacf2a23a902c751b
Message-Id: <167097094586.5412.16383358267507306912.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 22:35:45 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        thunder.leizhen@huawei.com, swboyd@chromium.org,
        yang.lee@linux.alibaba.com, linux@rasmusvillemoes.dk,
        petr.pavlu@suse.com, mwilck@suse.com, pmladek@suse.com,
        mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 18:53:27 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ba2c3ff98ea8bfb219288dbacf2a23a902c751b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
