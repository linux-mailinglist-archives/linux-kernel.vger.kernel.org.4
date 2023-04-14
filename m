Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDBD6E2990
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDNRk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDNRk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFB776B3;
        Fri, 14 Apr 2023 10:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0BB261C01;
        Fri, 14 Apr 2023 17:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 609BEC433D2;
        Fri, 14 Apr 2023 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681494025;
        bh=82uf7++NyS+0xhq50Zd47LDn8+0vWBh0FIVRWtFzemk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VyZNI8o7EL23gdI6U2H2XhnGE/gTGteub9YwxYUHVcVNDRIzV9VNvuy2SD7c83cy9
         MpZ30/Tlx8arYVblWv3CdORPRZWxTn0mfJwA2vGZ3P3ysVMn4LzuAVuQGGclswRiPm
         sopeVlFd8iQp/lUVWcDDT31W5hJb6l3bJM0clr4Iv0dPrDiUaXCiuZw+kVqkDydZFu
         wfXSQXh607b3FNsO73F/XjiY3wCWp7dhrL51WSmDwGfhmEhHTsabJXeppOsvlVbGt2
         PmOmRLtPB5kafU+jrKN4Bfnj5CZBkXj5sizfo6fSlsXKHFPRTKjWpGCukPQb+/8/SB
         LoN2eS/Q2gkIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42227E52446;
        Fri, 14 Apr 2023 17:40:25 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jfYRyiMzu2S3KXueGvrux=5082SAsz81pN6zwDVvFDUA@mail.gmail.com>
References: <CAJZ5v0jfYRyiMzu2S3KXueGvrux=5082SAsz81pN6zwDVvFDUA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jfYRyiMzu2S3KXueGvrux=5082SAsz81pN6zwDVvFDUA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc7
X-PR-Tracked-Commit-Id: a3babdb7a8f73c3d8965b245fe1b758b87538912
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95abc817ab3a5af57cc0b522f72225307fa6333f
Message-Id: <168149402525.11053.13917106051901098071.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Apr 2023 17:40:25 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Apr 2023 15:55:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95abc817ab3a5af57cc0b522f72225307fa6333f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
