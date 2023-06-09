Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9367572A04F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjFIQkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFIQkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5CF2D71;
        Fri,  9 Jun 2023 09:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D609360B66;
        Fri,  9 Jun 2023 16:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A3EAC433EF;
        Fri,  9 Jun 2023 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686328807;
        bh=HtHcZN3YrHg+wEeXs5oM8Mrhx0mnbJ8x0THDnRqKiQE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VjEVpkvP2V0eqxuIjnf8IhvSVmqo/4HEWQiZmXQZvU8U1Us1umuFTqsSCLPIpAXS6
         cRmGSTEbQbUJB302bBg6qkNpOQ7/JmQ7gIbnvBL6lIG1gW2frFUuZqjnom8VrH5bZm
         Wo/WKn8EsUYZnjZZ0XYfsIpI19NkWSL/fovsuhB024rjK08TbiQ0jjgv5IB+3xydnc
         iSVIizLCWMmeraNyow3/BI+9ex5bUp5yNncZWtpLwS9PfMvjWoapUlvSUm4OSRAxd4
         qg0L2FXemHR5h5XWnPuancn3HyT8fFceaEwzPPdPyL7byaVq7IJrq7FMxj5T28J000
         cNcyNy0JXgrHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32EE3C395EC;
        Fri,  9 Jun 2023 16:40:07 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZIMeobQOfS8XyayA@tuxmaker.boeblingen.de.ibm.com>
References: <ZIMeobQOfS8XyayA@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZIMeobQOfS8XyayA@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.4-3
X-PR-Tracked-Commit-Id: 03c5c83b70dca3729a3eb488e668e5044bd9a5ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87aceaa7f083cd4e77e28943bc5535ef34ead498
Message-Id: <168632880720.22626.4892825117257009736.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jun 2023 16:40:07 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Jun 2023 14:44:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87aceaa7f083cd4e77e28943bc5535ef34ead498

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
