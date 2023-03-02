Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F87E6A8997
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCBTj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCBTjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:39:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4B4166D5;
        Thu,  2 Mar 2023 11:39:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0436BB815AE;
        Thu,  2 Mar 2023 19:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B49C2C433EF;
        Thu,  2 Mar 2023 19:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677785945;
        bh=jMQyjFSSFX/TVxXDzD2RtntoL15j1XBiJxy/wEGTzEA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uJpXjPey3jdq/LrQfdZ7KMa4l+lpqYQs2SQ6OG6m/v1IXMcB8WiJa2bHuN8zY4/Xi
         1UelLQ74yrkYVxxb6tTAWjaSpPZVM2nMxx1z/XdzJTz25vHBbLkISGDnMD+k70Sl1A
         ClznxSjDHbMlOMKMokbxQBt4iK8Q4wycZSOOSCvS/l8XAFrbm5bg262uGaYUR4QFe5
         QE+60RGI3KTI5A36FeDdbXPjmjJkGJ+eIqC9daLF7CXPrcsJnaC80/5g5ffZkXb8yH
         VI8BCxSggGDb0pLZmVFYZ+eGaUETWsO/M0V/JbT86nDfX8N9bL1WaXxMpdA9fvQ3/U
         7LTctpLVhQ5rQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1E77C395EC;
        Thu,  2 Mar 2023 19:39:05 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230302165943.254479-1-idryomov@gmail.com>
References: <20230302165943.254479-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230302165943.254479-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.3-rc1
X-PR-Tracked-Commit-Id: f7c4d9b133c7a04ca619355574e96b6abf209fba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3f9b9fa10b9fb677966bfdab8c00da739c4af1b
Message-Id: <167778594565.8121.6005298282862141194.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Mar 2023 19:39:05 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  2 Mar 2023 17:59:43 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3f9b9fa10b9fb677966bfdab8c00da739c4af1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
