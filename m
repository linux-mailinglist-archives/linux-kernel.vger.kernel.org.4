Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C590608327
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 03:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJVB25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 21:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJVB2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 21:28:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCD82A568A;
        Fri, 21 Oct 2022 18:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 508D2B82DB5;
        Sat, 22 Oct 2022 01:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AB9FC43142;
        Sat, 22 Oct 2022 01:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666402118;
        bh=JAISS4aeZUKSFy+CJSrq8FWtw2ELPkXnQmGpBleK1gI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NSt/bticvkDwy20CO5HDY4426HWGPZW2orblu17damLe/8cKWEa4bFZR8A/Ry4Ihg
         KGiKdIGEV6NEg0qFksEwkDinb1q8Bimsa0vla+V0KBpJmCMO0RXLrtoYLPledke3n6
         BTSDnGZjR4628mzJGw7WRjx+I3WnW88jCFl+6ibYNdf8qFAe626ZiY/JzTOMYqfULn
         K6UBCcTzrf/nT7y54qQE7xPyDZgd4ZApnMhJZpXwah3QQAvY8EAjfUgzSzZaMNTLl7
         vpGsea+QwCjTJsVoKjGPwVb2zfPhpzBjIhKqcEoCfk9K67OibPzF7IbpaWYcK5X0/D
         wqvSnsK3yK19w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0205EE270E0;
        Sat, 22 Oct 2022 01:28:38 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v6.1-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hFewGmAWyvPWWO8Fd6w05p05U_vLMsi-5ryFU5wbB6BA@mail.gmail.com>
References: <CAJZ5v0hFewGmAWyvPWWO8Fd6w05p05U_vLMsi-5ryFU5wbB6BA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hFewGmAWyvPWWO8Fd6w05p05U_vLMsi-5ryFU5wbB6BA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.1-rc2
X-PR-Tracked-Commit-Id: 4bb7f6c2781e46fc5bd00475a66df2ea30ef330d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4da34b7d175dc99b8befebd69e96546c960d526c
Message-Id: <166640211799.11783.14312196336044672115.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Oct 2022 01:28:37 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 20:51:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4da34b7d175dc99b8befebd69e96546c960d526c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
