Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86C869EB55
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjBUXk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjBUXkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:40:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4387E2BEF2;
        Tue, 21 Feb 2023 15:40:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D296FCE1C7C;
        Tue, 21 Feb 2023 23:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 722B8C4339C;
        Tue, 21 Feb 2023 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677022807;
        bh=bB2EwgFxLpqW1ipFgS8iMiYX8ZoGcUnO+nkVHus9MFA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EKKp9P+YHikii/50IqdLegma/RSQuvjLlD0axcQ34KXGTD6AN5gqgvkOdbhyzz0tL
         bFSIeqMMoY1ZQxhUn+Lwg++J3fOyDH3JrwexxGuY7FLBwkC+YWcUydnoPXMkabWyyJ
         3baxQPHBkNYkWdGCix8kP7EfVzKCKZXdcPqv7HPK6TQ1qqWGCtTjUsYSI5tEKLKFZw
         tHKzUGeKUBMPsMFemb3M5XdfXMh/3AHamrfZAjNvWDeDMH7fo5KhBpxh1hLTaU7r0F
         QhH2i3Qrl2U9kVoKFyXHM8nv/R2ak3Zib5SqK0M2X+oruomB+Ab9CKJ29bVI1LsfnP
         T1RCNJ37VtYtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CF97C43159;
        Tue, 21 Feb 2023 23:40:07 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.3 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/NhOcWmhpYRPnK0@osiris>
References: <Y/NhOcWmhpYRPnK0@osiris>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/NhOcWmhpYRPnK0@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.3-1
X-PR-Tracked-Commit-Id: 6472a2dcc4274452bb46fb5a0d968a1c1ed772ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bcf5470eb4a13e5670fefb21525b43ef385c6fc6
Message-Id: <167702280735.12607.10361833997304093213.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 23:40:07 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 13:02:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bcf5470eb4a13e5670fefb21525b43ef385c6fc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
