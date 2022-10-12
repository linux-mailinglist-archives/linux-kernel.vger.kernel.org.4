Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492085FCE79
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJLWdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJLWda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:33:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B32411874A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 07CE5CE1D14
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B08EC433C1;
        Wed, 12 Oct 2022 22:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665614003;
        bh=useAVEG1SCn7DezhXEEy/Oj9mOvG627lbhcokJs58C4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YFrBq0OnNPLs8udUx1RN41lWZqUQxhAH+XBRENaNPIJIcQgfu8JwIR93BR38DtwyJ
         OSwEEqYfbC7YuNckwYygYuVWgzTnn3cb2xiDYsQLufKhNAHlRp2javXbsTbPprTtkd
         301GAarQ0pqfIaWBQIgvtNMMZf6iBpCP0qPPbhvWzOkCFlAUXF9jCsnY5ybBSj3lZx
         eNPI8CrEE5yECsmm5q3uiRCHzIydwgoOjJgKZq5s6BH9fSusYmqx4ou3Qae3EumDjB
         ZCg4DaxHKheHxSrugOXvHpQPMvt6yB26097RaqYUFcSsgtNaTnNUfvmaQ8gzBs1mBz
         84jzlCcYfXXOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B1C6E21EC5;
        Wed, 12 Oct 2022 22:33:23 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221012071618.8859-1-jgross@suse.com>
References: <20221012071618.8859-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20221012071618.8859-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.1-rc1-tag
X-PR-Tracked-Commit-Id: 7880672bdc975daa586e8256714d9906d30c615e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 778ce723e93ee803ef5883619fe2391e00dbc209
Message-Id: <166561400336.16489.1809685200706007965.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Oct 2022 22:33:23 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Oct 2022 09:16:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.1-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/778ce723e93ee803ef5883619fe2391e00dbc209

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
