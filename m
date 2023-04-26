Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F0B6EEBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbjDZAuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbjDZAt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:49:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92200193E6;
        Tue, 25 Apr 2023 17:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFFFD63239;
        Wed, 26 Apr 2023 00:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57EEBC4339C;
        Wed, 26 Apr 2023 00:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682470171;
        bh=HcSNG/pU/DqUb0gDg+tvhDJCM2ZtavX8QFQF9EZXXJA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T7Hi3Ekbz58WuCebgNNNm4yMGjrCB6AILPNmCTN7F00T3qWN+IY9PxXACIfDd0Rh/
         k9Dm/w6FHAjXbB+m7bXqEhFeQLVIlj0tWLGddBMY5Gehy8kxf7aLZZo1d3Y3LSbYqa
         A0xZCNdlr2wV8huXfZCXOUx/LyXcHGUUSZC9WA2UtZgZb80PaBbqN9NdLspzX6HZHg
         mfewlf15jsa+sR+R9zd+h2Fuv4+SnzKl09XvXJRGKCMMqWctGsuJ8e5fIUKOYTtAzz
         EO/ikxwRV8AUs2bJpe7Z9+Q+Gx6G15DjfQqwX72Dq55jKbIr6u0tqqtTesFpu14iwI
         Vpgwn0f4/zqiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42A1BE5FFC9;
        Wed, 26 Apr 2023 00:49:31 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424151912.278066-1-andersson@kernel.org>
References: <20230424151912.278066-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424151912.278066-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-v6.4
X-PR-Tracked-Commit-Id: 1f6fa392a9942e4a2bd3122913baeb33e987ccd9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3361e9a4ea957b09c5d6242613360c415194dbb5
Message-Id: <168247017126.10866.11271887442406692380.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 00:49:31 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        Simon Horman <horms@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Yu Zhe <yuzhe@nfschina.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 08:19:12 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3361e9a4ea957b09c5d6242613360c415194dbb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
