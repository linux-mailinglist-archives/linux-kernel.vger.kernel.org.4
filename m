Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A826688AD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbjAMAtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbjAMAsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:48:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB6B6145B;
        Thu, 12 Jan 2023 16:48:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9882B8203E;
        Fri, 13 Jan 2023 00:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62EC9C433D2;
        Fri, 13 Jan 2023 00:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673570900;
        bh=ee3SUjhc67PmTFjWF9OP6JoyAlQd1YsRCLuk1ovozCw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GTvUby1v+ooO8naAhKu5NLgb75kQiRqDDyGY985mo92Bxj28UvX0MBha9eqoKYN8z
         S6Y/UoVb15uMc/Mr/ZDo/Hu11wWpKc1FtYgz+dNOIa+jWHudg20AQRTedVPQe9khqI
         BJ4aHlrTIMf4JmxAMWZzmsq+q+ZjxzcJg4v3sAqoKTcvi8PZNBEN1HUWRgVJfbrMYB
         6Z8/DgBRXtkQEN00AQ75xjMj+ESYMZr36tyBukKMi2tCBk31rNHIAFLY8fVTE1NxyV
         5qmYxQ2u+BRqcG36JJJ9kUGFdAWDYYzZ1cXKnDhYjrcIKXeg65oBO8MW66bAVuHzQZ
         qwSc9iUjifZuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52FC5C395C8;
        Fri, 13 Jan 2023 00:48:20 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8BJs/dL1gwtOtqd@osiris>
References: <Y8BJs/dL1gwtOtqd@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8BJs/dL1gwtOtqd@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.2-2
X-PR-Tracked-Commit-Id: 1ecf7bd9c267ab85aff3c4a17fe56bc9754a13be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5be413a6e2a16e08c8f0f1b59794a7203b5eca2c
Message-Id: <167357090033.28490.11385922066507899860.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Jan 2023 00:48:20 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Jan 2023 18:56:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5be413a6e2a16e08c8f0f1b59794a7203b5eca2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
